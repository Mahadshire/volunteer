<?php

header("content-type: application/json");
include '..//config/conn.php';
// $action = $_POST['action'];

function register_user($conn){
    extract($_POST);
    $data = array();
    $eroor_Array= array();
    $new_id= generate($conn);

    $file_name= $_FILES['image']['name'];
    $file_type= $_FILES['image']['type'];
    $file_size= $_FILES['image']['size'];

    $save_name= $new_id . ".png";

    // allowed images

    $allowedImages =  ["image/jpg", "image/jpeg", "image/png"];
    $max_size= 5 * 1024 * 1024;

    if(in_array($file_type, $allowedImages)){
         
        if($file_size > $max_size){
            $eroor_Array[]=  $file_size/1024/1024 . " MB  file size must be less then" . $max_size/1024/1024 ." MB";
        }


    }else{
        $eroor_Array[]= "this file is not Allowed";
    }

     if(count($eroor_Array) <= 0){
        $query = "INSERT INTO `users`(`id`, `username`, `password`, `usertype`, `image`)
        VALUES('$new_id', '$username',  MD5('$password'),'$usertype', '$save_name')";
   
       $result = $conn->query($query);
   
   
       if($result){
       move_uploaded_file($_FILES['image']['tmp_name'], "../aploads/" . $save_name);
       $data = array("status" => true, "data"=>  "successfully Registered");

    
       }else{
           $data = array("status" => false, "data"=> $conn->error);
                
       }


     }else{
        $data = array("status" => false, "data"=> $eroor_Array);

     }
  

    echo json_encode($data);
}

// function read_all_employe_name($conn){
//     $data = array();
//     $array_data = array();
//    $query ="SELECT  e.emp_id,concat(e.emp_first_name, ' ', e.emp_last_name) as employe_name from employee e";
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

function get_user_list($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT id, username, usertype, image, status FROM `users`";
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

function get_user_info($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="SELECT * FROM `users` where id= '$id'";
    $result = $conn->query($query);


    if($result){
        $row = $result->fetch_assoc();
        
        $data = array("status" => true, "data" => $row);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function update_user($conn){
    extract($_POST);
    $data = array();
    if(!empty($_FILES['image']['tmp_name'])){

        $eroor_Array= array();
        // $new_id= generate($conn);
    
        $file_name= $_FILES['image']['name'];
        $file_type= $_FILES['image']['type'];
        $file_size= $_FILES['image']['size'];
    
        $save_name= $update_id . ".png";
    
        // allowed images
    
        $allowedImages =  ["image/jpg", "image/jpeg", "image/png"];
        $max_size= 15 * 1024 * 1024;
    
        if(in_array($file_type, $allowedImages)){
             
            if($file_size > $max_size){
                $eroor_Array[]=  $file_size/1024/1024 . " MB  file size must be less then" . $max_size/1024/1024 ." MB";
            }
    
    
        }else{
            $eroor_Array[]= "this file is not Allowed";
        }
    
         if(count($eroor_Array) <= 0){
            $query = "UPDATE users set users.usertype= '$usertype',  users.username= '$username', 
             password= MD5('$password') where users.id= '$update_id'";
       
           $result = $conn->query($query);
       
       
           if($result){
           move_uploaded_file($_FILES['image']['tmp_name'], "../aploads/" . $save_name);
           $data = array("status" => true, "data"=>  "successfully Updated");
           
    
        
           }else{
               $data = array("status" => false, "data"=> $conn->error);
                    
           }
    
    
         }else{
            $data = array("status" => false, "data"=> $eroor_Array);
    
         }
      

    }else{

        $query = "UPDATE users set users.usertype= '$usertype', users.username= '$username',
        password= MD5('$password') where users.id= '$update_id'";
  
      $result = $conn->query($query);
  
  
      if($result){
      $data = array("status" => true, "data"=>  "successfully updated");

   
      }else{
          $data = array("status" => false, "data"=> $conn->error);
               
      }


   

    }
   

    echo json_encode($data);
}



function Delete_user_info($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="DELETE FROM `users` where id= '$id'";
    $result = $conn->query($query);


    if($result){
     
        unlink('../aploads/' .$id. ".png");
        
        $data = array("status" => true, "data" => "Deleted successfully😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function generate($conn){
    $new_id= '';
    $data = array();
    $array_data = array();
   $query ="SELECT * FROM `users` order by users.id DESC limit 1";
    $result = $conn->query($query);


    if($result){
        $num_rows= $result->num_rows;

        if($num_rows > 0){
            $row = $result->fetch_assoc();

            $new_id = ++$row['id'];

        }else{
              
            $new_id= "USR001";
        }
       
        


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

  return $new_id;
}



if(isset($_POST['action'])){
    $action = $_POST['action'];
    $action($conn);
}else{
    echo json_encode(array("status" => false, "data"=> "Action Required....."));
}
?>