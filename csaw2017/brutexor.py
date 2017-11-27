#!/usr/bin/env python
#
# iheartxor is a tool for bruteforcing encoded strings
# within a boundary defined by a regular expression. It
# will bruteforce the key value range of 0x1 through 0x255
#
# Version 0.01 - still need to test passing regular expressions
# 
# Created by Alexander.Hanel@gmail).com
# 
# Usage: brutexor.py [options] <file>
#
# Options:
#   -h, --help            show this help message and exit
#   -k KEY, --key=KEY     Static XOR key to use
#   -f, --full            XOR full file
#   -r PATTERN, --re=PATTERN
#                       Regular Expression Pattern to search for

import string
import re 
import sys
from optparse import OptionParser 

def valid_ascii(char):
        if char in string.printable[:-3]:
                return True
        else:
                return None 

def xor(data, key):
        decode = ''
        if isinstance(key, basestring):
                key = int(key,16)
                
        for d in data:
                decode = decode + chr(ord(d) ^ key)
        return decode                 
        
def main(argv):
        parser = OptionParser()
        usage = 'usage: iheartxor.py [options] <file>'
        parser  =  OptionParser(usage=usage)
        parser.add_option('-k', '--key', action='store', dest='key', type='string', help='Static XOR key to use')
        parser.add_option('-f', '--full', action='store_true', dest='full', help='XOR full file')
        parser.add_option('-r', '--re', action='store', dest='pattern', type='string', help='Regular Expression Pattern to search for')
        (options, args) = parser.parse_args()
        # Test for Args 
        if len(sys.argv) < 2:
                parser.print_help()
                return
        try:
                f = open(sys.argv[len(sys.argv)-1],'rb+')
        except Exception:
                print '[ERROR] FILE CAN NOT BE OPENED OR READ!'
                return
        # Test that the full option contains a XOR Key
        if options.full != None and options.key == None:
                print '[ERROR] --FULL OPTION MUST INCLUDE XOR KEY'
                return
        # XOR the full file with key 
        if options.full != None and options.key != None:
                sys.stdout.write(xor(f.read(), options.key))
                return
        # Parse file for regular expressions 
        if options.pattern == None:
                regex = re.compile(r'\x00(?!\x00).+?\x00') 
        else:
                try:
                        regex = re.compile(pattern)
                except Exception:
                        print "ERROR: INVALID REGULAR EXPRESSION PATTERN"
                        sys.exit(1)
        buff = ''
        # for each regex pattern found
        for match in regex.finditer(f.read()):
                if len(match.group()) < 8:
                        continue 
                if options.key == None:
                        # for XOR key in range of 0x0 to 0xff
                        for key in range(1,0x100):
                                # for each byte in match of regex pattern 
                                for byte in match.group():
                                        if byte == '\x00':
                                                buff = buff + '\x00'
                                                continue 
                                        else:
                                                tmp = xor(byte,key)
                                                if valid_ascii(tmp) == None:
                                                        buff = ''
                                                        break
                                                else:
                                                        buff = buff + tmp
                                if buff != '':
                                        sys.stdout.write(hex(match.start()) + ' ' + 'key ' + hex(key) + ' ' +  buff + '\n')
                                        buff = ''
                        
                else:
                        # same as above but for static key
                        key = int(options.key,16)
                        for byte in match.group():
                                if byte == '\x00':
                                        buff = buff + '\x00'
                                        continue 
                                else:
                                        tmp = xor(byte,key)
                                        if valid_ascii(tmp) == None:
                                                buff = ''
                                                break
                                        else:
                                                buff = buff + tmp
                        if buff != '':
                                sys.stdout.write(hex(match.start()) + ' ' + 'key ' + hex(key) + ' ' + buff + '\n')
                        
                        
        return 

if __name__== '__main__':
        main(sys.argv[1:])



		
