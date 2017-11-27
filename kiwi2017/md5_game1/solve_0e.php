<?php
echo "running script";
 $base = "0e";
 $result = "";
  $curr_number = 0; 
  do {
      $curr = $base . "$curr_number";
        $result = md5($curr);
        $curr_number += 1;
          }
  while ($curr == $result);
  if ($curr == $result){
    echo 'equal';
  }
  echo "\n";
  echo $curr;
  echo "\n";
  echo $result;
  echo "\n";
