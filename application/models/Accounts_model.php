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
            'date'          => date('Y-m-d H:i:s') // Assuming you want to insert the current timestamp
        ];

        $this->db->insert('accounts', $data);
        $res= $this->db->insert_id();
        if ($res){
        	$this->Base_model->updateWalletBalance($post_arr['amount'],$post_arr['wallet_type']);
        }
        return $res; // Return the inserted row ID
    }

    return false; // Return false if the input array is empty
}
public function getAllAccountHistory()
{
    $query = $this->db->get('accounts'); // Fetch all records from the accounts table
    return $query->result_array(); // Return the result as an array
}


}