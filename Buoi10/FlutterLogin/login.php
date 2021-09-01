<?php

		include 'conn.php';
		
		$username = $_POST['username'];
		$password = $_POST['password'];
		
		//$username = 'taochoithoi1';
		//$password = '5555555';
		
		$foo = False;
		
		$queryResult = $connect->query("SELECT * FROM dataflutter WHERE  username= '$username'  AND  password='$password' ");
		
		
		$response = array();
		

		
		while($fetchData=$queryResult ->fetch_assoc())
         {
			 
			 
              //$response = $fetchData;
			  //echo json_encode($response);
			  
			  //$response[] = 'OK';
			  //echo 'OK';
			  $foo = True;
			  
	  
         }
		
		 
		 if($foo)
		 {
			 // trả về true => kiểm tra đúng username password có trong hệ thống
			 echo 'True';
		 }
		 else
		 {
			 echo 'False';
		 }
		 
		 $connect->close();
		 
		
		

?>