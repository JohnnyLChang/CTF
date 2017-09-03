#!/usr/bin/python2

from pwn import *

cipher = open('encrypted.txt', 'r')
enc = cipher.read()
enc = enc[:72]

data = enc.decode('hex')
encrypted = data[0]
print data