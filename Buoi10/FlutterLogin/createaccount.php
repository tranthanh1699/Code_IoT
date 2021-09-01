<?php

		include 'conn.php';
		
		$username = $_POST['username'];
		$password = $_POST['password'];
		
		
		// dữ liệu tạo username password 
		
		//$username = 'toannv10291111';
		//$password = '5555555';
		
		$foo = False;
		
		
		// kiểm tra username  tạo kia có tồn tại trong hệ thống không?
		
		$queryResult = $connect->query("SELECT * FROM dataflutter WHERE  username= '$username' ");
		
		
		$response = array();
		
		// hàm while xảy ra thì chắc username đã tồn tại trong hệ thống
		
		while($fetchData=$queryResult ->fetch_assoc())
         {
			 		 
			  $foo = True;
	   			  
         }
		
		 
		 if($foo)
		 {
			// khi tồn tại trong hệ thống trả về true => flutter đọc dc và yêu cầu nhập user khác
			
			//echo 'Đã tồn tại username trong hệ thống nên không cho create username password';
			 echo 'A';
		 }
		 else
		 {
			 // nếu là false thì user nhập thỏa điều kiện => bắt đầu lưu  username và password đã nhập
			 
			 date_default_timezone_set('Asia/Jakarta');
			$d = date("Y-m-d");
			$t = date("H:i:s");
			 
			  $queryResult = "INSERT INTO dataflutter (username , password, Date, Time) VALUES ('$username', '$password','".$d."', '".$t."')";
			 
			 
			 if ($connect->query($queryResult) == TRUE) 
			  {
				   // create username password  thành công
				   //echo 'create username password  thành công';
					echo "B";
											
			} 
			else 
			{
				    // create username password lỗi
					//echo 'create username password lỗi';
					echo "C";
			}	

		 }
		 
		 $connect->close();
		 
		
		

?>