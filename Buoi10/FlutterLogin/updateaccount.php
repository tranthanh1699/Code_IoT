<?php

		include 'conn.php';
		
		$username = $_POST['username'];
		$password = $_POST['password'];
		$passwordupdate = $_POST['passwordupdate'];
		
		//$username = 'toannv10291';
		//$password = '111111';
		//$passwordupdate = '222222';
		
		$foo = False;
		
		$queryResult = $connect->query("SELECT * FROM dataflutter WHERE  username= '$username'  AND  password='$password' ");
			
		$response = array();
			
		 // hàm while xảy ra chắc chắn đã kiểm tra dữ liệu username và password có tồn tại trong hệ thống => update password
		
		while($fetchData=$queryResult ->fetch_assoc())
         {
			 
			 // đọc data username password đúng hàng đó đưa vào chuỗi json
               
			  // hiển thị chuỗi json
			  //echo json_encode($response);
			  
			  // cho True để updatepassword
			
			  
			  //$response['id'] = $fetchData['id'];
              //$response['username'] = $fetchData['username'];
              //$response['password'] = $fetchData['password'];
			  
			  //echo json_encode($response);

				
			$response = $fetchData ;
			  $foo = True;
			    				  
         }
		 
		 
		 if($foo)
		 {
			// echo ("UPDATE password");
			 
			 // lấy dữ liệu id hàng dữ liệu so sánh đúng để update password mới
			  		  
			 $id = intval($response['id']);
			  
			 //echo ('------------------------------');
			 
			  //echo ('id = ');
				
			// echo ($id);
				  
			  
			  
			  $queryResult = "UPDATE dataflutter SET password= '$passwordupdate' WHERE id='$id' ";
			  
			  
			  if ($connect->query($queryResult) == TRUE) 
			  {
				   // Update passwold thành công
					echo "E";
											
			} 
			else 
			{
				    // Update passwold lỗi
					echo "F";
			}	
			
			
		 }
		 else
		 {
			 // username password nhập sai
			  echo ("G");
		 }
		 
		  
		 $connect->close();
	
?>