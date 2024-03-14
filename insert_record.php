<?php

include('dbconnection.php'); // Enclose the file name in quotes
$con = dbconnection();

if (isset($_POST["sid"])) {
    $sid = $_POST["sid"];
} else {
    return;
}

if (isset($_POST["uname"])) {
    $uname = $_POST["uname"];
} else {
    return;
}

if (isset($_POST["pone"])) {
    $pone = $_POST["pone"];
} else {
    return;
}

if (isset($_POST["password"])) {
    $password = $_POST["password"];
} else {
    return;
}

$query = "INSERT INTO `school`(`sid`, `uname`, `pone`, `password`) 
          VALUES ('$sid','$uname','$pone','$password')";

$exe = mysqli_query($con, $query);

$arr = [];
if ($exe) {
    $arr["success"] = "true";
} else {
    $arr["success"] = "false";
}

print(json_encode($arr));

?>
