<?php
header("content-type: application/json");
include '../config/conn.php';
// $action = $_POST['action'];

function register_payments($conn){
    extract($_POST);
    $data = array();
    $query = "insert into payment (customer_id, amount,payment_method_id,account_id)
    values('$Customer_id','$amount','$payment_method_id','$account_id')";
    $result = $conn->query($query);

    if($result){

      //  $row= $result->fetch_assoc();

            $data = array("status" => true, "data" => "Registered succesfully 😂😊😒😎");
        


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


// function read_all_payment($conn){
//     $data = array();
//     $array_data = array();
//    $query ="SELECT p.payment_id,concat(c.fristname, ' ', c.lastname) as customer_name,ca.car_name, r.taken_date,r.return_date, ca.rental_price as ret_per_day,p.amount as Total_amount,pm.method_name,ac.bank_name,p.date  from payment p JOIN customer c on p.customer_id=c.customer_id JOIN payment_method pm on p.payment_method_id=pm.payment_method_id JOIN account ac on p.account_id=ac.account_id JOIN rent r on p.customer_id=r.customer_id JOIN car ca on r.car_id=ca.car_id";
//     $result = $conn->query($query);


//     if($result){
//         while($row = $result->fetch_assoc()){
//             $array_data[] = $row;
//         }
//         $data = array("status" => true, "data" => $array_data);


//     }else{
//         $data = array("status" => false, "data"=> $conn->error);
             
//     }

//     echo json_encode($data);
// }




function fill_lacag($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
    $query = "call read_employee_total('$employees_id')";

    $result = $conn->query($query);


    if($result){
        while($row = $result->fetch_assoc()){
            $array_data[] = $row;
        }
        $data = array("status" => true, "data" => $array_data);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function read_all_payment_method($conn){
    $data = array();
    $array_data = array();
   $query ="select payment_method_id,method_name from payment_method";
    $result = $conn->query($query);


    if($result){
        while($row = $result->fetch_assoc()){
            $array_data[] = $row;
        }
        $data = array("status" => true, "data" => $array_data);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function read_all_payment($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT p.payment_id,concat(c.fristname,c.lastname) as name,p.amount,m.method_name,a.bank_name,p.date FROM payment p JOIN customer c ON p.customer_id=c.customer_id
   JOIN payment_method m ON p.payment_method_id=m.payment_method_id
   JOIN account a on p.account_id=a.account_id";
    $result = $conn->query($query);


    if($result){
        while($row = $result->fetch_assoc()){
            $array_data[] = $row;
        }
        $data = array("status" => true, "data" => $array_data);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function read_all_account($conn){
    $data = array();
    $array_data = array();
   $query ="select account_id,bank_name from account";
    $result = $conn->query($query);


    if($result){
        while($row = $result->fetch_assoc()){
            $array_data[] = $row;
        }
        $data = array("status" => true, "data" => $array_data);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function read_all_customer_name($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT customer_id, concat(fristname, ' ',lastname) as customer_name  from customer";
    $result = $conn->query($query);


    if($result){
        while($row = $result->fetch_assoc()){
            $array_data[] = $row;
        }
        $data = array("status" => true, "data" => $array_data);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function get_payment_info($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="SELECT * FROM payment where payment_id= '$payment_id'";
    $result = $conn->query($query);


    if($result){
        $row = $result->fetch_assoc();
        
        $data = array("status" => true, "data" => $row);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function update_payment($conn){
    extract($_POST);

    $data = array();

    $query = "UPDATE payment set customer_id = '$customer_id', amount = '$amount', payment_method_id = '$payment_method_id', account_id = '$account_id' WHERE payment_id= '$payment_id'";

    $result = $conn->query($query);


    if($result){

            $data = array("status" => true, "data" => "successfully updated 😂😊😒😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function Delete_payment($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="DELETE FROM payment where payment_id= '$payment_id'";
    $result = $conn->query($query);


    if($result){
   
        
        $data = array("status" => true, "data" => "successfully Deleted😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


if(isset($_POST['action'])){
    $action = $_POST['action'];
    $action($conn);
}else{
    echo json_encode(array("status" => false, "data"=> "Action Required....."));
}


?>