{extends file="layout/base.tpl"}
{block header} 
<link href="{assets_url()}plugins/select2/css/select2.min.css" rel="stylesheet" />
{/block}

{block body}


<div class="container-xxl">

	<div class="row justify-content-center">
		<div class="col-12">
			<div class="card">
				<div class="card-header">
					<div class="row align-items-center">
						<div class="col">
							<div class="container mt-5">
								<h2 class="mb-4">New Staff</h2>                    
							</div><!--end col-->
						</div>  <!--end row-->                                  
					</div>
					<div class="card-body pt-0">
						<form action="#" method="post" id="custom-step">
							{form_open()}
							<div class="tab-content" id="nav-tabContent">
								<div class="tab-pane active" id="step1">
									<div class="row">
										<div class="col-md-6">
											<div class="form-group row mb-2">
												<label for="txtName" class="col-lg-3 col-form-label">UserName:</label>
												<div class="col-lg-9">
													<input id="txtName" name="user_name" type="text" class="form-control">
													{form_error('user_name')}
												</div>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group row mb-2">
												<label for="txtStaffid" class="col-lg-3 col-form-label">Name:</label>
												<div class="col-lg-9">
													<input id="txtStaffid" name="name" type="text" class="form-control">
													{form_error('name')}
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group row mb-2">
												<label for="txtMobile" class="col-lg-3 col-form-label">Mobile No:</label>
												<div class="col-lg-9">
													<input id="txtMobile" name="mobile" type="tel" class="form-control">
													{form_error('mobile')}
												</div>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group row mb-2">
												<label for="txtEmail" class="col-lg-3 col-form-label">Email:</label>
												<div class="col-lg-9">
													<input id="txtEmail" name="email" type="email" class="form-control">
													{form_error('email')}
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group row mb-2">
												<label for="txtAddress" class="col-lg-3 col-form-label">Address:</label>
												<div class="col-lg-9">
													<textarea id="txtAddress" name="address" rows="4" class="form-control"></textarea>
													{form_error('address')}
												</div>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group row mb-2">
												<label for="txtJobrole" class="col-lg-3 col-form-label">Job Role:</label>
												<div class="col-lg-9">
													<select id="user_type" name="user_type" class="form-control" onchange="toggleVehicleField()">
														<option value="admin">Manager</option>
														<option value="supervisor">Accountant</option>
														<option value="salesman">Salesman</option>
													</select>
												</div>
											</div>
											<div class="form-group row mb-2" id="vehicleField" style="display: none;">
												<label for="txtVehicle" class="col-lg-3 col-form-label">Vehicle:</label>
												<div class="col-lg-9">
													<select id="source" name="vehicle_id" class="vehicles_ajax form-control select2">
														{if $search_arr['vehicle_id']}
														<option value="{$search_arr['vehicle_id']}" selected>{$search_arr['vehicle_name']}</option>
														{/if} 
													</select>  
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group row mb-2">
												<label for="txtOpeningBal" class="col-lg-3 col-form-label">Opening Bal:</label>
												<div class="col-lg-9">
													<input id="txtOpeningBal" name="open_bal" type="number" class="form-control">
													{form_error('open_bal')}
												</div>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group row mb-2">
												<label for="txtReceivePay" class="col-lg-3 col-form-label">Receive/Pay:</label>
												<div class="col-lg-9">
													<select id="txtReceivePay" name="re_pay" class="form-control">
														<option value="toreceive">To Receive</option>
														<option value="topay">To Pay</option>
													</select>
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group row mb-2">
												<label for="txtUnderGroup" class="col-lg-3 col-form-label">Under Group:</label>
												<div class="col-lg-9">
													<select id="txtUnderGroup" name="under_group" class="form-control">
														<option value="staffsalary">Staff Salary</option>
													</select>
												</div>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group row mb-2">
												<label for="txtPassword" class="col-lg-3 col-form-label">Password:</label>
												<div class="col-lg-9">
													<input id="txtPassword" name="password" type="password" class="form-control">
													{form_error('password')}
												</div>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group row mb-2">
												<label for="txtPassword" class="col-lg-3 col-form-label">Confirm Password:</label>
												<div class="col-lg-9">
													<input id="txtPassword" name="c_password" type="password" class="form-control">
													{form_error('c_password')}
												</div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-md-6">
											<div class="form-group row mb-2" id="accountField" style="display: none;">
												<label for="txtVehicle" class="col-lg-3 col-form-label">Accountant:</label>
												<div class="col-lg-9">
													<select id="subadmin" name="subadmin" class="form-control">
														{foreach $subadmins as $v}
														<option value="{$v.user_id}">{$v.user_name}</option>
														{/foreach}
													</select>  
												</div>
											</div>
										</div>
									</div>
									<div class="mt-2">
										<button type="submit" id="btnAdd" name="register" value="website" class="btn btn-primary float-end">Add Staff</button>
									</div>
								</div>
							</div>
							{form_close()}
						</form>             
					</div>
				</div>
			</div>                                                                              
		</div>                 
	</div>
</div>

{/block}
{block footer}

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="{assets_url()}plugins/select2/js/select2.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){ 


		$('.vehicles_ajax').select2({

			placeholder: 'Select a Vehicle',
			ajax: {
				url:'{base_url()}admin/autocomplete/vehicles_ajax',

				type: 'post',
				dataType: 'json',
				delay:250,
				processResults: function(data) {
					return {
						results: data
					};
				}
			},

		});
	});
</script>

<script>
	function toggleVehicleField() {



		var userType = document.getElementById("user_type").value;
		var vehicleField = document.getElementById("vehicleField");
		var accountField = document.getElementById("accountField");
		if (userType === "salesman") {
			vehicleField.style.display = "";
			accountField.style.display = "";
		} else {
			vehicleField.style.display = "none";
			accountField.style.display = "none";
		}
	}


	
</script>{/block}