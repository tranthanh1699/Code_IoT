<?php

$servername = "localhost";

$dbname = "flutterloginaccount";

$username = "root";

$password = "";

$connect = False;

$connect = new mysqli($servername, $username, $password, $dbname);
/*
 if ($connect) 
 {
    echo "Connect ";
 } 
 
 else
{
	echo "Failed Connect";
	exit();
}*/
if ($connect->connect_error) {
        die("Không thể kết nối tới Database" . $conn->connect_error);
		exit();
      }
	  else
	  {
		 //echo "Đã Kết nối Database" ; // println , 
	  }

?>