
$("#loginForm2").on("submit", function (e) {

    e.preventDefault();
    let username = $("#username").val();
    let password = $("#password").val();
  
  
    let sendingData = {
      "action": "login",
      "username": username,
      "password": password
    }
  
    $.ajax({
      method: "POST",
      dataType: "JSON",
      url: "Api/Login.php",
      data: sendingData,
  
      success: function (data) {
        let status = data.status;
        let response = data.data;
  
  
        if (status) {

            console.log('success');
  
  
          window.location.href = "Website/dashboard.php";
  
        } else {
          swal("NOW!", response, "error");
        }
  
      },
      error: function (data) {
  
      }
  
    })
  
  })
  
  
  
  
  
  
  
  