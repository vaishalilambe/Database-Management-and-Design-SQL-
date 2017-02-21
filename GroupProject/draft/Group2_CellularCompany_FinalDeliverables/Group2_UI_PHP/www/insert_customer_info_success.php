<?php
$con = mysql_connect('localhost','root','');
if (!$con){ die('Could not connect: ' . mysql_error()); }
mysql_select_db("customer_db", $con);


$query=
("INSERT INTO Customer
(
 CustomerID,
 Cus_lname,
 Cus_fname,
 CustomerEmail ,
 Phone
)


VALUES 
('{$_POST['id']}',
	
 '{$_POST['lname']}',

   '{$_POST['fname']}',

 '{$_POST['email_tf']}',
 '{$_POST['pno_tf']}')
 ");



mysql_query($query);

echo $query;

?>