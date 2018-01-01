from Crypto.Cipher import AES
from os import urandom

key = urandom(16)
iv = urandom(16)


def padding(string):
    l = len(string)
    blocksize = 16
    padlen = blocksize - (l % blocksize)
    padbyte = hex(padlen).replace("0x", "")
    if len(padbyte) != 2:
        padbyte = "0" + padbyte
    string = string.encode("hex") + padlen*padbyte
    string = string.decode("hex")
    return string


def encrypt(payload):
    obj = AES.new(key, AES.MODE_CBC, iv)
    for i in xrange(len(payload)):
        if payload[i] == ";" or payload[i] == "=":
            payload = payload.replace(payload[i], "?")
    str1 = "comment1=cooking%20MCs;userdata=" + payload + ";comment2=%20like%20a%20pound%20of%20bacon"
    str1 = padding(str1)
    print str1
    ciphertext = obj.encrypt(str1)
    return ciphertext


def decrypt(ciphertext):
    obj1 = AES.new(key,AES.MODE_CBC,iv)
    plaintext = obj1.decrypt(ciphertext)
    print(plaintext)
    if ";admin=true;" in plaintext:
        print "Logged in as admin"
    else:
        print "You need to be admin to get the access!"


# Exploit using the Bit Flipping Attack!
cipher_list = []
payload = ";admin=true;"
ciphertext = encrypt(payload)
print(ciphertext)
i = 0
while i*16 <= len(ciphertext):
    cipher_list.append(ciphertext[i*16: 16 + (i*16)])
    i += 1
cipher_list.remove(cipher_list[6])

attack_on_block = cipher_list[1]
list1 = list(attack_on_block)
list1[0] = chr(ord(list1[0]) ^ ord("?") ^ ord(";"))
list1[6] = chr(ord(list1[6]) ^ ord("?") ^ ord("="))
list1[11] = chr(ord(list1[11]) ^ ord("?") ^ ord(";"))
cipher_list[1] = ''.join(list1)
ciphertext = ''.join(cipher_list)
print(ciphertext)
decrypt(ciphertext)






