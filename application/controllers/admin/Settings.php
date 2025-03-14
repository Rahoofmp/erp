<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Settings extends Base_Controller {

	function __construct()
	{
		parent::__construct(); 	
	}


	function website_profile()
	{       
		$site_info = $this->Settings_model->getCompanyInformation();
		if ($this->input->post('update') && $this->validate_website_profile()) {
			$site_info = $this->input->post();  

			$update_company_info = $this->Settings_model->updateWebisteInfo($site_info);

			if ( $update_company_info ) { 
				$this->Base_model->insertIntoActivityHistory(log_user_id(), log_user_id(),'update_company_settings', serialize($site_info) );
				$msg = lang('success_site_updated');
				$this->redirect($msg, "settings/website-profile", TRUE);

			} else {
				$msg = lang('error_on_site_updation');
				$this->redirect($msg, "settings/website-profile", FALSE);
			}
		}

		$data['site_info'] = $site_info;

		$data['title'] = lang('website_profile'); 
		$this->loadView($data);
	}



	function add_vehicle($enc_id='')
	{

		$id=False;
		if ($enc_id) {
			$id=$this->Base_model->encrypt_decrypt('decrypt',$enc_id);
			$data['vehicle_details']=$this->Settings_model->getAllVehicleDetails($id);
			$data['enc_id']=$enc_id;
		}
		

		if ($this->input->post('add_vehicle') && $this->validate_add_vehicle()) {

			$post_arr=$this->input->post();
			$add=$this->Settings_model->addNewVehicle($post_arr);
			if ($add) {
				$this->redirect('Vehicle Added Successfully','settings/add-vehicle',TRUE);
			}
			else{
				$this->redirect('Error on adding','settings/add-vehicle',False);
			}

		}

		if ($this->input->post('update_vehicle') && $this->validate_edit_vehicle()) {

			$post_arr=$this->input->post();
			$update=$this->Settings_model->updateVehicleDetails($post_arr,$id);
			if ($update) {
				$this->redirect('Vehicle Updated Successfully','settings/list-vehicles',TRUE);
			}
			else{
				$this->redirect('Error on updating','settings/add-vehicle/'.$enc_id,False);
			}

		} 

		$data['title'] = 'Add Vehicle';
		$this->loadView($data);
	}

	function list_vehicles()
	{ 
		$details = $search_arr = $post_arr=[];
		if( $this->input->post() )
		{
			if( $this->input->post('submit') == 'reset')
			{
				$search_arr = [];
			}elseif( $this->input->post('submit') == 'filter'){
				$post_arr = $this->input->post();
				if(element('vehicle_id',$post_arr)){
					$search_arr['vehicle_name'] =$this->Base_model->getVehicleName($post_arr['vehicle_id']);
					$search_arr['vehicle_id'] = $post_arr['vehicle_id'];
				} 
				$search_arr['status'] = $post_arr['status'];
			}
		}

		$data['search_arr'] = $search_arr; 
		$data['details'] = $details;
		$data['title'] = 'List Vehicles'; 
		$this->loadView($data);
	}

	public function get_vehicle_list_ajax() {
		if ($this->input->is_ajax_request()) {
			$draw = $this->input->post('draw');
			$post_arr = $this->input->post();
			

			
			$count_without_filter = $this->Settings_model->getOrderCount();
			$count_with_filter = $this->Settings_model->getAllVehiclesAjax($post_arr, 1);
			$details = $this->Settings_model->getAllVehiclesAjax( $post_arr,'');

			$response = array(
				"draw" => intval($draw),
				"iTotalRecords" => $count_without_filter,
				"iTotalDisplayRecords" => $count_with_filter,
				"aaData" => $details,
			);

			echo json_encode($response);
		}
	}


	function add_party($enc_id='')
	{

		$id=False;
		if ($enc_id) {
			$id=$this->Base_model->encrypt_decrypt('decrypt',$enc_id);
			$data['party_details']=$this->Settings_model->getAllPartyDetails($id);
			$data['enc_id']=$enc_id;
		}
		

		if ($this->input->post('add_party') && $this->validate_add_party()) {

			$post_arr=$this->input->post();
			$post_arr['address']=htmlentities($post_arr['address']);
			$last_id=$this->Settings_model->getLastPartyId();
			if ($last_id) {
				preg_match('/\d+/', $last_id, $matches);
				$numeric_part = isset($matches[0]) ? (int) $matches[0] : 1000;
				$post_arr['party_id'] = 'PRT-' . ($numeric_part + 1);
			} 
			else {
				$post_arr['party_id'] = 'PRT-1000';
			}
			$add=$this->Settings_model->addNewParty($post_arr);
			if ($add) {
				$this->redirect('Party Added Successfully','settings/add-party',TRUE);
			}
			else{
				$this->redirect('Error on adding','settings/add-party',False);
			}
		}

		if ($this->input->post('update_party') && $this->validate_add_party()) {

			$post_arr=$this->input->post();

			$update=$this->Settings_model->updateParty($post_arr,$id);


			if ($update) {
				$this->redirect('Party Updated Successfully','settings/list-parties',TRUE);
			}
			else{
				$this->redirect('Error on updating','settings/add-party/'.$enc_id,False);
			}
		} 

		$data['title'] = 'Add Party';
		$this->loadView($data);
	}


	function list_parties()
	{ 

		$details = $search_arr = $post_arr=[];


		if( $this->input->post() )
		{
			if( $this->input->post('submit') == 'reset')
			{
				$search_arr = [];

			}elseif( $this->input->post('submit') == 'filter'){
				$post_arr = $this->input->post();
				if(element('party_id',$post_arr)){
					$search_arr['party_name'] =$this->Base_model->getPartyName($post_arr['party_id']);
					$search_arr['party_id'] = $post_arr['party_id'];
				} 
				$search_arr['status'] = $post_arr['status'];
				$search_arr['type'] = $post_arr['type'];
			}
		}
		$data['search_arr'] = $search_arr; 
		$data['details'] = $details;


		$data['title'] = 'List Parties'; 
		$this->loadView($data);
	}


	public function get_party_list_ajax() {
		if ($this->input->is_ajax_request()) {
			$draw = $this->input->post('draw');
			$post_arr = $this->input->post();
			$count_without_filter = $this->Settings_model->getPartyCount();
			$count_with_filter = $this->Settings_model->getAllPartysAjax($post_arr, 1);
			$details = $this->Settings_model->getAllPartysAjax( $post_arr,'');

			$response = array(
				"draw" => intval($draw),
				"iTotalRecords" => $count_without_filter,
				"iTotalDisplayRecords" => $count_with_filter,
				"aaData" => $details,
			);

			echo json_encode($response);
		}
	}


	function add_item($enc_id='')
	{

		$id=False;
		if ($enc_id) {
			$id=$this->Base_model->encrypt_decrypt('decrypt',$enc_id);


			$data['item_details']=$this->Settings_model->getAllitemDetails($id);
			$data['enc_id']=$enc_id;
		}

		if ($this->input->post('add_item') && $this->validate_add_item()) {

			$post_arr=$this->input->post();
			$add=$this->Settings_model->addNewItem($post_arr);
			if ($add) {
				$this->redirect('Item Added Successfully','settings/add-item',TRUE);
			}
			else{
				$this->redirect('Error on adding','settings/add-item',False);
			}

		}

		if ($this->input->post('update_item') && $this->validate_update_item()) {

			$post_arr=$this->input->post();
			$update=$this->Settings_model->updateItem($post_arr,$id);
			if ($update) {
				$this->redirect('Item Updated Successfully','settings/list-items',TRUE);
			}
			else{
				$this->redirect('Error on updating','settings/add-item/'.$enc_id,False);
			}
		} 

		$data['category_details']=$this->Settings_model->getAllCategoryDetails();

		$data['title'] = 'Add Vehicle';
		$this->loadView($data);
	}

	public function get_tax_ajax() {
		if ($this->input->is_ajax_request()) {
			$draw = $this->input->post('draw');
			$post_arr = $this->input->post();
			
			$tax = $this->Settings_model->getTaxByCategory($post_arr['category_id']);

			if ($tax !== null) {
				echo json_encode(['status' => 'success', 'tax' => $tax]);
			} else {
				echo json_encode(['status' => 'error', 'message' => 'Tax not found']);
			}
		}
	}


	function list_items()
	{ 
		$details = $search_arr = $post_arr=[];
		if( $this->input->post() )
		{
			if( $this->input->post('submit') == 'reset')
			{
				$search_arr = [];
			}elseif( $this->input->post('submit') == 'filter'){
				$post_arr = $this->input->post();
				
				
				if(element('product_id',$post_arr)){
					$search_arr['name'] =$this->Base_model->getProductName($post_arr['product_id']);
					$search_arr['product_id'] = $post_arr['product_id'];
				}

				if(element('category',$post_arr)){
					$search_arr['category_name'] =$this->Base_model->getCategoryName($post_arr['category']);
					$search_arr['category'] = $post_arr['category'];
				}

				$search_arr['status'] = $post_arr['status'];
			}
		}

		$data['category_details']=$this->Settings_model->getAllCategoryDetails();

		$data['search_arr'] = $search_arr; 
		$data['details'] = $details;

		
		$data['title'] = 'List Vehicles'; 
		$this->loadView($data);
	}

	public function get_item_list_ajax() {
		if ($this->input->is_ajax_request()) {
			$draw = $this->input->post('draw');
			$post_arr = $this->input->post();
			$count_without_filter = $this->Settings_model->getItemCount();
			$count_with_filter = $this->Settings_model->getAllProductsAjax($post_arr, 1);
			$details = $this->Settings_model->getAllProductsAjax( $post_arr,'');
			
			$response = array(
				"draw" => intval($draw),
				"iTotalRecords" => $count_without_filter,
				"iTotalDisplayRecords" => $count_with_filter,
				"aaData" => $details,
			);

			echo json_encode($response);
		}
	}














	function add_category($enc_id='')
	{

		$id=False;
		if ($enc_id) {
			$id=$this->Base_model->encrypt_decrypt('decrypt',$enc_id);
			$data['category_details']=$this->Settings_model->getAllCategoryDetails($id);

			$data['enc_id']=$enc_id;
		}

		if ($this->input->post('add_category') && $this->validate_add_category()) {

			$post_arr=$this->input->post();
			$post_arr['code']=$this->Settings_model->getMaxCatId()+1001;

			$add=$this->Settings_model->addNewCategory($post_arr);

			if ($add) {
				$this->redirect('Category Added Successfully','settings/add-category',TRUE);
			}
			else{
				$this->redirect('Error on adding','settings/add-category',False);
			}

		}

		if ($this->input->post('update_category') && $this->validate_add_category()) {

			$post_arr=$this->input->post();
			$update=$this->Settings_model->updateCategoryDetails($post_arr,$id);

			if ($update) {
				$this->redirect('Vehicle Updated Successfully','settings/add-category',TRUE);
			}
			else{
				$this->redirect('Error on updating','settings/add-category/'.$enc_id,False);
			}

		} 


		$data['table_details']=$this->Settings_model->getAllCategoryDetails();

		$data['title'] = 'Add Vehicle';
		$this->loadView($data);
	}



	function pin_allocation()
	{
		$packages = $this->Settings_model->getPackageUpgrade();
		$data['packages'] = $packages;
		if($this->input->post())
		{
			$post_arr=$this->input->post();
			$count = $post_arr['count'];
			$user_id = $this->Base_model->getUserId($post_arr['user_name']);
			if(!$user_id)
			{
				$msg = 'Invalid user id';
				$this->redirect($msg, "settings/pin-allocation", FALSE);
			}
			for ($i=0; $i < $count; $i++) { 
				# code...
				$random_string=$this->Base_model->getRandomStringEpin(10,'pin_allocation','random_string');
				$result=$this->Settings_model->addPinAllocation($post_arr,$random_string);
			}
			
			if($result)
			{
				$msg = 'ePIN allocated successfully';
				$this->redirect($msg, "settings/pin-allocation", TRUE);
			}
			else
			{
				$msg = 'error on creating ePIN...!';
				$this->redirect($msg, "settings/pin-allocation", FALSE);
			}
			
		}

		
		$data['title'] = 'ePIN ALLOCATION'; 
		$this->loadView($data);
	}
	
	function user_epin()
	{
		$data['title'] = 'USER ePIN'; 
		if ($this->input->post('submit') == 'search')
		{
			$user_id=NULL;
			$post_arr = $this->input->post();

			if($post_arr['user_name'])
			{
				$user_name = $post_arr['user_name'];

				$user_id = $this->Base_model->getUserId($user_name);
				$data['user_name']=$user_name;

			}
			
			$post_arr['from_date'] = ($post_arr['from_date']) ? $post_arr['from_date'] : date('Y-m-01');

			$post_arr['end_date'] = ($post_arr['end_date']) ? $post_arr['end_date'] : date('Y-m-t');
			
			$from_date = $post_arr['from_date'];
			$end_date = $post_arr['end_date']; 

			$user_epin = $this->Settings_model->getUserEpinDetails($user_id, $from_date, $end_date );
			$data['user_epin']=$user_epin;			
		}

		
		$this->loadView($data);
	}
	public function removePin($id='')
	{
		if($id)
			$res=$this->Settings_model->removePin($id);
		if($res)
			$this->redirect('Successfully deleted','settings/user-epin',true);
	}




	protected function validate_website_profile() {
		$this->form_validation->set_rules('website_name', lang('website_name'), 'trim|required');
		$this->form_validation->set_rules('address', lang('address'), 'trim|required');
		$this->form_validation->set_rules('email', lang('email'), 'trim|required|valid_email');
		$this->form_validation->set_rules('phone', lang('phone'), 'trim|required'); 
		$validation_result =  $this->form_validation->run();
		return $validation_result;
	}


	public function validate_add_vehicle()
	{
		$this->form_validation->set_rules('vehicle_name','Vehicle Name','trim|required');
		$this->form_validation->set_rules('vehicle_number','Vehicle Number','trim|required|is_unique[vehicles.vehicle_number]');
		$this->form_validation->set_rules('open_bal','Open Balance','trim|required');
		$this->form_validation->set_rules('res_pay','Recieve/Pay','trim|required');
		$result = $this->form_validation->run();

		return $result;
	}

	public function validate_edit_vehicle()
	{
		$this->form_validation->set_rules('vehicle_name','Vehicle Name','trim|required');
		$this->form_validation->set_rules('vehicle_number','Vehicle Number','trim|required');
		$this->form_validation->set_rules('open_bal','Open Balance','trim|required');
		$this->form_validation->set_rules('res_pay','Recieve/Pay','trim|required');
		$result = $this->form_validation->run();
		return $result;
	}


	public function validate_add_party()
	{
		$this->form_validation->set_rules('party_name','Party Name','trim|required');
		$this->form_validation->set_rules('open_bal','Open Balance','trim|required');
		$this->form_validation->set_rules('res_pay','Recieve/Pay','trim|required');
		$this->form_validation->set_rules('phone','Phone Number','trim|required');
		$this->form_validation->set_rules('address','Address','trim|required');
		$this->form_validation->set_rules('email','Email','trim|required');
		$this->form_validation->set_rules('vehicle_id','Vehicle ','trim|required');
		$result = $this->form_validation->run();


		return $result;
	}


	public function validate_add_item()
	{
		$this->form_validation->set_rules('bar_code','Bar Code','trim|required|is_unique[products.barcode]');
		$this->form_validation->set_rules('name','Product Name','trim|required');
		$this->form_validation->set_rules('type','Open Balance','trim|required');
		$this->form_validation->set_rules('category','Category','trim|required');
		$this->form_validation->set_rules('purchase_rate','Purchase Rate','trim|required');
		$this->form_validation->set_rules('sale_rate','Sale Rate','trim|required');
		$this->form_validation->set_rules('mrp','MRP','trim|required');
		$this->form_validation->set_rules('tax_cat','Tax Category','trim|required');
		$this->form_validation->set_rules('stock','Stock','trim|required');
		$this->form_validation->set_rules('as_date','Date','trim|required');
		$result = $this->form_validation->run();
		return $result;
	}

	public function validate_update_item()
	{
		$this->form_validation->set_rules('bar_code','Bar Code','trim|required');
		$this->form_validation->set_rules('name','Product Name','trim|required');
		$this->form_validation->set_rules('type','Open Balance','trim|required');
		$this->form_validation->set_rules('category','Category','trim|required');
		$this->form_validation->set_rules('purchase_rate','Purchase Rate','trim|required');
		$this->form_validation->set_rules('sale_rate','Sale Rate','trim|required');
		$this->form_validation->set_rules('mrp','MRP','trim|required');
		$this->form_validation->set_rules('tax_cat','Tax Category','trim|required');
		$this->form_validation->set_rules('stock','Stock','trim|required');
		$this->form_validation->set_rules('as_date','Date','trim|required');
		$result = $this->form_validation->run();
		return $result;
	}

	public function validate_add_category()
	{
		$this->form_validation->set_rules('name','Category Name','trim|required');
		$this->form_validation->set_rules('tax','Category Tax','trim|required');
		$result = $this->form_validation->run();

		return $result;
	}





}
