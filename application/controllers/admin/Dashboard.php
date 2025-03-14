<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Dashboard extends Base_Controller {

	function __construct()
	{
		parent::__construct(); 	
	}

	function index()
	{  
		$data['title'] = lang('dashboard'); 
		$id=log_user_id();

		$data['sendto_delivery_count'] = $this->Dashboard_model->getDeliveryCount('','send_to_delivery');
 		
		$id=log_user_id();

		$data['log_user_name'] = log_user_name();
		$this->loadView($data);
	}

}
