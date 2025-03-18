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
							<h2 class="mb-4">Update Category</h2>
							{else}
							<h2 class="mb-4">New Category</h2>
							{/if}                        
						</div>
					</div>                                 
				</div>
				<div class="card-body pt-0">
					{form_open('', 'class="needs-validation" id="custom-step" novalidate')}        

					
						<div class="tab-content" id="nav-tabContent">
							<div class="tab-pane active" id="step1">
								<div class="row">
									
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtName" class="col-lg-3 col-form-label">Category Name :</label>
											<div class="col-lg-9">
												<input type="text" id="name"  class="form-control" name="name" value="{$category_details['category_name']}" >
												<div class="invalid-feedback">Enter Category Name</div>
												{form_error('name')}
											</div>
										</div>
									</div>

									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtVnumber" class="col-lg-3 col-form-label">Category Tax(%) :</label>
											<div class="col-lg-9">
												<input type="text" id="tax" autocomplete="off" class="form-control" name="tax" value="{$category_details['tax']}">
												<div class="invalid-feedback">Enter Category Tax</div>
												{form_error('tax')}
											</div>
										</div>
									</div>

								</div>
								

								{if $enc_id}
								<div class="row">
									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtVnumber" class="col-lg-3 col-form-label">Code :</label>
											<div class="col-lg-9">
												<input type="text" id="code" autocomplete="off" class="form-control" name="code" value="{$category_details['code']}" readonly>
												<div class="invalid-feedback">Enter Code</div>
												{form_error('code')}
											</div>
										</div>
									</div>

									<div class="col-md-6">
										<div class="form-group row mb-2">
											<label for="txtEmail" class="col-lg-3 col-form-label">Status :</label>
											<div class="col-lg-9">
												<select id="txtVehicle" name="status" class="form-control">
													<option value="active"  {if $category_details['status'] == 'active'} selected {/if} >Active</option>
													<option value="inactive"  {if $category_details['status'] == 'inactive'} selected {/if}>Inactive</option>
												</select> 
												<div class="invalid-feedback">Choose an option</div>
											</div>
										</div>
									</div>
								</div>
								{/if}

								<div class="mt-2">
									{if $enc_id}
									<button type="submit"  name="update_category" value="update_category" class="btn btn-primary float-end">Update Category
									</button>
									{else}
									<button type="submit"  name="add_category" value="add_category" class="btn btn-primary float-end">Add Category
									</button>
									{/if}
								</div>                                        
							</div>
						</div>
					
					{form_close()}
				</div>
			</div>
		</div>                                                                              
	</div>     


	{if $table_details}
	<div class="col-md-12">
		<div class="card"> 
			<div class="card-header card-header-rose card-header-icon">
				
				<h4 class="card-title">Category Details</h4>
			</div> 
			<div class="card-body pt-0">
				<div class="table-responsive">
					<table class="table mb-0">
						<thead class="table-light">
							<tr>
								<th>#</th> 
								<th>Name</th>
								<th>{lang('Code')}</th>
								<th>Tax (%)</th>
								<th>Created Date</th>  
								<th>{lang('status')}</th>
								<th class="text-center">{lang('action')}</th>   
							</tr>
						</thead>
						<tbody> 
							{foreach from=$table_details item=v}

							<tr>
								<td>{counter}</td>
								<td>{$v.category_name}</td>  
								<td>{$v.code}</td>  
								<td>{$v.tax}</td>  
								<td>{$v.date|date_format:"%d-%m-%Y"}</td>
								<td>{$v.status}</td>  

								<td class="td-actions text-center"> 

									<a href="{base_url('admin/settings/add-category/')}{$v.enc_id}" rel="tooltip" class="btn btn-info btn-link" target="_blank" title="Profile {$v.user_name}">
										<i class="iconoir-edit-pencil"></i>
									</a> 

								</td>  
							</tr>
							{/foreach}  
						</tbody>
					</table>
				</div>
			</div> 
		</div>
		<div class="d-flex justify-content-center">  
			<ul class="pagination start-links"></ul> 
		</div>
	</div>
	{/if}            
</div>







{/block}

{block name=footer} 

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