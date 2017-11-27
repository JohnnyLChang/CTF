# coding: utf-8
context.log_level='DEBUG'
def shiftstr(param, shift):
    plain = ""
    for c in param:
        i = (ord(c)-32 + shift)%95+32
        plain += chr(i)
    return plain

with remote('neverending.tuctf.com', 12345) as p:
    while(True):
        p.sendline('abcdefg')
        print p.recvuntil('encrypted is ')
        encrypted=p.recvline()
        shift = ord(encrypted[0]) - ord('a')
        print p.recvuntil('What is ')
        solve = p.recvline()[:16]
        print solve
        plain = shiftstr(solve[:-1], shift*-1)
        print "plain:["+plain + "]"
        print p.recvuntil(':')
        p.sendline(plain)
        
    
