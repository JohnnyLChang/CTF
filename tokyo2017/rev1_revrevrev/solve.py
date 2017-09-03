# coding: utf-8
from pwn import *
result = "4129 d965 a1f1 e1c9 1909 9313 a109 b949 b989 dd61 3169 a1f1 7121 9dd5 3d15 d5"
result = result.replace(" ", "")
result
bytearray.fromhex(result)
cipher = bytearray.fromhex(result)
for i in range(0, len(cipher)):
    cipher[i] = ~cipher[i]
    
for i in range(0, len(cipher)):
    print ~cipher[i]
    
for i in range(0, len(cipher)):
    print hexdump(~cipher[i])
    
    
for i in range(0, len(cipher)):
    print hexdump((~cipher[i])*-1)
    
    
    
for i in range(0, len(cipher)):
    print hexdump((~cipher[i]) & 0*ff)
    
    
    
    
for i in range(0, len(cipher)):
    print hexdump((~cipher[i]) & 0xff)
        
for i in range(0, len(cipher)):
    cipher[i] = (~cipher[i]) & 0xff
    
        
hexdump(cipher[i])
cipher
for i in range(0, len(cipher)):
    cipher[i] = (~cipher[i]) & 0xff
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = (16*j)|(j>>4)
        if tmp == cipher[i]:
            v2 = j
    print v2
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = (16*j)|(j>>4)
        print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    print v2
    
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    print v2
    
    
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        #tmp = ((16*j)|(j>>4)) & 0xff
        print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    print v2
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    print v2
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    print v2
    v1 = 0
    for j in range(0, 256):
        tmp = (4 * (j&0x33) | (j>>2) & 0x33) & 0xff
        if v2 == tmp:
            v1 = j
    print v2+':'+v1
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    print v2
    v1 = 0
    for j in range(0, 256):
        tmp = (4 * (j&0x33) | (j>>2) & 0x33) & 0xff
        if v2 == tmp:
            v1 = j
    print str(v2)+':'+str(v1)
    
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = (4 * (j&0x33) | (j>>2) & 0x33) & 0xff
        if v2 == tmp:
            v1 = j
    print str(v2)+':'+str(v1)
    
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = (4 * (j&0x33) | (j>>2) & 0x33) & 0xff
        if v2 == tmp:
            v1 = j
    print hex(v2)+':'+str(v1)
    
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = (4 * (j&0x33) | (j>>2) & 0x33) & 0xff
        if v2 == tmp:
            v1 = j
    print hex(v2)+':'+hex(v1)
    
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = (4 * (j&0x33) | (j>>2) & 0x33) & 0xff
        if v2 == tmp:
            v1 = j
    #print hex(v2)+':'+hex(v1)
    org = 0
    for j in range(0, 256):
        org = (2 * (j&0x55) | (j>>1) & 0x55) & 0xff
    print hex(org)
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = (4 * (j&0x33) | (j>>2) & 0x33) & 0xff
        if v2 == tmp:
            v1 = j
    #print hex(v2)+':'+hex(v1)
    org = 0
    for j in range(0, 256):
        tmp = (2 * (j&0x55) | (j>>1) & 0x55) & 0xff
        if v1 == tmp:
            org = j
    print hex(org)
    
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = (4 * (j&0x33) | (j>>2) & 0x33) & 0xff
        if v2 == tmp:
            v1 = j
    print chr(v1)
       
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = (4 * (j&0x33) | (j>>2) & 0x33) & 0xff
        if v2 == tmp:
            v1 = j
    #print hex(v2)+':'+hex(v1)
    org = 0
    for j in range(0, 256):
        tmp = (2 * (j&0x55) | (j>>1) & 0x55) & 0xff
        if v1 == tmp:
            org = j
    print chr(org)
    
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = ( (4*(j&0x33)) | ((j>>2)&0x33) ) & 0xff
        if v2 == tmp:
            v1 = j
    #print hex(v2)+':'+hex(v1)
    org = 0
    for j in range(0, 256):
        tmp = (2 * (j&0x55) | (j>>1) & 0x55) & 0xff
        if v1 == tmp:
            org = j
    print chr(org)
    
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = ( (4*(j&0x33)) | ((j>>2)&0x33) ) & 0xff
        if v2 == tmp:
            v1 = j
    #print hex(v2)+':'+hex(v1)
    org = 0
    for j in range(0, 256):
        tmp = (2 * (j&0x55) | (j>>1) & 0x55) & 0xff
        if v1 == tmp:
            org = j
    print hex(org)
    
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = ( (4*(j&0x33)) | ((j>>2)&0x33) ) & 0xff
        if v2 == tmp:
            v1 = j
    print hex(v2)+':'+hex(v1)
    org = 0
    for j in range(0, 256):
        tmp = (2 * (j&0x55) | (j>>1) & 0x55) & 0xff
        if v1 == tmp:
            org = j
    print hex(org)
    
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = ( (4*(j&0x33)) | ((j>>2)&0x33) ) & 0xff
        if v2 == tmp:
            v1 = j
    print hex(v2)+':'+hex(v1)
    org = 0
    for j in range(0, 256):
        tmp = (2 * (j&0x55) | (j>>1) & 0x55) & 0xff
        if v1 == tmp:
            org = j
    #print hex(org)
    
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = ( (4*(j&0x33)) | ((j>>2)&0x33) ) & 0xff
        if v2 == tmp:
            v1 = j
    print chr(v1)+':'+hex(v1)
    org = 0
    for j in range(0, 256):
        tmp = (2 * (j&0x55) | (j>>1) & 0x55) & 0xff
        if v1 == tmp:
            org = j
    #print hex(org)
    
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = ( (4*(j&0x33)) | ((j>>2)&0x33) ) & 0xff
        if v2 == tmp:
            v1 = j
    print chr(v1)+':'+hex(v1)
    org = 0
    for j in range(0, 256):
        tmp = ( (2*(j&0x55))|((j>>1)&0x55) ) & 0xff
        if v1 == tmp:
            org = j
    print hex(org)
    
    
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = ( (4*(j&0x33)) | ((j>>2)&0x33) ) & 0xff
        if v2 == tmp:
            v1 = j
    print chr(v1)+':'+hex(v1)
    org = 0
    for j in range(0, 256):
        tmp = ( (2*(j&0x55))|((j>>1)&0x55) ) & 0xff
        if v1 == tmp:
            org = j
    print hex(org)
    
    
