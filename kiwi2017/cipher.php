<?php

define("BLOCK_SIZE", 16);
define("SEED", 1396);
define("ROUNDS", 1);

function pad($message,$block_size)
{
	return str_pad($message, max(floor( (strlen($message)-1)/$block_size)+1,1)*$block_size);
}
function sbox($block,$round=0,$reverse=false)
{
	static $sbox=null;
	if ($sbox===null) //generate sbox
	{
		srand(SEED);
		$sbox=array_fill(0, ROUNDS, array_fill(0,256,0));
		for ($k=0;$k<ROUNDS;++$k)
		{

			$base=range(0,255);
			for ($i=0;$i<256;++$i)
			{
				$r=rand(0,count($base)-1);
				$index=array_keys($base)[$r];
				$sbox[$k][$i]=$base[$index];
				unset($base[$index]);
			}
		}
	}

	$out=str_repeat(" ", BLOCK_SIZE);
	if ($reverse)
		for ($i=0;$i<BLOCK_SIZE;++$i)
			$out[$i]=chr(array_search(ord($block[$i]), $sbox[$round]));
	else
		for ($i=0;$i<BLOCK_SIZE;++$i)
			$out[$i]=chr($sbox[$round][ord($block[$i])]);
	return $out;
}
function pbox($block,$round=0,$reverse=false)
{
	srand(SEED);
	static $pbox=null;
	if ($pbox===null) //generate pbox
	{
		srand(SEED);
		$pbox=array_fill(0, ROUNDS, array_fill(0,BLOCK_SIZE,0));
		for ($k=0;$k<ROUNDS;++$k)
		{

			$base=range(0,BLOCK_SIZE-1);
			for ($i=0;$i<BLOCK_SIZE;++$i)
			{
				$r=rand(0,count($base)-1);
				$index=array_keys($base)[$r];
				$pbox[$k][$i]=$base[$index];
				unset($base[$index]);
			}
		}
	}
	$out=str_repeat(" ", BLOCK_SIZE);
	if ($reverse)
		for ($i=0;$i<BLOCK_SIZE;++$i)
			$out[$pbox[$round][$i]]=$block[$i];
	else
		for ($i=0;$i<BLOCK_SIZE;++$i)
			$out[$i]=$block[$pbox[$round][$i]];
	return $out;
}
function xbox($block,$key)
{
	$out=str_repeat(" ", BLOCK_SIZE);
	for ($i=0;$i<BLOCK_SIZE;++$i)
		$out[$i]=chr( (ord($block[$i])^ord($key[$i]))%256 );
	return $out;
}
function ps2_block($block,$key,$decrypt=false)
{
	$key=hex2bin(md5($key));
	$key=pad($key,BLOCK_SIZE);

	if ($decrypt)
		for ($i=ROUNDS-1;$i>=0;--$i)
		{
			$roundkey=$key;
			if (defined("PLUS"))
				$roundkey=pad(md5($key.$i),BLOCK_SIZE);
			echo "roundkey:" . bin2hex($roundkey) . PHP_EOL;
			$block=xbox($block,$roundkey,$i,$decrypt);
			$block=pbox($block,$i,$decrypt);
			$block=sbox($block,$i,$decrypt);
		}
	else //encrypt
		for ($i=0;$i<ROUNDS;++$i)
		{
			$roundkey=$key;
			if (defined("PLUS"))
				$roundkey=pad(md5($key.$i),BLOCK_SIZE);
			$block=sbox($block,$i,$decrypt);
			$block=pbox($block,$i,$decrypt);
			$block=xbox($block,$roundkey,$i,$decrypt);
		}
	return $block;
}
function ps2($message,$key,$decrypt=false)
{
	$msg=pad($message,BLOCK_SIZE);
	$blocks=str_split($msg,BLOCK_SIZE);
	$res=[];
	foreach ($blocks as $block) //ECB mode
		$res[]=ps2_block($block,$key,$decrypt);
	return implode($res);
}

$dec = true;
if($argv[3] == "false")
	$dec = false;

if($dec)
	$msg = hex2bin($argv[1]);
else
	$msg = $argv[1];

$ret = ps2($msg, $argv[2], $dec);

if(!$dec)
	echo bin2hex($ret) . PHP_EOL;
else
	echo "decrypt:" . $ret . PHP_EOL;

