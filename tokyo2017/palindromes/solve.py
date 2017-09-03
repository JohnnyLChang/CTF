# coding: utf-8
from pwn import *

class TrieNode:
    def __init__(self):
        self.word_idx = -1
        self.leaves = {}

    def insert(self, word, i):
        cur = self
        for c in word:
            if not c in cur.leaves:
                cur.leaves[c] = TrieNode()
            cur = cur.leaves[c]
        cur.word_idx = i

    def find(self, s, idx, res):
        cur = self
        print cur.leaves
        for i in reversed(xrange(len(s))):
            if s[i] in cur.leaves:
                cur = cur.leaves[s[i]]
                if self.is_palindrome(s, i - 1):
                    res.append([cur.word_idx, idx])
            else:
                break

    def is_palindrome(self, s, j):
        i = 0
        while i <= j:
            if s[i] != s[j]:
                return False
            i += 1
            j -= 1
        return True

class Solution_MLE(object):
    def palindromePairs(self, words):
        """
        :type words: List[str]
        :rtype: List[List[int]]
        """
        res = []
        trie = TrieNode()
        for i in xrange(len(words)):
            trie.insert(words[i], i)

        for i in xrange(len(words)):
            trie.find(words[i], 0, res)

        return res

class Solution_TLE(object):
    def palindromePairs(self, words):
        """
        :type words: List[str]
        :rtype: List[List[int]]
        """
        def manacher(s, P):
            def preProcess(s):
                if not s:
                    return ['^', '$']
                T = ['^']
                for c in s:
                    T +=  ["#", c]
                T += ['#', '$']
                return T
    
            T = preProcess(s)
            center, right = 0, 0
            for i in xrange(1, len(T) - 1):
                i_mirror = 2 * center - i
                if right > i:
                    P[i] = min(right - i, P[i_mirror])
                else:
                    P[i] = 0
                while T[i + 1 + P[i]] == T[i - 1 - P[i]]:
                    P[i] += 1
                if i + P[i] > right:
                    center, right = i, i + P[i]

        prefix, suffix = collections.defaultdict(list), collections.defaultdict(list)
        for i, word in enumerate(words):
            P = [0] * (2 * len(word) + 3)
            manacher(word, P)
            for j in xrange(len(P)):
                if j - P[j] == 1:
                    prefix[word[(j + P[j]) / 2:]].append(i)
                if j + P[j] == len(P) - 2:
                    suffix[word[:(j - P[j]) / 2]].append(i)
        res = []
        for i, word in enumerate(words):
            for j in prefix[word[::-1]]:
                res.append([i, j])
            for j in suffix[word[::-1]]:
                if len(word) != len(words[j]):
                    res.append([j, i])
        return res

obj = Solution_TLE()
test = 'a aa aaa aaaa aaaaa'
tokens = test.split()
print tokens
res = obj.palindromePairs(tokens)
print len(res)

pause()

r = remote('ppc1.chal.ctf.westerns.tokyo', 8765)
print r.recvuntil('----- START -----')
r.recvline()


def plaindromes():
    obj = Solution_TLE()
    print r.recvline()
    count = r.recvline()
    strings = r.recvline()
    tokens = strings.split()
    answer = str(len(obj.palindromePairs(tokens)))
    print tokens
    print answer
    r.sendline(answer)
    print r.recvline()
    print r.recvline()

for i in range(0,50):
    plaindromes()
r.interactive()
