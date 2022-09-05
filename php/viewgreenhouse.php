<?php
include "../connectDB.php";

$sql = "SELECT * FROM greenhouse WHERE greenhouse_ID NOT IN (SELECT greenhouse_ID FROM period)";
$arr = array();
$result = mysqli_query($con, $sql);
if ($result->num_rows > 0) {
    $arr = $result->fetch_all(MYSQLI_ASSOC);
    echo json_encode($arr, JSON_UNESCAPED_UNICODE);
} else {
    echo json_encode("Failed");
}
