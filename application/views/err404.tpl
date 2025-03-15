{extends file="login/layout.tpl"}

{block name="body"}  
<div class="card">
	<div class="card-body p-0 bg-black auth-header-box rounded-top">
		<div class="text-center p-3">
			<a href="{base_url()}" class="logo logo-admin">
				<img src="{assets_url()}images/logo-sm.png" height="50" alt="logo" class="auth-logo">
			</a>
			<h4 class="mt-3 mb-1 fw-semibold text-white fs-18">Oops! Sorry page does not found</h4>   
			<p class="text-muted fw-medium mb-0">Back to dashboard of Rizz</p>  
		</div>
	</div>
	<div class="card-body pt-0">                                    
		<div class="ex-page-content text-center">
			<img src="{assets_url()}images/extra/error.svg" alt="0" class="" height="170">
			<h1 class="my-2">404!</h1>  
			<h5 class="fs-16 text-muted mb-3">Somthing went wrong</h5>                                    
		</div>   
		<a class="btn btn-primary w-100" href="{base_url()}{log_user_type()}/dashboard">Back to Dashboard <i class="fas fa-redo ms-1"></i></a> 
	</div><!--end card-body-->
</div>
{/block}
