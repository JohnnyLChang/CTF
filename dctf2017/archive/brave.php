<?php
real_escape_string(@$_GET['key']);
if(preg_match('/\s|[\(\)\'"\/\\=&\|1-9]|#|\/\*|into|file|case|group|order|having|limit|and|or|not|null|union|select|from|where|--/i', $id)) 
    die('Attack Detected. Try harder: '. $_SERVER['REMOTE_ADDR']); // attack detected 
$query = "SELECT `id`,`name`,`key` FROM `users` WHERE `id` = $id AND `key` = '".$key."'"; $q = $db->query($query); 
if($q->num_rows) { echo '
Users:

    '; while($row = $q->fetch_array()) { echo '
    '.$row['name'].'
    '; } echo '

'; } else { die('
Nop.
'); } 