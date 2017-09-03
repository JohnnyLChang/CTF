from Crypto.Cipher import AES
import base64
import sys

obj = AES.new('n0t_just_t00ling', AES.MODE_CBC, '7215f7c61c2edd24')
ciphertext = sys.argv[1]
message = obj.decrypt(base64.b64decode(ciphertext))

print message
