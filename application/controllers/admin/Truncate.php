<?php

defined('BASEPATH') OR exit('No direct script access allowed');
 
class Truncate extends Base_Controller {


	public function truncate_all()
	{
        $this->Truncate_model->begin();
        $result = $this->Truncate_model->truncateAll();

        if ($result['status']) { 
        	$this->Truncate_model->commit(); 
            $this->redirect($result['message'], "dashboard/index", TRUE);
        } else {
            $this->Truncate_model->rollback(); 
            $this->redirect($result['message'], "dashboard/index", FALSE);
        }
        echo $result['message'];
    }
}
