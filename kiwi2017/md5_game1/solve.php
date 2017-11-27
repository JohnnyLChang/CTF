<?php
$i = 0;
for ($i;;$i++) 
  if ("00e{$i}"==md5("00e{$i}")) 
    //die ("00e{$i}\n"); 
    break;

{
    $md5="00e{$i}";
    if ($md5==md5($md5))
        echo "Wonderbubulous! Flag ";
    else
        echo "Nah... '",htmlspecialchars($md5),"' not the same as ",md5($md5);
}
