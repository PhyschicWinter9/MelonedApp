<?php
include '../connectDB.php';
// include 'connectDB.php';


$con->set_charset("utf8");

$sql = "SELECT historyperiod.period_ID, DATE_FORMAT(historyperiod.create_date,'%d/%m/%Y') as create_date, DATE_FORMAT(historyperiod.harvest_date,'%d/%m/%Y') as harvest_date, greenhouse.greenhouse_ID,greenhouse.greenhouse_name
    FROM historyperiod
    INNER JOIN greenhouse 
    ON historyperiod.greenhouse_ID = greenhouse.greenhouse_ID";



$result = mysqli_query($con, $sql);
$arr = array();

if ($result->num_rows > 0) {
    $arr = $result->fetch_all(MYSQLI_ASSOC);
    echo json_encode($arr, JSON_UNESCAPED_UNICODE);
    // echo $arr[0]['create_date'];

} else {
    echo json_encode("Failed");
}
