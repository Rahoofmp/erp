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
                $this->db->set('job_id', $post_arr['job_number']);
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

    public function getCategoryByItem($id) {
        $details = array();

        $this->db->select('category_id, SUM(stock) as total_stock');
        $this->db->from('purchase');
        $this->db->where('product_id', $id);
        $this->db->group_by('category_id'); 
        $this->db->limit(1);
        $query = $this->db->get();
        $row = $query->row_array(); 

        if ($row) {
            $row['category_name'] = $this->Base_model->getCategoryName($row['category_id']);
            $details = $row;
        }

        return $details;
    }


    public function reduceStock($product_id, $qty) {
        $remaining_qty = $qty;


        $this->db->select('id, stock');
        $this->db->from('purchase');
        $this->db->where('product_id', $product_id);
        $this->db->where('stock >', 0);
        $this->db->order_by('id', 'ASC'); 
        $query = $this->db->get();
        $stock_entries = $query->result_array();
        foreach ($stock_entries as $entry) {
            if ($remaining_qty <= 0) {
                break;
            }
            $deduct_qty = min($remaining_qty, $entry['stock']);
            $remaining_qty -= $deduct_qty;
            $this->db->set('stock', 'stock - ' . $deduct_qty, false)
            ->where('id', $entry['id'])
            ->update('purchase');
        }


        return ($remaining_qty == 0); 
    }



    public function generateJobNumber($as_date) {

        $formatted_date = date('m-d-Y', strtotime($as_date));
        $this->db->select('bill_number');
        $this->db->from('purchase');
        $this->db->like('bill_number', 'JOB-' . date('m-d', strtotime($as_date)) . '-', 'after');
        $this->db->order_by('id', 'DESC'); 
        $this->db->limit(1);
        $query = $this->db->get();
        $last_bill = $query->row();
        if ($last_bill) {
            $last_number = (int) substr($last_bill->bill_number, -2);
            $new_number = str_pad($last_number + 1, 2, '0', STR_PAD_LEFT);
        } else {
            $new_number = '01';
        }
        return 'JOB-' . $formatted_date . '-' . $new_number;
    }

    public function getAllSalesman($id='') 
    {
        $sales_man = array(); 
        $this->db->select('user_name,user_id');
        $this->db->from("login_info");
        $this->db->where('user_type','salesman');
        if ($id) {
            $this->db->where('user_id',$id);
        }else{
            $this->db->where('status',1);
        }
        $query = $this->db->get();


        if ($id) {
            foreach ($query->result_array() as $row) 
            {

                $sales_man=$row;
            }
        }
        else
        {
            foreach ($query->result_array() as $row) 
            {

                $row['enc_id']=$this->Base_model->encrypt_decrypt('encrypt',$row['user_id']);

                $sales_man[]=$row;
            }
        }

        return $sales_man;
    }

    public function getSaleCount()
    {
        $this->db->select('*');
        $this->db->from('job_details');
        $count = $this->db->count_all_results();
        return $count;
    }


    public function getAllJobAjax( $search_arr =[],$count = 0) 
    {
        $row = $search_arr['start'];
        $rowperpage = $search_arr['length'];
        $this->db->select('*');
        $searchValue = $search_arr['search']['value']; 
        if('' != $searchValue) { 
            $where = "(name LIKE '%$searchValue%' 
            OR  barcode LIKE '%$searchValue%')"; 
            $this->db->where($where);
        }

        if( $job_id =  element('job_id', $search_arr) ){
            $this->db->where('job_id', $job_id);
        }

        if( $status =  element('status', $search_arr) ){
            $this->db->where('status', $status);
        }

        if( $salesman =  element('salesman', $search_arr) ){
            $this->db->where('salesman_id', $salesman);
        }
        $this->db->from('job_details')
        ->order_by( 'id', 'ASC' );


        if($count) {
            return $this->db->count_all_results();
        }
        $this->db->limit($rowperpage, $row);
        $query = $this->db->get(); 


        $details = [] ;
        $i=1;
        foreach ($query->result_array() as $row) {


            $row['index'] =$search_arr['start']+$i;
            $row['enc_id']=$this->encrypt_decrypt('encrypt',$row['id']);
            $row['category_name']=$this->Base_model->getCategoryName($row['categories']);
            $row['product_name']=$this->Base_model->getProductName($row['products']);
            $row['purchase_date'] = date('d-m-Y', strtotime($row['created_date']));
            $row['vehicle_name'] = $this->Base_model->getVehicleName($row['vehicle_id']);
            $row['user_name'] = $this->Base_model->getUserName($row['salesman_id']);
            $details[] = $row;
            $i++;
        }
        return $details;
    }


}