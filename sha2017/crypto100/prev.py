# coding: utf-8
from numpy import *
from hexdump import *
import os
f = open('/media/johnny/mydisk/_CTF/SHA2017/crypto100/flag.pdf.enc', 'rb')
b = bytearray(f.read())
b30 = b[0x2e0:0x2f0]
p30 = '\x10'*16
key = bitwise_xor(bytearray(b30), bytearray(p30))
header = b[0:0x10]
hb = bytearray(header)
test = bitwise_xor(key, hb)
for t in test:
    os.sys.stdout.write(chr(t))

b30 = b[0:0x10]
b30 = b[0x2e0:0x2f0]
p30 = '\x10'*16
key = bitwise_xor(bytearray(b30), bytearray(p30))
plain = []
for i in xrange(0, len(b), 16):
    cipher = bytearray(b[i:i+16])
    plain += bitwise_xor(key[:len(cipher)], cipher).tolist()
    
pdf = open('/media/johnny/mydisk/_CTF/SHA2017/crypto100/plain2.pdf', 'wb')
plainb = bytearray(plain)
len(plainb)
pdf.write(plainb)
pdf.close()
