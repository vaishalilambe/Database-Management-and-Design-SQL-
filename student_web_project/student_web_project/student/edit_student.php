<?php
$con = mysql_connect("localhost","root","root");
if (!$con){
  die('Could not connect: ' . mysql_error());
  }
mysql_select_db("student_db", $con);

$student_id= $_REQUEST['student_id'];


$query = "SELECT * FROM student where student_id='$student_id' ";
$result= mysql_query($query) or die('Query failed: ' . mysql_error());
$row = mysql_fetch_array($result);

if($row!= NULL)
{
?>
<html>
<body>

<center>


<h2>Fill in New Student Details</h2>

<form action="edit_student_success.php" method="POST">
<table cellpadding=2 cellspacing=2 border="0">
<input type="hidden" name="student_id" value="<?php echo $row['student_id']; ?>" >


<tr>
<th>Student Name: </th>
<td><input name="name" type="text" value="<?php echo $row['Name']; ?>"></td>
</tr>


<tr>
<th>Email</th>
<td><input name="email" type="text" value="<?php echo $row['Email']; ?>"></td>
</tr>

<tr>
<th>Phone Number</th>
<td><input name="phone" type="text" value="<?php echo $row['Phone_No']; ?>"></td>
</tr>

<tr>
<th>Address</th>
<td><input name="address" type="text" value="<?php echo $row['Address']; ?>"></td>
</tr>

<tr>
<td><input type="submit" value="Update Student" /></td>
<td><input type="Reset" value="Reset" /></td>

</tr>

</form>

</center>
</body>
</html>
<?php
}
?>