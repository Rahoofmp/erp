<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Autocomplete extends Base_Controller {

	function __construct()
	{
		parent::__construct(); 	
	}

	function user_filter()
	{ 
		$keyword = $this->input->post('keyword'); 
		$user_arr = $this->Base_model->getfilteredUsers($keyword,20);
		echo json_encode($user_arr);
	}
	function project_filter()
	{ 
		$keyword = $this->input->post('keyword'); 
		$project_arr = $this->Base_model->getfilteredProject($keyword,20);
		echo json_encode($project_arr);
	}

	function category_ajax() {

		if ($this->input->is_ajax_request()) {
			$post = $this->input->post();
			$post['q'] = element('q', $post) ? $post['q'] : '';
			$json = $this->Base_model->getAllCategory($post['q']);
			echo json_encode($json);
		}
	} 

	function assigend_item_name_ajax() {

		if ($this->input->is_ajax_request()) {
			$post = $this->input->post();
			$post['q'] = element('q', $post) ? $post['q'] : '';
			$json = $this->Base_model->getAssignedItemAuto($post['q']);
			echo json_encode($json);
		}
	}

	function assigend_category_ajax() {

		if ($this->input->is_ajax_request()) {
			$post = $this->input->post();
			
			$post['q'] = element('q', $post) ? $post['q'] : '';
			$json = $this->Base_model->getAssignedCategoryAuto($post['q']);
			echo json_encode($json);
		}
	}

		function job_number_ajax() {

		if ($this->input->is_ajax_request()) {
			$post = $this->input->post();
			
			$post['q'] = element('q', $post) ? $post['q'] : '';
			$json = $this->Base_model->getJobsSalesman($post['q']);
			echo json_encode($json);
		}
	}


}