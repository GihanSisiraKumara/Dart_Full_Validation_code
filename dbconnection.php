<?php

function dbconnection(){
    $con=mysqli_connect("localhost","root","","mobiledart");
    return $con;
}



?>