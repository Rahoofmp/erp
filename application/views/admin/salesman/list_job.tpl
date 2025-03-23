{extends file="layout/base.tpl"}

{block header} 
<link href="{assets_url()}plugins/select2/css/select2.min.css" rel="stylesheet" />

<link rel="stylesheet" type="text/css" href="{assets_url('plugins/DataTables/css/dataTables.bootstrap.min.css')}">
<link rel="stylesheet" type="text/css" href="{assets_url('plugins/DataTables/css/dataTables.jqueryui.min.css')}">
<link rel="stylesheet" type="text/css" href="{assets_url('plugins/DataTables/css/dataTables.foundation.min.css')}">

{/block}


{block body}
<style type="text/css">
	.my-group .form-control
	{
		width:50%;
	} 
	table.dataTable thead > tr > th.sorting
	{
		text-align: left !important;
	}
	.dataTables_length select {
		width: 80px;
		padding: 5px;
		font-size: 14px;
	}
</style>


<div class="row "> 
	<div class="col-sm-12 hidden-print"> 
		<div class="card"> 
			<div class="card-content">
				<div class="card-body"> 
					{form_open('','')}
					<div class="form-body">
						<div class="row">
							<!-- <div class="col-md-3">
								<div class="form-group">
									<select id="packager" name="packager_id" class="packager_ajax form-control" >
										{if $post_arr['packager_id']}
										<option value="{$post_arr['packager_id']}">{$post_arr['packager_name']}</option>
										{/if} 
									</select> 
								</div> 
							</div> -->



							<div class="col-md-3">
								<div class="form-group">
									<select id="source" name="job_id" class="job_id_ajax form-control select2">
										{if $search_arr['job_id']}
										<option value="{$search_arr['job_id']}" selected>{$search_arr['job_id']}</option>
										{/if} 
									</select>  
								</div> 
							</div>


							<div class="col-md-3">
								<div class="form-group">
									<select id="salesman" name="salesman" class="form-control">
										<option value="">--Select Salesman--</option>
										{foreach $category_details as $v}
										<option value="{$v.user_id}" {if isset($search_arr['salesman']) && $search_arr['salesman'] == $v.user_id}selected{/if}>
											{$v.user_name}
										</option>
										{/foreach}
									</select> 
								</div> 
							</div>






							<div class="col-md-2">
								<div class="form-group row mb-2">

									<div class="col-lg-9">
										<select id="status" name="status" class="form-control">
											<option value=''>--ALL--</option>
											<option value="active" {if $search_arr['status']=='active'} selected {/if}>Active</option>
											<option value="inactive" {if $search_arr['status']=='inactive'} selected {/if}>Inactive</option>
										</select> 
									</div>
								</div>
							</div>

							

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
</div> 


<div class="row">
	<div class="col-md-12">
		
		<div class="col-md-12">
			<div class="card"> 
				<div class="card-header card-header-rose card-header-icon">

					<h4 class="card-title">Job List</h4>
				</div> 
				<div class="card-body">
					<div class="table-responsive">
						<table class="table" id="customer_list">
							<thead class="bg-light text-warning">
								<tr>
									<th>#</th> 
									<th>Job Number</th>
									<th>Salesman</th>
									<th>Vehicle Name</th>
									<th>Category Name</th>
									<th>Product Name</th>
									<th>Quantity</th>
									<th>Sale Count</th>
									<th>Sale Price</th>
									<th>Damage/Return</th>
									<th>Added Date</th>
									<th class="text-center">{lang('action')}</th>   
								</tr>
							</thead> 
						</table>
					</div>
				</div> 
			</div>
			<div class="d-flex justify-content-center">  
				<!-- <ul class="pagination start-links"></ul>  -->
			</div>
		</div> 
	</div> 

	{/block}

	{block footer}

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="{assets_url('plugins/DataTables/js/jquery.dataTables.min.js')}"></script>
	<script src="{assets_url('plugins/DataTables/js/dataTables.bootstrap.min.js')}"></script>
	<script src="{assets_url('plugins/DataTables/js/dataTables.jqueryui.min.js')}"></script>
	<script src="{assets_url('plugins/DataTables/js/dataTables.foundation.min.js')}"></script>
	<script src="{assets_url()}plugins/select2/js/select2.min.js"></script>

	<script type="text/javascript">

		$(document).ready(function(){ 


			$('.job_id_ajax').select2({

				placeholder: 'Select Bill Number',
				ajax: {
					url:'{base_url()}admin/autocomplete/job_number_ajax',

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




			var order = $('#customer_list').DataTable({

				'processing': true,
				'serverSide': true,
				"autoWidth": false,
				'serverMethod': 'post', 
				"pagingType": "full_numbers",
				"pageLength": 10, 
				"lengthMenu": [
					[10, 25, 50, 100, 150, 200, 250, 300, 350, 400], 
					[10, 25, 50, 100, 150, 200, 250, 300, 350, 400]  
				],


				"sortable": true,

				"aaSorting": [],
				"order": [],
				"aoColumnDefs": [
					{ "bSortable": false, "aTargets": [0, 1, 2, 3, 4, 5, 6] },
				],

				"columnDefs": [{
					"targets": 'no-sort',
					"orderable": false,
					"order": [],
				}],

				'ajax': {
					'url':'{base_url()}admin/salesman/get_job_list_ajax',
					"type": "POST", 
					"data" : {
						
						'salesman' : '{$search_arr['salesman']}',
						'job_id' : '{$search_arr['job_id']}',
						'status' : '{$search_arr['status']}',
						
					}

				},

				'columns': [


					{ data: 'index'},
					{ data: 'job_id'},
					{ data: 'user_name'},
					{ data: 'vehicle_name'},
					{ data: 'category_name'},
					{ data: 'product_name'},
					{ data: 'quantities'},
					{ data: 'sale_count'},
					{ data: 'sale_price'},
					{ data: 'damage_count'},
					{ data: 'purchase_date'},
					{
						mRender: function(data, type, row) {
							var link = '<a href = "#" class="btn-sm btn btn-info btn-link" data-placement="top" title ="Edit" ><i class="iconoir-edit-pencil" aria-hidden="true"></i></a>';

							return link;
						}}, 
					],


					dom: '<"top"lBf>rt<"bottom"ip>',
					buttons: [
						{
							extend: 'excelHtml5',
							title: 'Vehicle Data',
							className: 'btn btn-success',
							exportOptions: {
								columns: ':visible'
							}
						},

						{
							extend: 'print',
							title: 'Vehicle Data',
							className: 'btn btn-primary',
							exportOptions: {
								columns: ':visible'
							}
						}
					],

					success: function(response) { 
					} 
				});  

		});  
	</script>
	{/block}