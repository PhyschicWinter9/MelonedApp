<!-- php show time -->
<?php

date_default_timezone_set('Asia/Bangkok');
echo date('d-m-Y H:i:s');
// autoreload page
header("Refresh: 1; url=timer.php");


?>