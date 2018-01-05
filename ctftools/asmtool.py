from pwn import *
from struct import *

def print_asmstr( str ):
    for i in xrange(0, len(str), 4):
        t = str[i:i+4]
        padding = 4 - len(t)
        if padding > 0:
            t += " "*padding
        print 'push 0x{:02x}'.format(struct.unpack('<I', t)[0])

    for i in xrange(0, len(str), 8):
        t = str[i:i+8]
        padding = 8 - len(t)
        if padding > 0:
            t += " "*padding
        print 'push 0x{:04x}'.format(struct.unpack('<L', t)[0])

print_asmstr('/home/orw64/flag')
