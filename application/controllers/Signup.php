<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Signup extends Base_Controller 
{

	function __construct() {
		parent::__construct();  
	} 
	public function index()
	{ 

		$this->load->model('Settings_model');
		$data['title'] = 'Signup a user';
		$data['subadmins'] = $this->Settings_model->getSubadmin();

		
		if ($this->input->post('register') && $this->validate_signup()) {
			$register = $this->input->post();
			$this->Signup_model->begin();

			$last_id=$this->Signup_model->getLastStaffId();
			

			if ($last_id) {
				preg_match('/\d+/', $last_id, $matches);
				$numeric_part = isset($matches[0]) ? (int) $matches[0] : 1000;
				$register['staff_id'] = 'STFF-' . ($numeric_part + 1);
			} 
			else {
				$register['staff_id'] = 'STFF-1000';
			}


			$response = $this->Signup_model->registrationProcess($register);
			if ($response['status']) {
				$this->Signup_model->commit();


				$ecn_user_id = $this->Base_model->encrypt_decrypt( 'encrypt', $response['user_id'] );
				$username = $response['username'];
				$password = $response['password'];

				$msg = lang('signup_completed_successfully').' , ID : '.$username.' ,password : '.$password;
				$this->redirect("<b>$msg </b>", "signup", TRUE);

			} else {
				$this->Signup_model->rollback();
				$this->redirect($msg, "signup", FALSE);
			}


		}

		$this->loadView($data);

	} 

	public function success( $ecn_user_id = null )
	{ 

		if( !$ecn_user_id ){
			$this->redirect( lang('text_no_permission'), 'signup', FALSE );
		}

		$user_id = $this->Base_model->encrypt_decrypt('decrypt',$ecn_user_id);
		$preview_details = $this->Base_model->getUserDetails($user_id); 

		$preview_details['invoice_number'] = str_pad($user_id, 8, '0', STR_PAD_LEFT);
		$preview_details['date'] = date('Y - M - d');     

		$preview_details['username'] = $this->Base_model->getUserName($user_id); 
		$preview_details['reg_method'] = $this->Base_model->getLoginInfoField( 'payment_type', $user_id);

		$data['title'] = lang('success');
		$data['preview_details'] = $preview_details;

		$this->loadView($data);

	}

	function validate_signup() {
		$password_length = value_by_key('password_length');
		$this->form_validation->set_rules('user_type','user type', 'trim|required|in_list[supervisor,admin,salesman]');
		$this->form_validation->set_rules('user_name','user name', 'trim|required|is_unique[login_info.user_name]');
		// $this->form_validation->set_rules('department','Department', 'trim|required|is_exist[department.id]');
		
		$this->form_validation->set_rules('name', 'Name', 'trim|required');
		$this->form_validation->set_rules('email', 'email', 'trim|required|valid_email|is_unique[user_info.email]|callback_checkActiveEmail');
		$this->form_validation->set_message('checkActiveEmail','The Email already registered');
		$this->form_validation->set_rules('mobile','mobile', 'trim|required|is_unique[user_info.mobile]|callback_checkActiveMobile'); 
		$this->form_validation->set_message('checkActiveMobile','The Mobile Number already registered');
		$this->form_validation->set_rules('password','password', 'trim|required|min_length['. $password_length .']'); 
		$this->form_validation->set_rules('c_password','confirm password','trim|required|matches[password]'); 
		$validation_result =  $this->form_validation->run();

		return $validation_result;
	}



	function checkActiveEmail($post_arr=[]){
		$post=$this->input->post();
		if($this->Signup_model->checkEmailExist($post)){
			return FALSE;
		}
		return TRUE; 
	}

	function checkActiveMobile($post){
		$post=$this->input->post();
		if($this->Signup_model->checkMobileExist($post)){
			return FALSE;
		}
		return TRUE; 
	}

}

