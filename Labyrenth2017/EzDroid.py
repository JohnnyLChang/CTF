from z3 import *

L = lambda n: BitVecVal(n, 64)

s = Solver()

x = BitVec('x', 64)
s.add(x * L(-37) + L(42) == L(17206538691) )

print s.check()

model = s.model()
print model
print model[x].as_signed_long()
