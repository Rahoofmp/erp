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
							<h2 class="mb-4">Update Item</h2>
							{else}
							<h2 class="mb-4">New Item</h2>
							{/if}                        
						</div>
					</div>                                 
				</div>
				<div class="card-body pt-0">
					{form_open('', 'class="needs-validation" id="custom-step" novalidate')}    
					<form action="#" method="post" id="custom-step">
						<div class="tab-content" id="nav-tabContent">
							<div class="tab-pane active" id="step1">
								<div class="row">
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtVnumber" class="col-lg-3 col-form-label">Code/Barcode :</label>
											<div class="col-lg-9">
												<input type="text" id="bar_code" autocomplete="off" class="form-control" name="bar_code" value="{$item_details['barcode']}" required="">
												{form_error('bar_code')}
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtName" class="col-lg-3 col-form-label"> Item Name :</label>
											<div class="col-lg-9">
												<input type="text" id="name"  class="form-control" name="name" value="{$item_details['name']}"  required="">
												{form_error('name')}
											</div>
										</div>
									</div>
								</div>
								<div class="row">

									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtEmail" class="col-lg-3 col-form-label">Item Type :</label>
											<div class="col-lg-9">
												<select id="txtVehicle" name="type" class="form-control" required="">
													<option value="service"  {if $item_details['type'] == 'service'} selected {/if} >Service</option>
													<option value="product"  {if $item_details['type'] == 'product'} selected {/if}>Product</option>
												</select> 
											</div>
										</div>
									</div>


									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtEmail" class="col-lg-3 col-form-label">Category :</label>
											<div class="col-lg-9">
												<select id="category" name="category" class="form-control" required="">
													<option value="">--Select Category--</option>
													{foreach $category_details as $v}
													<option value="{$v.id}" {if $v.id == $item_details['category']}selected{/if}>{$v.category_name}</option>
													{/foreach}
												</select> 
											</div>
										</div>
									</div>


									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtName" class="col-lg-3 col-form-label"> Purchase Rate :</label>
											<div class="col-lg-9">
												<input type="text" id="purchase_rate"  class="form-control" name ="purchase_rate" value="{$item_details['purchase_rate']}"  required="">
												{form_error('purchase_rate')}
											</div>
										</div>
									</div>
									
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtName" class="col-lg-3 col-form-label"> Sales Rate :</label>
											<div class="col-lg-9">
												<input type="text" id="sales_rate"  class="form-control" name ="sales_rate" value="{$item_details['sales_rate']}"  required="">
												{form_error('sales_rate')}
											</div>
										</div>
									</div>

									

									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtName" class="col-lg-3 col-form-label">MRP:</label>
											<div class="col-lg-9">
												<input type="text" id="mrp"  class="form-control" name ="mrp" value="{$item_details['mrp']}"  required="">
												{form_error('mrp')}
											</div>
										</div>
									</div>

									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtName" class="col-lg-3 col-form-label">Opeining Stock:</label>
											<div class="col-lg-9">
												<input type="number" id="opening_stock"  class="form-control" name ="opening_stock" value="{$item_details['opening_stock']}"  required="">
												{form_error('opening_stock')}
											</div>
										</div>
									</div>

									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtName" class="col-lg-3 col-form-label">Adding Date:</label>
											<div class="col-lg-9">
												<input id="txtDate" name="date" type="date" value="{$party_details['date']}" class="form-control" required>
												{form_error('datre')}
											</div>
										</div>
									</div>

									


									{if $enc_id}
									<div class="form-group">
										<label for="description">Status <span class="text-danger">*</span></label>
										<select id="txtLedger" name="status" class="form-control">
											<option value="active" {if $item_details['status'] == 'active'} selected="" {/if}>Active</option>
											<option value="inactive" {if $item_details['status'] == 'inactive'} selected="" {/if}>Inactive</option>
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
<script>



	(function () {
		'use strict'

		var forms = document.querySelectorAll('.needs-validation')
		Array.prototype.slice.call(forms)
		.forEach(function (form) {
			form.addEventListener('submit', function (event) {
				if (!form.checkValidity()) {
					event.preventDefault()
					event.stopPropagation()
				}

				form.classList.add('was-validated')
			}, false)
		})
	})()

</script>





{/block}