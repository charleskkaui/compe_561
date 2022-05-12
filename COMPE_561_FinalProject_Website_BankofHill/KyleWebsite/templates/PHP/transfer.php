<?php
    $conn = mysqli_connect("localhost", "root", "", "BankofHill");

    if($conn === false){
        die("ERROR: Could not connect. " 
            . mysqli_connect_error());
    }

    $first_name =  $_REQUEST['first_name'];
        $last_name = $_REQUEST['last_name'];
        $gender =  $_REQUEST['gender'];
        $address = $_REQUEST['address'];
        $email = $_REQUEST['email'];
?>