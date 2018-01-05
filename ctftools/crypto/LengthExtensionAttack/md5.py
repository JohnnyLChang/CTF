#!/usr/bin/env python

import struct
import math
import sys

class md5:
    def __init__(self):
        # Initial value for magic number
        self.hashs = [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476]
        # Continue with previous hash if message provided ( get back the magic number )
        self.functions = [lambda b, c, d: (b & c) | (~b & d)] + \
                         [lambda b, c, d: (d & b) | (~d & c)] + \
                         [lambda b, c, d: b ^ c ^ d] + \
                         [lambda b, c, d: c ^ (b | ~d)]
        self.indexs = [lambda i: i] + \
                      [lambda i: (5*i + 1)%16] + \
                      [lambda i: (3*i + 5)%16] + \
                      [lambda i: (7*i)%16]
        self.rotates = [7,12,17,22]*4+[5,9,14,20]*4+[4,11,16,23]*4+[6,10,15,21]*4
        self.constants = [int((abs(math.sin(i+1)) * 2**32)) & 0xFFFFFFFF for i in xrange(64)]
    def leftRotate(self, x, n):
        x &= 0xFFFFFFFF
        return (x << n) | (x >> (32-n)) & 0xFFFFFFFF
    def calculate(self, block):
        data = struct.unpack("16I",block)
        a, b, c, d = self.hashs
        for i in xrange(64):
            f = self.functions[i/16](b,c,d)
            g = self.indexs[i/16](i)
            a, b, c, d = d, (b + self.leftRotate(a + f + self.constants[i] + data[g],self.rotates[i])) & 0xFFFFFFFF, b, c
        for index,value in enumerate([a, b, c, d]):
            self.hashs[index] += value
            self.hashs[index] &= 0xFFFFFFFF
    def padding(self, length):
        L = (56-length%64+64)%64
        return ('\x80' + '\x00'*(L-1) if L else '') + struct.pack('Q',length*8)
    def hash(self, message):
        message += self.padding(len(message))
        # Every 64 bytes will be a block
        for i in xrange(0,len(message),64):
            self.calculate(message[i:i+64])
        # Append magic number together ( answer )
        return "".join(['{0:0{1}x}'.format((x >> (i*8)) & 0xFF,2) for x in self.hashs for i in xrange(4)])
    def LEA(self,hashed,message,length,append):
        length += len(message)
        _append = append # origin append string
        self.hashs = [sum([int(hashed[i+j:i+j+2],16) << (j*4) for j in xrange(0,8,2)]) for i in xrange(0,len(hashed),8)]
        pad = self.padding(length)
        append += self.padding(length+len(pad)+len(append))
        # Every 64 bytes will be a block
        for i in xrange(0,len(append),64):
            self.calculate(append[i:i+64])
        # Append magic number together ( answer )
        return (message+pad+_append,"".join(['{0:0{1}x}'.format((x >> (i*8)) & 0xFF,2) for x in self.hashs for i in xrange(4)]))
 
if __name__ == '__main__':
    m = md5()
    if not (len(sys.argv) == 2 or (len(sys.argv) == 6 and sys.argv[1] == "-LEA")):
        print "usage: python md5.py <value>"
        print "       python md5.py -LEA <hash value> <origin message> <salt length> <append message>"
        exit(1)
    if sys.argv[1] == "-LEA":
        answer = m.LEA(sys.argv[2],sys.argv[3],int(sys.argv[4]),sys.argv[5])
        print "modified message : ",repr(answer[0])
        print "modified hash value : ",answer[1]
    else:
        print m.hash(sys.argv[1])