<?php
$url = 'http://cdn.wonderfulengineering.com/wp-content/uploads/2014/01/Lenovo-wallpaper-6.jpg';
?>
<html>
<body>

<form action="delete_customer_success.php" method="post">
<style type="text/css">
body
{
background-image:url('<?php echo $url ?>');
}
.whitetext {
        color: white;
}
</style>

<h3 class="whitetext"> Confirm customer ID to delete record!!!</h3>

<h3 class="whitetext">Customer ID :</h3>
<input    type = 'Integer' name='id'>

<input type = 'submit'>
<form>
</body>
</html>

