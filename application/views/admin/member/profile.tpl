{extends file="layout/base.tpl"}

{block body}
<div class="row">
	<div class="col-md-4">
		<div class="card"> 
			<div class="card-content collapse show">
				<div class="card-body">
					<span class="bmd-form-group">
						{form_open('','id="user_wise" name="user_wise" method="get" ')}
						<div class="input-group no-border">
							<input type="text"  class="form-control" data-lang="{lang('text_username')}" id="user_name" name="user_name" value="{$user_name}" onClick="autoComplete(this, 'admin', 'autocomplete/user_filter')" autocomplete="Off" >
							{form_error("user_name")}
							<button type="submit" class="btn btn-primary">
								<i class="material-icons">search</i>
								<div class="ripple-container"></div>
							</button>
						</div>
						{form_close()}
					</span>
				</div>
			</div>
		</div> 
		<div class="card profile-card-with-stats box-shadow-2">
			<div class="text-center">
				<div class="card-body">
					<img src="{assets_url('images/profile_pic/')}{$user_details['user_photo']}" class="rounded-circle  height-150" alt="Profile image"style="max-width:120px;">
				</div>
				<div class="card-body">
					<h4 class="card-title">{$user_name}</h4>
				</div>
				<!-- <div class="text-center mb-2">

					<a href="{$user_details['facebook']}" class="btn btn-social-icon btn-sm mr-1 btn-facebook"><span class="fa fa-facebook" target="_blank"></span></a>

					<a href="{$user_details['twitter']}" class="btn btn-social-icon btn-sm mr-1 btn-twitter" target="_blank"><span class="fa fa-twitter"></span></a>

					<a href="{$user_details['instagram']}" class="btn btn-social-icon btn-sm mr-1 btn-instagram"><span class="fa fa-instagram" target="_blank"></span></a>

				</div>  -->
			</div> 
		</div> 
	</div>


	<div class="col-md-8">
		<div class="card">
			
			<div class="card-header card-header-tabs card-header-info">
				<div class="nav-tabs-navigation">
					<div class="nav-tabs-wrapper"> 
						<ul class="nav nav-tabs" role="tablist">
							<li class="nav-item">
								<a class="nav-link active" data-bs-toggle="tab" href="#edit_profile" role="tab" aria-selected="true">{lang('edit_profile')}</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" data-bs-toggle="tab" href="#change_username" role="tab" aria-selected="false">{lang('change_username')}</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" data-bs-toggle="tab" href="#change_password" role="tab" aria-selected="false">{lang('change_password')}</a>
								
							</li>

						</ul>
						<div class="tab-content">
							<div class="tab-pane p-3 active" id="edit_profile">

								{form_open_multipart("{current_url()}?user_name={$user_name}",'id="trans_form" name="trans_form" class="form-login"' )} 
								<div class="row"> 
									<div class="col-md-6">
										<div class="form-group bmd-form-group">
											<label class="bmd-label-floating">{lang('username')}</label>
											<input type="text" class="form-control" disabled value="{$user_name}">
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group bmd-form-group">
											<label class="bmd-label-floating">{lang('email')}</label>
											<input type="email" class="form-control" name="email" value="{$user_details['email']}"> 
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group bmd-form-group">
											<label class="bmd-label-floating">{lang('firstname')}</label>

											{form_input('first_name', $user_details['first_name'], "class='form-control'")} 
											{form_error('firstname' )}
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group bmd-form-group">
											<label class="bmd-label-floating">{lang('mobile')}</label>
											{form_input('mobile', $user_details['mobile'], "class='form-control'")} 
											{form_error('mobile' )}
										</div>
									</div>

									<div class="col-md-12">
										<div class="form-group bmd-form-group">
											<label class="bmd-label-floating">{lang('address')}</label>
											{form_textarea('address', $user_details['address'], "class='form-control'")} 
											{form_error('address' )}
										</div>
									</div>

									<div class="col-md-6">
										<div class="form-group bmd-form-group">
											<label class="bmd-label-floating">{lang('status')}</label><br>
											<select title="Status" id="status" name="status" class="form-control">

												<option value="1" {if $user_status == 1} selected {/if}  {set_select( 'status', 'active')}>Active</option>
												<option value="0" {if $user_status == 0} selected {/if} {set_select( 'status', 'inactive')}>Inactive</option>
											</select> 


											
										</div>
										{form_error('status')}
									</div>



								</div>
								{if $user_type==dept_supervisor}
								<div class="row">
									<div class="col-md-12">
										<div class="form-group bmd-form-group">
											<select class="selectpicker col-12" data-size="7" data-style="select-with-transition" title="Department" id="department" name="department" required="" >
												{foreach $department as $v}
												<option value="{$v.id}" {if $department_id == $v.id } selected {/if}>{$v.name} - {$v.dep_id}</option>
												{/foreach}
											</select> 
											{form_error('department')}
										</div>
									</div>
								</div>{/if}

							
								<div class="row mt-3">
									<div class="col-md-6">
										<h4 class="title">Change Profile Photo</h4>
										<div class="fileinput text-center">
											<div class="thumbnail img-circle" id="previewContainer">
												<img id="previewImage" 
												src="{assets_url('images/profile_pic/')}{$user_details['user_photo']}" 
												alt="{$user_name}" 
												width="120px;">
											</div>
											<div class="input-group mb-3 p-3">
												<input type="file" class="form-control" id="inputGroupFile02" name="userfile" accept="image/*">
												
											</div>
											<button type="button" class="btn btn-danger d-none" id="removeButton">Remove</button>
										</div>
									</div>
								</div>

								<button type="submit" class="btn btn-primary float-end" name="profile_update" value="profile_update">{lang('update_profile')}</button>
								<div class="clearfix"></div>
								{form_close()}
							</div>


							<div class="tab-pane p-3" id="change_username">
								{form_open("{current_url()}?user_name={$user_name}",'id="trans_form" name="trans_form" class="form-login"' )} 
								<div class="row"> 
									<div class="col-md-4 mb-3">
										<div class="form-group bmd-form-group">
											<label class="bmd-label-floating">{lang('username')}</label>
											<input type="text" class="form-control" name="username" value="{$user_name}">
											{form_error('username')}
										</div>
									</div>
									<div class="col-md-4 mb-3">
										<div class="form-group bmd-form-group">
											<label class="bmd-label-floating">{lang('new_username')}</label>
											<input type="text" class="form-control" name="new_username" value="{set_value('new_username')}">
											{form_error('new_username')} 
										</div>
									</div>

									<div class="clearfix"></div>
								</div>
								<div class="form-group bmd-form-group">
									<button type="submit" class="btn btn-primary float-end" name="credential_update" value="username">{lang('button_update')}</button>
								</div>
								{form_close()}
							</div>
							<div class="tab-pane p-3" id="change_password">
								{form_open("{current_url()}?user_name={$user_name}",'id="trans_form" name="trans_form" class="form-login"' )} 
								<div class="row mb-3"> 
									<div class="col-md-4">
										<div class="form-group bmd-form-group">
											<label class="bmd-label-floating">{lang('username')}</label>
											<input type="text" class="form-control" name="username" value="{$user_name}">
											{form_error('username')}
										</div>
									</div>

									<div class="col-md-4">
										<div class="form-group bmd-form-group">
											<label class="bmd-label-floating">{lang('new_password')}</label>
											<input type="password" class="form-control" name="new_password">
											{form_error('new_password')}
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group bmd-form-group">
											<label class="bmd-label-floating">{lang('confirm_password')}</label>
											<input type="password" class="form-control" name="confirm_password">
											{form_error('confirm_password')} 
										</div>
									</div>
								</div>

								<div class="form-group bmd-form-group">
									<button type="submit" class="btn btn-primary float-end" name="credential_update" value="password">{lang('button_update')}</button>
								</div>
								{form_close()}
							</div> 

						</div> 

					</div>
				</div>
			</div>


		</div> 
	</div>
</div>  
{/block}


{block name="head"}





<link href="{assets_url('plugins/autocomplete/jquery-ui.min.css')}" rel="stylesheet" />
<link href="{assets_url('plugins/autocomplete/style.css')}" rel="stylesheet" /> 

{/block}

{block name="footer"}

<script src="{assets_url('plugins/autocomplete/jquery-ui.min.js')}"></script>
<script src="{assets_url('plugins/autocomplete/filter.js')}"></script>

<script type="text/javascript">

	
	$(function() {
		md.initFormExtendedDatetimepickers(); 	
	});
</script> 

<script>
	document.getElementById('inputGroupFile02').addEventListener('change', function(event) {
		const file = event.target.files[0];
		if (file) {
			const reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById('previewImage').src = e.target.result;
				document.getElementById('removeButton').classList.remove('d-none');
			};
			reader.readAsDataURL(file);
		}
	});

	document.getElementById('removeButton').addEventListener('click', function() {
		document.getElementById('inputGroupFile02').value = "";
		document.getElementById('previewImage').src = "{assets_url('images/profile_pic/')}{$user_details['user_photo']}";
		this.classList.add('d-none');
	});
</script>



{/block}