<?php
$con = mysql_connect("localhost","root","root");
if (!$con){ die('Could not connect: ' . mysql_error()); }
mysql_select_db("student_db", $con);

$student_id=$_POST['student_id'];
$name= $_POST['name'];
$email= $_POST['email'];
$phone= $_POST['phone'];
$address= $_POST['address'];

 
$query  = "
UPDATE student
SET Name='$name',Email='$email',Phone_No='$phone',Address='$address'
WHERE student_id='$student_id' " ;

mysql_query($query);

echo $query;

?>
