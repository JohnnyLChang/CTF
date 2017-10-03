
<?php
/* 
5616f5962674d26741d2810600a6c5647620c4e3d2870177f09716b2379012c342d3b584c5672195d653722443f1c39254360007010381b721c741a532b03504d2849382d375c0d6806251a2946335a67365020100f160f17640c6a05583f49645d3b557856221b2
*/
function my_encrypt($flag, $key) {
    $key = md5($key);
    echo 'key:' . $key . PHP_EOL;
	$message = $flag . "|" . $key;

    $encrypted = chr(rand(0, 126));
	for($i=0;$i<strlen($message);$i++) {
        if($i == 0){
            echo ord($message[$i]) . '+' . ord($key[$i % strlen($key)]) . '+' . ord($encrypted[$i]) . PHP_EOL;
            echo ((ord($message[$i]) + ord($key[$i % strlen($key)]) + ord($encrypted[$i])) % 126) . PHP_EOL;
        }
		$encrypted .= chr((ord($message[$i]) + ord($key[$i % strlen($key)]) + ord($encrypted[$i])) % 126);
    }
    $hexstr = unpack('h*', $encrypted);
	return array_shift($hexstr);
}

function parr($arr){
    for($i=0;$i<$arr->getSize();++$i){
        if(!is_null($arr[$i]))
            echo $arr[$i];
        else
            echo '-';
    }
    echo PHP_EOL;
}

function my_decrypt($flag){
    $md5str = "1234567890abcdef";
    $flagstr = "DCTF{}1234567890abcdef";
    $key = "?";
    $key = md5($key);
    $message = pack('h*', $flag);
    $deli = strlen($message) - 33;
    $keyarr = new SplFixedArray(32);
    for ($i=0 ; $i<strlen($md5str); $i++) {
        if( $message[$deli] == chr( ( ord($message[$deli-1]) + ord($md5str[$i]) + ord('|') ) % 126 ) ){
            $keyarr[6] = $md5str[$i];
        }
    }
    $idx = 6;
    $j = 0;
    while($j < 32){
        for( $i = 0 ; $i < strlen($md5str); $i++ ){
            if( $message[$deli+$idx+1] == chr( ( ord($message[$deli+$idx]) + ord($md5str[$i]) + ord($keyarr[$idx]) ) % 126 ) ){
                $keyarr[($idx+7)%32] = $md5str[$i];
                $idx = ($idx+7)%32;
                parr($keyarr);
                ++$j;
            }
        }
    }
    $flag = "";
    for($j = 1 ; $j < $deli ; $j++){
        for( $i = 0 ; $i < strlen($flagstr); $i++ ){
            if( $message[$j+1] == chr( ( ord($message[$j]) + ord($flagstr[$i]) + ord($keyarr[($j)%32]) ) % 126 ) ){
                $flag .= $flagstr[$i];
            }
        }
    }
    #parr($keyarr);
    echo $flag . PHP_EOL;
}

#$enc = my_encrypt('DCTF{76c77d557198ff760ab9866ad1261a01a7298c349617cc4557462f80500d56a7}', 'f');
#echo $enc . PHP_EOL;
#my_decrypt($enc);
$enc = '5616f5962674d26741d2810600a6c5647620c4e3d2870177f09716b2379012c342d3b584c5672195d653722443f1c39254360007010381b721c741a532b03504d2849382d375c0d6806251a2946335a67365020100f160f17640c6a05583f49645d3b557856221b2';
echo $enc . PHP_EOL;
my_decrypt($enc);
