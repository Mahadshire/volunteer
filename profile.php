<?php
session_start();
include 'config/conn.php';
$id = $_SESSION['user_id'];
if (!isset($_SESSION['username'])) {
    header('Location:login.php');
    die();
}

?>

<!-- <?php
$usertype = mysqli_query($conn, "SELECT usertype, username, status,date FROM users u WHERE u.user_id='$id'");
$date = mysqli_fetch_array($usertype);

?> -->

<style>
    #show {
        width: 100px;
        height: 100px;
        border: solid 1px #744547;
        border-radius: 50%;
        object-fit: cover;
    }
</style>

<?php

include 'include/header.php';

?>
<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <!-- sidebar -->
        <?php
        include 'include/sidebar.php';

        ?>
        <!-- / sidebar -->

        <!-- Layout container -->
        <div class="layout-page">
            <!-- Navbar -->
            <?php
            include 'include/nav.php';
            ?>
            <!-- / Navbar -->

            <!-- Content wrapper -->
            <div class="content-wrapper">
                <!-- Content -->

                <form id="profile">
                    <div class="profile">
                        <div class="container rounded  mt-5 mb-5">
                            <div class="row justify-content-center">
                                <div class="col-md-3 border-right">
                                    <div class="d-flex flex-column align-items-center text-center p-3 py-5"><img src="<?php  echo "aploads/" . $_SESSION['image']?>" style="width: 130px" height="130px" alt="Profile" class="rounded-circle mt-5">
                                        <span class="fw-semibold d-block mt-2"><?php echo  $_SESSION['username'] ?> </span>
                                        <!-- <small class="text-muted"><?php echo $_SESSION['email'] ?></small> -->
                                    </div>
                                </div>
                                <div class="col-md-5 border-right">
                                    <div class="p-3 py-5">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <h4 class="text-right">Profile Settings</h4>
                                        </div>

                                        <div class="row mt-3">
                                            <div class="col-md-6">
                                                <label class="labels">UserName</label>
                                                <input type="text" class="form-control mt-2" value="<?php echo $_SESSION['username'] ?>" readonly>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="labels">status</label>
                                                <input type="text" class="form-control mt-2" value="<?php echo $_SESSION['status'] ?>" readonly>
                                            </div>
                                            <div class="col-md-12">
                                                <label class="labels mt-3">usertype</label>
                                                <input type="text" class="form-control mt-2" value="<?php echo $_SESSION['usertype'] ?>" readonly>
                                            </div>
                                            <!-- <div class="col-md-6">
                                                <label class="labels mt-3">date</label>
                                                <input type="text" class="form-control mt-2" value="<?php echo $date['date'] ?>" readonly>
                                            </div>
 -->


                                        </div>



                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-- / Content -->



        <style>
            .form-control:focus {
                box-shadow: none;
                border-color: #BA68C8
            }

            .profile-button {
                background: rgb(99, 39, 120);
                box-shadow: none;
                border: none
            }

            .profile-button:hover {
                background: #682773
            }

            .profile-button:focus {
                background: #682773;
                box-shadow: none
            }

            .profile-button:active {
                background: #682773;
                box-shadow: none
            }

            .back:hover {
                color: #682773;
                cursor: pointer
            }

            .labels {
                font-size: 11px
            }

            .add-experience:hover {
                background: #BA68C8;
                color: #fff;
                cursor: pointer;
                border: solid 1px #BA68C8
            }
        </style>



        <!-- Footer -->

        <!-- / Footer -->

        <div class="content-backdrop fade"></div>
    </div>

    <!-- Content wrapper -->
</div>

<!-- / Layout page -->
</div>


<!-- Overlay -->
<div class="layout-overlay layout-menu-toggle"></div>
</div>
<!-- / Layout wrapper -->

<?php
include 'include/footer.php';
?>