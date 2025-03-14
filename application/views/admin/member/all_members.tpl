{extends file="layout/base.tpl"}

{block header} 
<link href="{assets_url()}plugins/select2/css/select2.min.css" rel="stylesheet" />

{/block}


{block body}
<style type="text/css">
	.my-group .form-control{
		width:50%;
	} 
</style>
<div class="row">
	<div class="col-md-12">
		<div class="card"> 
			<div class="card-content collapse show">
				<div class="card-body">
					{form_open('','class="form" ')}
					<div class="form-body">
						<div class="row ">

							<div class="col-md-3">
								<div class="form-group">
									<label for="staff_id">User Name</label>
									<select id="source" name="user_name" class="user_ajax form-control select2">
										{if $search_arr['user_name']}
										<option value="{$search_arr['user_name']}" selected>{$search_arr['user_name']}</option>
										{/if} 
									</select>  
								</div> 
							</div>

							<div class="col-sm-3">
								<div class="form-group">
									<label for="email">Email</label>
									<input type="text" id="email" class="form-control" name="email" autocomplete="off" value="{$search_arr['email']}">
								</div>
							</div>

							<div class="col-sm-4">
								<div class="form-group row mb-2">
									<label for="txtReceivePay" class="">User Type:</label>
									<div class="col-lg-9">
										<select id="user_type" name="user_type" class="form-control">
											<option value="">--ALL--</option>
											<option value="admin" {set_select( 'user_type', 'admin')}>Manager</option>

											<option value="supervisor" {set_select( 'user_type', 'supervisor')}>Accountant</option>

											<option value="salesman" {set_select( 'user_type', 'salesman')}>Salesman</option>
										</select>
									</div>
								</div>
							</div>

							
						</div>
						<div class="row mt-2"> 
							<div class="col-md-4"> 
								<button type="submit" class="btn btn-primary" name="submit" value="filter">
									<i class="fa fa-filter"></i> {lang('button_filter')}
								</button>
								<button type="submit" class="btn btn-warning mr-1" name="submit" value="reset">
									<i class="fa fa-refresh"></i>  {lang('button_reset')}
								</button> 
							</div>
						</div>
					</div>
					{form_close()}
				</div>
			</div>
		</div>
	</div>
	{if $details}
	<div class="col-md-12">
		<div class="card"> 
			<div class="card-header card-header-rose card-header-icon">
				
				<h4 class="card-title">Staff Details</h4>
			</div> 
			<div class="card-body pt-0">
				<div class="table-responsive">
					<table class="table mb-0">
						<thead class="table-light">
							<tr>
								<th>#</th> 
								<th>{lang('username')}</th>
								<th>{lang('firstname')}</th>
								<th>{lang('email')}</th>
								<th>{lang('mobile')}</th>

								<th>{lang('registerd_on')}</th>  
								<th>User type</th>  
								<th class="text-center">{lang('action')}</th>   
							</tr>
						</thead>
						<tbody> 
							{foreach from=$details item=v}

							<tr>
								<td>{counter}</td>
								<td>{$v.user_name}</td>  
								<td>{$v.first_name}</td>  
								<td>{$v.email}</td>  
								<td>{$v.mobile}</td>  

								<td>{$v.joining_date|date_format:"%d-%m-%Y"}</td>
								<td>
									{if $v.user_type == 'packager'} <span class="">Packager</span> 

									{elseif $v.user_type == 'admin'} <span class="badge bg-danger">Manager</span>
									{elseif $v.user_type == 'supervisor'} <span class="badge bg-success">Accountant</span>


									{elseif $v.user_type == 'salesman'} <span class="badge bg-warning">Salesman</span>

									{/if}

								</td>        
								<td class="td-actions text-center"> 

									<a href="{base_url('admin/member/profile?user_name=')}{$v.user_name}" rel="tooltip" class="btn btn-info btn-link" target="_blank" title="Profile {$v.user_name}">
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

{block footer}
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="{assets_url()}plugins/select2/js/select2.min.js"></script>


<script type="text/javascript">

	$(document).ready(function(){ 

		$('.user_ajax').select2({

			placeholder: 'Select a user',
			ajax: {
				url:'{base_url()}admin/packages/user_ajax',

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
{/block}