len(cipher)
for i in range(0, len(cipher)):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == cipher[i]:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = ( (4*(j&0x33)) | ((j>>2)&0x33) ) & 0xff
        if v2 == tmp:
            v1 = j
    print chr(v1)+':'+hex(v1)
    org = 0
    for j in range(0, 256):
        tmp = ( (2*(j&0x55))|((j>>1)&0x55) ) & 0xff
        if v1 == tmp:
            org = j
    print hex(org)
    
t = 0x7d
t
t1  = (2*(t&0x55)|(t>>1)&0x55) & 0xff
t1
hex(t1)
t2 = (4*(t1&0x33)|(t1>>2)&0x33) & 0xff
hex(t2)
t = 0x6B
t1  = (2*(t&0x55)|(t>>1)&0x55) & 0xff
hex(t1)
t2 = (4*(t1&0x33)|(t1>>2)&0x33) & 0xff
hex(t2)
t3 = ((16*t2) | (t2>>4)) & 0xff
hex(t3)
def reverse(t):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == t:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = ( (4*(j&0x33)) | ((j>>2)&0x33) ) & 0xff
        if v2 == tmp:
            v1 = j
    print chr(v1)+':'+hex(v1)
    org = 0
    for j in range(0, 256):
        tmp = ( (2*(j&0x55))|((j>>1)&0x55) ) & 0xff
        if v1 == tmp:
            org = j
    return org
    
    
hex(reverse(t3))
hex(reverse(t3))
t3 = 0x7b
hex(reverse(t3))
t3 = 0xde
hex(reverse(t3))
t3 = 0x62
hex(reverse(t3))
chr(reverse(t3))
for i in range(0, len(cipher)):
    hex(reverse(cipher[i]))
    
