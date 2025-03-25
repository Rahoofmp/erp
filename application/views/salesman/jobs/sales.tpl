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

<div class="modal fade" id="exampleModalPrimary" tabindex="-1" role="dialog" aria-labelledby="exampleModalPrimary1" aria-hidden="true">
	<div class="modal-dialog" role="document">
		{form_open('','')}
		<div class="modal-content">
			<div class="modal-header bg-primary">
				<h6 class="modal-title m-0 text-white" id="exampleModalPrimary1">Item Changes</h6>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">
					
					<div class="col-lg-12">
						<div class="card">

							<div class="card-header card-header-tabs card-header-info">
								<div class="nav-tabs-navigation">
									<div class="nav-tabs-wrapper"> 
										<ul class="nav nav-tabs" role="tablist">
											<li class="nav-item">
												<a class="nav-link active" data-bs-toggle="tab" href="#edit_profile" role="tab" aria-selected="true">Mark as Delivered</a>
											</li>
											<!-- <li class="nav-item">
												<a class="nav-link" data-bs-toggle="tab" href="#change_username" role="tab" aria-selected="false">Damage & Return</a>
											</li> -->


										</ul>
										
										<div class="tab-content">
											
											<div class="tab-pane p-3 active" id="edit_profile">
												<div class="row"> 
													<div class="col-md-12">
														<div class="form-group bmd-form-group">
															<label class="bmd-label-floating">Sale Count:</label>
															<input type="number" name="sale_count" class="form-control" value="" oninput="this.value=this.value.replace(/[^0-9]/g,'')">

															<input type="hidden" id="enc_item_id" name="enc_item_id" value="">
														</div>
													</div>
												</div>
												<br>
												<div class="row">
													<div class="col-md-12">
														<div class="form-group bmd-form-group">
															<label class="bmd-label-floating">Sale Price:</label>
															<input type="number" class="form-control" name="sale_price" value="" oninput="this.value=this.value.replace(/[^0-9]/g,'')"> 
														</div>
													</div>
												</div>
											</div>
										</div> 
										
									</div>
								</div>
							</div>
						</div> 
					</div>
				</div>                                                   
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
				<button type="submit" class="btn btn-primary btn-sm" name="update" value="update">Save changes</button>
			</div>
		</div>
		{form_close()}
	</div>
</div>                               



<div class="row "> 
	<div class="col-sm-12 hidden-print"> 
		<div class="card"> 
			<div class="card-content">
				<div class="card-body"> 
					{form_open('','')}
					<div class="form-body">
						<div class="row">

							<div class="col-md-3">
								<div class="form-group">
									<select id="source" name="job_id" class="job_id_ajax form-control select2">
										{if $search_arr['job_id']}
										<option value="{$search_arr['job_id']}" selected>{$search_arr['job_id']}</option>
										{/if} 
									</select>  
								</div> 
							</div>

							<div class="col-md-2">
								<div class="form-group row mb-2">

									<div class="col-lg-9">
										<select id="status" name="status" class="form-control">
											<option value=''>--ALL--</option>
											<option value="pending" {if $search_arr['status']=='pending'} selected {/if}>Pending</option>
											<option value="approved" {if $search_arr['status']=='approved'} selected {/if}>Approved</option>
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

					<h4 class="card-title">Loaded Items</h4>
				</div> 
				<div class="card-body">
					<div class="table-responsive">
						<table class="table" id="customer_list">
							<thead class="bg-light text-warning">
								<tr>
									<th>#</th> 
									<th>Bar-Code</th>
									<th>Item Name</th>
									<th>Category</th>
									<th>Stock</th>
									<th>Sale Count</th>
									<th>Sale Rate</th>
									<th>Status</th>  
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

		$(document).on("click", ".openModal", function () {
			var encId = $(this).data("enc-id"); 
			$("#enc_item_id").val(encId); 
		});


		$(document).ready(function(){ 


			$('.job_id_ajax').select2({

				placeholder: 'Select Bill Number',
				ajax: {
					url:'{base_url()}salesman/autocomplete/job_number_ajax',

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
					'url':'{base_url()}salesman/jobs/get_saled_items_ajax',
					"type": "POST", 
					"data" : {
						
						'job_id' : '{$search_arr['job_id']}',
						'status' : '{$search_arr['status']}',
						
					}

				},

				'columns': [


					{ data: 'index'},
					{ data: 'barcode'},
					{ data: 'product_name'},
					{ data: 'category_name'},
					{ data: 'quantities'},
					{ data: 'sale_count'},
					{ data: 'sale_price'},
				
					{ data: 'status'},
					
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