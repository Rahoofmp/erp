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
							
							<h2 class="mb-4">Accounts</h2>

						</div>
					</div>                                 
				</div>
				<div class="card-body pt-0">
					{form_open('', 'class="needs-validation" id="custom-step" novalidate')}  
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
										<option value="purchase" >Purchase</option>
										<option value="expenses" >Expenses</option>
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
	{if $table_details}
	<div class="col-md-12">
		<div class="card"> 
			<div class="card-header card-header-rose card-header-icon">
				
				<h4 class="card-title">Account History</h4>
			</div> 
			<div class="card-body pt-0">
				<div class="table-responsive">
					<table class="table mb-0">
						<thead class="table-light">
							<tr>
								<th>#</th> 
								<th>Amount</th>
								<th>Transfer Type</th>
								<th>Type</th>
								<th>Remarks</th>  
								<th>Date</th>
								  
							</tr>
						</thead>
						<tbody> 
							{foreach from=$table_details item=v}

							<tr>
								<td>{counter}</td>
								<td>{cur_format($v.amount)}</td>  
								<td>{ucfirst($v.transfer_type)}</td>  
								<td>{ucfirst($v.type)}</td>  
								<td>{$v.remarks}</td>  
								<td>{$v.date|date_format:"%d-%m-%Y"}</td>
								  

								 
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
{block name="footer"}

<script src="{assets_url()}backend/js/plugins-init/select2-init.js"></script> *}
<script src="{assets_url()}backend/vendor/select2/js/select2.full.min.js"></script>
<script src="{assets_url()}backend/js/plugins-init/select2-init.js"></script>
<script type="text/javascript">
	$(document).ready(function(){

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