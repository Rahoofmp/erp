<?php  defined('BASEPATH') OR exit('No direct script access allowed');

class Jobs_model extends Base_model {

    function __construct() {
        parent::__construct();

    }



    public function getItemsCount($salesman_id='')
    {
        $this->db->select('*');
        $this->db->from('job_details');
        if($salesman_id)
        {
            $this->db->where('salesman_id',$salesman_id);
        }
        $count = $this->db->count_all_results();
        return $count;
    }

    public function getAllItemsAjax($search_arr = [], $count = 0) {
        $row = $search_arr['start'];
        $rowperpage = $search_arr['length'];

        $this->db->select('*');
        $this->db->from('job_details');
        $this->db->where('salesman_id', log_user_id());

        if ($category_id = element('category_id', $search_arr)) {
            $this->db->where('categories', $category_id);
        }

        if ($product_id = element('product_id', $search_arr)) {
            $this->db->where('products', $product_id);
        }

        if ($status = element('status', $search_arr)) {
            $this->db->where('status', $status);
        }

        $this->db->order_by('id', 'ASC');

        if ($count) {
            return $this->db->count_all_results();
        }

        $this->db->limit($rowperpage, $row);
        $query = $this->db->get();

        $details = [];
        $i = 1;
        foreach ($query->result_array() as $row) {
            $row['index'] = $search_arr['start'] + $i;
            $product_details = $this->getProductDetails($row['products']);
            $row['product_name'] = $product_details['name'];
            $row['sale_rate'] = $product_details['sale_rate'];
            $row['mrp'] = $product_details['mrp'];
            $row['barcode'] = $product_details['barcode'];
            $row['enc_item_id'] = $this->encrypt_decrypt('encrypt', $row['id']);
            $row['category_name'] = $this->Base_model->getCategoryName($row['categories']);
            $details[] = $row;
            $i++;
        }
        return $details;
    }




    public function getProductDetails($id='') 
    {
        $product_details = array(); 
        $this->db->select('*');
        $this->db->from("products");
        $this->db->where('id',$id);
        $query = $this->db->get();

        foreach ($query->result_array() as $row) 
        {

            $product_details=$row;
        }

        return $product_details;
    }



}