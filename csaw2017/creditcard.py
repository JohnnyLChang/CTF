#!/usr/bin/python
# -*- coding: utf-8 -*-
# by ..:: crazyjunkie ::.. 2014
# If you need a Good Wordlist ====> http://uploaded.net/folder/j7gmyz

"""
gencc: A simple program to generate credit card numbers that pass the
MOD 10 check (Luhn formula).
Usefull for testing e-commerce sites during development.
by ..:: crazyjunkie ::.. 2014
"""
from baluhn import generate, verify
from random import Random
from pwn import *
import copy

visaPrefixList = [
        ['4', '5', '3', '9'],
        ['4', '5', '5', '6'],
        ['4', '9', '1', '6'],
        ['4', '5', '3', '2'],
        ['4', '9', '2', '9'],
        ['4', '0', '2', '4', '0', '0', '7', '1'],
        ['4', '4', '8', '6'],
        ['4', '7', '1', '6'],
        ['4']]

mastercardPrefixList = [
        ['5', '1'], ['5', '2'], ['5', '3'], ['5', '4'], ['5', '5']]

amexPrefixList = [['3', '4'], ['3', '7']]

discoverPrefixList = [['6', '0', '1', '1']]

dinersPrefixList = [
        ['3', '0', '0'],
        ['3', '0', '1'],
        ['3', '0', '2'],
        ['3', '0', '3'],
        ['3', '6'],
        ['3', '8']]

enRoutePrefixList = [['2', '0', '1', '4'], ['2', '1', '4', '9']]

jcbPrefixList = [['3', '5']]

voyagerPrefixList = [['8', '6', '9', '9']]


def completed_number(prefix, length):
    """
    'prefix' is the start of the CC number as a string, any number of digits.
    'length' is the length of the CC number to generate. Typically 13 or 16
    """

    ccnumber = prefix

    # generate digits

    while len(ccnumber) < (length - 1):
        digit = str(generator.choice(range(0, 10)))
        ccnumber.append(digit)

    # Calculate sum

    sum = 0
    pos = 0

    reversedCCnumber = []
    reversedCCnumber.extend(ccnumber)
    reversedCCnumber.reverse()

    while pos < length - 1:

        odd = int(reversedCCnumber[pos]) * 2
        if odd > 9:
            odd -= 9

        sum += odd

        if pos != (length - 2):

            sum += int(reversedCCnumber[pos + 1])

        pos += 2

    # Calculate check digit

    checkdigit = ((sum / 10 + 1) * 10 - sum) % 10

    ccnumber.append(str(checkdigit))

    return ''.join(ccnumber)


def credit_card_number(rnd, prefixList, length, howMany):

    result = []

    while len(result) < howMany:

        ccnumber = copy.copy(rnd.choice(prefixList))
        result.append(completed_number(ccnumber, length))

    return result


def output(title, numbers):

    result = []
    result.append(title)
    result.append('-' * len(title))
    result.append('\n'.join(numbers))
    result.append('')
    
    return '\n'.join(result)

def is_mod10_valid(card):
    # Check for empty string
    if not card:
        return False
    
    # Run mod10 on the number
    dub, tot = 0, 0
    for i in range(len(card) - 1, -1, -1):
        for c in str((dub + 1) * int(card)):
            tot += int(c)
        dub = (dub + 1) % 2
    return (tot % 10) == 0


generator = Random()
generator.seed()        # Seed from current time


mastercard = credit_card_number(generator, mastercardPrefixList, 16, 10)
print(output("Mastercard", mastercard))

visa16 = credit_card_number(generator, visaPrefixList, 16, 10)
print(output("VISA 16 digit", visa16))

amex = credit_card_number(generator, amexPrefixList, 15, 5)
print(output("American Express", amex))

discover = credit_card_number(generator, discoverPrefixList, 16, 3)
print(output("Discover", discover))

r = remote('misc.chal.csaw.io', 8308)
pflist = []
while(True):
    p = r.recvline()
    print p
    card = p[13:]
    card = card.strip()
    if card == 'American Express!':
        amex = credit_card_number(generator, amexPrefixList, 15, 1)
        r.sendline(amex[0])
    elif card == 'MasterCard!':
        mastercard = credit_card_number(generator, mastercardPrefixList, 16, 1)
        r.sendline(mastercard[0])
    elif card == 'Visa!':
        v = credit_card_number(generator, visaPrefixList, 16, 1)
        r.sendline(v[0])
    elif card == 'Discover!':
        v = credit_card_number(generator, discoverPrefixList, 16, 1)
        r.sendline(v[0])
    else:
        if(len(card.strip()) > 0):
            idx = card.find('ends with')
            if idx > 0:
                end = card.find('!')
                postfix = card[idx+10:end]
                v = credit_card_number(generator, visaPrefixList, 16, 1)
                while(True != v[0].endswith(postfix)):
                    v = credit_card_number(generator, visaPrefixList, 16, 1)
                r.sendline(v[0])
            else:
                #w if 8670007359202543 is valid!
                idx = card.find(' if ')
                end = card.find(' is valid!')
                if idx > 0:
                    check = card[idx+4:end]
                    if verify(check):
                        r.sendline('1')
                    else:
                        r.sendline('0')
                else:
                    prefix = card[22:26]
                    pflist = []
                    pflist.append(list(prefix))
                    v = credit_card_number(generator, pflist, 16, 1)
                    r.sendline(v[0])