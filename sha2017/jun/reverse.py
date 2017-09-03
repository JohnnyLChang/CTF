import os

def reverse(b):
    x = b >> 4
    x += (b & 0x0f) << 4
    return x

f = open('reverse', 'rb')
b = bytearray(f.read())[::-1]

for i in xrange(0, len(b)):
    b[i] = reverse(b[i])

out = open('reverse_flag.png', 'wb')
out.write(b)
out.close()
