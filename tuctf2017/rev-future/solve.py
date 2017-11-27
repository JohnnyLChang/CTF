from pwn import *

def genMatrix(flag):
    mat = [ [ 0 for i in range(5) ] for j in range(5) ] 
    for i in range(0,25):
        m = (i * 2) % 25
        f = (i * 7) % 25
        mat[m/5][m%5] = flag[f]
    return mat


def genAuthString(mat):
    auth = [0] * 18
    auth[0] = mat[0][0] + mat[4][4]
    auth[1] = mat[2][1] + mat[0][2]
    auth[2] = mat[4][2] + mat[4][1]
    auth[3] = mat[1][3] + mat[3][1]
    auth[4] = mat[3][4] + mat[1][2]
    auth[5] = mat[1][0] + mat[2][3]
    auth[6] = mat[2][4] + mat[2][0]
    auth[7] = mat[3][3] + mat[3][2] + mat[0][3]
    auth[8] = mat[0][4] + mat[4][0] + mat[0][1]
    auth[9] = mat[3][3] + mat[2][0]
    auth[10] = mat[4][0] + mat[1][2]
    auth[11] = mat[0][4] + mat[4][1]
    auth[12] = mat[0][3] + mat[0][2]
    auth[13] = mat[3][0] + mat[2][0]
    auth[14] = mat[1][4] + mat[1][2]
    auth[15] = mat[4][3] + mat[2][3]
    auth[16] = mat[2][2] + mat[0][2]
    auth[17] = mat[1][1] + mat[4][1]
    return auth

def genMatrix2(flag):
    mat = [ [ 0 for i in range(5) ] for j in range(5) ] 
    for i in range(0,25):
        m = (i * 2) % 25
        f = (i * 7) % 25
        mat[m/5][m%5] = ord(flag[f])
    return mat

def genAuthString2(mat):
    auth2 = [0] * 18
    auth2[0] = mat[0][0] + mat[4][4]
    auth2[1] = mat[2][1] + mat[0][2]
    auth2[2] = mat[4][2] + mat[4][1]
    auth2[3] = mat[1][3] + mat[3][1]
    auth2[4] = mat[3][4] + mat[1][2]
    auth2[5] = mat[1][0] + mat[2][3]
    auth2[6] = mat[2][4] + mat[2][0]
    auth2[7] = (mat[3][3] + mat[3][2] + mat[0][3])%0xff
    auth2[8] = (mat[0][4] + mat[4][0] + mat[0][1])%0xff
    auth2[9] = mat[3][3] + mat[2][0]
    auth2[10] = mat[4][0] + mat[1][2]
    auth2[11] = mat[0][4] + mat[4][1]
    auth2[12] = mat[0][3] + mat[0][2]
    auth2[13] = mat[3][0] + mat[2][0]
    auth2[14] = mat[1][4] + mat[1][2]
    auth2[15] = mat[4][3] + mat[2][3]
    auth2[16] = mat[2][2] + mat[0][2]
    auth2[17] = mat[1][1] + mat[4][1]
    return auth2


flag = "TUCTF{123456789?????????}"

mat = genMatrix(flag)
print mat
myauth = genAuthString(mat)
print myauth

auth = bytearray(b'\x8b\xce\xb0\x89\x7b\xb0\xb0\xee\xbf\x92\x65\x9d\x9a\x99\x99\x94\xad\xe4\x00')

flag1 = list(flag)
for i in range(0, 7):
    flag1[flag.index(myauth[i][1])] = chr(auth[i] - ord(myauth[i][0]))

print ''.join(flag1)

flag2 = "TUCTF{5y573m5abcdefghijk}"
mat = genMatrix(flag2)
myauth = genAuthString(mat)
print myauth

flag3 = list(flag2)
for i in range(9, 18):
    print myauth[i][0]
    flag3[flag2.index(myauth[i][0])] = chr(auth[i] - ord(myauth[i][1]))
print ''.join(flag3)

flag4 = "TUCTF{5y573m5_0f_4_d0wn!}"
mat = genMatrix2(flag4)
myauth = genAuthString2(mat)
print myauth
print list(auth)