<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Questions_model extends CI_Model {

    public function __construct() {
        parent::__construct();

        // 独自処理
    }
    
    public function getTests(){
        $sql = 'SELECT * FROM test';
        $query = $this->db->query($sql);
        if ($this->db->query($sql)) {
            // 成功処理
            $result = $query->result('array');
            return $result;
        } else {
            // 失敗処理
            return false;
        }
    }

    
    public function setAnswer($sLon,$sLat, $eLon,$eLat, $ename, $dist, $time){
        $params = array(
            'start_point_lon' => (double)$sLon,
            'start_point_lat' => (double)$sLat,
            'end_point_lon' => (double)$eLon,
            'end_point_lat' => (double)$eLat,
            'end_name' => $ename,
            'dist' => $dist,
            'time' => $time,
        );

        $sql = $this->db->insert_string('answers', $params);
        if ($this->db->query($sql)) {
            // 成功処理
            return true;
        } else {
            // 失敗処理
            return false;
        }
    }

    public function getQuestionById($qId) {
        $sql = 'SELECT * FROM questions WHERE question_id = '.$qId;
        $query = $this->db->query($sql);
        if ($this->db->query($sql)) {
            // 成功処理
            $result = $query->result('array');
            return $result;
        } else {
            // 失敗処理
            return false;
        }
    }

}

?>
