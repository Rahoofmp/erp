{extends file="layout/base.tpl"}

{block header} 
<link href="{assets_url()}plugins/select2/css/select2.min.css" rel="stylesheet" />
<link href="{assets_url()}libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css">
<link href="{assets_url()}libs/animate.css/animate.min.css" rel="stylesheet" type="text/css">
{/block}

{block body}

{form_open('admin/settings/sales','class="needs-validation" novalidate=""')} 
<div class="row justify-content-center">
	<div class="col-12">
		<div class="card">
			<div class="card-body">
				<div class="row">
					{*<div class="col-md-6">
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
					</div>*}

					<div class="col-md-6">
						<div class="form-group row mb-2">
							<label for="category" class="col-lg-3 col-form-label">Invoice Number:</label>
							<div class="col-lg-9">
								<input id="txtDate" name="invoice_number" type="text" value="{$party_details['invoice_number']}" class="form-control" required>
								{form_error('invoice_number')}


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
					<div class="col-md-6">
						<div class="form-group row mb-2">

							
							<label for="party_id" class="col-lg-3 col-form-label">Party Name:</label>
							<div class="col-lg-9">
								<select id="source" name="party_id" class="party_ajax form-control select2">
									{if $search_arr['party_id']}
									<option value="{$search_arr['party_id']}" selected>{$search_arr['party_name']}</option>
									{/if}
								</select>  
								{form_error('party_id')}
							</div>
						</div>
					</div>
				</div>
				<!-- <button type="button" class="btn btn-primary add-row">Add Item</button> -->
			</div>
		</div>
	</div>
</div>

<div class="row justify-content-center">
	<div class="col-12">
		<div class="card">
			<div class="card-body pt-0">
				<div class="product-container"></div>
				<div class="product-total"></div>
				<button type="submit" class="btn btn-success submit-job float-end mt-3" id="purchase-button" name="sale" value="sale">Purchase</button>
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


		function addTotalRow() {
			if ($(".total-row").length === 0) {
				$(".product-total").append(`
					<div class="row total-row mt-2" style="font-weight: bold; border-top: 2px solid #000; padding-top: 10px;">
					<div class="col-md-2"><label>Total:</label></div>
					<div class="col-md-2"><label></label></div>
					<div class="col-md-2"><label></label></div>
					<div class="col-md-2"><span class="total-tax">0.00</span></div>
					<div class="col-md-2"><span class="total-purchase-rate">0.00</span></div>
					
					<div class="col-md-2"><span class="grand-total">0.00</span></div>
					</div>
				`);
			}

		}

		$(document).on("input", " .tax, .sale_rate", function () {
			updateTotals();
		});

		$('.party_ajax').select2({

			placeholder: 'Select a Party',
			ajax: {
				url:'{base_url()}admin/autocomplete/party_ajax',

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

		function addNewRow() {
			var uniqueIndex = getUniqueIndex();
			var party_id = $('.party_ajax').val();

			var newRow = `
        <div class="row product-row mt-2">
            <div class="col-md-2">
                <label>Item:</label>
				<select name="products[` + uniqueIndex + `][product_id]" class="item-select form-control select2"></select>
            </div>

			<div class="col-md-2">
                <label>Stock:</label>
				<input type="readonly" name="products[` + uniqueIndex + `][stock]" class="stock form-control" min="1" required readonly>
            </div>

            <div class="col-md-2">
                <label>Quantity:</label>
				<input type="hidden" name="products[` + uniqueIndex + `][party_id]" class="party_id" value="`+ party_id +`">
				<input type="number" name="products[` + uniqueIndex + `][quantity]" class="quantity form-control" min="1" required>
            </div>
            <div class="col-md-2">
                <label>TAX:</label>
				<input type="text" name="products[` + uniqueIndex + `][tax]" class="tax form-control" min="1" required>
            </div>
            <div class="col-md-2">
                <label>Sale Rate:</label>
				<input type="number" name="products[` + uniqueIndex + `][sale_rate]" class="sale_rate form-control" min="1" required>
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
				addTotalRow();
				updateTotals();
			}


			addNewRow();

			$(document).on("click", ".add-row", function () {
				addNewRow();
			});

			$(document).on("click", ".remove-row", function () {
				$(this).closest(".product-row").remove();
				updateTotals();
				if ($(".product-row").length === 0) {
					addNewRow();
				}
			});

			$("#purchase-button").click(function () {
				var party_id = $(".party_ajax").val();

				if (!party_id) {
					executeExample('error', 'Invalid Action', 'Please select a Party before making a purchase!');
					return false;
				}
			});

		});




function updateTotals() {
	let totalMRP = 0;
	let totalTax = 0;
	let totalPurchaseRate = 0;
	let quantity = 0;
	let Total = 0;
	let grandTotal = 0;

	$(".product-row").each(function () {
		// let mrp = parseFloat($(this).find(".mrp").val()) || 0;
		let tax = parseFloat($(this).find(".tax").val()) || 0;
		let purchaseRate = parseFloat($(this).find(".sale_rate").val()) || 0;
		let quantity = parseFloat($(this).find(".quantity").val()) || 0;

		// totalMRP += mrp;
		totalTax += tax;
		totalPurchaseRate += purchaseRate;
		Total= purchaseRate*quantity;
		grandTotal += Total+tax;
	});

	// $(".total-mrp").text(totalMRP.toFixed(2));
	$(".total-tax").text(totalTax.toFixed(2));
	$(".total-purchase-rate").text(totalPurchaseRate.toFixed(2));
	$(".grand-total").text(grandTotal.toFixed(2));


	if ($(".product-row").length === 0) {
		$(".total-row").remove();
	}
}

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
			// row.find('.tax').val(response.details.tax);
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


$(document).on('change', '.item-select', function() {
	var row = $(this).closest('.product-row');
	var product_id = $(this).val(); 

	if (!product_id) return; 

	$.ajax({
		url: '{base_url()}admin/settings/get_product_stock_ajax', 
		type: "POST",
		data: { product_id: product_id },
		dataType: "json",
		success: function(response) {
			if (response.status == "success") {
				row.find('.stock').val(response.stock).prop('readonly', true); 
			} else {
				alert("Error fetching stock details.");
			}
		},
		error: function() {
			alert("Something went wrong. Try again!");
		}
	});
});



</script>
{/block}
