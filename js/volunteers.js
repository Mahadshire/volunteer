
fillebranch();
loaddData();
showImage();
btnAction = "Insert";
function showImage(){
  let fileimage = document.querySelector("#image");
let showInput = document.querySelector("#show");

const reader = new FileReader();

fileimage.addEventListener("change", (e) => {
  const selectedFile = e.target.files[0];
  reader.readAsDataURL(selectedFile);
})

reader.onload = e => {
  showInput.src = e.target.result;
}
}




function fillebranch() {

  let sendingData = {
    "action": "read_all_branch"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/volunteers.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['branch_id']}">${res['branch_name']}</option>`;

        })

        $("#branch_id").append(html);


      } else {
        displaymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}







$("#employeeform").on("submit", function (event) {

  event.preventDefault();



  // let amount= $("#amount").val();
  // let type= $("#type").val();
  // let description= $("#description").val();
  // let id= $("#update_id").val();

  let form_data = new FormData($("#employeeform")[0]);
  form_data.append("image", $("input[type=file]")[0].files[0]);


  if (btnAction == "Insert") {
    form_data.append("action", "register_valunteers");
    $("#employeeTable tr").html('');
    loaddData();



  }
   else {
    form_data.append("action", "update_volunteers");
    loaddData();  

  }



  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/volunteers.php",
    data: form_data,
    processData: false,
    contentType: false,
    success: function (data) {
      let status = data.status;
      let response = data.data;

      if (status) {
        displaymassage("success", response);
        btnAction = "Insert";
        loaddData();
        $("#employeeform")[0].reset();
        $("#usermodal").modal("hide");

        displaymassage("success", response);



      } else {
       // swal("Good job!", "success", response);
               displaymassage("error", response);


      }

    },
    error: function (data) {

    }

  })

})



function loaddData() {
  $("#employeeTable tr").html('');

  let sendingData = {
    "action": "get_volunteers_list"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/volunteers.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';
      let th = '';

      if (status) {
        response.forEach(res => {

          th = "<tr>";
          for (let i in res) {
            th += `<th>${i}</th>`;
          }

          th += "<th>Action</th></tr>";

          tr += "<tr>";
          for (let r in res) {

            if (r == "image") {

              tr += `<td><img style="width:50px; height:50px; border: 1px solid #e3ebe7;
                     border-radius:50%; object-fit:cover;" src="aploads/${res[r]}"></td>`;

            } else {
              tr += `<td>${res[r]}</td>`;
            }

          }

          tr += `<td> <a class="btn btn-info update_info"  update_id=${res['volunteers_id']}><i class="bi bi-pencil-square" style="color: #fff"></i></a>&nbsp;&nbsp <a class="btn btn-danger delete_info" delete_id=${res['volunteers_id']}><i class="bi bi-trash" style="color: #fff"></i></a> </td>`
          tr += "</tr>"

        })

        $("#employeeTable thead").append(th);
        $("#employeeTable tbody").append(tr);
      }

    },
    error: function (data) {

    }

  })
}


function fetchuserinfo(volunteers_id) {

  let sendingData = {
    "action": "get_volunteers_info",
    "volunteers_id": volunteers_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/volunteers.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        btnAction = "update";

        $("#update_id").val(response['volunteers_id']);
        $("#fullname").val(response['fullname']);
        $("#sex").val(response['sex']);
        $("#phone").val(response['phone']);
        $("#age").val(response['age']);
        $("#education").val(response['education']);
        $("#branch_id").val(response['branch_id']);
        $("#method").val(response['method']);
        $("#show").attr('src', `aploads/${response['image']}`);
        $("#usermodal").modal("show");







      } else {
        displaymessagee("error", response);
      }

    },
    error: function (data) {

    }

  })
}


function Delete_volunteers_info(volunteers_id) {

  let sendingData = {
    "action": "Delete_volunteers_info",
    "volunteers_id": volunteers_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/volunteers.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        swal("Good job!", response, "success");
        loaddData();


      } else {
        swal(response);
      }

    },
    error: function (data) {

    }

  })
}

function displaymassage(type, message){
    let success =   document.querySelector(".alert-success");
    let error =   document.querySelector(".alert-danger");
    if(type== "success"){
      error.classList= "alert alert-danger d-none";
       success.classList= "alert alert-success";
       success.innerHTML= message;
  
       setTimeout(function(){
        $("#usermodal").modal("hide");
        success.classList= "alert alert-success d-none";
        $("#usermodal")[0].reset();
        
  
       },3000);
    }else{
      error.classList= "alert alert-danger";
      error.innerHTML= message;
    }
  }



$("#employeeTable").on('click', "a.update_info", function () {
  let id = $(this).attr("update_id");
  fetchuserinfo(id)
})

$("#employeeTable").on('click', "a.delete_info", function () {
  let volunteers_id = $(this).attr("delete_id");
  if (confirm("Are you sure To Delete")) {
    Delete_volunteers_info(volunteers_id)

  }

})