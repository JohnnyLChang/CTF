# primepwn write-up (34C3 CTF)

02 January 2018 on [Write-ups](https://blog.bushwhackers.ru/tag/write-up/),
[pwn](https://blog.bushwhackers.ru/tag/pwn/)

We are given an `x86_64` ELF binary and remote server address. The goal is to
gain remote execution and read the flag.

## Reverse engineering

Let's open the binary with your favourite disassembler and see what is going
on. I'll be using IDA Pro.

Function `main` is rather simple: it calls the function `test_prime`, then
returns.

Function `test_prime` shows more complicated logic:

    
    
    __int64 test_prime()
    {
      unsigned int i; // [rsp+Ch] [rbp-14h]
      size_t v2; // [rsp+18h] [rbp-8h]
    
      if ( mmap((void *)0x1337000, 0x1000uLL, 7, 50, -1, 0LL) != (void *)0x1337000 )
      {
        perror("error on mmap");
        exit(1);
      }
      v2 = fread((void *)0x1337000, 1uLL, 4096uLL, _bss_start);
      for ( i = 0; (signed int)i < v2; ++i )
      {
        if ( !(unsigned __int8)is_prime(*(_BYTE *)((signed int)i + 0x1337000LL)) )
        {
          printf("Byte %d (value: %u) is not prime.\n", i, *(unsigned __int8 *)((signed int)i + 0x1337000LL));
          exit(0);
        }
      }
      puts("All bytes are prime!");
      return jump_to((__int64 (*)(void))0x1337000);
    }
    

Basically, it allocates `0x1000` RWX bytes at address `0x1337000`, reads
`0x1000` bytes from `stdin` to that buffer, checks something and jumps
directly to the buffer's beginning.

From the line `puts("All bytes are prime!");` we can assume that it checks
that all bytes are prime. Let's take a look at the function `is_prime`:

    
    
    signed __int64 __fastcall is_prime(unsigned __int8 a1)
    {
      signed int i; // [rsp+10h] [rbp-4h]
    
      if ( a1 <= 1u )
        return 0LL;
      for ( i = 2; i <= 255 && a1 > i; ++i )
      {
        if ( !(a1 % i) )
          return 0LL;
      }
      return 1LL;
    }
    

It does indeed check that the passed argument (`uint8_t`) is prime.

In conclusion, the binary is pretty simple: it executes the passed shellcode
at the known address but all bytes should be prime numbers.

## Creating shellcode

Prime bytes definitely add a challenging part to the task. Since we have RWX
memory at known address, the good approach will be to try to make two-stage
shellcode: the first stage will be "prime" and will write a normal shellcode
(second stage) to known address and then run it. That way we only need to make
a write-what-where primitive in prime bytes.

Let's take a look at the `x86_64` opcode table to see what instructions we can
use. I used [this table](http://ref.x86asm.net/coder64.html) and an assembler
to check my assumptions. After that, the following table was born:

    
    
    2       add r8, r/m8
    3       add r, r/m
    5       add eax, imm32              49 05   add rax, imm32
    7       -
    b       or r, r/m
    d       or eax, imm32               49 0d   or rax, imm32
    11      adc r/m, r
    13      adc r, r/m
    17      -
    1d      sbb eax, imm32              49 1d   sbb rax, imm32
    1f      -
    25      and eax, imm32              49 25   and rax, imm32
    29      sub r/m, r
    2b      sub r, r/m
    2f      -
    35      xor eax, imm32              49 35   xor rax, imm32
    3b      cmp
    3d      cmp
    43      REX.XB
    47      REX.RXB
    49      REX.WB
    4f      REX.WRXB
    53      push   rbx
    59      pop    rcx
    61      -
    65      GS
    67      addr32 override
    6b      imul r, r/m, imm8
    6d      -
    71      jno
    7f      jg
    83      add/or/adc/sbb/and/sub/xor/cmp r/m, imm8
    89      mov r/m, r
    8b      mov r, r/m
    95      xchg eax, ebp               49 95   xchg r13,rax
    97      xchg eax, edi               49 97   xchg r15,rax
    9d      popf
    a3      movabs off, rAX
    a7      cmps
    ad      lods eax, [rsi]
    b3      mov bl,imm8
    b5      mov ch,imm8
    bf      mov edi, imm32
    c1      rol/ror/rcl/rcr/shl/shr/sal/sar r/m, imm8
    c5      -
    c7      mov r/m, imm32
    d3      rol/ror/rcl/rcr/shl/shr/sal/sar r/m, CL
    df
    e3      jecxz
    e5      -
    e9      jmp
    ef      -
    f1      -
    fb      -
    

First of all, we see useful operations like `add eax, imm32`, `and eax,
imm32`, `xor eax, imm32`, etc. Using `and` we can zero the `EAX` in two ops:
`and eax, 0x02020202; and eax, 0x05050505`. After that there are several ways
to get any number in `EAX`. I proceeded with opcode `xor` because it occured
that you can take 3 prime bytes, xor them and get any byte in range `[0-255]`.

Okay, we can get any number in `EAX`, but what registers can we move that
number to? We have no `mov r, r` opcode but we have `xchg eax, ebp` and `xchg
eax, edi`.

> Note: we also have `mov edi, imm32` opcode but it limits us to prime-bytes
values of `EDI`.

Now we can set `EAX`, `EBP` and `EDI` to arbitrary values. What if we already
can do something like `mov r/m, r`? We have this opcode in our list, `89`.
After a bit of poking it occures that `mov dword ptr [rdi], eax` assembles to
`89 07` that are prime bytes. Looks like we have our desired write-what-where
primitive.

The scheme is:

  1. set addr in `EAX`
  2. move `EAX` to `EDI`
  3. set value in `EAX`
  4. move `EAX` to `[RDI]`

> Note: we have a lot of "set number in `EAX`" operations, each one takes 2
ANDs to zero the `EAX` and then 3 XORs to make a number. To get rid of ANDs we
track `EAX` value through the process of building the shellcode, then we can
XOR `EAX` with any number, so we XOR it with `N ^ EAX` to get `N` in `EAX`.

From that point we simply take some shellcode, for example, `shellcraft.sh()`
from `pwntools`, write it DWORD by DWORD to our memory after the first stage,
and pass the control. Since we do not have a NOP, we can use some other
harmless one-byte instruction to fill the rest of memory like `xchg edi, eax`
(`97`). Victory!

### How NOT to create the shellcode

Here I'll explain the more complicated solution I came up with on the CTF.

After finding a way to set up arbitrary values in `EAX`, `EDI` and `EBP` I
just started to search randomly for other useful unstructions to proceed with
and that's how I found the `mov dword ptr [rdi], ebx`. Somehow I didn't try to
change `EBX` to `EAX` but proceeded with `EBX` version. But it gives us a
problem: we don't have the control over the `EBX` register... or do we?

We have `mov dword ptr [rdi], ebx`, and we have `mov r/m, r` and `mov r, r/m`
instructions in general, that means, we have `mov ebx, dword ptr [rdi]`. We
also have `add r, r/m`. These two instructions give us the following scheme:
search for different numbers in the binary itself (since we know base
address), place one in the `EBX`, then add other numbers until we get the
needed one. For these purposes I take first `0xA70` bytes from binary. There
we can find numbers like that: `['0x0', '0x1', '0x2', '0x3', '0x4', '0x5',
..., '0xe28', '0x1b90', '0x441f', '0x8be8', '0xb807', '0xb81b', '0xc308',
'0xc3f3', '0xfffc', '0x10001', '0x10102', '0x1be00', '0x20000', ...,
'0xf66c35d', '0xf66f4ff', '0x1000be00', '0x10070190', '0x100e4100',
'0x100e4200', '0x100e4218', '0x10615567', '0x14ff41ff', '0x19e8c789',
'0x1f0fc35d', '0x2008f315', '0x2009ce05', '0x20297525', ..., '0xffffffb0',
'0xffffffc0', '0xffffffd0', '0xffffffe0']`. There are numbers almost similar
to powers of 2, we need only ~log(N) additions to produce number N with them.

The other problem is how to efficiently find the optimal set of numbers whose
sum gives the needed one. I believe that this problem somehow relates to
[subset sum problem](https://en.wikipedia.org/wiki/Subset_sum_problem) and so
is NP-complete. I use a greedy approach that takes maximum number that does
not exceeds our goal, then keeps adding the largest possible numbers until we
get the needed one. One step of algorithm is to take a number from priority
queue, try to add each number from the binary, store sums that are less then
the goal in priority queue. It seems that this algorithm gives a suboptimal
result in constant time (constant since we have the same set of numbers and I
make constant number of steps, 1000). For example, for the number `0xCAFEBABE`
we get the following set of numbers to sum up: `(3351726080, 50087367,
3670080, 131074, 65794, 7056, 3624, 504, 3)`.

To recap, we use the following algorithm:

  1. Set up address of zero in `EDI`
  2. Move `[RDI]` to `EBX`
  3. Set up address of the addition term in `EDI`
  4. Add `[RDI]` to `EBX`
  5. Repeat steps 3 and 4 if necessary
  6. Profit

The write-what-where then looks like this:

  1. Set up value in `EBX`
  2. Set up address in `EDI`
  3. Move `EBX` to `[RDI]`

Now we can use this primitive as described in previous part "Creating
shellcode". The source code can be found
[here](https://gist.github.com/vient/1c5e9e8bab1be7e6040474cfa52917db).

That's all!

[vient's Picture](https://blog.bushwhackers.ru/author/vient/)

#### [vient](https://blog.bushwhackers.ru/author/vient/)

Reverse engineer

#### Share this post

[ Twitter ](https://twitter.com/intent/tweet?text=primepwn%20write-
up%20\(34C3%20CTF\)&url=https://blog.bushwhackers.ru/34c3-ctf-primepwn/) [
Facebook
](https://www.facebook.com/sharer/sharer.php?u=https://blog.bushwhackers.ru/34c3
-ctf-primepwn/) [ Google+
](https://plus.google.com/share?url=https://blog.bushwhackers.ru/34c3-ctf-
primepwn/)

Please enable JavaScript to view the [comments powered by
Disqus.](https://disqus.com/?ref_noscript) [

## slot machine write-up (Google CTF 2017 Finals)

"slot machine" was a hardware task in the reverse-engineering category on
Google CTF Finals 2017, which took…

](https://blog.bushwhackers.ru/slot-machine-write-up-google-ctf-2017-finals/)
[Bushwhackers' blog](https://blog.bushwhackers.ru) (C) 2018 Proudly published
with [Ghost](https://ghost.org)

