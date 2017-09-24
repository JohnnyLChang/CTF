from pwn import *

cipher = '1b580305170002074b0a1a4c414d1f1d171d00151b1d0f480e491e0249010c15'
#cipher = '5806075204070555535b5650035700550252070205060705075b5a0055560155'
#ascii numbers: 30~39

cipherbin = bytearray(cipher.decode('hex'))
print hexdump(cipherbin)

k = string.ascii_letters+string.digits+string.punctuation

def ishex(v):
    if v > 0x2f and v < 0x40:
        return True
    if v > 0x60 and v < 0x67:
        return True
    return False

p = []
for c in cipherbin:
    str = ""
    for t in k:
        v = ord(t) ^ c
        if ishex(v):
            str += t
    print '{:02x}'.format(c)+" : "+str
    p.append(str)

def findmatch(s1, s2):
    for s in s1:
        if s in s2:
            return True
    return False


#find key length
for t in p[0]:
    for i in range(1, len(p)):
        if t in p[i]:
            x = 1
            #check all repeated occurence
            for k in range(i, len(p), i):
                if t not in p[k]:
                    x = 0
                    break
            if x == 1:
                for l in range(1, i):
                    if l+i < len(p): 
                        if False == findmatch(p[l], p[l+i]):
                            x = 0
            if x == 1:
                print '{}:{}'.format(t, i)   
