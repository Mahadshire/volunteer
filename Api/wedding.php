<?php
header("content-type: application/json");
include '..//config/conn.php';
// $action = $_POST['action'];


function register_wedding($conn){
    extract($_POST);
    $data = array();
    $query = "INSERT INTO wedding (male_name,female_name) 
    values('$male_name','$female_name')";

    $result = $conn->query($query);


    if($result){

       
            $data = array("status" => true, "data" => "successfully Registered 😂😊😒😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function read_all_wedding($conn){
    $data = array();
    $array_data = array();
   $query ="select * from wedding";
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

function get_wedding($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="SELECT *FROM wedding where w_id = '$w_id '";
    $result = $conn->query($query);


    if($result){
        $row = $result->fetch_assoc();
        
        $data = array("status" => true, "data" => $row);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function update_wedding($conn){
    extract($_POST);

    $data = array();

    $query = "UPDATE wedding set male_name = '$male_name' WHERE w_id  = '$w_id '";
     

    $result = $conn->query($query);


    if($result){

            $data = array("status" => true, "data" => "successfully updated 😂😊😒😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function Delete_wedding($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="DELETE FROM wedding where w_id = '$w_id '";
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