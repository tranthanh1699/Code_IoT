<?php
	$servername = "localhost"; // 
    $username = "root";
    $password = "";        
    $dbname = "dataesp";

    // connect mysql php
    $conn = mysqli_connect($servername, $username, $password, $dbname);
    mysqli_set_charset($conn, 'UTF8');

    // Kiểm tra kết nối
    if ($conn->connect_error) {
        die("Không thể kết nối tới Database" . $conn->connect_error);
      }
	  else
	  {
		 echo "Đã Kết nối Database" ; // println , 
		/*
		date_default_timezone_set('Asia/Jakarta');
		$d = date("Y-m-d");
		$t = date("H:i:s");
		$nhietdo = "111111";
		$doam = "22222222";
		$anhsang = "33333";
		$relay1 = "4444";
		$relay2 = "5555";
	    $sql = "INSERT INTO phpdata (nhietdo, doam, anhsang, relay1 , relay2 , Date, Time) VALUES ('".$nhietdo."', '".$doam."' , '".$anhsang."' , '".$relay1."' , '".$relay2."' ,'".$d."', '".$t."')"; 

		if ($conn->query($sql) === TRUE) 
		{
		    echo "OK";
		} 
		else 
		{
		    echo "Error: " . $sql . "<br>" . $conn->error;
		}
		
		*/
		
		 
			//Get current date and time
			date_default_timezone_set('Asia/Jakarta');
			$d = date("Y-m-d");
			$t = date("H:i:s");

			if(!empty($_POST['nhietdo']))
			{
					$nhietdo = $_POST['nhietdo'];
					$doam = $_POST['doam'];
					$anhsang = $_POST['anhsang'];
					$relay1 = $_POST['relay1'];
					$relay2 = $_POST['relay2'];
					$sql = "INSERT INTO phpdata (nhietdo, doam, anhsang, relay1 , relay2 , Date, Time) VALUES ('".$nhietdo."', '".$doam."' , '".$anhsang."' , '".$relay1."' , '".$relay2."' ,'".$d."', '".$t."')"; 

				if ($conn->query($sql) === TRUE) 
				{
					echo "OK";
				} 
				else 
				{
					echo "Error: " . $sql . "<br>" . $conn->error;
				}
			}
			
			
	  }
	$conn->close();

?>




