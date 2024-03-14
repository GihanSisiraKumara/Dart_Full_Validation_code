<?php
include('dbconnection.php'); // Assuming this file contains the database connection logic
$con = dbconnection();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get the input values
    $sid = $_POST['sid'];
    $password = $_POST['password'];

    // Use prepared statement to prevent SQL injection
    $sql = "SELECT * FROM school WHERE sid = ? AND password = ?";
    $stmt = mysqli_prepare($con, $sql);
    mysqli_stmt_bind_param($stmt, "ss", $sid, $password);

    mysqli_stmt_execute($stmt);
    
    // Store the result
    mysqli_stmt_store_result($stmt);

    // Check if a row is returned
    $count = mysqli_stmt_num_rows($stmt);

    if ($count == 1) {
        echo json_encode("Success");
    } else {
        echo json_encode("Error: Invalid SID or password");
    }

    // Close the statement
    mysqli_stmt_close($stmt);
}

// Close the database connection
mysqli_close($con);
?>
