<?php

$servername = "localhost";
$username = "root";
$password = "";        
$dbname = "dataesp";
 
        $conn = new mysqli($servername, $username, $password, $dbname);
        // Check connection
        if ($conn->connect_error) 
        {
            die("Connection failed: " . $conn->connect_error);
        } 
         
        $sql = "SELECT id, den1, den2, text1, text2 FROM dieukhien";
       
        $result = $conn->query($sql);
		
        if ($result->num_rows >= 0) 
        {
            // output data of each row
            while($row = $result->fetch_assoc())
             {
              echo "A" . $row["den1"]. "B" . $row["den2"]. "C" . $row["text1"]. "D" . $row["text2"]. "E";
			  
             }
        } 
        else 
        {
            echo "0 results";
        }

        $conn->close();      
   
    
    ?>

