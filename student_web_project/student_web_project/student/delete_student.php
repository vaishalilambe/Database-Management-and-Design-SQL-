<?php
$con = mysql_connect("localhost","root","root");
if (!$con){ die('Could not connect: ' . mysql_error()); }
mysql_select_db("student_db", $con);

$student_id= $_REQUEST['student_id'];
 
$query  = " DELETE FROM student
WHERE student_id='$student_id' " ;



mysql_query($query);

echo $query;

?>