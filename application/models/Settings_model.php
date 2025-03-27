<?php  defined('BASEPATH') OR exit('No direct script access allowed');

class Settings_model extends Base_model {

    function __construct() {
        parent::__construct();

    }

    public function updateWebisteInfo($data) {
        $this->db->set('name', $data['website_name']);
        $this->db->set('address', $data['address']);
        $this->db->set('email', $data['email']);
        $this->db->set('phone', $data['phone']);
        $result =  $this->db->update('site_info');
        return $result;
    }

    public function insertActivateHistory($user_id , $renewal_date , $new_renewal_date){

        $submit_date = date('Y-m-d H:i:s');
        $this->db->set('user_id',$user_id);
        $this->db->set('old_date',$renewal_date);
        $this->db->set('new_date',$new_renewal_date);
        $this->db->set('submit_date',$submit_date);
        $result = $this->db->insert('activate_history');
        return $result;

    }  

    public function insertDepartmentMaster($post_arr)
    {
        $this->db->set('dep_id',$post_arr['department_id']);
        $this->db->set('name',$post_arr['department_name']);
        $this->db->set('cost_per_hour',$post_arr['cost_per_hour']);
        $this->db->set('date_added',date('Y-m-d H:i:s'));
        $this->db->set('status',$post_arr['status']);
        $insert = $this->db->insert('department');
        return $insert;
    }

    public function getDepartmentMaster($id='',$search_arr=[] )
    {
        $details = array();
        $this->db->select('*');
        $this->db->from('department');
        if($search_arr)
        {
            if(element('status',$search_arr)=='active') {
                $this->db->where('status',1);
            }else if(element('status',$search_arr)=='inactive')
            {
                $this->db->where('status','0');
            }

            if(element('department_id',$search_arr))
            {
                $this->db->where('id',$search_arr['department_id']);
            }
            
            if(element('dep_id',$search_arr))
            {
                $this->db->where('dep_id',$search_arr['dep_id']);
            }
        }

        if($id)
        {
            $this->db->where('id',$id);
        } 

        $query = $this->db->get();
        foreach($query->result_array() as $row)
        {
            $row['enc_id'] = $this->Base_model->encrypt_decrypt('encrypt',$row['id']);
            if($id){

                $details = $row;
            }else{

                $details[] = $row;
            }
        }
        return $details;
    }
    public function getDepartments()
    {
        $details = array();
        $this->db->select('*');
        $this->db->from('department');
        $this->db->where('status',1);

        $query = $this->db->get();
        foreach($query->result_array() as $row)
           $details[]=$row;
       return $details;
   }
   public function getDepartmentID($department_name='') {
    $id = array();
    $this->db->select('dep_id');
    $this->db->from('department');
    if($department_name)
    {

        $this->db->where('name', $department_name);
    }

    $query = $this->db->get();
    foreach ($query->result_array() as $row) {
        $dep_id[]= $row['dep_id'];
    }
    return $dep_id;
}
public function updateDepartmentMaster($post_arr,$id)
{
    $this->db->set('dep_id',$post_arr['department_id']);
    $this->db->set('name',$post_arr['department_name']);
    $this->db->set('cost_per_hour',$post_arr['cost_per_hour']);
    $this->db->set('date_updated',date('Y-m-d H:i:s'));
    $this->db->set('status',$post_arr['status']);
    $this->db->where('id',$id);
    $update = $this->db->update('department');
    return $update;
}

public function updateDepartmentStatus($id)
{
    $this->db->set('status',0);
    $this->db->where('id',$id);
    $update = $this->db->update('department');
    return $update;
}

public function getSubadmin()
{
    $details = array();
    $this->db->select('user_id,user_name');
    $this->db->from('login_info');
    $this->db->where('user_type','supervisor');
    $this->db->where('status',1);
    $query = $this->db->get();
    foreach($query->result_array() as $row)
    {

        $details[] = $row;
        
    }
    return $details;
}

public function addNewVehicle($post_arr){

    $submit_date = date('Y-m-d H:i:s');
    $this->db->set('vehicle_name',$post_arr['vehicle_name']);
    $this->db->set('vehicle_number',$post_arr['vehicle_number']);
    $this->db->set('open_bal',$post_arr['open_bal']);
    $this->db->set('res_pay',$post_arr['res_pay']);
    $this->db->set('as_date',$post_arr['as_date']);
    // $this->db->set('under_group',$post_arr['under_group']);
    $this->db->set('created_date',$submit_date);
    $this->db->set('status','active');
    $result = $this->db->insert('vehicles');


    return $result;

}  


public function getOrderCount()
{
    $this->db->select('*');
    $this->db->from('vehicles');
    $count = $this->db->count_all_results();
    return $count;
}

public function getPartyCount()
{
    $this->db->select('*');
    $this->db->from('party_details');
    $count = $this->db->count_all_results();
    return $count;
}

public function getItemCount()
{
    $this->db->select('*');
    $this->db->from('products');
    $count = $this->db->count_all_results();
    return $count;
}

public function getPurchaseCount()
{
    $this->db->select('*');
    $this->db->from('purchase');
    $count = $this->db->count_all_results();
    return $count;
}


public function getAllVehiclesAjax( $search_arr =[],$count = 0) 
{


    $row = $search_arr['start'];
    $rowperpage = $search_arr['length'];

    $this->db->select('*');
    
    $searchValue = $search_arr['search']['value']; 
    if('' != $searchValue) { 
        $where = "(vehicle_name LIKE '%$searchValue%' 
        OR  vehicle_number LIKE '%$searchValue%')"; 
        $this->db->where($where);
    }

