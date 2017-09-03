# coding: utf-8
from pwn import *
p = process(['/bin/wine', 'asby.exe'])
p = process(['/usr/share/wine', 'asby.exe'])
p = process(['/usr/bin/wine', 'asby.exe'])
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
sh.sendline('flag{')
p.sendline('flag{')
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
p.sendline('flag{')
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
p.sendline('flag{')
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recvline(timeout=1)
p.recv(timeout=1)
p.sendline('flag{')
p.sendline('flag{')
p.recv(timeout=1)
chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'
chars[1]
chars[3]
prefix = 'flag{'
for c in chars:
    print c
    
for c in chars:
    p.sendline(prefix+c)
    lastline = ''
    while(True):
        s = p.recvline()
        if len(s) > 0:
            lastline = s
        else:
            break
    print lastline
    
for c in chars:
    p.sendline(prefix+c)
    lastline = ''
    while(True):
        s = p.recvline()
        print s
        if len(s) > 0:
            lastline = s
        else:
            break
    print lastline
    
for c in chars:
    p.sendline(prefix+c)
    lastline = ''
    while(True):
        s = p.recvline()
        print len(s)
        if len(s) > 0:
            lastline = s
        else:
            break
    print lastline
    
p.sendline('flag{')
p.recvline()
p.recvline()
p.recvline()
p.recvline()
p.recvline()
p.recvline()
for c in chars:
    p.sendline(prefix+c)
    lastline = ''
    while(True):
        s = p.recvline(timeout=0.1)
        print len(s)
        if len(s) > 0:
            lastline = s
        else:
            break
    print lastline
    
for c in chars:
    p.sendline(prefix+c)
    lastline = ''
    while(True):
        s = p.recvline(timeout=0.1)
        print len(s)
        if len(s) > 0:
            lastline = s
        else:
            break
    print lastline
    
    
for c in chars:
    p.sendline(prefix+c)
    lastline = ''
    print prefix+c
    while(True):
        s = p.recvline(timeout=0.1)
        print len(s)
        if len(s) > 0:
            lastline = s
        else:
            break
    print lastline
    
    
for c in chars:
    p.sendline(prefix+c)
    lastline = ''
    print prefix+c
    while(True):
        s = p.recvline(timeout=0.1)
        print len(s)
        if len(s) > 0:
            lastline = s
        else:
            break
    print lastline[-8:] == "CORRECT!"
    
    
    
for c in chars:
    p.sendline(prefix+c)
    lastline = ''
    print prefix+c
    while(True):
        s = p.recvline(timeout=0.1)
        print len(s)
        if len(s) > 0:
            lastline = s
        else:
            break
    print lastline[-8:]
    print lastline[-8:] == "CORRECT!"
    
    
    
for c in chars:
    p.sendline(prefix+c)
    lastline = ''
    print prefix+c
    while(True):
        s = p.recvline(timeout=0.1)
        print len(s)
        if len(s) > 0:
            lastline = s
        else:
            break
    print lastline[-8:]
    print lastline[-8:] == "RRECT!"
    
    
    
for c in chars:
    p.sendline(prefix+c)
    lastline = ''
    print prefix+c
    while(True):
        s = p.recvline(timeout=0.1)
        print len(s)
        if len(s) > 0:
            lastline = s
        else:
            break
    print lastline[-8:]
    print lastline[-8:] == "RRECT!\r\n"
    
    
    
while(True):
    for c in chars:
        p.sendline(prefix+c)
        lastline = ''
        print prefix+c
        while(True):
            s = p.recvline(timeout=0.1)
            print len(s)
            if len(s) > 0:
                lastline = s
            else:
                break
        if lastline[-8:] == "RRECT!\r\n":
            prefix = prefix + c
            print prefix
            break
    
    
    
while(True):
    for c in chars:
        p.sendline(prefix+c)
        lastline = ''
        print prefix+c
        while(True):
            s = p.recvline(timeout=0.1)
            if len(s) > 0:
                lastline = s
            else:
                break
        if lastline[-8:] == "RRECT!\r\n":
            prefix = prefix + c
            print prefix
            break
    
    
    
get_ipython().magic(u'save asby.py ~0/')
