def skewer(t):
    return ord(t) - 53


import sys
import base64
import os
import re
import md5
from pwn import *
ppp = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
password = base64.b64decode("S0lXSU1BU1RFUg==")
r = [chr((x + 5 + y**2) % 256)
     for y, x in enumerate([skewer(x) + 7 % 256 for x in password])]
for y, x in enumerate([skewer(x) + 7 % 256 for x in password]):
    print str(y) + ":" + str(x) + ":" + chr((x + 5 + y**2) % 256)
print hexdump(password)
r = "HAIRASS"
print hexdump(r)
flag = ""
for y in range(0, 7):
    for p in ppp:
        x = (skewer(p) + 7) % 256
        if chr((x + 5 + y**2) % 256) == r[y]:
            flag += p
m = md5.new()
m.update(flag)
print "flag:" + m.hexdigest()
code = '''
# code here
use MIME::Base64;
my $pwd=decode_base64("JASUS");
$pwd=substr($pwd,-3).substr($pwd,0,(length $pwd) -3);
# print $pwd;
use File::Temp qw(tempfile);
($fh, $filename) = tempfile( );
my $code="<".<<'Y';
?php $p='JERKY';echo $flag=$p[0]=='A'?$p[1]=='S'?$p[2]=='S'?$p[3]=='H'?$p[4]=='A'?$p[5]=='I'?$p[6]=='R'?strlen($p)==7?'YES, the flag is: ':0:0:0:0:0:0:0:'NO';
Y
$code =~ s/JERKY/$pwd/g; print $fh $code;print `php ${filename}`;
'''.replace('JASUS', base64.b64encode("".join(r)));

import tempfile
f = tempfile.NamedTemporaryFile(delete=False)
print f.name
f.write(code)
f.close()
print os.popen("perl " + f.name).read()
