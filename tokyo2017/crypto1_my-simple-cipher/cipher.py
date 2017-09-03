#!/usr/bin/python2

import sys
import random

key = "ENJ0YH4CK1NG!"
flag = 'TWCTF{ORED**123456789'

assert len(key) == 13
assert max([ord(char) for char in key]) < 128
assert max([ord(char) for char in flag]) < 128

message = flag + "|" + key

encrypted = '|'
print encrypted
print message

for i in range(0, len(message)):
  encrypted += chr((ord(message[i]) + ord(key[i % len(key)]) + ord(encrypted[i])) % 128)

print(encrypted.encode('hex'))
