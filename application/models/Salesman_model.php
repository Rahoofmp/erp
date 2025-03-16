<?php  defined('BASEPATH') OR exit('No direct script access allowed');

class Salesman_model extends Base_model {

    function __construct() {
        parent::__construct();

    }


    public function addJobDetails($post_arr) {
        $ins=false;
        $submit_date = date('Y-m-d H:i:s');
        $vehicle_id = $post_arr['vehicle_id'];
        $salesman_id = $post_arr['sales_man_id'];

        if (!empty($post_arr['products'])) {
            foreach ($post_arr['products'] as $product) {
                $this->db->set('vehicle_id', $vehicle_id);
                $this->db->set('salesman_id', $salesman_id);
                $this->db->set('categories', $product['category_id']);
                $this->db->set('products', $product['product_id']);
                $this->db->set('quantities', $product['quantity']);
                $this->db->set('saled_quantities', $product['quantity']);
                $this->db->set('created_date', $submit_date);
                $this->db->set('status', 'active');
                $ins=$this->db->insert('job_details');
            }
        }


        return $ins; 
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