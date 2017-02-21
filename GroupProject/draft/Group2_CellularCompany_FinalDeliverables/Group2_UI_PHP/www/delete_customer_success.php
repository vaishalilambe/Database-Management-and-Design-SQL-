<?php
$con = mysql_connect('localhost','root','');
if (!$con){ die('Could not connect: ' . mysql_error()); }
mysql_select_db("customer_db", $con);

$CustomerID= $_REQUEST['id'];
 
$query  = " DELETE FROM customer
WHERE CustomerID='$CustomerID'" ;

mysql_query($query);

echo $query;

?>