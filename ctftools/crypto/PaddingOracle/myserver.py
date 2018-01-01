#!/usr/bin/env python3
import binascii
from base64 import b64encode, b64decode
from Crypto.Cipher import AES
import oracle

with open('key', 'rb') as data:
    key = data.read().strip()

with open('flag', 'rb') as data:
    flag = data.read().strip()

IV = b"STARWAR888888888"

def pad(plain):
    # calculate padding length
    padding = (16 - len(plain) % 16)%16
    # append the padding
    plain += bytes([padding] * padding)
    assert(len(plain) % 16 == 0)
    return plain

def check(plain):
    # get the padding length
    length = plain[-1]
    if length > 16: return False

    return all(map(lambda x: x == length, plain[-length:]))

def encrypt(iv, text):
    aes = AES.new(key, AES.MODE_CBC, iv)
    text = aes.encrypt(text)
    return text

def decrypt(iv, text):
    aes = AES.new(key, AES.MODE_CBC, iv)
    text = aes.decrypt(text)
    return text

def in_message(message):
    iv, text = b64decode(message)[:16], b64decode(message)[16:]
    text = decrypt(iv, text)
    return text

def out_message(iv, text):
    text = encrypt(iv, text)
    message = b64encode(iv + text)
    return message

def checkmsg(cipher):
    try:
        # check the padding
        plain = in_message(cipher)
        if check(plain):
            print(plain)
            return("YES, I will take that")
        else:
            return("NO, padding is invalid")

    except:
        return ''

def main():
    #assert(b64encode(encrypt(IV, pad(flag))) == b"XmmSv7+azqHCSPwBYfsVKVoqq+NpOaWrRHOYlLn3GlRAg4kdAVmEdc5L9koCHcxl5U0Ee28wMqTNdZYzd/BOaynUpmthknT0QdVGLXpx5Oko7QiK7+I0UVFhi8MP0+YFigbKhXMGzuv7ySqhnakeaRhaRGjRvVShMmjL0vitvuw=")
    cipher = b64encode(encrypt(IV, pad(flag)))
    out = out_message(IV, pad(flag))
    o = oracle.Oracle(IV, cipher, 'YES', 'NO')
    o.setGuessfunc(checkmsg)
    print('plain = '+o.attack())

if __name__ == '__main__':
    main()
