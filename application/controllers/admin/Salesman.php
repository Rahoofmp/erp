<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Salesman extends Base_Controller {

	function __construct()
	{
		parent::__construct(); 	
	}

	function create_job($enc_id='')
	{   	
		
		if( $enc_id ){


			// $salesman_username =  $this->input->get( 'salesman_username' ); 
			$salesman_id = $this->Base_model->encrypt_decrypt('decrypt',$enc_id); 

			if (!$salesman_id) {
				$msg = lang('text_invalid_salesman_username');
				$this->redirect($msg, 'salesman/create-job', FALSE);
			}
			$data['id']=$salesman_id;
			$search_arr['salesman_username']=$salesman_id;
			$data['salesman'] = element(0,$this->Salesman_model->getAllsalesmans( $search_arr ));

			

		}
		if ($this->input->post('add_job')&& $this->validate_add_job()) {

			

			$post_arr=$this->input->post();
			
			if (!isset($post_arr['products']) || empty($post_arr['products']) || !isset($post_arr['products'][0]['product_id']) ||empty($post_arr['products'][0]['product_id'])
		) {
				$this->redirect('No valid products chosen', 'salesman/create-job', false);
		}

		foreach ($post_arr['products'] as $product) {
			if (!empty($product['product_id']) && !empty($product['quantity'])) {
				$this->Salesman_model->reduceStock($product['product_id'], $product['quantity']);
			}
		}

		$product_ids = array_column($post_arr['products'], 'product_id');
		$category_ids = array_column($post_arr['products'], 'category_id');
		$quantities = array_column($post_arr['products'], 'quantity');


		$product_ids_str = implode(',', $product_ids);
		$category_ids_str = implode(',', $category_ids);
		$quantities_str = implode(',', $quantities);




		$ins=$this->Salesman_model->addJobDetails($post_arr['vehicle_id'],$post_arr['sales_man_id'],$category_ids_str,$product_ids_str,$quantities_str);

		if($ins){


			$this->Base_model->insertIntoActivityHistory(log_user_id(), $post_arr['sales_man_id'],'Job created', serialize($post_arr));


				// $this->load->model('Mail_model');
				// $email_alerts_arr = $this->software->getSettingsByKey('register'); 

				// if(value_by_key('register') && $email_alerts_arr['code'] == 'e_mail_alert')
				// {
				// 	$this->load->model('Mail_model'); 
				// 	$post_arr['fullname'] = $post_arr['name'];

				// 	// $send_mail = $this->Mail_model->sendEmails('salesman_registration', $post_arr);
				// }

			$msg = 'Job Assigned Successfully for '.$post_arr['sales_man_name'];
			$this->redirect("<b>$msg </b>", "salesman/create-job", TRUE);
		}
		else{
			$msg = 'Creation Failed...!';
			$this->redirect("<b>$msg </b>", "salesman/create-job", FALSE);
		}

	}


	if ($this->input->post('update_salesman') && $this->validate_update_salesman()) {
		$post_arr = $this->input->post();

		$post_arr['password']=$post_arr['psw'];
		if($post_arr['psw']){
			if ($post_arr['psw']!=$post_arr['cpsw']) {
				$this->redirect("Confirm Password missmatch to Password", "salesman/create-job/$enc_id", FALSE);
			}
		}
		if($post_arr['salesman_username']!=$data['salesman']['salesman_username']){
			if ($this->Salesman_model->check_exists('salesman_username',$post_arr['salesman_username'])) {
				$this->redirect("UserName Already Exists", "salesman/create-job/$enc_id", FALSE);
			}
		}
		if($post_arr['mobile']!=$data['salesman']['mobile']){
			if ($this->Salesman_model->check_exists('mobile',$post_arr['mobile'])) {
				$this->redirect("Mobile Already Exists", "salesman/create-job/$enc_id", FALSE);
			}
		}
		if($post_arr['email']!=$data['salesman']['email']){
			if ($this->Salesman_model->check_exists('email',$post_arr['email'])) {
				$this->redirect("Email Already Exists", "salesman/create-job/$enc_id", FALSE);
			}
		}

		$update=$this->Salesman_model->updatesalesmanDetails($post_arr,$salesman_id);
		if($update){
			$this->load->model('Mail_model'); 

				// $send_mail = $this->Mail_model->sendEmails('salesman_updation', $post_arr);

			$this->Base_model->insertIntoActivityHistory(log_user_id(), log_user_id(), 'salesman_data_updated', serialize($post_arr));

			$msg = 'Updateion completed Successfully'.' , ID : '.$post_arr['salesman_username'];
			$this->redirect("<b>$msg </b>", "salesman/salesman-list", TRUE);
		}
		else{
			$msg = 'Updateion Failed...!';
			$this->redirect("<b>$msg </b>", "salesman/salesman-list", FALSE);
		}

	}
		// print_r($this->input->post());
		// die();


	$data['title'] = 'Add salesman';
	$this->loadView($data);
}


public function get_salesman_ajax() {
	if ($this->input->is_ajax_request()) {
		$draw = $this->input->post('draw');
		$post_arr = $this->input->post();


		$details = $this->Salesman_model->getSalesmanByvehicle($post_arr['vehicle_id']);

		if ($details !== null) {
			echo json_encode(['status' => 'success', 'details' => $details]);
		} else {
			echo json_encode(['status' => 'error', 'message' => 'Tax not found']);
		}
	}
}

public function get_category_ajax() {
	if ($this->input->is_ajax_request()) {
		$draw = $this->input->post('draw');
		$post_arr = $this->input->post();


		$details = $this->Salesman_model->getCategoryByItem($post_arr['item_id']);

		if ($details !== null) {
			echo json_encode(['status' => 'success', 'details' => $details]);
		} else {
			echo json_encode(['status' => 'error', 'message' => 'Tax not found']);
		}
	}
}



function validate_add_salesman() 
{
	$password_length = value_by_key('password_length');
	$this->form_validation->set_rules('salesman_username', 'UserName', 'required|is_unique[salesman_info.salesman_username]|alpha_numeric');
	$this->form_validation->set_rules('name', 'salesman Name', 'required');
	$this->form_validation->set_rules('mobile', 'Contact Number', 'required|is_unique[salesman_info.mobile]');
	$this->form_validation->set_rules('address', 'Address', 'required');
	$this->form_validation->set_rules('email', 'Email', 'required|valid_email|is_unique[salesman_info.email]');
	$this->form_validation->set_rules('location', 'Location', 'required');
	$this->form_validation->set_rules('psw','password', 'required|matches[cpsw]|min_length['. $password_length .']'); 
	$this->form_validation->set_rules('cpsw','confirm password','required'); 
	$this->form_validation->set_rules( 'user_type', 'salesman Type', 'required|in_list[lead,salesman]'); 
	$this->form_validation->set_rules('salesman_id','salesman_id ','required'); 

	$this->form_validation->set_rules( 'organization_type', 'Organization Type', 'required|in_list[Individual,organization]');
	$result =  $this->form_validation->run();

	return $result;
}

function validate_add_job() 
{

	$this->form_validation->set_rules('vehicle_id', 'Vehicle', 'required|is_exist[vehicles.id]');
	$this->form_validation->set_rules('sales_man_id', 'Salesman', 'required|is_exist[login_info.user_id]');

	$result =  $this->form_validation->run();

	return $result;
}


function validate_update_salesman() 
{

	$this->form_validation->set_rules('salesman_username', 'UserName', 'required');
	$this->form_validation->set_rules('name', 'salesman Name', 'required');
	$this->form_validation->set_rules('mobile', 'Contact Number', 'required');
	$this->form_validation->set_rules('address', 'Address', 'required');
	$this->form_validation->set_rules('salesman_id', 'Salesman', 'required|numeric');
	$this->form_validation->set_rules('email', 'Email', 'required|valid_email');
	$this->form_validation->set_rules('location', 'Location', 'required');		
	$this->form_validation->set_rules( 'user_type', 'salesman Type', 'required|in_list[lead,salesman]');
	$this->form_validation->set_rules( 'organization_type', 'Organization Type', 'required|in_list[Individual,organization]'); 

	$result =  $this->form_validation->run();

	return $result;
}
function salesman_list()
{ 

	$details = $search_arr = $post_arr=[];


	if( $this->input->post() )
	{
		if( $this->input->post('submit') == 'reset')
		{
			$search_arr = [];

		}elseif( $this->input->post('submit') == 'filter'){
			$post_arr = $this->input->post();

			if(!element('salesman_username',$post_arr)){
				$post_arr['salesman_username'] = '';
			} 

			if(element('source_id',$post_arr)){
				$search_arr['source_user'] =$this->Base_model->getSourceName($post_arr['source_id']);
				$search_arr['source_id'] = $post_arr['source_id'];
			} 

			if(element('country',$post_arr)){
				$search_arr['country_name'] =$this->Base_model->getCountryName($post_arr['country']);

			}

			if(!element('salesman_id',$post_arr)){
				$post_arr['salesman_id'] = '';
			}else{
				$post_arr['salesman_name'] = $this->Base_model->getUserName($post_arr['salesman_id']);
				$search_arr['salesman_name'] = $post_arr['salesman_name'];

			}


			$search_arr['enquiry'] = $post_arr['enquiry'];
			$search_arr['salesman_username'] = $post_arr['salesman_username'];
			$search_arr['salesman_id'] = $post_arr['salesman_id'];
			$search_arr['country'] = $post_arr['country'];


		}
		;

	}


	$data['search_arr'] = $search_arr; 
	$data['details'] = $details;


	$data['title'] = lang('salesmans_list'); 
	$this->loadView($data);
}
public function get_salesman_list_ajax() {
	if ($this->input->is_ajax_request()) {
		$draw = $this->input->post('draw');
		$post_arr = $this->input->post();

		$count_without_filter = $this->Salesman_model->getOrderCount();
		$count_with_filter = $this->Salesman_model->getAllsalesmansAjax($post_arr, 1);
		$details = $this->Salesman_model->getAllsalesmansAjax( $post_arr,'');
			// echo $this->db->last_query();
			// die();
		$response = array(
			"draw" => intval($draw),
			"iTotalRecords" => $count_without_filter,
			"iTotalDisplayRecords" => $count_with_filter,
			"aaData" => $details,
		);

		echo json_encode($response);
	}
}

function salesman_ajax() {

	if ($this->input->is_ajax_request()) {
		$post = $this->input->post();
			// print_r($post);
			// die();
		$post['q'] = element('q', $post) ? $post['q'] : '';
		$json = $this->Base_model->getsalesmanIdAuto($post['q']);
		echo json_encode($json);
	}
}

}