$cipher = "78 fc d5 fd 96 cb 82 5d 1f 25 5e 25 a4 dc 7b 56 45 ce 8e e2 ab 0b 70 d0 32 53 5e 9f 96 dc f0 b8 cc ce a3 d5 4c 67 70 75 14 82 d7 9f b8 dc f0 ca 6f 64 88 a2 96 a6 a4 c7 99 18 8e 65 2a e1 60 81 65 c1 d5 72 98 18 29 8c 32 cc 63 88 96 0c 7b f7 cc 66 04 04 81 32 a0 20 10 80 7c 6f b8 aa 6f 81 45 66 a3 04 b4 80 a4 d8 10 07 fb 88 b8 35 e9 f7 f3 fc b8 5f bc 80 c1 fa 32 25 7c 97 0c dc bf f7 5e 66 2c 04 4c b2 a0 5d 71 80 49 6f 47 53 5d 81 78 eb 06 50 96 34 07 8c 3a 2a 8e 65 31 f6 60 ca ac 77 2a d5 96 a6 07 c7 9f f5 5e b5 eb 20 ab 67 78 e3 89 69 b4 bd a0 73 3a 21 f9 97 31 aa 60 52 e2 48 2a a2 96 bd 8a 75 c0 25 b7 12 31 0c f0 50 4a 4e 04 72 33 1a 82 4c b1 53 84 5c 0c 7d 16 f7 e0 c1 9e 13 96 80 7a 75 32 80 ce 6a 2a f6 c7 ec e2 66 d5 72 b4 aa 7a d0 0b 2a 5e 88 31 35 77 50 33 c1 89 a8 1f 67 a0 5d c0 18 d1 10 26 7b 60 50 6f 11 a3 58 8d b9 30 5f 66 0f 5e b5 0c c7 e9 27 78 4e a3 a2 49 a6 82 e1 66 53 84 6f 87 7b e9 ca 9f 1b d5 d7 96 2d 05 8c 1f 82 d7 b5 eb 53 5d 81 9f 66 04 13 96 80 82 e1 0b 84 51 c3 0c 55 4a 81 45 eb b4 d5 4c 1a d6 20 99 f5 84 c3 ee dc ba 41 e2 77 a3 a2 31 67 af 8c 1f 0f e8 bb 13 dc 89 f3 9f b7 81 72 e0 a6 a0 c7 c0 07 e8 c3 0c 55 4a 81 ac 4e b8 4f 8d 32 07 fa 5f ff 28 b5 2a 03 6f 2d 45 66 a3 4f b4 80 29 2a 66 cc 5e ba 13 d8 89 41 45 eb b4 d5 4c 1a d6 20 99 f5 84 03 b8 aa c7 41 95 fc 81 d5 96 97 07 2a b7 93 ff 5c 31 d2 c7 1e 41 c1 06 50 31 34 80 8c 3a d9 39 97 31 aa 60 ca d5 fc 2c 69 ab bd 82 5b 3a 25 8e ae eb e1 60 50 45 eb 2a d3 ab b2 70 fa 32 53 d7 6f b8 7b e9 81 5e 28 ad 50 96 80 d6 2a 66 ac 5e 98 ee 6a 4a e0 33 1b 1c d7 31 67 70 75 10 18 d1 b5 96 79 6e 81 95 48 04 d3 46 67 29 d8 71 18 28 3c 47 06 c7 dd e2 da d5 a8 96 cb 7a 20 9f 2a 5a 25 31 f6 e9 52 6f da a3 a8 19 80 16 2a cf 53 28 3c 31 fe b0 7e 6f eb 9e 7d e0 bd 29 5f 14 53 84 97 31 e1 42 d5 45 c1 04 fb 7f cb d6 75 66 f5 74 3c 96 dc 4a 27 78 4e a3 a8 33 67 8a 75 10 ff 74 ae eb e1 60 81 cc e3 7c 4f 46 41 a0 fa 25 21 f9 ae 87 aa 16 d5 45 da 04 4f 46 bd a0 fe 32 18 7c 3a 2a e1 42 dd 9f fc 04 72 20 67 82 75 71 07 d1 b5 96 79 16 81 e2 1b d5 a2 1f bd 82 d0 c0 53 d1 10 31 e1 77 96 45 c1 4a 58 1f b2 07 d0 c0 f5 fb 9f 31 4c b0 50 e2 eb a7 72 37 9f 70 06 10 84 7c c3 0c 55 77 50 67 eb 06 fb 92 2d 7f e1 2d 25 ce 12 fa 35 60 f7 67 1b 79 72 91 9f 8a fa 07 2b 5e b5 be fe 16 ca 5e a0 89 58 8d 6d 2f d0 a6 fa 5e c3 96 95 7b 67 45 c1 2a 96 ab 6d d6 5f 10 ff 50 5c 31 55 c7 dd 5e 77 15 69 92 67 c1 8c ca 25 f9 fc 26 7b 16 ca 78 ec 89 fd 96 67 70 5d c0 25 63 25 be dc 7b 2d 5c eb 04 b2 92 54 a0 5d 10 ac 5e ac cd 50 ec 7e 6f 4e 33 e2 96 90 bb 25 10 18 7c 12 35 fe 60 f7 24 4e 33 72 fd cb bb d8 10 18 35 80 b7 17 42 f7 45 48 88 8b 63 3b 3b d0 40 4b 50 97 0c c7 4a 6c 68 c1 a3 b5 6f cb d6 d8 10 ff d7 c5 1a ea d9 1e 5e c1 2c d5 4c bd 07 fa 10 d9 5e 88 3e 35 7b f7";
$cipher = str_replace(' ', '', $cipher);
echo $cipher;