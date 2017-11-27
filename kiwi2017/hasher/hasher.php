<?php
function str_xor($str,$max_depth=0,$depth=0)
{
    $mid=strlen($str)/2;
    $left=substr($str,0,$mid);
    $right=substr($str,$mid);
    if ($depth<$max_depth)
    {
        $left=str_xor($left,$max_depth,$depth+1);
        $right=str_xor($right,$max_depth,$depth+1);
    }
    $out="";
    for ($i=0;$i<strlen($left);++$i)
        $out.=$left[$i]^$right[$i];
    return $out;
}

function hasher($string)
{
    if (!ctype_alnum($string))
        return null;
    $t=trim(shell_exec("echo -n '{$string}' | openssl dgst -whirlpool | openssl dgst -rmd160"));
    $tmp = "echo -n '{$string}'";
    $t=str_replace("(stdin)= ","",$t); //some linux adds this
    if (!$t)
        return null;
    return bin2hex(str_xor(hex2bin($t),1));
}

$found = 0;
$user = "";
$password = "";
for ($i=0; ; ++$i) {
    if ( hasher("$i") == "0e$i") {
        echo "i: $i // hasher(i): " . hasher("$i") . "\n";
        $found += 1;
        if ($found == 1) $user=$i;
        elseif ($found == 2) $password=$i;
    } elseif ($found == 2) {
        break;
    }
}
if (hasher($user)==hasher($password) and $user!=$password)
    echo "user: $user / password: $password \n";
