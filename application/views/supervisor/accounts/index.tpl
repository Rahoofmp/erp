{extends file="layout/base.tpl"}

{block header} 

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
							
							<h2 class="mb-4">Accounts</h2>

						</div>
					</div>                                 
				</div>
				<div class="card-body pt-0">
					{form_open('', 'class="needs-validation" novalidate=""')}          

					<div class="row">



						<div class="col-md-4">
							<div class="form-group row mb-2">
								<label for="txtName" class="col-lg-3 col-form-label">Amount</label>
								<div class="col-lg-9">

									<input type="number" class="form-control" id="amount" name="amount" value="" autocomplete="off" required> 

									<div class="invalid-feedback">Enter An Amount</div>

									{form_error("amount")}

									<div class="form-group" >
										<div id="amount_words_div" style="display: none;">
											<label>Amount in Words</label>
											<input type="text" class="form-control" id="amount_words" name="amount_words"  
											value= "" autocomplete="off" readonly>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group row mb-2">
								<label for="txtEmail" class="col-lg-3 col-form-label">Type :</label>
								<div class="col-lg-9">
									<select id="txtVehicle" name="type" class="form-control" >
										<option  value="" selected >Select Type</option>
										<option value="salary">Salary</option>
										<option value="food" >Food</option>
										<option value="travel" >Travel</option>
										<option value="others" >Other Expense</option>
									</select> 
									<div class="invalid-feedback">Choose an option</div>
									{form_error('type')}
								</div>
							</div>
						</div>

						<div class="col-md-4">
							<div class="form-group row mb-2">
								<label for="txtAddress" class="col-lg-3 col-form-label">Remarks :</label>
								<div class="col-lg-9">
									<textarea id="txtAddress" name="remarks" rows="4" class="form-control">
										
									</textarea>
									<!-- <div class="invalid-feedback">Enter Remarks</div> -->
									
								</div>
							</div><!--end form-group-->
						</div>
						<div class="col-12">
							<button type="submit" class="btn btn-primary" name="submit" value="credit_amount" id="credit_amount">Credit Amount</button>
							<button class="btn btn-warning" type="submit" id="debit_amount" name="submit" value="debit_amount">
								Debit Amount
							</button>
						</div>
					</div>
					{form_close()}
				</div>
			</div>
		</div>
	</div>



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
								<th>Amount</th>
								<th>Transfer Type</th>
								<th>Type</th>
								<th>Note</th>
								<th>Done By</th>
								<th>Date</th>
								<!-- <th class="text-center">{lang('action')}</th>    -->
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
{block name="footer"}
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="{assets_url('plugins/DataTables/js/jquery.dataTables.min.js')}"></script>
<script src="{assets_url('plugins/DataTables/js/dataTables.bootstrap.min.js')}"></script>
<script src="{assets_url('plugins/DataTables/js/dataTables.jqueryui.min.js')}"></script>
<script src="{assets_url('plugins/DataTables/js/dataTables.foundation.min.js')}"></script>
<script src="{assets_url()}backend/js/plugins-init/select2-init.js"></script> 
<script src="{assets_url()}backend/vendor/select2/js/select2.full.min.js"></script>
<script src="{assets_url()}backend/js/plugins-init/select2-init.js"></script>
<script type="text/javascript">
	$(document).ready(function(){



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
				'url':'{base_url()}admin/accounts/get_added_records_ajax',
				"type": "POST", 
				"data" : {

					'category_id' : '{$search_arr['category']}',
					'product_id' : '{$search_arr['product_id']}',
					'status' : '{$search_arr['status']}',

				}

			},

			'columns': [


				{ data: 'index'},
				{ data: 'amount'},
				{ data: 'transfer_type'},
				{ data: 'type'},
				{ data: 'remarks'},
				{ data: 'done_name'},
				{ data: 'date'},
				// {
				// 	mRender: function(data, type, row) {
				// 		var link = '<button type="button" class="btn-sm btn btn-info btn-link openModal" data-bs-toggle="modal" data-bs-target="#exampleModalPrimary" data-enc-id="' + row.enc_entry_id + '" title="Edit"><i class="iconoir-edit-pencil" aria-hidden="true"></i></button>';
				// 		return link;


				// 	}}, 
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

		$('#amount').on('blur', function(){

			var value= $(this).val();

			$.post( "{base_url()}admin/accounts/get_amount_words", { amount: value })
			.done(function( data ) {
				$('#amount_words').val(data);
				$('#amount_words_div').show();

			});

		});

	});

	$('.user_name_ajax').select2({
		placeholder: '{lang('select_a_user')}',
		ajax: {
			url:'{base_url()}admin/autocomplete/getUser_ajax',

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