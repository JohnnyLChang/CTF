import string
from Crypto.Cipher import AES
from base64 import b64encode, b64decode
import hexdump
import logging

fmt = ('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logging.basicConfig(level=logging.INFO, format=fmt)
logger = logging.getLogger(__name__)
#logger.setLevel(logging.DEBUG)

class Oracle(object):
    BLOCK_SIZE=16

    def __init__(self, IV, Cipher, yes, no):
        self.IV = IV
        self.Cipher = Cipher
        self.BLOCK_SIZE = 16
        self.yes = yes
        self.no = no
        return

    def setExpectedMsg(sef, yes, no):
        self.yes = yes
        self.no = no
        
    def setGuessfunc(self, auth_func):
        self.func_auth = auth_func

    def blockify(self, text, block_size=BLOCK_SIZE):
        return [text[i:i+block_size] for i in range(0, len(text), block_size)]

    def showhex(self, t):
        return hexdump.dump(t)

    def attack(self):
        logger.debug(self.IV)
        logger.debug(self.Cipher)
        cipher = b64decode(self.Cipher)
        blocks = self.blockify(cipher)
        cleartext = ''
        for block_num, (c1, c2) in enumerate(zip([self.IV]+blocks, blocks)):
            logger.info("cracking block {} out of {}".format(block_num+1, len(blocks)))
            i2, p2 = [0] * 16, [0] * 16 #inter-mediatevalue
            for i in range(15,-1,-1):  #test from last bytes
                logger.info("cracking block {} offset {}".format(block_num+1, i))
                found = False
                for b in range(0, 256):
                    #forge correct prefix IV
                    prefix, pad_byte = c1[:i], self.BLOCK_SIZE-i
                    suffix = bytes([pad_byte ^ val for val in i2[i+1:]])
                    #bytes(n) will create bytes array
                    #bytes([n]) will convert n into b'n'
                    evil_c1 = prefix + bytes([b]) + suffix
                    test = b64encode(evil_c1+c2).decode('ascii')
                    if self.trymessage(test):
                        if b == c1[i] and i==0xf: continue
                        logging.info('found offset {}'.format(i))
                        i2[i] = evil_c1[i] ^ pad_byte
                        p2[i] = c1[i] ^ i2[i]
                        found = True
                        break
                if not found: #last block and the padding should be 0x1
                    logger.info('last block padding should be 0x1')
                    p2[i] = 0x1
                    i2[i] = c1[i] ^ p2[i]
                print(' '.join(map(lambda x: hex(x), p2)))
            cleartext += ''.join(map(lambda x: chr(x), p2))
        
        return cleartext

    def trymessage(self, cipher):
        logger.debug('cipher: '+ cipher)
        ret = self.func_auth(cipher)
        logging.debug('return msg: '+ret)
        if self.yes in ret: return True
        elif self.no in ret: return False
        else: raise SyntaxError('no tag in return message')