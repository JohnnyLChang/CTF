#!/usr/bin/env python
from pwn import *

context.log_level = 'debug'
def guesshash(tail, hash):
    chars = string.ascii_letters + string.digits
    for i in range(0, len(chars)):
        for j in range(0, len(chars)):
            for k in range(0, len(chars)):
                for l in range(0, len(chars)):
                    xxxx = chars[i]+chars[j]+chars[k]+chars[l]
                    digest = hashlib.sha256(xxxx+tail).hexdigest()
                    if digest == hash: return xxxx
    return ''

def getvalue(output, key):
    return output[output.index(key)+len(key): output.index('\n', output.index(key))]


def pad(text):
    padding = 16 - len(text) % 16
    return text + bytes([padding] * padding)

def unpad(text):
    padding = text[-1]
    return text[:-padding]

with remote('bamboofox.cs.nctu.edu.tw', 58791) as p:
     o = p.recv()
     index, poflen = 14, 16
     tail = o[index:index + poflen]
     hash = o[o.index('== ')+3:o.index('\n')]
     xxxx = guesshash(tail, hash)
     print xxxx
     p.sendline(xxxx)
     o = p.recv()
     token = getvalue(o, 'your token: ')
     token = b'user=someone\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\xc0user=admin'
     auth = getvalue(o, 'your authentication code: ')
     auth = 'd03f925b44e21311de8378635e71f3145d8543e2861cccd62e966c3fdc66fd9a'
     print token, auth
     p.sendline(token)
     p.sendline(auth)
     p.interactive()