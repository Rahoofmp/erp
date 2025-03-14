{extends file="login/layout.tpl"}

{block name="body"} 
<div class="card">
    <div class="card-body p-0 bg-black auth-header-box rounded-top">
        <div class="text-center p-3">
            <a href="index.html" class="logo logo-admin">
                <img src="{assets_url()}images/logo-sm.png" height="50" alt="logo" class="auth-logo">
            </a>
            <h4 class="mt-3 mb-1 fw-semibold text-white fs-18">Reset Password</h4>   
            <p class="text-muted fw-medium mb-0">Enter your Email and instructions will be sent to you!</p>  
        </div>
    </div>
    <div class="card-body pt-0">                                    
        {form_open('', 'class="my-4"')}         
        <div class="form-group mb-2">
            <label class="form-label" for="username">User Name</label>
            <input type="text" class="form-control" required id="user-name" name="user_name" placeholder="{lang('username')}" required autocomplete="off">                               
        </div><!--end form-group-->
        <div class="form-group mb-2">
            <label class="form-label" for="username">Email</label>
            <input type="text" class="form-control" id="userEmail" name="email" required="" autocomplete="off" placeholder="Enter Email Address">                               
        </div><!--end form-group-->             

        <div class="form-group mb-0 row">
            <div class="col-12">
                <div class="d-grid mt-3">
                    <button class="btn btn-primary" type="submit" name="forgot" value="forgot">Reset <i class="fas fa-sign-in-alt ms-1"></i></button>
                </div>
            </div><!--end col--> 
        </div> <!--end form-group-->                           
        {form_close()}
        <div class="text-center  mb-2">
            <p class="text-muted">Remember It ?  <a href="{base_url('login')}" class="text-primary ms-2">Sign in here</a></p>
        </div>
    </div><!--end card-body-->
</div><!--end card-->



{/block}