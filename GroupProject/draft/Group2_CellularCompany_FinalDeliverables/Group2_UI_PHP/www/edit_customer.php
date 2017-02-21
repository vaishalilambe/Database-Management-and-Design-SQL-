<?php
$url = 'http://cdn.wonderfulengineering.com/wp-content/uploads/2014/01/Lenovo-wallpaper-6.jpg';
$con = mysql_connect('localhost','root','');
if (!$con){ die('Could not connect: ' . mysql_error()); }

mysql_select_db("customer_db", $con);



$query = "SELECT * FROM customer" ;
$result= mysql_query($query) or die('Query failed: ' . mysql_error());

$row = mysql_fetch_array($result);


if($row!= NULL)

{
?>

<html>
<body>
<style type="text/css">
body
{
background-image:url('<?php echo $url ?>');
}
.whitetext {
        color: white;
}
</style>

<center>


<h2 class="whitetext">Update Customer Details</h2>


<form action="edit_customer_success.php" method="POST">
<table cellpadding=2 cellspacing=2 border="0">

<tr>
<th class="whitetext">CustomerID</th>
<td><input name="CustomerID" type="Integer" value="<?php echo $row['CustomerID'];
?>" >

<tr>
<th class="whitetext">CustomerLastName</th>
<td><input name="Cus_lname" type="text" value="<?php echo $row['Cus_lname']; 
?>" >

<tr>
<th class="whitetext">CustomerFirstName</th>
<td><input name="Cus_fname" type="text" value="<?php echo $row['Cus_fname']; 
?>"></td>
</tr>


<tr>
<th class="whitetext">CustomerEmail</th>
<td><input name="CustomerEmail" type="text" value="<?php echo $row['CustomerEmail']; 
?>"></td>
</tr>

<tr>
<th class="whitetext">Phone</th>
<td><input name="Phone" type="text" value="<?php echo $row['Phone']; 
?>"></td>
</tr>

<tr>
<td><input type="submit" value="Update Customer" /></td>
<td><input type="Reset" value="Reset" /></td>

</tr>

</form>

</center>
</body>
</html>

<?php
}
?>