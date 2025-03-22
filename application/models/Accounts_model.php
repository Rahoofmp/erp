<?php  defined('BASEPATH') OR exit('No direct script access allowed');

class Accounts_model extends Base_model {

	function __construct() {
		parent::__construct();

	}
	public function insertAccountDetails($post_arr = [])
	{
		if (!empty($post_arr)) {
			$data = [
				'amount'        => $post_arr['amount'],
				'transfer_type' => $post_arr['transfer_type'],
				'type'          => $post_arr['type'],
				'remarks'       => $post_arr['remarks'],
				'done_by'       => $post_arr['done_by'],
				'date'          => date('Y-m-d H:i:s') 
			];

			$this->db->insert('accounts', $data);
			$res= $this->db->insert_id();
			if ($res){
				$this->Base_model->updateWalletBalance($post_arr['amount'],$post_arr['wallet_type']);
			}
			return $res; 
		}

		return false; 
	}
	public function getAllAccountHistory()
	{
		$query = $this->db->get('accounts'); 
		return $query->result_array(); 
	}

	public function getEntryCount()
	{
		$this->db->select('*');
		$this->db->from('accounts');
		$count = $this->db->count_all_results();
		return $count;
	}

	public function getAllEntrysAjax($search_arr = [], $count = 0) {
		$row = $search_arr['start'];
		$rowperpage = $search_arr['length'];

		$this->db->select('*');

		$searchValue = $search_arr['search']['value']; 
		if('' != $searchValue) { 
			$where = "(amount LIKE '%$searchValue%' 
			OR  transfer_type LIKE '%$searchValue%')"; 
			$this->db->where($where);
		}


		$this->db->from('accounts');
		

		// if ($category_id = element('category_id', $search_arr)) {
		// 	$this->db->where('categories', $category_id);
		// }

		// if ($product_id = element('product_id', $search_arr)) {
		// 	$this->db->where('products', $product_id);
		// }

		// if ($status = element('status', $search_arr)) {
		// 	$this->db->where('status', $status);
		// }

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
			$row['date']=date( 'd-m-Y', strtotime($row['date']));
			$row['enc_entry_id'] = $this->encrypt_decrypt('encrypt', $row['id']);
			$row['done_name'] = $this->Base_model->getUserName($row['done_by']);
			$details[] = $row;
			$i++;
		}
		return $details;
	}



}