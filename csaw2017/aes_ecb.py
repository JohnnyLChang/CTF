# coding: utf-8
from pwn import *
p = remote('crypto.chal.csaw.io', 1578)
p.recv()
def guessing(p):
    p.recv()
    p.sendline('a'*15)
    ci = p.recvline()[0:16]
    for t in string.printable:
        p.recv()
        p.sendline('a'*15+t)
        bi = p.recvline()[0:16]
        if bi == ci:
            print t
    
p = remote('crypto.chal.csaw.io', 1578)
guess(p)
guessing(p)
def guessing(p):
    p.recv()
    p.sendline('a'*15)
    ci = p.recvline()[0:16]
    print ci
    for t in string.printable:
        p.recv()
        p.sendline('a'*15+t)
        bi = p.recvline()[0:16]
        print bi
        if bi == ci:
            print t
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
def guessing(p):
    p.recv()
    p.sendline('a'*15)
    p.recvuntil('Your Cookie is:')
    ci = p.recvline()[0:16]
    print ci
    for t in string.printable:
        p.recv()
        p.sendline('a'*15+t)
        p.recvuntil('Your Cookie is:') 
        bi = p.recvline()[0:16]
        print bi
        if bi == ci:
            print t
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = ""
def guessing(p):
    for i in range(1, 16):
        p.recv()
        p.sendline('a'*(16-i)+flag)
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[0:16]
        print ci
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[0:16]
            print bi
            if bi == ci:
                flag += t
                print flag
                break;
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = ""
def guessing(p):
    global flag
    for i in range(1, 16):
        p.recv()
        p.sendline('a'*(16-i)+flag)
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[0:16]
        print ci
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[0:16]
            print bi
            if bi == ci:
                flag += t
                print flag
                break;
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = ""
def guessing(p):
    global flag
    for i in range(1, 16):
        p.recv()
        p.sendline('a'*(16-i)+flag)
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[0:16]
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[0:16]
            if bi == ci:
                flag += t
                print flag
                break;
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = ""
context.log_level = 'debug'
def guessing(p):
    global flag
    for i in range(1, 16):
        p.recv()
        p.sendline('a'*(16-i)+flag)
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[0:16]
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[0:16]
            if bi == ci:
                flag += t
                print flag
                break;
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = ""
context.log_level = 'debug'
def guessing(p):
    global flag
    for i in range(1, 16):
        p.recv()
        p.sendline('a'*(16-i))
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[0:16]
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[0:16]
            if bi == ci:
                flag += t
                print flag
                break;
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = ""
context.log_level = 'error'
def guessing(p):
    global flag
    for i in range(1, 16):
        p.recv()
        p.sendline('a'*(16-i))
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[0:16]
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[0:16]
            if bi == ci:
                flag += t
                print flag
                break;
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = ""
context.log_level = 'error'
def guessing(p):
    global flag
    for i in range(1, 17):
        p.recv()
        p.sendline('a'*(16-i))
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[0:16]
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[0:16]
            if bi == ci:
                flag += t
                print flag
                break;
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = "flag{Crypt0_is_s"
context.log_level = 'error'
def guessing(p):
    global flag
    for i in range(1, 17):
        p.recv()
        p.sendline('a'*(16-i))
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[0:32]
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[0:32]
            if bi == ci:
                flag += t
                print flag
                break;
    
guessing(p)
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
p = remote('crypto.chal.csaw.io', 1578)
flag = "flag{Crypt0_is_s"
context.log_level = 'debug'
def guessing(p):
    global flag
    for i in range(1, 17):
        p.recv()
        p.sendline('a'*(16-i)+flag)
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[0:32]
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[0:32]
            if bi == ci:
                flag += t
                print flag
                break;
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = "flag{Crypt0_is_s"
context.log_level = 'info'
def guessing(p):
    global flag
    for i in range(1, 17):
        p.recv()
        p.sendline('a'*(16-i)+flag)
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[0:32]
        print ci
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[0:32]
            if bi == ci:
                flag += t
                print flag
                break;
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = "flag{Crypt0_is_s"
context.log_level = 'info'
def guessing(p):
    global flag
    for i in range(1, 17):
        p.recv()
        p.sendline('a'*(16-i)+flag)
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[0:32]
        print ci
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[0:32]
            print bi
            if bi == ci:
                flag += t
                print flag
                break;
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = "flag{Crypt0_is_s"
context.log_level = 'info'
def guessing(p):
    global flag
    for i in range(1, 17):
        p.recv()
        p.sendline('a'*(16-i)+flag)
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[0:32]
        print ci
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[0:32]
            print bi
            if bi == ci:
                flag += t
                print flag
                break;
    
flag = "flag{Crypt0_is_s"
context.log_level = 'info'
def guessing(p):
    global flag
    for i in range(1, 17):
        p.recv()
        p.sendline('a'*(16-i)+flag)
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[0:32]
        print ci
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[0:32]
            print bi
            if bi == ci:
                flag += t
                print flag
                break;
                
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
guessing(p)
flag = "flag{Crypt0_is_s00000000000000000000000000"
context.log_level = 'info'
def guessing(p):
    global flag
    for i in range(1, 25):
        p.recv()
        p.sendline('a'*(24-i)+flag)
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[0:48]
        print ci
        for t in string.printable:
            p.recv()
            p.sendline('a'*(24-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[0:48]
            print bi
            if bi == ci:
                flag += t
                print flag
                break;
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = "flag{Crypt0_is_s"
context.log_level = 'error'
def guessing(p):
    global flag
    for i in range(1, 17):
        p.recv()
        p.sendline('a'*(16-i))
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[0:32]
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[0:32]
            if bi == ci:
                flag += t
                print flag
                break;
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = "flag{Crypt0_is_s"
context.log_level = 'error'
def guessing(p):
    global flag
    for i in range(1, 17):
        p.recv()
        p.sendline('a'*(16-i)+flag)
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[32:64]
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[32:64]
            if bi == ci:
                flag += t
                print flag
                break;
    
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = "flag{Crypt0_is_s"
context.log_level = 'error'
def guessing(p):
    global flag
    for i in range(1, 17):
        p.recv()
        p.sendline('a'*(16-i))
        print 'a'*(16-i)+flag
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[32:64]
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[32:64]
            if bi == ci:
                flag += t
                print flag
                break;
                   
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = "flag{Crypt0_is_s0_h@rd_t0_d0..."
context.log_level = 'error'
def guessing(p):
    global flag
    for i in range(1, 17):
        p.recv()
        p.sendline('a'*(16-i))
        print 'a'*(16-i)+flag
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[64:96]
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[64:96]
            if bi == ci:
                flag += t
                print flag
                break;
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
flag = "flag{Crypt0_is_s0_h@rd_t0_d0..."
context.log_level = 'error'
def guessing(p):
    global flag
    for i in range(1, 17):
        p.recv()
        p.sendline('a'*(16-i))
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[64:96]
        print ci
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[64:96]
            if bi == ci:
                flag += t
                print flag
                break;
flag = "flag{Crypt0_is_s"
context.log_level = 'error'
def guessing(p):
    global flag
    for i in range(1, 17):
        p.recv()
        p.sendline('a'*(16-i))
        print 'a'*(16-i)+flag
        p.recvuntil('Your Cookie is:')
        ci = p.recvline()[32:64]
        for t in string.printable:
            p.recv()
            p.sendline('a'*(16-i)+flag+t)
            p.recvuntil('Your Cookie is:') 
            bi = p.recvline()[32:64]
            if bi == ci:
                flag += t
                print flag
                break;
                   
p = remote('crypto.chal.csaw.io', 1578)
guessing(p)