    if( $voucher_name =  element('vehicle_name', $search_arr) ){
        $this->db->where('vehicle_name', $name);
    }


    if( $vehicle_id =  element('vehicle_id', $search_arr) ){
        $this->db->where('id', $vehicle_id);
    }

    if( $status =  element('status', $search_arr) ){
        $this->db->where('status', $status);
    }



    $this->db->from('vehicles ')
    ->order_by( 'created_date', 'DESC' );


    if($count) {
        return $this->db->count_all_results();
    }
    $this->db->limit($rowperpage, $row);
    $query = $this->db->get(); 


    $details = [] ;
    $i=1;
    foreach ($query->result_array() as $row) {


        $row['index'] =$search_arr['start']+$i;
        $row['enc_vehicleid']=$this->encrypt_decrypt('encrypt',$row['id']);
        $row['created_date'] = date('Y-m-d',strtotime($row['created_date']));
        $details[] = $row;
        $i++;
    }


    return $details;
}

public function getAllPartysAjax( $search_arr =[],$count = 0) 
{
    $row = $search_arr['start'];
    $rowperpage = $search_arr['length'];
    $this->db->select('*');
    $searchValue = $search_arr['search']['value']; 
    if('' != $searchValue) { 
        $where = "(name LIKE '%$searchValue%' 
        OR  party_id LIKE '%$searchValue%')"; 
        $this->db->where($where);
    }

    if( $party_id =  element('party_id', $search_arr) ){
        $this->db->where('id', $party_id);
    }

    if( $status =  element('status', $search_arr) ){
        $this->db->where('status', $status);
    }

    if( $type =  element('type', $search_arr) ){
        $this->db->where('type', $type);
    }
    $this->db->from('party_details ')
    ->order_by( 'party_id', 'ASC' );


    if($count) {
        return $this->db->count_all_results();
    }
    $this->db->limit($rowperpage, $row);
    $query = $this->db->get(); 
    $details = [] ;
    $i=1;
    foreach ($query->result_array() as $row) {


        $row['index'] =$search_arr['start']+$i;
        $row['enc_party_id']=$this->encrypt_decrypt('encrypt',$row['id']);
        $row['vehicle_name']=$this->Base_model->getVehicleName($row['vehicle_id']);
        if ($row['type']=='1') {

            $row['type']='Purchase';
        }
        if ($row['type']=='2') {

            $row['type']='Sales';
        }
        // $row['created_date'] = date('Y-m-d',strtotime($row['created_date']));
        $details[] = $row;
        $i++;
    }
    return $details;
}


public function getAllProductsAjax( $search_arr =[],$count = 0) 
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

    if( $product_id =  element('product_id', $search_arr) ){
        $this->db->where('id', $product_id);
    }

    if( $status =  element('status', $search_arr) ){
        $this->db->where('status', $status);
    }

    if( $category_id =  element('category_id', $search_arr) ){
        $this->db->where('category', $category_id);
    }
    $this->db->from('products ')
    ->order_by( 'name', 'ASC' );


    if($count) {
        return $this->db->count_all_results();
    }
    $this->db->limit($rowperpage, $row);
    $query = $this->db->get(); 
    $details = [] ;
    $i=1;
    foreach ($query->result_array() as $row) {


        $row['index'] =$search_arr['start']+$i;
        $row['enc_product_id']=$this->encrypt_decrypt('encrypt',$row['id']);
        $row['category_name']=$this->Base_model->getCategoryName($row['category']);

        // $row['created_date'] = date('Y-m-d',strtotime($row['created_date']));
        $details[] = $row;
        $i++;
    }
    return $details;
}

