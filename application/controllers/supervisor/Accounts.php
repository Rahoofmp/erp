<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Accounts extends Base_Controller {

	function __construct()
	{
		parent::__construct(); 	
	}

	public function index()
	{    

		// $this->load->model('Calculation_model');
		$log_user_id = log_user_id(); 
		// $date_of_submission = date("Y-m-d H:i:s");
		
		if ($this->input->post('submit') && $this->validate_add_deduct_amount()) {

			// $this->load->config('ssl');
			// if($this->config->item('demo_mode'))
			// { 
			// 	$this->redirect( lang('site_under_maintenance'), "accounts/index", FALSE);
			// } 

			$post_arr = $this->input->post(NULL, TRUE); 

			$this->Accounts_model->begin();
			if ($post_arr['submit']=='credit_amount') {
				
				$post_arr['transfer_type']='credit';
				$post_arr['wallet_type']='add_fund';
			}
			else if ($post_arr['submit']=='debit_amount'){
				$bal_amount = $this->Base_model->getCompanyWallet();

				if ($bal_amount < $post_arr['amount']) {
					$this->Accounts_model->rollback();
					$msg = "Low Balance";
					$this->redirect($msg, 'accounts', FALSE);
				}
				$post_arr['transfer_type']='debit';
				$post_arr['amount']=-$post_arr['amount'];
				$post_arr['wallet_type']='deduct_fund';
			}
			$post_arr['done_by']=$log_user_id;

			$insert=$this->Accounts_model->insertAccountDetails( $post_arr);

			if ($insert) {
				$this->Accounts_model->commit();                         
				$data = serialize($post_arr);
				$this->Base_model->insertIntoActivityHistory($log_user_id, $log_user_id, $post_arr['submit'],$data,$post_arr['amount']);                       

				$msg = "Accounts Updated ";
				$this->redirect($msg, 'accounts', TRUE);
			} else {
				$this->Accounts_model->rollback();
				$msg = "Error On updating account ..... Please try again later";
				$this->redirect($msg, 'accounts', FALSE);
			}


		}
		$data['table_details']=$this->Accounts_model->getAllAccountHistory();
		
		$data['title'] = "Accounts";
		$this->loadView($data);
	}

	public function validate_add_deduct_amount() {


		$this->form_validation->set_rules('amount', "Amount", 'required|greater_than[0]|numeric');
		$this->form_validation->set_rules('type', "Type", 'required');
		$result =  $this->form_validation->run();
		return $result;
	}
	function get_amount_words() {

		if($this->input->is_ajax_request()){
			$post = $this->input->post();
			$amount =$post['amount'];
			$words = $this->Base_model->numberTowords($amount);
			echo $words;
		}
	}


	public function get_added_records_ajax() {
		if ($this->input->is_ajax_request()) {
			$draw = $this->input->post('draw');
			$post_arr = $this->input->post();

			$count_without_filter = $this->Accounts_model->getEntryCount();
			$count_with_filter = $this->Accounts_model->getAllEntrysAjax($post_arr, 1);
			$details = $this->Accounts_model->getAllEntrysAjax( $post_arr,'');
		
			$response = array(
				"draw" => intval($draw),
				"iTotalRecords" => $count_without_filter,
				"iTotalDisplayRecords" => $count_with_filter,
				"aaData" => $details,
			);

			echo json_encode($response);
		}
	}


}
