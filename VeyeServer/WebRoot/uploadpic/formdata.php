<?php
 
 
$word =$_REQUEST['RsStream'];

$userid = $_REQUEST['userid'];
$path='users/'.$userid;
file_put_contents($path, $word);
if(file_exists($path))
{
  echo ($path);
 
}
if(!file_exists($path))
{
  echo ('failed to upload.');
}
 echo($word)
  ?>