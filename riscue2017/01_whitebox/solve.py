import phoenixAES
from whitebox import *

t = open('tracefile', 'wb')
inp = "A"*16

x = encrypt(inp, fault=False, idx=0, byte=0)

t.write(("41"*16+" "+x+"\n").encode('utf8'))

for idx in range(16):
    for byte in range(16):
        x = encrypt(inp, fault=True, idx=idx, byte=byte )
        t.write(("41"*16+" "+x+"\n").encode('utf8'))
        

rk_10 = phoenixAES.crack('tracefile')

from z3.z3 import *
from aes import AES
 
AES = AES()
s = Solver()
 
# make AES sbox z3-friendly
sbox = AES.sbox[::]
AES.sbox = Array("sbox", BitVecSort(8), BitVecSort(8))
for x in xrange(256):
    s.add(AES.sbox[x] == sbox[x])
 
# symbolical key expansion almost for free :)
master = [BitVec("master%d" % i, 8) for i in xrange(16)]
exp = AES.expandKey(master, 16, 11*16)

leak = map(ord,rk_10.decode("hex"))
for i in xrange(16):
    s.add(exp[160+i]==leak[i])
 
print s.check()
key = ""
model = s.model()
for m in master:
    key += chr(model[m].as_long())
print key

