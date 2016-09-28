<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Evaluations_model extends CI_Model {

    public function __construct() {
        parent::__construct();

        // 独自処理
    }

    public function getAps() {
        $sql = 'SELECT * FROM aps';
        $query = $this->db->query($sql);
        if ($query) {
            // 成功処理
            $result = $query->result('array');
            return $result;
        } else {
            // 失敗処理
            return false;
        }
    }

    public function getTypeCountByApId($id, $type) {
        $params = array($id, $type);
        $sql = 'SELECT COUNT(*) AS num FROM evaluations WHERE ap_id = ? AND type = ?';
        $query = $this->db->query($sql, $params);
        if ($query) {
            // 成功処理
            $result = $query->result('array');
            
            if(!empty($result)){
                return $result[0]['num'];
            }
            
            return 0;
        } else {
            // 失敗処理
            return false;
        }
    }

    public function setEvaluation($id, $type, $info) {
        $params = array(
            'ap_id' => $id,
            'type' => $type,
            'user_info' => $info,
            'm_datetime' => date('Y-m-d h:i:s'),
            'r_datetime' => date('Y-m-d h:i:s'),
        );

        $sql = $this->db->insert_string('evaluations', $params);
        if ($this->db->query($sql)) {
            // 成功処理
            return true;
        } else {
            // 失敗処理
            return false;
        }
    }

}

?>