public function getAllVehicleDetails($id) 
{
    $vehicle_details = array(); 
    $this->db->select('*');
    $this->db->from("vehicles");
    $this->db->where('id',$id);

    $query = $this->db->get();

    foreach ($query->result_array() as $row) 
    {

        $row['created_date'] = date('m-d-Y', strtotime($row['created_date']));
        $vehicle_details=$row;
    }
    return $vehicle_details;
}

public function getAllPartyDetails($id) 
{
    $vehicle_details = array(); 
    $this->db->select('*');
    $this->db->from("party_details");
    $this->db->where('id',$id);
    $query = $this->db->get();
    foreach ($query->result_array() as $row) 
    {
        $row['vehicle_name']=$this->Base_model->getVehicleName($row['vehicle_id']);
        $vehicle_details=$row;
    }
    return $vehicle_details;
}


public function updateVehicleDetails($post_arr,$id)
{

    $this->db->set('vehicle_name',$post_arr['vehicle_name']);
    $this->db->set('vehicle_number',$post_arr['vehicle_number']);
    $this->db->set('open_bal',$post_arr['open_bal']);
    $this->db->set('res_pay',$post_arr['res_pay']);
    $this->db->set('as_date',$post_arr['as_date']);
    $this->db->set('under_group',$post_arr['under_group']);
    $this->db->set('status',$post_arr['status']);
    $this->db->where('id',$id);
    $update = $this->db->update('vehicles');
    return $update;
}

public function addNewParty($post_arr){

    $submit_date = date('Y-m-d H:i:s');
    $this->db->set('name',$post_arr['party_name']);
    $this->db->set('party_id',$post_arr['party_id']);
    $this->db->set('mobile_number',$post_arr['phone']);
    $this->db->set('address',$post_arr['address']);
    $this->db->set('email',$post_arr['email']);
    $this->db->set('type',$post_arr['party_type']);
    $this->db->set('vehicle_id',$post_arr['vehicle_id']);
    $this->db->set('open_bal',$post_arr['open_bal']);
    $this->db->set('res_pay',$post_arr['res_pay']);
    $this->db->set('as_date',$post_arr['as_date']);
    $this->db->set('ledger_group',$post_arr['ledger_group']);
    $this->db->set('created_date',$submit_date);
    $this->db->set('status','active');
    $result = $this->db->insert('party_details');
    return $result;
}  

public function getLastPartyId() {
    $party_id = NULL;
    $this->db->select('party_id');
    $this->db->order_by('party_id', 'DESC');
    $this->db->limit(1);
    $query = $this->db->get('party_details');
    foreach ($query->result() as $row) {
        $party_id = $row->party_id;
    }
    return $party_id;
}

public function updateParty($post_arr,$id){

    $post_arr['address']=htmlentities($post_arr['address']);
    $submit_date = date('Y-m-d H:i:s');
    $this->db->set('name',$post_arr['party_name']);
    $this->db->set('mobile_number',$post_arr['phone']);
    $this->db->set('address',$post_arr['address']);
    $this->db->set('email',$post_arr['email']);
    $this->db->set('type',$post_arr['party_type']);
    $this->db->set('vehicle_id',$post_arr['vehicle_id']);
    $this->db->set('open_bal',$post_arr['open_bal']);
    $this->db->set('res_pay',$post_arr['res_pay']);
    $this->db->set('as_date',$post_arr['as_date']);
    $this->db->set('ledger_group',$post_arr['ledger_group']);
    $this->db->set('status',$post_arr['status']);
    $this->db->where('id',$id);
    $result = $this->db->update('party_details');
    return $result;
}  

public function getMaxCatId() {
    $id = NULL;
    $this->db->select_max('id');
    $this->db->from('category');
    $this->db->limit(1);
    $query = $this->db->get();
    foreach ($query->result() as $row) {
        $id = $row->id;
    }
    return $id;
}

public function addNewCategory($post_arr){

    $submit_date = date('Y-m-d H:i:s');
    $this->db->set('category_name',$post_arr['name']);
    $this->db->set('code',$post_arr['code']);
    $this->db->set('tax',$post_arr['tax']);
    $this->db->set('date',$submit_date);
    $this->db->set('status','active');
    $result = $this->db->insert('category');
    return $result;

}  