chr(reverse(t3))
for i in range(0, len(cipher)):
    print hex(reverse(cipher[i]))
    
t1 = 0xD6
t1 = (~t1)&0xff

    
        
hex(t1)
result = "4129 d965 a1f1 e1c9 1909 9313 a109 b949 b989 dd61 3169 a1f1 7121 9dd5 3d15 d5"
result = result.replace(" ", "")
result
bytearray.fromhex(result)
b = bytearray.fromhex(result)
b[0]
from binascii import *
b = unhexlify(result)
b
hex(b[0])
b[0]
ord(b[0])
hex(ord(b[0]))
b = unhexlify(result)
for i in range(0, len(b)):
    b[i] = (~b[i]) & 0xff
       
b = a2b_hex(result)
b
b[0]
for i in range(0, len(b)):
    b[i] = (~b[i]) & 0xff
       
for i in range(0, len(b)):
    b[i] = (~int(b[i])) & 0xff
    
       
for i in range(0, len(b)):
    b[i] = (~ord(b[i])) & 0xff
    
       
for i in range(0, len(b)):
    b[i] = (~ord(b[i])) & 0xff
    
c = []
for i in range(0, len(b)):
    c[i] = (~ord(b[i])) & 0xff
    
       
c = [:31]
for i in range(0, len(b)):
    c[i] = (~ord(b[i])) & 0xff
    
       
c = [None] * 32
for i in range(0, len(b)):
    c[i] = (~ord(b[i])) & 0xff
    
       
c
hexdump(c)
hexdump(c[0:31])
len(c)
c = [None] * 31
for i in range(0, len(b)):
    c[i] = (~ord(b[i])) & 0xff
    
       
c
for i in range(0, len(c)):
    print hex(c[i])
    
for i in range(0, len(c)):
    print hex(reverse(c[i]))
    
    
def reverse(t):
    v2 = 0
    for j in range(0, 256):
        tmp = ((16*j)|(j>>4)) & 0xff
        #print str(tmp) + ':' + str(cipher[i])
        if tmp == t:
            v2 = j
    #print v2
    v1 = 0
    for j in range(0, 256):
        tmp = ( (4*(j&0x33)) | ((j>>2)&0x33) ) & 0xff
        if v2 == tmp:
            v1 = j
    #print chr(v1)+':'+hex(v1)
    org = 0
    for j in range(0, 256):
        tmp = ( (2*(j&0x55))|((j>>1)&0x55) ) & 0xff
        if v1 == tmp:
            org = j
    return org
    
    
for i in range(0, len(c)):
    print hex(reverse(c[i]))
    
    
for i in range(0, len(c)):
    print chr((reverse(c[i])))
    
    
    
import sys
for i in range(len(c), 1, -1):
    print chr((reverse(c[i])))
    
    
    
for i in range(len(c)-1, 1, -1):
    print chr((reverse(c[i])))
    
    
    
s = ""
for i in range(len(c)-1, 1, -1):
     s.append(chr((reverse(c[i]))))
print s

    
    
s = ""
for i in range(len(c)-1, 1, -1):
     s += chr((reverse(c[i])))
print s

    
    
s = ""
for i in range(len(c)-1, 0, -1):
     s += chr((reverse(c[i])))
print s

    
    
s = ""
for i in range(len(c), 0, -1):
     s += chr((reverse(c[i])))
print s


    
    
s = ""
for i in range(len(c), 1, -1):
     s += chr((reverse(c[i])))
print s


    
    
s = ""
for i in range(len(c), 0, -1):
     s += chr((reverse(c[i])))
print s


    
    
s = ""
for i in range(len(c)-1, 0, -1):
     s += chr((reverse(c[i])))
print s

    
    
for i in range(0, len(c)):
    print hex(reverse(c[i]))
    
    
for i in range(0, len(c)):
    print chr(reverse(c[i]))
    
    
for i in range(0, len(c)):
    print chr(reverse(c[i]))
    
get_ipython().magic(u'save solve.py ~0/')
