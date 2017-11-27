<?php
$input =  base64_decode("Y2F0IGluZGV4LnR4dCAjCmRhdGU=");
echo $input;
$output = shell_exec($input);
echo "<pre>$output</pre>";
?>