public function getAllCategoryDetails($id='') 
{
    $category_details = array(); 
    $this->db->select('*');
    $this->db->from("category");
    if ($id) {
        $this->db->where('id',$id);
    }else{
        $this->db->where('status','active');
    }
    $query = $this->db->get();
    if ($id) {
        foreach ($query->result_array() as $row) 
        {

            $category_details=$row;
        }
    }
    else
    {
        foreach ($query->result_array() as $row) 
        {
            $row['date']=date('Y-m-d',strtotime($row['date']));
            $row['enc_id']=$this->Base_model->encrypt_decrypt('encrypt',$row['id']);

            $category_details[]=$row;
        }
    }
    return $category_details;
}

public function updateCategoryDetails($post_arr,$id)
{

    $this->db->set('category_name',$post_arr['name']);
    $this->db->set('tax',$post_arr['tax']);
    $this->db->set('status',$post_arr['status']);
    $this->db->where('id',$id);
    $update = $this->db->update('category');
    return $update;
}

public function getTaxByCategory($category_id) 
{
    $tax = 0;
    $this->db->select('tax');
    $this->db->from('category');
    $this->db->where('id', $category_id);
    $this->db->limit(1);
    $query = $this->db->get();
    foreach ($query->result() as $row) {
        $tax = $row->tax;
    }
    return $tax;
}

public function addNewItem($post_arr){

    $submit_date = date('Y-m-d H:i:s');
    $this->db->set('barcode',$post_arr['bar_code']);
    $this->db->set('name',$post_arr['name']);
    $this->db->set('type',$post_arr['type']);
    $this->db->set('category',$post_arr['category']);
    $this->db->set('sales_rate',$post_arr['sales_rate']);
    // $this->db->set('as_date',$post_arr['as_date']);
    $this->db->set('created_date',$submit_date);
    $this->db->set('status','active');
    $result = $this->db->insert('products');


    return $result;

} 

public function getAllitemDetails($id) 
{
    $vehicle_details = array(); 
    $this->db->select('*');
    $this->db->from("products");
    $this->db->where('id',$id);
    $query = $this->db->get();
    foreach ($query->result_array() as $row) 
    {
        $row['category_name']=$this->Base_model->getCategoryName($row['category']);
        $vehicle_details=$row;
    }
    return $vehicle_details;
}


public function updateItem($post_arr,$id){


    $this->db->set('barcode',$post_arr['bar_code']);
    $this->db->set('name',$post_arr['name']);
    $this->db->set('type',$post_arr['type']);
    $this->db->set('category',$post_arr['category']);
    // $this->db->set('as_date',$post_arr['as_date']);
    $this->db->set('status',$post_arr['status']);
    $this->db->where('id',$id);
    $result = $this->db->update('products');
    return $result;

} 


public function generateBillNumber($as_date) {
    
    $formatted_date = date('m-d-Y', strtotime($as_date));
    $this->db->select('bill_number');
    $this->db->from('purchase');
    $this->db->like('bill_number', 'BLL-' . date('m-d', strtotime($as_date)) . '-', 'after');
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
    return 'BLL-' . $formatted_date . '-' . $new_number;
}



public function addPurchaseProducts($post_arr){

   foreach ($post_arr['products'] as $product) {
    $purchase=false;

    $data = [
        'bill_number'      => $post_arr['bill_number'],
        'product_id'      => $product['product_id'],
        'category_id'     => $product['category_id'],
        'purchase_rate'   => $product['purchase_rate'],
        'party_id'   => $product['party_id'],
        'invoice_number'   => $post_arr['invoice_number'],
        // 'sale_rate'       => $product['sale_rate'],
        'tax'       => $product['tax'],
        'mrp'            => $product['mrp'],
        'stock'        => $product['quantity'],
        'status'        => 'active',
        'date_created'   => $post_arr['as_date'],
        'date_updated'   => date('Y-m-d H:i:s'),
    ];

    $purchase=$this->db->insert('purchase', $data);

}
return $purchase;

}


public function getAllPurchaseAjax( $search_arr =[],$count = 0) 
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

    if( $bill_id =  element('bill_id', $search_arr) ){
        $this->db->where('bill_number', $bill_id);
    }

    if( $status =  element('status', $search_arr) ){
        $this->db->where('status', $status);
    }

    if( $category_id =  element('category_id', $search_arr) ){
        $this->db->where('category_id', $category_id);
    }
    $this->db->from('purchase ')
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
        $row['enc_item_id']=$this->encrypt_decrypt('encrypt',$row['id']);
        $row['category_name']=$this->Base_model->getCategoryName($row['category_id']);
        $row['product_name']=$this->Base_model->getProductName($row['product_id']);
        $row['sale_rate']=$this->Base_model->getSaleRate($row['product_id']);
        $row['purchase_date'] = $row['date_created'];
        $details[] = $row;
        $i++;
    }
    return $details;
}





}