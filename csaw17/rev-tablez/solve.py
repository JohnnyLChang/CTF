# coding: utf-8
from binascii import *
from pwn import *

f = open('result.bin', 'rb')
sbox = bytearray(f.read())
input = bytearray('AAA%AAsAABAA$AAnAACAA-AA(AADAA;AA)AAE')
r = bytearray(37)
i = 0
def fsbox(v):
    for k in range(0, 0xef):
        if sbox[k*2] == v:
            return sbox[k*2+1]
    return 0

f = open('target.bin', 'rb')
target = bytearray(f.read())            
pt = bytearray(string.printable)
ans = bytearray(37)
anw = ""
for i in range(0, 37):
    for p in pt:
        if fsbox(p) == target[i]:
            anw += chr(p)
            print anw
            