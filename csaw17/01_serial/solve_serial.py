# coding: utf-8
from pwn import *
r = remote('misc.chal.csaw.io',4239)
context.log_level = 'info'
print r.recvline()
def checkparity(resp):
    c = 0
    for a in resp[1:9]:
        if a == '1':
            c += 1
    if resp[9] == '1':
        return c%2 == 1
    else:
        return c%2 == 0
flag = ""
while(True):
    q = r.recv(timeout=5)
    print q
    if checkparity(q):
        flag += chr(int(q[1:9], 2))
        print flag
        r.sendline('1')
    else:
        r.sendline('0')
        
