<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Jobs extends Base_Controller {

	function __construct()
	{
		parent::__construct(); 	
	}


	function loaded_items()
	{ 

		$details = $search_arr = $post_arr=[];

		if( $this->input->post('submit') == 'reset')
		{
			$search_arr = [];

		}elseif( $this->input->post('filter')){
			$post_arr = $this->input->post();

			if(element('product_id',$post_arr)){
				$search_arr['product_name'] =$this->Base_model->getProductName($post_arr['product_id']);
				$search_arr['product_id'] = $post_arr['product_id'];
			} 

			if(element('category',$post_arr)){
				$search_arr['category_name'] =$this->Base_model->getCategoryName($post_arr['category']);
				$search_arr['category'] = $post_arr['category'];

			}
			$search_arr['status'] = $post_arr['status'];

		}


		elseif( $this->input->post('update')){

			$update_sale=false;
			$reduce_stock=false;

			$post_arr = $this->input->post();

			
			$id=$this->Base_model->encrypt_decrypt('decrypt',$post_arr['enc_item_id']);
			$item_details=$this->Jobs_model->getLoadeditemDetails($id);


			if (empty($post_arr['sale_count'])) {

				$this->redirect('Unavailable Action','jobs/loaded-items',False);
			}

			
			if ($post_arr['sale_count'] > $item_details['quantities']) {
				$this->redirect('Invalid Count', 'jobs/loaded-items', false);
			}

			if ((!empty($post_arr['sale_count']) && empty($post_arr['sale_price'])) || 
				(!empty($post_arr['sale_price']) && empty($post_arr['sale_count']))) 
			{
				$this->redirect('Both sale count and sale price are required together', 'jobs/loaded-items', false);
			}


			if (!empty($post_arr['sale_count']) && !empty($post_arr['sale_price'])) {
				$post_arr['type']= 'sales';
			}

			$this->Jobs_model->begin();
			$post_arr['salesman_id']=log_user_id();
			$ins_sale=$this->Jobs_model->insertPendingSale($post_arr,$id);
			$update_sale=$this->Jobs_model->updateSale($post_arr,$id);



			if ($update_sale) {
				$reduce_stock=$this->Jobs_model->reduceItemcount($post_arr,$id);

			}


			
			if ($update_sale && $reduce_stock) {
				$this->Jobs_model->commit();
				$this->redirect('Sale Updated Successfully', 'jobs/loaded-items', TRUE);
			}
			else{
				$this->redirect('Error on updation', 'jobs/loaded-items', false);
			}

		}



		$data['search_arr'] = $search_arr; 
		$data['details'] = $details; 

		// print_r($data);die();
		$data['title'] = 'Loaded Items'; 
		$this->loadView($data);
	}
	public function get_assigned_item_ajax() {
		if ($this->input->is_ajax_request()) {
			$draw = $this->input->post('draw');
			$post_arr = $this->input->post();

			$count_without_filter = $this->Jobs_model->getItemsCount(log_user_id());
			$count_with_filter = $this->Jobs_model->getAllItemsAjax($post_arr, 1);
			$post_arr['salesman_id'] = log_user_id();

			$details = $this->Jobs_model->getAllItemsAjax( $post_arr,'');

			$response = array(
				"draw" => intval($draw),
				"iTotalRecords" => $count_without_filter,
				"iTotalDisplayRecords" => $count_with_filter,
				"aaData" => $details,
			);

			echo json_encode($response);
		}
	}


	function sales()
	{ 

		$details = $search_arr = $post_arr=[];
		if( $this->input->post() )
		{

			if( $this->input->post('submit') == 'reset')
			{
				$search_arr = [];
			}elseif( $this->input->post('submit') == 'filter'){
				$post_arr = $this->input->post();

				if(element('job_id',$post_arr)){

					$search_arr['job_id'] = $post_arr['job_id'];
				}

				$search_arr['status'] = $post_arr['status'];
			}
		}


		$data['search_arr'] = $search_arr; 
		$data['details'] = $details; 

		
		$data['title'] = lang('Sales'); 
		$this->loadView($data);
	}

	public function get_saled_items_ajax() {
		if ($this->input->is_ajax_request()) {
			$draw = $this->input->post('draw');
			$post_arr = $this->input->post();
			$post_arr['salesman_id'] = log_user_id();

			$count_without_filter = $this->Jobs_model->getSalesCount(log_user_id());
			$count_with_filter = $this->Jobs_model->getAllSalesAjax($post_arr, 1);
			$details = $this->Jobs_model->getAllSalesAjax( $post_arr,'');

			$response = array(
				"draw" => intval($draw),
				"iTotalRecords" => $count_without_filter,
				"iTotalDisplayRecords" => $count_with_filter,
				"aaData" => $details,
			);

			echo json_encode($response);
		}
	}





	function validate_update_customer() 
	{

		$this->form_validation->set_rules('customer_username', 'UserName', 'required');
		$this->form_validation->set_rules('name', 'Customer Name', 'required');
		$this->form_validation->set_rules('mobile', 'Contact Number', 'required');
		$this->form_validation->set_rules('address', 'Address', 'required');
		$this->form_validation->set_rules('salesman_id', 'Salesman', 'required|numeric');
		$this->form_validation->set_rules('email', 'Email', 'required|valid_email');
		$this->form_validation->set_rules('location', 'Location', 'required');		
		$this->form_validation->set_rules( 'user_type', 'Customer Type', 'required|in_list[lead,customer]');
		$this->form_validation->set_rules( 'organization_type', 'Organization Type', 'required|in_list[Individual,organization]'); 

		$result =  $this->form_validation->run();

		return $result;
	}

}






