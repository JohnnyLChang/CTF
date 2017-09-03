import random, string, sys, os
from time import time
from Crypto.Cipher import AES
import base64
from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw
from PIL import ImageFilter
import textwrap
from io import BytesIO

p = 'Hb8jnSKzaNQr5f7p'

def get_iv(modified_time):
    iv = ""
    random.seed(int(modified_time))  
    for i in range(0,16):
       iv += random.choice(string.letters + string.digits)
    return iv
 
def decrypt(m, p, i):
    aes = AES.new(p, AES.MODE_CFB, i)
    return aes.decrypt(base64.b64decode(m))

def find_images():
    i = []
    #for r, d, f in os.walk(os.environ['HOME']):
    for r, d, f in os.walk("."):
        for g in f:
            if g.endswith(".png"):
                i.append((os.path.join(r, g)))
    return i

for image in find_images() :
   modified_time = int( os.stat(image).st_mtime )
   iv = get_iv( modified_time )
   data = open( image , 'r').read()
   pos = data.find('IEND') + 9
   data = data[pos:]
   flag = open( image + 'dec.png' , 'w' ).write ( decrypt( data,p,iv) )


