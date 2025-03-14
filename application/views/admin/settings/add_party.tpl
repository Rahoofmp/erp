{extends file="layout/base.tpl"}

{block header} 

<link href="{assets_url()}plugins/select2/css/select2.min.css" rel="stylesheet" />

<link rel="stylesheet" type="text/css" href="{assets_url('plugins/DataTables/css/dataTables.bootstrap.min.css')}">
<link rel="stylesheet" type="text/css" href="{assets_url('plugins/DataTables/css/dataTables.jqueryui.min.css')}">
<link rel="stylesheet" type="text/css" href="{assets_url('plugins/DataTables/css/dataTables.foundation.min.css')}">

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
							<h2 class="mb-4">Update Party</h2>
							{else}
							<h2 class="mb-4">New Party</h2>
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
											<label for="txtPname" class="col-lg-3 col-form-label"> Party Name :</label>
											<div class="col-lg-9">
												<input id="txtPname" name="party_name" type="text" class="form-control" value="{$party_details['name']}">
												{form_error('party_name')}
											</div>
										</div><!--end form-group-->
									</div><!--end col-->
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtMobile" class="col-lg-3 col-form-label">Mobile No :</label>
											<div class="col-lg-9">
												<input id="txtMobile" name="phone" type="tel" class="form-control" value="{$party_details['mobile_number']}">
												{form_error('phone')}
											</div>
										</div><!--end form-group-->
									</div><!--end col-->

								</div><!--end row-->
								<div class="row">
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtAddress" class="col-lg-3 col-form-label">Address :</label>
											<div class="col-lg-9">
												<textarea id="txtAddress" name="address" rows="4" class="form-control">
													{$party_details['address']}
												</textarea>
												{form_error('address')}
											</div>
										</div><!--end form-group-->
									</div><!--end col-->
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtPtype" class="col-lg-3 col-form-label">Party Type :</label>
											<div class="col-lg-9">
												<select id="txtPtype" name="party_type" class="form-control">
													<option value="1" {if $party_details['type'] == '1'} selected {/if}>Purchase Party</option>
													<option value="2" {if $party_details['type'] == '2'} selected {/if}>Sales Party</option>
												</select>    
											</div>
										</div><!--end form-group-->


										<div class="form-group row mb-2">
										<label for="txtVehicle" class="col-lg-3 col-form-label">Vehicle Group :</label>
											<div class="col-lg-9">
												<select id="source" name="vehicle_id" class="vehicles_ajax form-control select2">
													{if $party_details['vehicle_id']}
													<option value="{$party_details['vehicle_id']}" selected>{$party_details['vehicle_name']}</option>
													{/if} 
												</select>    
											</div>
										</div>



									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtMobile" class="col-lg-3 col-form-label">Opening Bal :</label>
											<div class="col-lg-9">
												<input id="txtMobile" name="open_bal" type="number" value="{$party_details['open_bal']}" class="form-control">
												{form_error('open_bal')}
											</div>
										</div><!--end form-group-->
									</div><!--end col-->
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtEmail" class="col-lg-3 col-form-label">Receive/Pay :</label>
											<div class="col-lg-9">
												<select id="txtVehicle" name="res_pay" class="form-control">
													<option value="toreceive" {if $party_details['res_pay'] == 'toreceive'} selected {/if}>To Receive</option>
													<option value="topay" {if $party_details['res_pay'] == 'topay'} selected {/if}>To Pay</option>
												</select>  
											</div>
										</div><!--end form-group-->
									</div><!--end col-->
								</div><!--end row-->
								<div class="row">
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtMobile" class="col-lg-3 col-form-label">As of Date :</label>
											<div class="col-lg-9">
												<input id="txtMobile" name="as_date" type="date" value="{$party_details['as_date']}" class="form-control">
												{form_error('as_date')}
											</div>
										</div><!--end form-group-->
									</div><!--end col-->
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtEmail" class="col-lg-3 col-form-label">Ledger Group:</label>
											<div class="col-lg-9">

												<select id="txtLedger" name="ledger_group" class="form-control">
													<option value="sales" {if $party_details['ledger_group'] == 'sales'} selected {/if}>Sales Receipt</option>
													<option value="purchase" {if $party_details['ledger_group'] == 'purchase'} selected {/if}>Purchase Payment</option>
												</select>    
											</div>
										</div><!--end form-group-->
									</div><!--end col-->
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtEmail" class="col-lg-3 col-form-label">Email :</label>
											<div class="col-lg-9">
												<input id="txtEmail" name="email" type="email" class="form-control" value="{$party_details['email']}">
												{form_error('email')}
											</div>
										</div><!--end form-group-->
									</div><!--end col-->
								</div><!--end row-->


								{if $enc_id}
								<div class="row">

									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtPartyid" class="col-lg-3 col-form-label"> Party Id :</label>
											<div class="col-lg-9">
												<input id="txtPartyid" name="party_id" value="{$party_details['party_id']}" type="text" class="form-control" readonly>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtPartyid" class="col-lg-3 col-form-label"> Status :</label>
											<div class="col-lg-9">
												<select id="txtLedger" name="status" class="form-control">
													<option value="active" {if $party_details['status'] == 'active'} selected {/if}>Active</option>
													<option value="inactive" {if $party_details['status'] == 'inactive'} selected {/if}>Inactive</option>
												</select>  
											</div>
										</div>
									</div>
			
								</div>
								{/if}


								<div class="mt-2">
									{if $enc_id}
									<button type="submit"  name="update_party" value="update_party" class="btn btn-primary float-end">Update Party
									</button>
									{else}
									<button type="submit"  name="add_party" value="add_party" class="btn btn-primary float-end">Add Party
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
		document.addEventListener("DOMContentLoaded", function() {
			let vehicleInput = document.getElementById("vehicle_number");

			vehicleInput.addEventListener("input", function() {
				this.value = this.value.toUpperCase();
			});
		});
	</script>



	{/block}
