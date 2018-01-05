from pwn import *
import random
n = 3
context.log_level = 'debug'
def getvalue(output, key):
    return output[output.index(key)+len(key): output.index('\n', output.index(key))]

def scaninput(msg):
    print msg

def isline(game):
    for i in range(0, 3):
        line = True
        for j in range(0, 3):
            if game[i+j*3] == 0:
                line = False
                break
        if line: return line
    for i in range(0, 3):
        line = True
        for j in range(0, 3):
            if game[i*3+j] == 0:
                line = False
                break
        if line: return line
    if game[0] == 1 and game[4] == 1 and game[8] == 1: return True
    if game[2] == 1 and game[4] == 1 and game[6] == 1: return True
    return False

def play(game, role):
    moves = getmoves(game)
    if not moves:
        if role == 'AI': return True
        else: return False
    if role == 'AI': role='ME'
    else: role = 'AI'
    for m in moves:
        newgame = list(game)
        newgame[m] = 1
        result = play(newgame, role)
        if role == 'ME' and result == False:
            return False
    return True


#find the move will let computer lose
def expore(game):
    opt = getmoves(game)
    winopt = []
    for m in opt:
        #try this step
        newgame = list(game)
        newgame[m] = 1
        #test if ai no move at the end
        if play(newgame, 'AI'): winopt.append(m)
    return winopt


def getmoves(game):
    avails = list(game)
    opt = []
    for i in range(0, len(avails)):
        if avails[i] == 0: 
            avails[i] = 1
            if not isline(avails): opt.append(i)
            avails[i] = 0
    return opt

def test():
    game = [0] * 9
    game[4] = 1
    game[2] = 1
    'expected 0,2'
    print expore(game)

def round(p):
    while True:
        msg = p.recv()
        if 'Your move:' not in msg:
            print msg
            break
        if ' Round ==========' in msg:
            print 'game started'
            game = [0] * 9
            game[4] = 1
            p.sendline('4')
            msg = p.recv()
        game[int(getvalue(msg, 'My move: '))] = 1
        opt = expore(game)
        print opt, game
        m = random.choice(opt)
        print m
        game[m] = 1
        p.sendline(str(m))

with remote('bamboofox.cs.nctu.edu.tw', 58793) as p:
    round(p)