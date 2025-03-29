{extends file="layout/base.tpl"}

{block header} 
<link href="{assets_url()}plugins/select2/css/select2.min.css" rel="stylesheet" />
<link href="{assets_url()}libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css">
<link href="{assets_url()}libs/animate.css/animate.min.css" rel="stylesheet" type="text/css">
{/block}

{block body}

{form_open('admin/salesman/create_job')} 
<div class="row justify-content-center">
	<div class="col-12">
		<div class="card">
			<div class="card-body">
				<div class="row">
					<div class="col-md-4">
						<div class="form-group row mb-2">
							<label for="vehicle" class="col-lg-3 col-form-label">Vehicle:</label>
							<div class="col-lg-9">
								<select id="vehicle" name="vehicle_id" class="vehicle_name_ajax form-control select2">
									{if $search_arr['vehicle_id']}
									<option value="{$search_arr['vehicle_id']}" selected>{$search_arr['vehicle_name']}</option>
									{/if}
								</select>  
								{form_error('vehicle_id')}
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group row mb-2">
							<label for="sales_man_name" class="col-lg-3 col-form-label">Salesman:</label>
							<div class="col-lg-9">
								<input type="text" id="sales_man_name" class="form-control" name="sales_man_name" value="{$job_details['salesman']}" readonly>
								{form_error('sales_man_id')}
								<input type="hidden" id="sales_man_id" name="sales_man_id" value="">
							</div>
						</div>
					</div>

					<div class="col-md-4">
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
				<button type="button" class="btn btn-primary add-row">Add Product</button>
			</div>
		</div>
	</div>
</div>

<div class="row justify-content-center">
	<div class="col-12">
		<div class="card">
			<div class="card-body pt-0">
				<div class="product-container"></div>
				<button type="submit" id="add-job" class="btn btn-success submit-job float-end mt-3" name="add_job" value="add_job">Submit Job</button>
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
		$('.vehicle_name_ajax').select2({
			placeholder: 'Select a Vehicle',
			ajax: {
				url: '{base_url()}admin/autocomplete/vehicles_ajax',
				type: 'post',
				dataType: 'json',
				delay: 250,
				processResults: function(data) {
					return { results: data };
				}
			}
		});

		$('#vehicle').change(function() {
			var vehicle_id = $(this).val();
			if (vehicle_id) {
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
			}
		});

		function initItemSelect() {
			$('.item-select').select2({
				placeholder: 'Select an Item',
				ajax: {
					url: '{base_url()}admin/autocomplete/add_item_name_ajax',
					type: 'post',
					dataType: 'json',
					delay: 250,
					processResults: function(data) {
						return { results: data };
					}
				}
			});
		}

		function getUniqueIndex() {
			return $('.product-row').length;
		}

		$(document).on("click", ".add-row", function () {
			var uniqueIndex = getUniqueIndex();
			var newRow = `
        <div class="row product-row mt-2">
            <div class="col-md-3">
                <label>Item:</label>
				<select name="products[` + uniqueIndex + `][product_id]" class="item-select form-control select2"></select>
            </div>
            <div class="col-md-2">
                <label>Category:</label>
				<input type="text" name="products[` + uniqueIndex + `][category_name]" class="category_name form-control" readonly>
				<input type="hidden" name="products[` + uniqueIndex + `][category_id]" class="category_id">
            </div>
            <div class="col-md-2">
                <label>Stock:</label>
				<input type="number" name="products[` + uniqueIndex + `][stock]" class="stock form-control" readonly>
            </div>
            <div class="col-md-2">
                <label>Quantity:</label>
				<input type="number" name="products[` + uniqueIndex + `][quantity]" class="quantity form-control" min="1">
            </div>

			<div class="col-md-1">
                <label>Remove:</label><br>
                <button type="button" class="btn btn-danger remove-row">X</button>

            </div>
            <div class="col-md-1">
                 <label>Add:</label><br>
                 <button type="button" class="btn btn-primary add-row">+</button>

            </div>
				</div>`;
				$('.product-container').append(newRow);
				initItemSelect();
			});

		$(document).on('click', '.remove-row', function() {
			$(this).closest('.product-row').remove();
		});

		$(document).on('change', '.item-select', function() {
			var row = $(this).closest('.product-row');
			$.ajax({
				url: '{base_url()}admin/salesman/get_category_ajax',
				type: "POST",
				data: { item_id: $(this).val() },
				dataType: "json",
				success: function(response) {
					if (response.status == "success") {
						row.find('.category_id').val(response.details.category_id);
						row.find('.category_name').val(response.details.category_name);
						row.find('.stock').val(response.details.total_stock);
					} else {
						alert("Error fetching category details.");
					}
				}
			});
		});

		$(document).on('input', '.quantity', function() {
			var stock = $(this).closest('.product-row').find('.stock').val();
			var quantity = $(this).val();

			if (parseInt(quantity) > parseInt(stock)) {
				executeExample('error', 'Invalid Quantity', 'Quantity cannot be greater than stock!');
				$(this).val(stock); 
			}
		});


		$("#add-job").click(function () {
			var party_id = $(".vehicle_name_ajax").val();
			
			if (!party_id) {
				executeExample('error', 'Invalid Action', 'Please select a Vehicle before assigning  products!');
				return false;
			}
		});


	});
</script>
{/block}
