
get_total_feedback();
get_all_employee();
get_all_users();
get_total_valunteer();
get_total_programs();


function get_total_valunteer() {

    let sendingData = {
        "action": "get_total_volunteer"

    }

    $.ajax({
        method: "POST",
        dataType: "JSON",
        url: "Api/income.php",
        data: sendingData,
        async: false,
        success: function (data) {
            let status = data.status;
            let response = data.data;


            if (status) {


                document.querySelector("#total_valunteer").innerText = response['volunter']


            } else {

            }

        },
        error: function (data) {

        }

    })
}


function get_total_programs() {

    let sendingData = {
        "action": "get_total_programs"

    }

    $.ajax({
        method: "POST",
        dataType: "JSON",
        url: "Api/income.php",
        data: sendingData,
        async: false,
        success: function (data) {
            let status = data.status;
            let response = data.data;
            console.log("hello", response)



            if (status) {


                document.querySelector("#total_prgrams").innerText = response['programs']


            } else {

            }

        },
        error: function (data) {

        }

    })
}


function get_total_feedback() {

    let sendingData = {
        "action": "get_total_feedback"

    }

    $.ajax({
        method: "POST",
        dataType: "JSON",
        url: "Api/income.php",
        data: sendingData,
        async: false,
        success: function (data) {
            let status = data.status;
            let response = data.data;
            if (status) {
                document.querySelector("#total_feedback").innerText = response['feedback']

            } else {

            }
        },
        error: function (data) {

        }

    })
}


function get_all_employee() {

    let sendingData = {
        "action": "get_all_employee"

    }

    $.ajax({
        method: "POST",
        dataType: "JSON",
        url: "Api/income.php",
        data: sendingData,
        async: false,
        success: function (data) {
            let status = data.status;
            let response = data.data;


            if (status) {


                document.querySelector("#employee").innerText = response['employee'];


            } else {

            }

        },
        error: function (data) {

        }

    })
}



function get_total_revenue() {



    document.querySelector("#Revenue").innerText = tempTotalincome - tempTotalexpense;



}



function get_all_users() {

    let sendingData = {
        "action": "get_all_users"

    }

    $.ajax({
        method: "POST",
        dataType: "JSON",
        url: "Api/income.php",
        data: sendingData,

        success: function (data) {
            let status = data.status;
            let response = data.data;


            if (status) {


                document.querySelector("#users").innerText = response['users']


            } else {

            }

        },
        error: function (data) {

        }

    })
}



function loadtop() {
    $("#topcustomers tbody").html('');
    $("#topcustomers thead").html('');
  
    let sendingData = {
      "action": "read_top"
    }
  
    $.ajax({
      method: "POST",
      dataType: "JSON",
      url: "Api/income.php",
      data: sendingData,
  
      success: function (data) {
        let status = data.status;
        let response = data.data;
        let html = '';
        let tr = '';
        let th = '';
  
        if (status) {
          response.forEach(res=>{
            tr += "<tr>";
            th = "<tr>";
            for(let r in res){
              th += `<th>${r}</th>`;
  
           if(r == "rating_name"){
            if(res[r] == "Excellent"){
              tr += `<td><span class="badge bg-success text-white">${res[r]}</span></td>`;
            }else if (res[r] == "Good"){
              tr += `<td><span class="badge bg-primary text-white">${res[r]}</span></td>`;
            }
  
            else if (res[r] == "Fair"){
              tr += `<td><span class="badge bg-warning text-white">${res[r]}</span></td>`;
            }
            else if (res[r] == "Very Poor"){
              tr += `<td><span class="badge bg-danger text-white">${res[r]}</span></td>`;
            }
  
            else{
              tr += `<td><span class="badge bg-dark text-white">${res[r]}</span></td>`;
            }
  
  
  
            
           }else{
            tr += `<td>${res[r]}</td>`;
           }
  
            }
     
          
        })
          $("#topcustomers thead").append(th);
          $("#topcustomers tbody").append(tr);
        }
  
      },
      error: function (data) {
  
      }
  
    })
  }
  