<?php


// echo is used to output text with php
echo "STUDENT INFO";
echo "<br/>";

// creating a connection to the database
$con = mysql_connect("localhost","root","root");

// if connection to the database fails an error is thrown
if (!$con){
  die('Could not connect: ' . mysql_error());
  }
  
// selecting the database for the connection created  
mysql_select_db("student_db", $con);

// storing the query in a variable called $query
$query=
("INSERT INTO student 
(Name,
Email,
Phone_No,
Address)
VALUES 
('{$_POST['name']}',	
 '{$_POST['email_tf']}',
 '{$_POST['pno_tf']}',
 '{$_POST['add_tf']}')
 ");

 // executing the query
mysql_query($query);
echo "<br/>";
echo $query; 

//closing the connection
mysql_close($con);

echo "<br/>";
echo "<a href='home.php'>Home</a><br/>";
echo "<a href='add_student_info.php'>Back</a>";

?>