<!DOCTYPE html>
<html lang="en" dir="ltr" data-startbar="dark" data-bs-theme="light">
<head>
    <meta charset="utf-8" />

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />   
    <title> {$title} | {$site_details['name']}</title>

    {block name=header}


    <link rel="stylesheet" href="{assets_url()}libs/jsvectormap/css/jsvectormap.min.css">

    <link href="{assets_url()}css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="{assets_url()}css/icons.min.css" rel="stylesheet" type="text/css" />
    <link href="{assets_url()}css/app.min.css" rel="stylesheet" type="text/css" />



    {$smarty.block.child}
    
    {/block}
    <link rel="shortcut icon" href="{assets_url()}images/logo/favicon.png" />
</head>

<body class="">

    <div class="startbar d-print-none">

        <div class="brand">
            <a href="index.html" class="logo">
                <span>
                    <img src="{assets_url()}images/logo-sm.png" alt="logo-small" class="logo-sm">
                </span>
                <span class="">
                    <img src="{assets_url()}images/logo-light.png" alt="logo-large" class="logo-lg logo-light">
                    <img src="{assets_url()}images/logo-dark.png" alt="logo-large" class="logo-lg logo-dark">
                </span>
            </a>
        </div>

        {include file="layout/menu.tpl"}    


    </div>
    <div class="startbar-overlay d-print-none"></div>


    <div class="topbar d-print-none">
        <div class="container-xxl">
            <nav class="topbar-custom d-flex justify-content-between" id="topbar-custom">    


                <ul class="topbar-item list-unstyled d-inline-flex align-items-center mb-0">                        
                    <li>
                        <button class="nav-link mobile-menu-btn nav-icon" id="togglemenu">
                            <i class="iconoir-menu-scale"></i>
                        </button>
                    </li> 
                    <li class="mx-3 welcome-text">
                        <h3 class="mb-0 fw-bold text-truncate">Wellcome Back, {$user_details['first_name']}</h3>

                    </li>                   
                </ul>
                <ul class="topbar-item list-unstyled d-inline-flex align-items-center mb-0">


                  <!--   <li class="topbar-item">
                        <a class="nav-link nav-icon" href="javascript:void(0);" id="light-dark-mode">
                            <i class="icofont-moon dark-mode"></i>
                            <i class="icofont-sun light-mode"></i>
                        </a>                    
                    </li> -->

                 <!--    <li class="dropdown topbar-item">
                        <a class="nav-link dropdown-toggle arrow-none nav-icon" data-bs-toggle="dropdown" href="#" role="button"
                        aria-haspopup="false" aria-expanded="false">
                        <i class="icofont-bell-alt"></i>
                        <span class="alert-badge"></span>
                    </a>

                </li> -->

                <li class="dropdown topbar-item">
                    <a class="nav-link dropdown-toggle arrow-none nav-icon" data-bs-toggle="dropdown" href="#" role="button"
                    aria-haspopup="false" aria-expanded="false">
                    <img src="{assets_url()}images/profile_pic/{$user_details['user_photo']}" alt="" class="thumb-lg rounded-circle">
                </a>
                <div class="dropdown-menu dropdown-menu-end py-0">
                  
                    <div class="dropdown-divider mt-0"></div>
                    <small class="text-muted px-2 pb-1 d-block">Account</small>
                    <a class="dropdown-item" href="pages-profile.html"><i class="las la-user fs-18 me-1 align-text-bottom"></i> Profile</a>
                    <a class="dropdown-item" href="pages-faq.html"><i class="las la-wallet fs-18 me-1 align-text-bottom"></i> Earning</a>
                    <small class="text-muted px-2 py-1 d-block">Settings</small>                        
                    <a class="dropdown-item" href="pages-profile.html"><i class="las la-cog fs-18 me-1 align-text-bottom"></i>Account Settings</a>
                    <a class="dropdown-item" href="pages-profile.html"><i class="las la-lock fs-18 me-1 align-text-bottom"></i> Security</a>
                    <a class="dropdown-item" href="pages-faq.html"><i class="las la-question-circle fs-18 me-1 align-text-bottom"></i> Help Center</a>                       
                    <div class="dropdown-divider mb-0"></div>
                    <a class="dropdown-item text-danger" href="auth-login.html"><i class="las la-power-off fs-18 me-1 align-text-bottom"></i> Logout</a>
                </div>
            </li>
        </ul>
    </nav>

</div>
</div>



<div class="page-wrapper">
    <div class="page-content">

        {include file="layout/flash_message.tpl"}
        {block name=body}{/block}
        <footer class="footer text-center text-sm-start d-print-none">
            <div class="container-xxl">
                <div class="row">
                    <div class="col-12">
                        <div class="card mb-0 rounded-bottom-0">
                            <div class="card-body">
                                <p class="text-muted mb-0">
                                    ©
                                    <script> document.write(new Date().getFullYear()) </script>
                                    Golden Signature
                                    <span
                                    class="text-muted d-none d-sm-inline-block float-end">
                                    Developed by <a href="https://www.xteum.com" target="_blank"> 
                                    Xteum Technologies</a> <i class="iconoir-heart text-success"></i> </span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </div>
</div>


{block name=footer} 


<script src="{assets_url()}libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="{assets_url()}libs/simplebar/simplebar.min.js"></script>

<!-- <script src="{assets_url()}libs/apexcharts/apexcharts.min.js"></script> -->
<script src="{assets_url()}data/stock-prices.js"></script>
<script src="{assets_url()}libs/jsvectormap/js/jsvectormap.min.js"></script>
<script src="{assets_url()}libs/jsvectormap/maps/world.js"></script>
<script src="{assets_url()}js/pages/index.init.js"></script>
<script src="{assets_url()}js/app.js"></script>
{$smarty.block.child} 
{/block}
</body>


</html>