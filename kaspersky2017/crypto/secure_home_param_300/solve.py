from pwn import *

# 49 45 4e 44 ae 42 60 82
# 48 ba 4e 52 51 bd 9f 7d
sbox_chk = {
    0xff: 0x00,
    0xf2: 0x0d,
    0xf5: 0x0a,
    0xbd: 0x42,
    0xbb: 0x44,
    0xba: 0x45,
    0xb1: 0x4E,
    0xb6: 0x49,
    0xb7: 0x48,
    0xb8: 0x47,
    0xaf: 0x50,
    0xad: 0x52,
    0x9f: 0x60,
    0x7d: 0x82,
    0x76: 0x89,
    0x51: 0xae,
}

sbox = {
    0xf: 0x0,
    0xe: 0x1,
    0xd: 0x2,
    0xc: 0x3,
    0xb: 0x4,
    0xa: 0x5,
    0x9: 0x6,
    0x8: 0x7,
    0x7: 0x8,
    0x6: 0x9,
    0x5: 0xa,
    0x4: 0xb,
    0x3: 0xc,
    0x2: 0xd,
    0x1: 0xe,
    0x0: 0xf
}


def readfile(filename):
    fileContent = []
    with open(filename, mode='rb') as file:
        fileContent = file.read()
    return bytearray(fileContent)


def write(filename, content):
    fileContent = []
    with open(filename, mode='wb') as file:
        file.write(content)


cipher = readfile('secret_encrypted.png')
for i in range(0, len(cipher)):
    cipher[i] = sbox[cipher[i] >> 4] << 4 | sbox[cipher[i] & 0xf]
write('flag.png', cipher)