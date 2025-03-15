{extends file="layout/base.tpl"}

{block header} 
<link href="{assets_url()}plugins/select2/css/select2.min.css" rel="stylesheet" />
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
							<h2 class="mb-4">Update Item</h2>
							{else}
							<h2 class="mb-4">New Job</h2>
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
											<label for="txtName" class="col-lg-3 col-form-label"> Vehicle:</label>
											<div class="col-lg-9">
												<select id="vehicle" name="vehicle_id" class="vehicle_name_ajax form-control select2">
													{if $search_arr['vehicle_id']}
													<option value="{$search_arr['vehicle_id']}" selected>{$search_arr['vehicle_name']}</option>
													{/if} 
												</select>  
											</div>
										</div>
									</div>


									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtVnumber" class="col-lg-3 col-form-label">Salesman:</label>
											<div class="col-lg-9">
												<input type="text" id="sales_man_name" autocomplete="off" class="form-control" name="sales_man_name" value="{$job_details['salesman']}" readonly>
												{form_error('salesman')}
											</div>
										</div>
									</div>
									
								</div>
								<div class="row">

									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtEmail" class="col-lg-3 col-form-label">Item:</label>
											<div class="col-lg-9">
												<select id="item" name="product_id" class="item_name_ajax form-control select2">
													{if $search_arr['product_id']}
													<option value="{$search_arr['product_id']}" selected>{$search_arr['name']}</option>
													{/if} 
												</select>  
											</div>
										</div>
									</div>


									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtEmail" class="col-lg-3 col-form-label">Category :</label>
											<div class="col-lg-9">
												<select id="category" name="category" class="form-control">
													<option value="">--Select Category--</option>
													{foreach $category_details as $v}
													<option value="{$v.id}" {if $v.id == $job_details['category']}selected{/if}>{$v.category_name}</option>
													{/foreach}
												</select> 
											</div>
										</div>
									</div>


									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtMobile" class="col-lg-3 col-form-label">Purchase Rate :</label>
											<div class="col-lg-9">
												<input type="number" id="purchase_rate"  class="form-control" name="purchase_rate" value="{$job_details['purchase_rate']}" >
												{form_error('purchase_rate')}
											</div>
										</div>
									</div>

									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtMobile" class="col-lg-3 col-form-label">Sale Rate:</label>
											<div class="col-lg-9">
												<input type="number" id="sale_rate"  class="form-control" name="sale_rate" value="{$job_details['sale_rate']}" >
												{form_error('sale_rate')}
											</div>
										</div>
									</div>

									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtMobile" class="col-lg-3 col-form-label">MRP:</label>
											<div class="col-lg-9">
												<input type="number" id="mrp"  class="form-control" name="mrp" value="{$job_details['mrp']}" >
												{form_error('mrp')}
											</div>
										</div>
									</div>

									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtEmail" class="col-lg-3 col-form-label">Tax Category :</label>
											<div class="col-lg-9">
												<input type="number" id="tax_cat"  class="form-control" name="tax_cat" value="{$job_details['tax']}" readonly>
											</div>
										</div>
									</div>
								</div>

								<div class="row">

									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtEmail" class="col-lg-3 col-form-label">OP Stock:</label>
											<div class="col-lg-9">
												<input type="number" id="stock"  class="form-control" name="stock" value="{$job_details['stock']}" >
												{form_error('stock')}
											</div>
										</div>
									</div>

									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtMobile" class="col-lg-3 col-form-label">As of Date :</label>
											<div class="col-lg-9">
												<input id="txtMobile" name="as_date" type="date"  class="form-control" value="{$job_details['as_date']}">
												{form_error('open_bal')}
											</div>
										</div>
									</div>

									<div class="col-md-6">
										<div class="form-group row mb-2">

											<div class="col-lg-9">
												<input type="hidden" id="sales_man_id" autocomplete="off" class="form-control" name="sales_man_id" value="">
												{form_error('salesman')}
											</div>
										</div>
									</div>


									{if $enc_id}
									<div class="form-group">
										<label for="description">Status <span class="text-danger">*</span></label>
										<select id="txtLedger" name="status" class="form-control">
											<option value="active" {if $job_details['status'] == 'active'} selected="" {/if}>Active</option>
											<option value="inactive" {if $job_details['status'] == 'inactive'} selected="" {/if}>Inactive</option>
										</select> 
										{form_error('status')}
									</div>  
									{/if}




								</div>

								<div class="mt-2">
									{if $enc_id}
									<button type="submit"  name="update_item" value="update_item" class="btn btn-primary float-end">Update Item
									</button>
									{else}
									<button type="submit"  name="add_item" value="add_item" class="btn btn-primary float-end">Add Item
									</button>
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
<script>


	$(document).ready(function() {


		$('.item_name_ajax').select2({

			placeholder: 'Select an Item',
			ajax: {
				url:'{base_url()}admin/autocomplete/item_name_ajax',

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

	$(document).ready(function() {


		$('.vehicle_name_ajax').select2({
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



		$('#vehicle').change(function() {
			var vehicle_id = $(this).val(); 

			$.ajax({
				url: '{base_url()}admin/salesman/get_salesman_ajax', 
				type: "POST",
				data: { vehicle_id: vehicle_id },
				dataType: "json",
				success: function(response) {
					if (response.status == "success") {
						$('#sales_man_id').val(response.details.user_id);
						$('#sales_man_name').val(response.details.user_name);
					} else {
						alert("Error fetching salesman details.");
					}
				},
				error: function() {
					alert("AJAX request failed.");
				}
			});
		});

	});

</script>





{/block}