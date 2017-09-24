# coding: utf-8
from pwn import *
from ascii import *
import struct
import string
import itertools
from array import array

rol = lambda val, r_bits, max_bits: \
    (val << r_bits%max_bits) & (2**max_bits-1) | \
    ((val & (2**max_bits-1)) >> (max_bits-(r_bits%max_bits)))

ror = lambda val, r_bits, max_bits: \
    ((val & (2**max_bits-1)) >> r_bits%max_bits) | \
    (val << (max_bits-(r_bits%max_bits)) & (2**max_bits-1))

flag = bytearray("TWCTF{11")
key = bytearray("KEY_TW:)")
sbox = open('sbox', 'rb')
sboxb = sbox.read()
box = bytearray(sboxb)

sbox.close()
flag2 = []
flag2[:] = flag

def go_encode(flag):
    flag2 = list(flag)
    rcx = flag2[0]
    for j in range(0, 0x20):
        str = ""
        for i in range(0, 8):
            rcx += key[i]
            rcx = box[rcx&0xff]
            d = 0
            if i < 7:
                d = i+1
            rcx = (rcx + flag2[d])
            rcx = rcx&0xff00 | rol(rcx, 1, 8)
            if i != 7:
                flag2[i+1] = rcx&0xff
            else:
                flag2[0] = rcx&0xff
    return flag2

enc_flag = [[0x4a, 0xfe, 0x5c, 0x39, 0xdd, 0x9f, 0xfd, 0x48],
	[0xf0, 0x6c, 0xde, 0x5b, 0x72, 0xd4, 0x5e, 0x55],
	[0x60, 0xa1, 0x9f, 0xe0, 0x5d, 0x2d, 0x49, 0x0b],
	[0x0e, 0x32, 0x9e, 0xf3, 0x31, 0x65, 0x32, 0x9c],
	[0x3d, 0x23, 0xef, 0x2c, 0x09, 0xc9, 0xec, 0x5e],
	[0x45, 0x39, 0xd7, 0x5f, 0x3f, 0xe7, 0xb4, 0x10]]


def go_decode(flag):
    enc = bytearray(flag)
    for i in range(0x20):
    	for j in range(7, -1, -1):
            rcx = enc[(j + 1) & 7]
            rcx = ror(rcx, 1, 8)
            enc[(j + 1) & 7] = (rcx - box[(enc[j] + key[j]) & 0xff]) & 0xff
    return enc

flag = ""
for e in enc_flag:
    flag += str(go_decode(e))

print flag