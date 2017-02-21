<?php
$con = mysql_connect('localhost','root','');
if (!$con){ die('Could not connect: ' . mysql_error()); }
mysql_select_db("customer_db", $con);


$CustomerID=$_POST['CustomerID'];

$Cus_lname= $_POST['Cus_lname'];

$Cus_fname= $_POST['Cus_fname'];

$CustomerEmail= $_POST['CustomerEmail'];

$Phone= $_POST['Phone'];

$query  = "
UPDATE customer SET Cus_lname='$Cus_lname',Cus_fname='$Cus_fname',CustomerEmail='$CustomerEmail',Phone='$Phone' 
WHERE CustomerID='$CustomerID' " ;


mysql_query($query);


echo $query;

?>
