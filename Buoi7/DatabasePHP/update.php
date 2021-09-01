<?php
$servername = "localhost";
$username = "root";
$password = "";        
$dbname = "dataesp";

$den1=$_POST['den1'];
$den2=$_POST['den2'];
$text1=$_POST['text1'];
$text2=$_POST['text2'];


// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

 date_default_timezone_set('Asia/Jakarta');
 $date = date("Y-m-d");
 $time = date("H:i:s");
$sql = "UPDATE dieukhien SET den1= '$den1',den2= '$den2', text1= '$text1' , text2= '$text2' , Date = '$date' , Time= '$time'  WHERE id=1";

if ($conn->query($sql) === TRUE) 
{
  echo "Record updated successfully";
} 
else 
{
  echo "Error updating record: " . $conn->error;
}

$conn->close();



?>