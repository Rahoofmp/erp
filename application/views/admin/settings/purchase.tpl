{extends file="layout/base.tpl"}

{block header} 
<link href="{assets_url()}plugins/select2/css/select2.min.css" rel="stylesheet" />
<link href="{assets_url()}libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css">
<link href="{assets_url()}libs/animate.css/animate.min.css" rel="stylesheet" type="text/css">
{/block}

{block body}

{form_open('admin/settings/purchase','class="needs-validation" novalidate=""')} 
<div class="row justify-content-center">
	<div class="col-12">
		<div class="card">
			<div class="card-body">
				<div class="row">
					<div class="col-md-6">
						<div class="form-group row mb-2">
							<label for="category" class="col-lg-3 col-form-label">Category:</label>
							<div class="col-lg-9">
								<select id="category" name="category_id" class="category_name_ajax form-control select2">
									{if $search_arr['category_id']}
									<option value="{$search_arr['category_id']}" selected>{$search_arr['category_name']}</option>
									{/if}
								</select>  
								{form_error('category_id')}
							</div>
						</div>
					</div>

					<div class="col-md-6">
						<div class="form-group row mb-2">
							<label for="category" class="col-lg-3 col-form-label">Date:</label>
							<div class="col-lg-9">
								<input id="txtDate" name="as_date" type="date" value="{$party_details['as_date']}" class="form-control" required>
								{form_error('as_date')}
								
								{form_error('as_date')}
							</div>
						</div>
					</div>
				</div>
				<button type="button" class="btn btn-primary add-row">Add Item</button>
			</div>
		</div>
	</div>
</div>

<div class="row justify-content-center">
	<div class="col-12">
		<div class="card">
			<div class="card-body pt-0">
				<div class="product-container"></div>
				<button type="submit" class="btn btn-success submit-job float-end mt-3" name="purchase" value="purchase">Purchase</button>
			</div>
		</div>
	</div>
</div>
{form_close()}

{/block}

{block footer}
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="{assets_url()}plugins/select2/js/select2.min.js"></script>
<script src="{assets_url()}libs/sweetalert2/sweetalert2.min.js"></script>
<script src="{assets_url()}js/pages/sweet-alert.init.js"></script>
<script src="{assets_url()}js/app.js"></script>

<script>
	$(document).ready(function() {
		$('.category_name_ajax').select2({
			placeholder: 'Select a Category',
			ajax: {
				url: '{base_url()}admin/autocomplete/category_ajax',
				type: 'post',
				dataType: 'json',
				delay: 250,
				processResults: function(data) {
					return { results: data };
				}
			}
		});



		function initItemSelect() {
			$('.item-select').select2({
				placeholder: 'Select an Item',
				ajax: {
					url: '{base_url()}admin/autocomplete/item_name_ajax',
					type: 'post',
					dataType: 'json',
					delay: 250,
					data: function(params) {
						var category_id = $('.category_name_ajax').val(); 
						return {
							category_id: category_id, 
							q: params.term 
						};
					},
					processResults: function(data) {
						return { results: data };
					}
				}
			});
		}



		function getUniqueIndex() {
			return $('.product-row').length;
		}

		$('.add-row').click(function () {
			var uniqueIndex = getUniqueIndex();

			var category_id = $('.category_name_ajax').val();

			if (!category_id) {
				executeExample('error', 'Invalid Action', 'Please select a category before adding an item!');
				return;
			}

			var newRow = `
        <div class="row product-row mt-2">
            <div class="col-md-2">
                <label>Item:</label>
				<select name="products[` + uniqueIndex + `][product_id]" class="item-select form-control select2"></select>
            </div>

            <div class="col-md-2">
                <label>Quantity:</label>
				<input type="hidden" name="products[` + uniqueIndex + `][category_id]" class="category_id">
				<input type="number" name="products[` + uniqueIndex + `][quantity]" class="quantity form-control" min="1" required>
            </div>
             <div class="col-md-2">
                <label>Purchase Rate:</label>
				<input type="number" name="products[` + uniqueIndex + `][purchase_rate]" class="purchase_rate form-control" min="1" required>
            </div>
            <div class="col-md-2">
                <label>Sale Rate:</label>
				<input type="hidden" name="products[` + uniqueIndex + `][tax]" class="tax">
				<input type="number" name="products[` + uniqueIndex + `][sale_rate]" class="sale_rate form-control" min="1" required>
            </div>

		   <div class="col-md-2">
                <label>MRP:</label>
				<input type="number" name="products[` + uniqueIndex + `][mrp]" class="mrp form-control" min="1" required>
            </div>

            <div class="col-md-1">
				 <label>Remove:</label>
                <button type="button" class="btn btn-danger remove-row">X</button>
            </div>
				</div>`;
				$('.product-container').append(newRow);
				initItemSelect();



			});
	});



	$(document).on('click', '.remove-row', function() {
		$(this).closest('.product-row').remove();
	});

	$(document).on('change', '.item-select', function() {
		var row = $(this).closest('.product-row');
		$.ajax({
			url: '{base_url()}admin/settings/get_category_ajax',
			type: "POST",
			data: { category_id: $('.category_name_ajax').val() },
			dataType: "json",
			success: function(response) {
				if (response.status == "success") {
					row.find('.category_id').val(response.details.id);
					row.find('.category_name').val(response.details.category_name);
					row.find('.tax').val(response.details.tax);
				} else {
					alert("Error fetching category details.");
				}
			}
		});
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
	$(document).on('click', '.submit-job', function(e) {
		var isValid = true; 
		$('.product-container .item-select').each(function() {
			if (!$(this).val()) { 
				isValid = false;
				return false; 
			}
		});
		if (!isValid) {
			e.preventDefault(); 
			executeExample('error', 'Invalid Submission', 'Please select an item before purchasing!');
			return;
		}
	});
	$(document).ready(function() {
		$('.submit-job').prop('disabled', true); 

		$(document).on('click', '.add-row', function() {
			if ($('.product-container .item-select').length > 0) {
				$('.submit-job').prop('disabled', false); 
			}
		});

		$(document).on('click', '.remove-item', function() {
			$(this).closest('.item-row').remove(); 

			if ($('.product-container .item-select').length === 0) {
				$('.submit-job').prop('disabled', true); 
			}
		});
	});

</script>
{/block}
