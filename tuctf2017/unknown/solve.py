# coding: utf-8
f = open('gdb.txt', 'r')
expected = f.read()
expected
f = open('gdb.txt', 'r')
expected = f.readlines()
expected
f = open('gdb.txt', 'r')
f = open('gdb.txt', 'r')
expected = f.readlines()
exp = []
for e in expected:
    if len(e) > 0 and e[0] == '$':
        print e[6:]
        
for e in expected:
    if len(e) > 0 and e[0] == '$':
        print e[6:-1]
        
        
for e in expected:
    if len(e) > 0 and e[0] == '$':
        print e[e.index('$')+1:-1]
        
        
        
for e in expected:
    if len(e) > 0 and e[0] == '$':
        print e[e.index('=')+1:-1]
        
        
        
for e in expected:
    if len(e) > 0 and e[0] == '$':
        exp.append(int(e[e.index('=')+1:-1], 16))
        
        
        
exp
sol = {
4261066106:'T',
 52709799:'U',
 1597519905:'C',
 625171970:'F',
1508043533:'{',
4011558093:'}'}
def solve(exp, sol):
    ret = ""
    for e in exp:
        if e in sol:
            ret += sol[e]
        else:
            ret += "?"
    print ret
    return ret
solve(exp, sol)
get_ipython().system(u'rm gdb.txt')
arr = []
f = open('gdb.txt', 'r')
chk = f.readlines()
for e in chk:
    if len(e) > 0 and e[0] == '$':
        arr.a
        
        
        
for e in chk:
    if len(e) > 0 and e[0] == '$':
        print int(e[e.index('=')+1:-1], 16)
        
        
        
chkstr = abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234
for e,c in zip(chk, chkstr):
    if len(e) > 0 and e[0] == '$':
        sol[int(e[e.index('=')+1:-1], 16)] = c
        
        
        
        
chkstr = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234"
for e,c in zip(chk, chkstr):
    if len(e) > 0 and e[0] == '$':
        sol[int(e[e.index('=')+1:-1], 16)] = c
        
        
        
        
solve(exp, sol)
f = open('gdb.txt', 'r')
chk = f.readlines()
chkstr = "567890_567890_567890_567890_567890_567890_567890_567890_"
for e,c in zip(chk, chkstr):
    if len(e) > 0 and e[0] == '$':
        sol[int(e[e.index('=')+1:-1], 16)] = c
        
        
        
        
        
solve(exp, sol)
sol
f = open('gdb.txt', 'r')
chk = f.readlines()
chkstr = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234"
i = 0
for e in chk:
    if len(e) > 0 and e[0] == '$':
        sol[int(e[e.index('=')+1:-1], 16)] = chkstr[i]
        i += 1
        
        
        
        
        
sol
chkstr = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234"
i = 0
for e in chk:
    if len(e) > 0 and e[0] == '$':
        sol[int(e[e.index('=')+1:-1], 16)] = chkstr[i]
        i += 1
        print i
        
        
        
        
solve(exp, sol)
sol = {
4261066106:'T',
 52709799:'U',
 1597519905:'C',
 625171970:'F',
1508043533:'{',
4011558093:'}'}
chkstr = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234"
i = 0
for e in chk:
    if len(e) > 0 and e[0] == '$':
        sol[int(e[e.index('=')+1:-1], 16)] = chkstr[i]
        i += 1
        print i
        
        
        
        
solve(exp, sol)
chk = f.readlines()
f = open('gdb.txt', 'r')
f = open('gdb.txt', 'r')
chk = f.readlines()
chkstr = "567890_hijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234"
i = 0
for e in chk:
    if len(e) > 0 and e[0] == '$':
        sol[int(e[e.index('=')+1:-1], 16)] = chkstr[i]
        i += 1
        print i
        
        
        
        
        
sol
solve(exp, sol)
get_ipython().magic(u'save solve.py 0~')
get_ipython().magic(u'save solve.py ~0')
get_ipython().magic(u'save solve.py ~0')
get_ipython().magic(u'save solve.py ~0/')
