#code here
use MIME::Base64;
my $pwd=decode_base64("SEFJUkFTUw==");
$pwd=substr($pwd,-3).substr($pwd,0,(length $pwd) -3);
print $pwd;
use File::Temp qw(tempfile);
($fh, $filename) = tempfile( );
my $code="<".<<'Y';
?php $p='JERKY';echo $flag=$p[0]=='A'?$p[1]=='S'?$p[2]=='S'?$p[3]=='H'?$p[4]=='A'?$p[5]=='I'?$p[6]=='R'?strlen($p)==7?'YES, the flag is: ':0:0:0:0:0:0:0:'NO';
Y
$code =~ s/JERKY/$pwd/g; print $fh $code;print `php ${filename}`;
