<?php
    //include './connection.php';
	
	$servername = "localhost";
	$username = "root";
	$password = "";        
	$dbname = "dataesp";

    // connect mysql php
    $conn = mysqli_connect($servername, $username, $password, $dbname);
    mysqli_set_charset($conn, 'UTF8');

    // Kiểm tra kết nối
    if ($conn->connect_error) 
	{
        die("Không thể kết nối tới Database" . $conn->connect_error);
    }
	else
	{
		$sql = "SELECT id, nhietdo, doam, anhsang, relay1, relay2 FROM phpdata ORDER BY id DESC LIMIT 1 ";
		$response = array();
		$result = $conn->query($sql);
        if ($result->num_rows >= 0) 
        {
            // output data of each row
            while($row = $result->fetch_assoc())
             {
              //echo "id" . $row["id"]. "- nhietdo:" . $row["nhietdo"]. "- doam:" . $row["doam"]. "N";
              //$row_nhietdo = $row["nhietdo"];
              //$row_doam = $row["doam"];
				$response['id'] = $row['id'];
                $response['nhietdo'] = $row['nhietdo'];
                $response['doam'] = $row['doam'];
                $response['anhsang'] = $row['anhsang'];
                $response['relay1'] = $row['relay1'];
                $response['relay2'] = $row['relay2'];               
             }
             echo json_encode($response);
            $result->free();
        } 
        else 
        {
            echo "0 results";
        }
	}
    
        //$conn->close();     
?>