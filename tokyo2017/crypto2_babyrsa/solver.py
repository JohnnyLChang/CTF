import math
from Crypto.PublicKey import RSA 

def egcd(a, b):
	x,y, u,v = 0,1, 1,0
	while a != 0:
		q, r = b//a, b%a
		m, n = x-u*q, y-v*q
		b,a, x,y, u,v = a,r, u,v, m,n
		gcd = b
	return gcd, x, y

def decrypt(p, q, e, ct):
	n = p * q
	phi = (p - 1) * (q - 1)
	gcd, a, b = egcd(e, phi)
	d = a
	pt = pow(ct, d, n)
	return hex(pt)[2:-1].decode("hex")

def isqrt(n):
  x = n
  y = (x + n // x) // 2
  while y < x:
    x = y
    y = (x + n // x) // 2
  return x

def fermat(n):
	x = isqrt(n) + 1
	y = isqrt(x * x - n)

	while True:
		w = x * x - n - y * y
		if w == 0:
			break
		elif w > 0:
			y += 1
		else:
			x += 1
	return x+y, x-y

f = open('twrsa.pub', 'r')
twrsa = f.read()
key = RSA.importKey(twrsa)

n = key.n
e = key.e
print n
print e
p, q = fermat(n)

print "p=", str(p)
print "q=", str(q)