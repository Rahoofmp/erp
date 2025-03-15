<?php  defined('BASEPATH') OR exit('No direct script access allowed');

class Salesman_model extends Base_model {

    function __construct() {
        parent::__construct();

    }


    public function addJobDetails($vehicle_id,$salesman_id,$categories,$products,$quantities){

        $submit_date = date('Y-m-d H:i:s');
        $this->db->set('vehicle_id',$vehicle_id);
        $this->db->set('salesman_id',$salesman_id);
        $this->db->set('categories',$categories);
        $this->db->set('products',$products);
        $this->db->set('quantities',$quantities);
        $this->db->set('saled_quantities',$quantities);
        $this->db->set('created_date',$submit_date);
        $this->db->set('status','active');
        $result = $this->db->insert('job_details');
        return $result;
    }  


    public function getSalesmanByvehicle($vehicle_id) 
    {
        $details = array();
        $this->db->select('user_id,user_name');
        $this->db->from('login_info');
        $this->db->where('vehicle_id', $vehicle_id);
        $this->db->limit(1);
        $query = $this->db->get();
        foreach ($query->result_array() as $row) {
            $details = $row;
        }
        return $details;
    }

    public function getCategoryByItem($id) 
    {
        $details = array();
        $this->db->select('category,stock');
        $this->db->from('products');
        $this->db->where('id', $id);
        $this->db->limit(1);
        $query = $this->db->get();
        foreach ($query->result_array() as $row) {
            $row['category_name']=$this->Base_model->getCategoryName($row['category']);
            $details = $row;
        }
        return $details;
    }

    public function reduceStock($product_id, $qty) {
        $this->db->set('stock', 'stock - ' . (int)$qty, false)
        ->where('id', (int)$product_id)
        ->where('stock >=', (int)$qty)
        ->update('products');

        return $this->db->affected_rows() > 0;
    }



}