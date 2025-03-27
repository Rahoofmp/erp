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
        $this->db->where('saled_quantities >', 0);


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
            $product_details = $this->getSalesProductDetails($row['products']);

            $row['product_name'] = $product_details['name'];
            $row['sale_rate'] = $product_details['sales_rate'];
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
    public function getSalesProductDetails($id='') 
    {
        $product_details = array(); 
        $this->db->select('pd.*');
        $this->db->select('pr.mrp,pr.sale_rate,pr.purchase_rate');
        $this->db->from("products as pd");
        $this->db->join("purchase as pr","pr.product_id=pd.id");
        $this->db->where('pd.id',$id);
        $query = $this->db->get();

        foreach ($query->result_array() as $row) 
        {

            $product_details=$row;
        }

        return $product_details;
    }


    public function getLoadeditemDetails($id='') 
    {
        $item_details = array(); 
        $this->db->select('*');
        $this->db->from("job_details");
        $this->db->where('id',$id);
        $query = $this->db->get();

        foreach ($query->result_array() as $row) 
        {

            $item_details=$row;
        }

        return $item_details;
    }

    public function updateSale($post_arr, $id)
    {
        if (!empty($post_arr['sale_count'])) {
            $this->db->set('sale_count', 'sale_count + ' . $post_arr['sale_count'], false);
        }
        if (!empty($post_arr['sale_price'])) {
            $this->db->set('sale_price', $post_arr['sale_price']);
        }
        if (!empty($post_arr['damage_count'])) {
            $this->db->set('damage_count', 'damage_count + ' . $post_arr['damage_count'], false);
        }
        if (!empty($post_arr['reason'])) {
            $this->db->set('reason', $post_arr['reason']);
        }
        $this->db->set('modified_date',date('Y-m-d'));
        $this->db->where('id',$id);
        return $this->db->update('job_details');
        
    }    
    public function insertPendingSale($post_arr, $id)
    {

        if (!empty($post_arr['sale_count'])) {
            $this->db->set('sale_count', $post_arr['sale_count']);
            
        }
        if (!empty($post_arr['sale_price'])) {
            $this->db->set('sale_price', $post_arr['sale_price']);
        }
        if (!empty($post_arr['damage_count'])) {
            $this->db->set('damage_count', $post_arr['damage_count']);
        }
        if (!empty($post_arr['reason'])) {
            $this->db->set('reason', $post_arr['reason']);
        }
        $this->db->set('type', $post_arr['type']);
        $this->db->set('modified_date',date('Y-m-d'));
        $this->db->set('ref_id',$id);
        $this->db->set('status','pending');
        $this->db->set('salesman_id',$post_arr['salesman_id']);

        return $this->db->insert('pending_sales');
        
    }




    public function reduceItemcount($post_arr, $id)
    {
        $update_expression = 'saled_quantities';

        if (!empty($post_arr['sale_count'])) {
            $update_expression .= ' - ' . $post_arr['sale_count'];
        }

        if (!empty($post_arr['damage_count'])) {
            $update_expression .= ' - ' . $post_arr['damage_count'];
        }

        if ($update_expression !== 'saled_quantities') {
            $this->db->set('saled_quantities', $update_expression, false);
            $this->db->where('id', $id);
            return $this->db->update('job_details');
        }

        return false; 
    }

    public function getSalesCount($salesman_id='')
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

    public function getAllSalesAjax($search_arr = [], $count = 0) {
        $row = $search_arr['start'];
        $rowperpage = $search_arr['length'];

        $this->db->select('jb.id, jb.job_id, jb.salesman_id,jb.categories,jb.products,jb.sale_count,jb.sale_price,jb.quantities, ps.status');
        $this->db->from('job_details jb');
        $this->db->join("pending_sales as ps","ps.ref_id=jb.id");
        $this->db->where('jb.salesman_id', log_user_id());


        if ($job_id = element('job_id', $search_arr)) {
            $this->db->where('jb.job_id', $job_id);
        }

        if ($status = element('status', $search_arr)) {
            $this->db->where('ps.status', $status);
        }
        $this->db->group_by('ps.ref_id');
        $this->db->order_by('jb.id', 'ASC');

        if ($count) {
            return $this->db->count_all_results();
        }

        $this->db->limit($rowperpage, $row);
        $query = $this->db->get();

        $details = [];
        $i = 1;
        foreach ($query->result_array() as $row) {
            $row['index'] = $search_arr['start'] + $i;
            $product_details = $this->getSalesProductDetails($row['products']);
            $row['product_name'] = $product_details['name'];
            $row['sale_rate'] = $product_details['sales_rate'];
            $row['mrp'] = $product_details['mrp'];
            $row['barcode'] = $product_details['barcode'];
            $row['enc_item_id'] = $this->encrypt_decrypt('encrypt', $row['id']);
            $row['category_name'] = $this->Base_model->getCategoryName($row['categories']);
            $details[] = $row;
            $i++;
        }
        return $details;
    }



}