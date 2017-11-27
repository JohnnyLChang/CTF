<?php

echo md5('240610708') . PHP_EOL;
echo md5('QNKCDZO') . PHP_EOL;
echo var_dump(md5('240610708') == '0e123212321') . PHP_EOL;
var_dump(md5('240610708') == md5('QNKCDZO'));