<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Member extends Base_Controller {

	function __construct()
	{
		parent::__construct(); 	
	}


	public function profile($url_id = '')
	{
		$data['title']=" Edit Profile";
		$url_id = $this->Base_model->encrypt_decrypt('decrypt',$url_id); 
		
		if( $url_id )
		{
			$user_id = $url_id;
			$user_name = $this->Base_model->getUserName($user_id);
			if( !$user_name )
			{
				$msg = lang('invalid_user_name');
				$this->redirect($msg, 'member/profile', FALSE);
			}

		}elseif( $this->input->get( 'user_id' ) ){

			$encoded_user_id =  $this->input->get('user_id');
			$user_id = $this->Base_model->encrypt_decrypt('decrypt', $encoded_user_id);
			$user_name = $this->Base_model->getUserName($user_id); 

		}elseif( $this->input->get( 'user_name' ) ){

			$user_name =  $this->input->get( 'user_name' ); 
			$user_id = $this->Base_model->getUserId($user_name); 

			if (!$user_id) {
				$msg = lang('text_invalid_user_name');
				$this->redirect($msg, 'member/profile', FALSE);
			}

		}else{            
			$user_id = log_user_id();
			$user_name = $this->Base_model->getUserName($user_id);

		}
		
		if( $this->input->post( 'profile_update' ) )
		{


			
			$post_arr = $this->input->post();
			$post_arr['file_name'] = NULL;

			if($_FILES['userfile']['error']!=4)
			{
				$config['upload_path'] = './assets/images/profile_pic/';
				$config['allowed_types'] = 'gif|jpg|png|jpeg|pdf|doc|docx';
				$config['max_size'] = '2000000';
				$config['remove_spaces'] = true;
				$config['overwrite'] = false;
				$config['encrypt_name'] = TRUE;

				$this->load->library('upload', $config);
				$msg = '';
				if (!$this->upload->do_upload()) {
					$msg = lang('image_not_selected');
					$error = $this->upload->display_errors();
					$this->redirect( $error, "member/profile?user_name=$user_name", false );
				} else {
					$image_arr = $this->upload->data();  
					$post_arr['file_name']=$image_arr['file_name'];
				}
			}

			$update_profile =  $this->Member_model->updateUserProfile( $post_arr, $user_id );

			if($update_profile)
				$this->redirect(lang("success_profile_updation"), "member/profile?user_name=$user_name", TRUE);
			else
				$this->redirect(lang("failed_profile_updating"), "member/profile?user_name=$user_name", FLASE);
		}

		$select_arr = ['first_name', 'user_photo', 'email', 'mobile',  'facebook', 'instagram', 'twitter'];
		$data['user_details'] = $this->Base_model->getUserDetails($user_id, $select_arr ); 			
		
		$data['user_name'] = $user_name;
		$data['user_id'] = $user_id;
		$this->loadView($data);
	}	



	function change_credential()
	{ 

		$user_id = log_user_id();
		$user_name = log_user_name(); 

		if($this->input->post('credential_update') == 'password' && $this->validate_change_credential('update_password')){

			$post_arr = $this->input->post();

			$this->config->load('bcrypt');
			$this->load->library('bcrypt');
			$new_password_hashed = $this->bcrypt->hash_password( $post_arr["new_password"] );


			if ( $this->Member_model->updatePassword( $new_password_hashed, $user_id )) 
			{
				$this->load->model('Mail_model');
				$mail_arr = array(
					'user_id' => $user_id,
					'password' => $post_arr["new_password"],
					'email' => $this->data[ 'user_details' ]['email'],
					'fullname' => $this->data[ 'user_details' ]['first_name'],
				);  

				$post_arr['ticket_id'] = $this->Mail_model->sendEmails("password",$mail_arr);

				$this->Base_model->insertIntoActivityHistory(log_user_id(), log_user_id(),'update_password_admin', serialize($post_arr));

				$this->redirect( lang('password_updated_successfully'), "member/change-credential?user_name=$user_name", TRUE);
			} else {
				$msg = lang('error_on_password_updation');
				$this->redirect($msg, "member/change-credential?user_name=$user_name", FALSE);
			}

		}
		$data['user_name'] = $user_name; 
		$data['enc_user_id'] = $this->Base_model->encrypt_decrypt("encrypt",$user_id);; 

		$data['title'] = lang('change_credential'); 
		$this->loadView($data);
	}

	function follow_messages()
	{ 

		$user_id = log_user_id();
		$user_name = log_user_name(); 
		$search_arr=array();

		if ($this->input->post()) {

			$post_arr=$this->input->post();

			$search_arr['type'] = $post_arr['type'];

		}

		$data['search_arr']=$search_arr;

		$data['title'] = 'Follow-up Messages'; 
		$this->loadView($data);
	}

	function reminder_settings()
	{ 

		$user_id = log_user_id();
		$user_name = log_user_name(); 

		$data['current_reminders'] = $this->Member_model->getcurrentreminders($user_id);


		if($this->input->post() && $this->validate_reminder())
		{

			$post_arr = $this->input->post();
			$post_arr['user_id']=$user_id;
			$create_reminder=$this->Member_model->createReminder($post_arr);

			if ($create_reminder) {

				$this->redirect( 'Reminder Created', "member/reminder-settings", true );
			}
			else{
				$this->redirect( 'Error On Reminder Creation', "member/reminder-settings", false );
			}


		}


		$data['title'] = 'Reminder Settings'; 
		$this->loadView($data);
	}

	protected function validate_change_credential( $action ){

		if( $action == 'update_password'){

			$password_length = value_by_key('password_length');
			$this->form_validation->set_rules( 'new_password', lang('new_password'), 'trim|required');
			$this->form_validation->set_rules( 'confirm_password', lang( 'confirm_password' ), 'trim|required|min_length['. $password_length .']|matches[new_password]' );
		}

		$result = $this->form_validation->run(); 
		return $result;
	}

	protected function validate_reminder(){

		$this->form_validation->set_rules( 'date', lang('date'), 'trim|required');
		$this->form_validation->set_rules( 'message', lang( 'message' ), 'trim|required' );
		$result = $this->form_validation->run(); 
		return $result;
	}


	public function get_messages_list_ajax() {
		if ($this->input->is_ajax_request()) {
			$draw = $this->input->post('draw');
			$post_arr = $this->input->post();
			$count_without_filter = $this->Member_model->getMessageCount();
			$count_with_filter = $this->Member_model->getAllMessageAjax($post_arr, 1);
			$details = $this->Member_model->getAllMessageAjax( $post_arr,'');
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

	function inactive_leads($enc_id='',$enc_row='')
	{   	
		// print_r($enc_id);
		// die();
		$this->load->model('Customer_model');
		$customer_id=false;
		if( $enc_id ){


			// $customer_username =  $this->input->get( 'customer_username' ); 
			$customer_id = $this->Base_model->encrypt_decrypt('decrypt',$enc_id);
		
			if (!$customer_id) {
				$msg = lang('text_invalid_customer_username');
				$this->redirect($msg, 'customer/add-customer', FALSE);
			}
			$data['id']=$customer_id;
			$search_arr['customer_username']=$customer_id;
			$data['customer'] = element(0,$this->Customer_model->getAllCustomers( $search_arr ));


			

		}



		if ($this->input->post('inactive_lead') ) {
			$post_arr = $this->input->post();
			$id=$this->Base_model->encrypt_decrypt('decrypt',$enc_row);
			$inactive_lead=$this->Base_model->inactivateLead($customer_id);
			$inactive_lead=$this->Base_model->changeReminder($id);

			
			

			if($inactive_lead)
			{
				$this->redirect( 'Lead inactivated successfully', "member/follow-messages", true );
			}
			else{
				$this->redirect( 'Error on inactiving lead', "member/follow-messages/".$enc_id, false );
			}



		}
		// print_r($this->input->post());
		// die();

		
		$data['title'] = 'Modify Leads';
		$this->loadView($data);
	}
	function pending_sales($value='')
	{
		$data['title']="Pending Sales";
		$this->loadView($data);
	}
	function get_pending_sales_ajax($value='')
	{
		if ($this->input->is_ajax_request()) {
			$draw = $this->input->post('draw');
			$post_arr = $this->input->post();

			$count_without_filter = $this->Member_model->getPendingSalesCount();
			$count_with_filter = $this->Member_model->getAllPendingSalesAjax($post_arr, 1);
			// $post_arr['salesman_id'] = log_user_id();

			$details = $this->Member_model->getAllPendingSalesAjax( $post_arr,'');
			$response = array(
				"draw" => intval($draw),
				"iTotalRecords" => $count_without_filter,
				"iTotalDisplayRecords" => $count_with_filter,
				"aaData" => $details,
			);

			echo json_encode($response);
		}
	}
	function approve_sales($action='',$enc_sales_id='')
	{
		$pending_id=$this->Base_model->encrypt_decrypt( 'decrypt', $enc_sales_id);
		if($pending_id){
			if($pending_id){
				$data['enc_sales_id']=$enc_sales_id;
			}
			// $this->load->model('Member_model');
			$sales_data=$this->Member_model->getAllPendingSales($pending_id,'pending');

			// print_r($sales_data);
			// die();
			if (empty($sales_data)) {
				$this->redirect("Already processed","member/pending-sales",FALSE);
			}
			$ref_id=$sales_data['ref_id'];
			$this->Member_model->begin();
			if ($action=='approve') {
				$update=$this->Member_model->updatePendingSalesStatus($pending_id,'approved');
				$this->load->model('Accounts_model');
				$insert=0;

				if ($sales_data['type']=='sales') {


					$sales_wallet=$sales_data['sale_count']*$sales_data['sale_price'];
					$account_data = [
						'amount'        => $sales_wallet,
						'wallet_type'   => 'sales',
						'transfer_type' => 'credit',
						'type'          => 'sales',
						'remarks'       => '',
						'done_by'       => $sales_data['salesman_id'],
						'date'          => date('Y-m-d H:i:s') 
					];

					$insert=$this->Accounts_model->insertAccountDetails( $account_data);
					
				}
				elseif ($sales_data['type']=='return') {


					$return_wallet=$sales_data['damage_count']*$sales_data['sale_rate'];
					$account_data = [
						'amount'        => -$return_wallet,
						'wallet_type'   => 'return',
						'transfer_type' => 'debit',
						'type'          => 'return',
						'remarks'       => $sales_data['reason'],
						'done_by'       => $sales_data['salesman_id'],
						'date'          => date('Y-m-d H:i:s') 
					];

					$insert=$this->Accounts_model->insertAccountDetails( $account_data);
					
				}
				if ($insert) {
					$this->Member_model->commit();
					$this->redirect("Approved Successfully",'member/pending-sales',TRUE);
				}
				else{
					$this->Member_model->roll_back();
					$this->redirect("Error on approving",'member/pending-sales',FALSE);
				}
				
			}
			elseif ($action=='reject') {
				$update=$this->Member_model->updatePendingSalesStatus($pending_id,'rejected');
				$update_sales=0;

				if ($sales_data['type']=='sales') {
					$update_sales=$this->Member_model->updateSalesCount('sale_count',-$sales_data['sale_count'],$ref_id);

					$update_sales=$this->Member_model->updateSalesCount('saled_quantities',$sales_data['sale_count'],$ref_id);


				}
				elseif ($sales_data['type']=='return') {
					$update_sales=$this->Member_model->updateSalesCount('damage_count',-$sales_data['damage_count'],$ref_id);
					$update_sales=$this->Member_model->updateSalesCount('saled_quantities',$sales_data['sale_count'],$ref_id);
				}
				if ($update_sales && $update) {
					$this->Member_model->commit();
					$this->redirect("Request rejected Successfully",'member/pending-sales',TRUE);
				}
				else{
					$this->Member_model->roll_back();
					$this->redirect("Error on rejecting request",'member/pending-sales',FALSE);
				}
			}
			else{
				$this->Member_model->roll_back();
				$this->redirect("Invalid Action", "member/pending-sales", FALSE);
			}
			


		}else{
			$this->redirect("Error on action", "member/pending-sales", FALSE);
		}
	}
}
