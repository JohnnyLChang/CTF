#!/usr/bin/env python3
from Crypto.Cipher import AES
from Crypto.Util import Counter
import os, binascii, struct, zlib, json

enc_key = os.urandom(0x10)
mac_key = os.urandom(0x10)

def crc(bs):
    return 0xffffffff ^ zlib.crc32(bs)

def authenc(m):
    s = m + mac_key
    s = s + struct.pack('<L', crc(s))
    assert not crc(s)
    aes = AES.new(enc_key, AES.MODE_CTR, counter = Counter.new(128))
    return aes.encrypt(s)

def authdec(c):
    aes = AES.new(enc_key, AES.MODE_CTR, counter = Counter.new(128))
    s = aes.decrypt(c)
    assert not crc(s)
    assert s[-4-16:-4] == mac_key
    return s[:-4-16]

cipher = authenc(json.dumps({'admin': 1}).encode())
print(binascii.hexlify(cipher).decode())
cipher = binascii.unhexlify(input().strip())
obj = json.loads(authdec(cipher).decode())
print(obj)
if obj['admin']:
    print('The flag is: {}'.format(open('flag.txt').read().strip()))

