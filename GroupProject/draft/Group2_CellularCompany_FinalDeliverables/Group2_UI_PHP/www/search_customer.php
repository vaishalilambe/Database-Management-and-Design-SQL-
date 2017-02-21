<?php
$url = 'http://cdn.wonderfulengineering.com/wp-content/uploads/2014/01/Lenovo-wallpaper-6.jpg';
$con = mysql_connect('localhost','root','');
if (!$con){ die('Could not connect: ' . mysql_error()); }

mysql_select_db("customer_db", $con);


$searchtext=$_GET['searchtext'];

?>


<?php

 $query = "SELECT * FROM customer where CustomerID like '%$searchtext%' ";
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

<h3 class="whitetext"> Search Results </h3>
<table border='1'>
<tr>
<th class="whitetext">CustomerID</td><th class="whitetext">Cus_lname</td>
<th class="whitetext">Cus_fname</td>
<th class="whitetext">CustomerEmail</td>
<th class="whitetext">Phone</td>
<th class="whitetext">Action</td>
</tr>

<?php
while($row = mysql_fetch_array($result))
 { 
 
?></td>
<td class="whitetext"><?php echo $row['CustomerID']; 
?></td>
<td class="whitetext"><?php echo $row['Cus_lname']; 
?></td>
<td class="whitetext"><?php echo $row['Cus_fname']; 
?></td>
<td class="whitetext"><?php echo $row['CustomerEmail']; 
?></td>
<td class="whitetext"><?php echo $row['Phone']; 
?></td>
<td><a href="edit_customer.php?customer_id=<?php echo $row['CustomerID'];
 ?>">Edit</a>&nbsp;

<a href="delete_customer.php? customer_id=<?php echo $row['CustomerID']; 
?>">Delete</a>
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





