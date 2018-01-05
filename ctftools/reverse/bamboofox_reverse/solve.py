#!/usr/bin/env python

from pwn import *

ELF_PATH = "./lasmhard"
elf = ELF(ELF_PATH)

r = process(["gdb", ELF_PATH])

start = 0x555555554000
#context.log_level = 'debug'
def init():
    r.sendline("pset option ansicolor off")
    r.sendline("set prompt (gdb)")

def b(p):
    if isinstance(p, str):
        r.sendlineafter("(gdb)", "b "+ p)
    else:
        r.sendlineafter("(gdb)", "b *" + hex(p))

def run(flag = 'a'):
    r.sendlineafter("(gdb)","r")
    r.sendlineafter("Input magic string:",flag)

def c():
    r.sendlineafter("(gdb)","c")

stop = ("(gdb)")
def p(register):
    cmd = "p " + register
    r.sendlineafter(stop, cmd)
    ret = r.recvuntil(stop)
    r.unrecv(stop)
    return ret[ret.index(' = ')+3:ret.index('\n')].strip()

def x(size, fmt, addr):
    #log.info("examine: " + addr)
    cmd = "x/" + str(size) + fmt + " " + addr
    r.sendlineafter("(gdb)", cmd)
    ret = r.recvuntil("(gdb)")
    r.unrecv("(gdb)")
    try:
        return ret[ret.index(':')+1:ret.index('\n')].strip()
    except:
        print ret
        return '0'

if __name__ == "__main__":
    init()
    run()
    b(start+0x125e)
    chars = '_{}'+string.ascii_letters + string.digits
    flag = 'BAMBOOFOX'
    for i in range(len(flag), 42):
        for j in range(0, len(chars)):
            tmp = flag+chars[j]
            run(tmp+'a'*(42-len(flag)))
            for k in range(0, i):
                c()
            eax = p('$eax')
            edx = p('$edx')
            if eax == edx:
                flag+=chars[j]
                print flag
                break
    r.interactive()