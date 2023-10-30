
<?php   ob_start();
ini_set('error_reporting', 1);
ini_set('display_errors', 1);

require $_SERVER['DOCUMENT_ROOT'] . '/vendor/autoload.php';

// Load environment variables from the .env file
//var_dump(dirname(__DIR__, 1));
//var_dump(file_exists(dirname(__DIR__, 1).'/.env'));
$dotenv = Dotenv\Dotenv::createImmutable(dirname(__DIR__, 1));
$dotenv->load();
$databaseHost = $_ENV['DB_HOST'];
$databaseUser = $_ENV['DB_USERNAME'];
$databasePassword = $_ENV['DB_PASSWORD'];
$databaseName= $_ENV['DB_DATABASE'];

$skey = $_REQUEST['skey'];
$tranID = $_REQUEST['tranID'];
$domain = $_REQUEST['domain'];
$status = $_REQUEST['status'];
$amount = $_REQUEST['amount'];
$currency = $_REQUEST['currency'];
$paydate = $_REQUEST['paydate'];
$orderid = $_REQUEST['orderid'];
$appcode = $_REQUEST['appcode'];
$error_code = $_REQUEST['error_code'];
$error_desc = $_REQUEST['error_desc'];
$channel = $_REQUEST['channel'];
$extraP = $_REQUEST['extraP'];
// Use the variables as needed
/*echo "Database Host: $databaseHost<br>";
echo "Database User: $databaseUser<br>";
echo "Database Password: $databasePassword<br>";

// Use the request variables
echo "Skey: $skey<br>";
echo "Transaction ID: $tranID<br>";
echo "Domain: $domain<br>";
echo "Status: $status<br>";
echo "Amount: $amount<br>";
echo "Currency: $currency<br>";
echo "Payment Date: $paydate<br>";
echo "Order ID: $orderid<br>";
echo "App Code: $appcode<br>";
echo "Error Code: $error_code<br>";
echo "Error Description: $error_desc<br>";
echo "Channel: $channel<br>";
echo "Channel: $extraP<br>";*/


if(!(empty($skey))) {
    $mysqli = new mysqli($databaseHost, $databaseUser, $databasePassword, $databaseName);
    
    // Check for a valid connection
    if ($mysqli->connect_error) {
        die("Connection failed: " . $mysqli->connect_error);
    }
    
    // Check if the transaction ID exists in the database
    $query = "SELECT * FROM transactions WHERE transaction_id = '$tranID'";
    $result = $mysqli->query($query);
    
    if ($result->num_rows > 0) {
        // Transaction ID exists, update the record
        $updateQuery = "UPDATE transactions SET 
            domain = '$domain',
            payment_Status = '$status',
            amount = $amount,
            currency = '$currency',
            paydate = '$paydate',
            order_id = '$orderid',
            appcode = '$appcode',
            error_code = '$error_code',
            error_desc = '$error_desc',
            channel = '$channel',
            extra_P ='$extraP',
            payment_method = 'razerpay' -- Update this with the actual payment method
            WHERE transaction_id = '$tranID'";
        
        if ($mysqli->query($updateQuery) === TRUE) {
            //echo "Record updated successfully";
    
            // Check if payment status is successful
            if ($status === '00') {
                // Update the 'status' field in the 'orders' table to 'pending'
                $updateOrderStatusQuery = "UPDATE orders SET status = 'pending' WHERE id = '$orderid'";
                if ($mysqli->query($updateOrderStatusQuery) === TRUE) {
                    //echo "Order status updated to 'pending'";
                } else {
                    //echo "Error updating order status: " . $mysqli->error;
                }
                // Redirect to the complete page on success
                
                //header("Location: https://apsgarlands.santhila.com/checkout/complete");
               
               
                echo '<script> window.location.href= "https://apsgarlands.santhila.com/account/orders" </script>';
                
               
            }
            else{
                $updateOrderStatusQuery = "UPDATE orders SET status = 'payment_failed' WHERE id = '$orderid'";   
                 if ($mysqli->query($updateOrderStatusQuery) === TRUE) {
                     echo '<script> window.location.href= "https://apsgarlands.santhila.com/cart" </script>';
                   }
               
               //header("Location: https://apsgarlands.santhila.com/cart");
                
            }
        } else {
            echo "Error updating record: " . $mysqli->error;
        }
    } else {
        // Transaction ID doesn't exist, create a new record
        $insertQuery = "INSERT INTO transactions (transaction_id, domain, payment_Status, amount, currency, paydate, order_id, appcode, error_code, error_desc, channel, payment_method,extra_P)
            VALUES ('$tranID', '$domain', '$status', $amount, '$currency', '$paydate', '$orderid', '$appcode', '$error_code', '$error_desc', '$channel', 'razerpay','$extraP')";
    
        if ($mysqli->query($insertQuery) === TRUE) {
            echo "New record created successfully";
    
            // Check if payment status is successful
            if ($status === '00') {
                // Update the 'status' field in the 'orders' table to 'pending'
                $updateOrderStatusQuery = "UPDATE orders SET status = 'pending' WHERE id = '$orderid'";
                if ($mysqli->query($updateOrderStatusQuery) === TRUE) {
                    echo "Order status updated to 'pending'";
                } else {
                    echo "Error updating order status: " . $mysqli->error;
                }
                // Redirect to the complete page on success
               echo '<script> window.location.href= "https://apsgarlands.santhila.com/account/orders" </script>';
                https://apsgarlands.santhila.com/checkout/complete
               // exit();
            } else {
                $updateOrderStatusQuery = "UPDATE orders SET status = 'payment_failed' WHERE id = '$orderid'";   
                 if ($mysqli->query($updateOrderStatusQuery) === TRUE) {
                     echo '<script> window.location.href= "https://apsgarlands.santhila.com/cart" </script>';
                }
                    
            }
        } else {
            echo "Error creating record: " . $mysqli->error;
        }
    }
    
    // Close the database connection
    $mysqli->close();
} else {
    echo "\r\n <br/> No Transaction exits.";
}
