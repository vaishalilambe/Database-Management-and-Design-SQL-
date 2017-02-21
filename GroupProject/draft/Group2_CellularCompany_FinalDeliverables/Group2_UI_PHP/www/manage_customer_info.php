<?php

$url = 'http://cdn.wonderfulengineering.com/wp-content/uploads/2014/01/Lenovo-wallpaper-6.jpg';

?>

<html>
<body >
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
								 
								<h2 class ="whitetext"> Manage Customer Information</h2>
                                 
                                 <a href='insert_customer_info.php'><h2 >Add Customer</h2></a>
                                 <form action='search_customer.php' method='get'>
                                 <input type ='text' name='searchtext'>
								 <input type='submit' value='Search'>
								 </form>
                                 <center>
								 
</body>
</html>