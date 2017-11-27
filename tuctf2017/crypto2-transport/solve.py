import gmpy2
import struct
from Crypto.PublicKey import RSA
from Crypto.Cipher import DES

keys = (
    'ZW5jX2tleToxMzA1NTIzMDU0MDQyNjY0NTk2NDg0OTQKbjo1NDI4MDA1NzMzODAw'
    'ODQ4MjY5MTAzODEKZTo2NTUzNwppdjpkqmNUCELPqQ=='
).decode('base64')
cipher = (
    'bncFlPPa6T6JFup6dMYQn7m3uWokRWYT3K/j907seyUm8Pk19ZD9a5hgPZ/P8w0i'
    'txAyMZNyG7dOtINeCVhSxw=='
).decode('base64')

# tokenize the key pairs
enc_key, n, e, iv = [k.split(':')[1] for k in keys.split()]

# mapping the type from str to long
enc_key, n, e = map(long, (enc_key, n, e))

print n
# http://www.factordb.com/index.php?query=542800573380084826910381
p = 201559811875263582217
q = 2693

d = long(gmpy2.invert(e, (p - 1) * (q - 1)))

rsa_key = RSA.construct((n, e, d))
des_key = struct.pack('>Q', rsa_key.decrypt(enc_key))
print DES.new(des_key, DES.MODE_CBC, iv).decrypt(cipher)
