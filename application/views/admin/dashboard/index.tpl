{extends file="layout/base.tpl"}
{block header}
<link rel="stylesheet" type="text/css" href="{assets_url('plugins/sweetalert/lib/sweet-alert.css')}">
{/block}
{block name="body"}  
{if log_user_type()=="admin"}



<div class="container-xxl">
	<div class="row justify-content-center">
		<div class="col-md-4 col-lg-3">
			<div class="card">
				<div class="card-body">
					<div class="row d-flex justify-content-center border-dashed-bottom pb-3">
						<div class="col-9">
							<p class="text-dark mb-0 fw-semibold fs-14"> Today <span class="text-success"> Sales </span></p>
							<h3 class="mt-2 mb-0 fw-bold">24k</h3>
						</div>
						<!--end col-->
						<div class="col-3 align-self-center">
							<div class="d-flex justify-content-center align-items-center thumb-xl bg-light rounded-circle mx-auto">
								<i class="iconoir-hexagon-dice h1 align-self-center mb-0 text-secondary"></i>
							</div>
						</div>
						<!--end col-->
					</div>
					<!--end row-->
					<p class="mb-0 text-truncate text-muted mt-3"><span class="text-success">8.5%</span>
					Monthly Avg.Sales</p>
				</div>
				<!--end card-body-->
			</div>
			<!--end card-->
		</div>
		<!--end col-->
		<div class="col-md-4 col-lg-3">
			<div class="card">
				<div class="card-body">
					<div class="row d-flex justify-content-center border-dashed-bottom pb-3">
						<div class="col-9">
							<p class="text-dark mb-0 fw-semibold fs-14">Today <span class="text-danger">Purchases</span></p>
							<h3 class="mt-2 mb-0 fw-bold">00:18</h3>
						</div>
						<!--end col-->
						<div class="col-3 align-self-center">
							<div class="d-flex justify-content-center align-items-center thumb-xl bg-light rounded-circle mx-auto">
								<i class="iconoir-clock h1 align-self-center mb-0 text-secondary"></i>
							</div>
						</div>
						<!--end col-->
					</div>
					<!--end row-->
					<p class="mb-0 text-truncate text-muted mt-3"><span class="text-danger">1.5%</span>
					Monthly Avg.Purchases</p>
				</div>
				<!--end card-body-->
			</div>
			<!--end card-->
		</div>
		<!--end col-->
		<!--end col-->
		<div class="col-md-4 col-lg-3">
			<div class="card">
				<div class="card-body">
					<div class="row d-flex justify-content-center border-dashed-bottom pb-3">
						<div class="col-9">
							<p class="text-dark mb-0 fw-semibold fs-14">Today <span class="text-success">Receipts</span></p>
							<h3 class="mt-2 mb-0 fw-bold">00:18</h3>
						</div>
						<!--end col-->
						<div class="col-3 align-self-center">
							<div class="d-flex justify-content-center align-items-center thumb-xl bg-light rounded-circle mx-auto">
								<i class="iconoir-clock h1 align-self-center mb-0 text-secondary"></i>
							</div>
						</div>
						<!--end col-->
					</div>
					<!--end row-->
					<p class="mb-0 text-truncate text-muted mt-3"><span class="text-success">1.5%</span>
					Monthly Avg.Receipts</p>
				</div>
				<!--end card-body-->
			</div>
			<!--end card-->
		</div>
		<!--end col-->
		<div class="col-md-4 col-lg-3">
			<div class="card">
				<div class="card-body">
					<div class="row d-flex justify-content-center border-dashed-bottom pb-3">
						<div class="col-9">
							<p class="text-dark mb-0 fw-semibold fs-14">Today <span class="text-danger">Payments</span></p>
							<h3 class="mt-2 mb-0 fw-bold">36.45%</h3>
						</div>
						<!--end col-->
						<div class="col-3 align-self-center">
							<div class="d-flex justify-content-center align-items-center thumb-xl bg-light rounded-circle mx-auto">
								<i class="iconoir-percentage-circle h1 align-self-center mb-0 text-secondary"></i>
							</div>
						</div>
						<!--end col-->
					</div>
					<!--end row-->
					<p class="mb-0 text-truncate text-muted mt-3"><span class="text-danger">8%</span>
					Monthly Avg.Payments</p>
				</div>
				<!--end card-body-->
			</div>
			<!--end card-->
		</div>
		<!--end col-->
	</div>
	<!--end row-->

	<div class="row justify-content-center">
		<div class="col-md-6 col-lg-6">
			<div class="card">
				<div class="card-header">
					<div class="row align-items-center">
						<div class="col">                      
							<h4 class="card-title">No Sales above 30 Days</h4>                      
						</div><!--end col-->
					</div>  <!--end row-->                                  
				</div><!--end card-header-->
				<div class="card-body pt-0">
					<div class="table-responsive">
						<table class="table table-bordered mb-0 table-centered">
							<thead class="table-light">
								<tr>
									<th class="border-top-0">Party Id & Name</th>
									<th class="border-top-0">Last Sales Date</th>
									<th class="border-top-0">Mobile</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
							</tbody>
						</table><!--end /table-->
					</div><!--end /tableresponsive-->             
				</div><!--end card-body--> 
			</div><!--end card--> 
		</div> <!--end col--> 
		<div class="col-md-6 col-lg-6">
			<div class="card">
				<div class="card-header">
					<div class="row align-items-center">
						<div class="col">                      
							<h4 class="card-title">No Sales above 30 Days</h4>                      
						</div><!--end col-->
					</div>  <!--end row-->                                  
				</div><!--end card-header-->
				<div class="card-body pt-0">
					<div class="table-responsive">
						<table class="table table-bordered mb-0 table-centered">
							<thead class="table-light">
								<tr>
									<th class="border-top-0">Party Id & Name</th>
									<th class="border-top-0">Last Sales Date</th>
									<th class="border-top-0">Mobile</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
							</tbody>
						</table><!--end /table-->
					</div><!--end /tableresponsive-->
				</div><!--end card-body--> 
			</div><!--end card--> 
		</div> <!--end col-->                                                       
	</div><!--end row-->

	<div class="row justify-content-center">
		<div class="col-md-6 col-lg-6">
			<div class="card">
				<div class="card-header">
					<div class="row align-items-center">
						<div class="col">                      
							<h4 class="card-title">No Sales above 30 Days</h4>                      
						</div><!--end col-->
					</div>  <!--end row-->                                  
				</div><!--end card-header-->
				<div class="card-body pt-0">
					<div class="table-responsive">
						<table class="table table-bordered mb-0 table-centered">
							<thead class="table-light">
								<tr>
									<th class="border-top-0">Party Id & Name</th>
									<th class="border-top-0">Last Sales Date</th>
									<th class="border-top-0">Mobile</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
							</tbody>
						</table><!--end /table-->
					</div><!--end /tableresponsive-->             
				</div><!--end card-body--> 
			</div><!--end card--> 
		</div> <!--end col--> 
		<div class="col-md-6 col-lg-6">
			<div class="card">
				<div class="card-header">
					<div class="row align-items-center">
						<div class="col">                      
							<h4 class="card-title">No Sales above 30 Days</h4>                      
						</div><!--end col-->
					</div>  <!--end row-->                                  
				</div><!--end card-header-->
				<div class="card-body pt-0">
					<div class="table-responsive">
						<table class="table table-bordered mb-0 table-centered">
							<thead class="table-light">
								<tr>
									<th class="border-top-0">Party Id & Name</th>
									<th class="border-top-0">Last Sales Date</th>
									<th class="border-top-0">Mobile</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
								<tr>
									<td>GSP1001 - Xteum Technologies</td>
									<td>15/02/2024</td>
									<td>9020042004</td>
								</tr>
								<!--end tr-->
							</tbody>
						</table><!--end /table-->
					</div><!--end /tableresponsive-->
				</div><!--end card-body--> 
			</div><!--end card--> 
		</div> <!--end col-->                                                       
	</div><!--end row-->
	<!-- container -->

	<!--Start Rightbar-->
	<!--Start Rightbar/offcanvas-->
	<div class="offcanvas offcanvas-end" tabindex="-1" id="Appearance" aria-labelledby="AppearanceLabel">
		<div class="offcanvas-header border-bottom justify-content-between">
			<h5 class="m-0 font-14" id="AppearanceLabel">Appearance</h5>
			<button type="button" class="btn-close text-reset p-0 m-0 align-self-center" data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">  
			<h6>Account Settings</h6>
			<div class="p-2 text-start mt-3">
				<div class="form-check form-switch mb-2">
					<input class="form-check-input" type="checkbox" id="settings-switch1">
					<label class="form-check-label" for="settings-switch1">Auto updates</label>
				</div><!--end form-switch-->
				<div class="form-check form-switch mb-2">
					<input class="form-check-input" type="checkbox" id="settings-switch2" checked>
					<label class="form-check-label" for="settings-switch2">Location Permission</label>
				</div><!--end form-switch-->
				<div class="form-check form-switch">
					<input class="form-check-input" type="checkbox" id="settings-switch3">
					<label class="form-check-label" for="settings-switch3">Show offline Contacts</label>
				</div><!--end form-switch-->
			</div><!--end /div-->
			<h6>General Settings</h6>
			<div class="p-2 text-start mt-3">
				<div class="form-check form-switch mb-2">
					<input class="form-check-input" type="checkbox" id="settings-switch4">
					<label class="form-check-label" for="settings-switch4">Show me Online</label>
				</div><!--end form-switch-->
				<div class="form-check form-switch mb-2">
					<input class="form-check-input" type="checkbox" id="settings-switch5" checked>
					<label class="form-check-label" for="settings-switch5">Status visible to all</label>
				</div><!--end form-switch-->
				<div class="form-check form-switch">
					<input class="form-check-input" type="checkbox" id="settings-switch6">
					<label class="form-check-label" for="settings-switch6">Notifications Popup</label>
				</div><!--end form-switch-->
			</div><!--end /div-->               
		</div><!--end offcanvas-body-->
	</div>







	{/if}
	{/block}

	{block name="footer"}


	{/block}