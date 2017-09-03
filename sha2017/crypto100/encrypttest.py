import os, sys
from hexdump import *
from Crypto.Cipher import AES


# Secure CTR mode encryption using random key and random IV, taken from
# http://stackoverflow.com/questions/3154998/pycrypto-problem-using-aesctr
for i in xrange(1, 10):
    print hexdump(os.urandom(16))
    print hexdump(os.urandom(32))

