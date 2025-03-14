


<!DOCTYPE html>
<html lang="en" dir="ltr" data-startbar="dark" data-bs-theme="light">


<!-- Mirrored from mannatthemes.com/rizz/default-dark/auth-recover-pw.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 02 Nov 2024 16:05:40 GMT -->
<head>


    <meta charset="utf-8" />
    <title> {$title} | {$site_details['name']}</title>
    {block name=header}
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta content=" {$title} | {$site_details['name']}" name="description" />
    <meta content="" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <!-- App favicon -->
    <link rel="shortcut icon" href="{assets_url('images/ico/favicon.ico')}">
    <!-- App css -->
    <link href="{assets_url()}css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="{assets_url()}css/icons.min.css" rel="stylesheet" type="text/css" />
    <link href="{assets_url()}css/app.min.css" rel="stylesheet" type="text/css" />
    {$smarty.block.child}
    {/block}

</head>


<!-- Top Bar Start -->
<body>
    <div class="container-xxl">
        <div class="row vh-100 d-flex justify-content-center">
            <div class="col-12 align-self-center">
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-4 mx-auto">

                            {include file="layout/flash_message.tpl"}
                            {block name=body}{/block}


                        </div><!--end col-->
                    </div><!--end row-->
                </div><!--end card-body-->
            </div><!--end col-->
        </div><!--end row-->                                        
    </div><!-- container -->
</body>
{block name=footer} 
{$smarty.block.child} 
{/block}
<!--end body-->

<!-- Mirrored from mannatthemes.com/rizz/default-dark/auth-recover-pw.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 02 Nov 2024 16:05:40 GMT -->
</html>