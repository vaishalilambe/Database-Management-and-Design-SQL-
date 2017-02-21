<?php
$url = 'http://cdn.wonderfulengineering.com/wp-content/uploads/2014/01/Lenovo-wallpaper-6.jpg';
?>
<html>
<body>
<form action="insert_customer_info_success.php" method="post">
<style type="text/css">
body
{
background-image:url('<?php echo $url ?>');
}
.whitetext {
        color: white;
}
</style>

<h3 class="whitetext"> Enter customer details below:</h3>

<h3 class="whitetext">Customer ID :</h3><input    type = 'Integer' name='id'>
<h3 class="whitetext">Customer Lastname :</h3><input    type = 'text' name='lname'>
<h3 class="whitetext">Customer Firstname :</h3><input    type = 'text' name='fname'>
<h3 class="whitetext">Customer Email :</h3><input   type = 'text' name='email_tf'>
<h3 class="whitetext">Phone No :</h3><input type = 'text' name='pno_tf'><br><br>

<input type = 'submit'>
<form>
</body>
</html>


