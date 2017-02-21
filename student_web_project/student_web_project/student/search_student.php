<?php
$con = mysql_connect("localhost","root","root");
if (!$con){ die('Could not connect: ' . mysql_error()); }
mysql_select_db("student_db", $con);

$searchtext=$_GET['searchtext'];

?>

<html>
<body>
<center>
<h2>Search Results</h2>

<?php

 $query = "SELECT * FROM student where Name like '%$searchtext%' ";
 $result= mysql_query($query) or die('Query failed: ' . mysql_error()); 
 $numresults=mysql_query($query);
 $numrows=mysql_num_rows($numresults);

 if ($numrows == 0)
  {
    echo ("<h3>No match Found</h3>");
 	}
 	
 else	
 {	
?>
<table border='1'>
<tr>
<th>Name</td>
<th>Email</td>
<th>Phone_No</td>
<th>Adress</td>
<th>Action</td>
</tr>

<?php
while($row = mysql_fetch_array($result))
 { 
 ?>
 
<tr>
<td><?php echo $row['Name']; ?></td>
<td><?php echo $row['Email']; ?></td>
<td><?php echo $row['Phone_No']; ?></td>
<td><?php echo $row['Address']; ?></td>
<td><a href="edit_student.php?student_id=<?php echo $row['student_id']; ?>">Edit</a>&nbsp;
<a href="delete_student.php?student_id=<?php echo $row['student_id']; ?>">Delete</a>
</td>
</tr>
<?php 
  
   }  //end of while
   
 }  //end of else i.e match is found
 ?>
 </table>
</center>
</body>
</html>





