#!/usr/bin/env python3
import random, gmpy2, struct
random = random.SystemRandom()

bits = 2048
bits = 256
e = 65537

# Amount of coprimes
def phi(p, q):
    return (p-1)*(q-1)

# Extended Euclidean algorithm
def egcd(a, b):
    if a == 0:
        return (b, 0, 1)
    g, y, x = egcd(b%a,a)
    return (g, x - (b//a) * y, y)

def modinv(a, m):
    g, x, y = egcd(a, m)
    if g != 1:
        raise Exception('No modular inverse')
    return x%m

def prime_factors(n):
    i = 2
    factors = []
    while i * i <= n:
        if n % i:
            i += 1
        else:
            n //= i
            factors.append(i)
    if n > 1:
        factors.append(n)
    return factors

p = gmpy2.next_prime(random.randrange(1 << bits // 2))
q = gmpy2.next_prime(random.randrange(1 << bits // 2))

d = modinv(e, phi(p, q))

print("p",p)
print("q",q)
#print("e",e)
#print("d",d)

n = p * q
l = (p ^ q) * (p + q)
print(p^q)
print("  d=",d)
print("  l=",l)
print("test d", (d*e)%phi(p,q))
print("test l", (d*e)%l)
print("phi=",phi(p,q))



#print("n",n)
#print("l",l)

flag = open('flag.txt', 'rb').read()
m = int.from_bytes(flag, 'big')

with open('test.txt', 'w') as f:
    f.write('{:#x}\n'.format(n))
    f.write('{:#x}\n'.format(l))
    f.write('{:#x}\n'.format(pow(m, e, n)))

enc = pow(m,e,n)
print("private: d,n",d,n)
dec = pow(enc,d,n)
print((int(dec)).to_bytes(32, byteorder="big"))
