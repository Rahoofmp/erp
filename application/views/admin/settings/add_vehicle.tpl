{extends file="layout/base.tpl"}

{block header} 

{/block}

{block body}

<div class="row justify-content-center">
	<div class="col-12">
		<div class="card">
			<div class="card-header">
				<div class="row align-items-center">
					<div class="col">
						<div class="container mt-3">
							{if $enc_id}
							<h2 class="mb-4">Update Vehicle</h2>
							{else}
							<h2 class="mb-4">New Vehicle</h2>
							{/if}                        
						</div>
					</div>                                 
				</div>
				<div class="card-body pt-0">
					{form_open()}
					<form action="#" method="post" id="custom-step">
						<div class="tab-content" id="nav-tabContent">
							<div class="tab-pane active" id="step1">
								<div class="row">
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtVnumber" class="col-lg-3 col-form-label"> Vehicle Number :</label>
											<div class="col-lg-9">
												<input type="text" id="vehicle_number" autocomplete="off" class="form-control" name="vehicle_number" value="{$vehicle_details['vehicle_number']}">
												{form_error('vehicle_number')}
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtName" class="col-lg-3 col-form-label"> Vehicle Name :</label>
											<div class="col-lg-9">
												<input type="text" id="vehicle_name"  class="form-control" name="vehicle_name" value="{$vehicle_details['vehicle_name']}" >
												{form_error('vehicle_name')}
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtMobile" class="col-lg-3 col-form-label">Opening Bal :</label>
											<div class="col-lg-9">
												<input type="text" id="open_bal"  class="form-control" name="open_bal" value="{$vehicle_details['open_bal']}" >
												{form_error('open_bal')}
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtEmail" class="col-lg-3 col-form-label">Receive/Pay :</label>
											<div class="col-lg-9">
												<select id="txtVehicle" name="res_pay" class="form-control">
													<option value="toreceive"  {if $vehicle_details['res_pay'] == 'toreceive'} selected {/if} >To Receive</option>
													<option value="topay"  {if $vehicle_details['res_pay'] == 'topay'} selected {/if}>To Pay</option>
												</select> 
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtMobile" class="col-lg-3 col-form-label">As of Date :</label>
											<div class="col-lg-9">
												<input id="txtMobile" name="as_date" type="date"  class="form-control" value="{$vehicle_details['as_date']}">
												{form_error('open_bal')}
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtEmail" class="col-lg-3 col-form-label">Under Group:</label>
											<div class="col-lg-9">
												<select id="txtLedger" name="under_group" class="form-control">
													<option value="vehicleexpense">Vehicle Expense</option>
												</select>    
											</div>
										</div>
									</div>

									{if $enc_id}
									<div class="form-group">
										<label for="description">Status <span class="text-danger">*</span></label>
										<select id="txtLedger" name="status" class="form-control">
											<option value="active" {if $vehicle_details['status'] == 'active'} selected="" {/if}>Active</option>
											<option value="inactive" {if $vehicle_details['status'] == 'inactive'} selected="" {/if}>Inactive</option>
										</select> 
										{form_error('status')}
									</div>  
									{/if}




								</div>

								<div class="mt-2">
									{if $enc_id}
									<button type="submit"  name="update_vehicle" value="update_vehicle" class="btn btn-primary float-end">Update Vehicle
									</button>
									{else}
									<button type="submit"  name="add_vehicle" value="add_vehicle" class="btn btn-primary float-end">Add Vehicle
										{/if}
									</div>                                        
								</div>
							</div>
						</form>
						{form_close()}               
					</div>
				</div>
			</div>                                                                                
		</div>
	</div>



	{/block}

	{block footer}

	<script>
		document.addEventListener("DOMContentLoaded", function() {
			let vehicleInput = document.getElementById("vehicle_number");

			vehicleInput.addEventListener("input", function() {
				this.value = this.value.toUpperCase();
			});
		});
	</script>



	{/block}
