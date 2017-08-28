from __future__ import print_function
import difflib
import sys
import string
from difflib import Differ
correct = "\x68\x3C\x79\x71\x63\x7C\x81\x92\x92\x65\x65\x93\x92\x49\x79\x92\x38\x6C\x3C\x6F\x7B\x87\x58\x55\x89\x5A\x59\x7E\x7E\x6B\x87\x6C\x57\x6C\x6B\x58\x59\x5A\x5A\x6F"
def algo(a1, offset):
  result = ""
  v2 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  v3 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  v4 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  
  for i in xrange(20):
    v4[i] = ord(a1[i])
  for j in xrange(20,40):
    v3[j-20]= ord(a1[j]) 
  for k in xrange(0,20):
    v4[k] = (((((v4[k] ^ 0xC) + 6) ^ 0xD) + 7) ^ 0xE) + 8
    v3[k] = (((((v3[k] ^ 0xF) + 9) ^ 0x10) + 10) ^ 0x11) + 11
  for l in xrange(0,20):
    v2[l] = v4[l]
  for m in xrange(20,40):
    v2[m] = v3[m-20]
  flag = ''.join([chr(x) for x in v2])
  #print(flag)
  #print(correct)
  
  if(flag != correct):
    result = "Wrong"
  else:
    result = "Correct"
  return result, flag[offset] == correct[offset]
def main():
  v2 = 0
  v4 = ""
  flag = "" # 0x20
  v6 = ''
  v7 = 0
  i = 0
  result = 'Wrong'
  offset = 7
  flag = "h4ck1t{AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA}"
  diff = False
  #print (string.printable)
  #exit(0)
  while result == 'Wrong':
    #print offset
    for y in string.printable:  
      v4 = ""
      flag = [x for x in flag]
      #print offset
      flag[offset] = y
      #print(flag)
      #print('\r'+''.join(flag),end='')
      i = 0
      while True:
        v2 = i
        if (v2 >= len(flag)):
          break
        v4 += flag[i]
        i +=1
      #print (v4,offset)
      result, diff = algo(v4, offset)
      if result == 'Correct':
        break
      #print (diff,y)
      #print len(list(diff))
      if diff:
        diff = False
        offset += 1
        break
  print(''.join(flag), result)
main()

