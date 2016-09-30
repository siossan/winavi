<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Aps_model extends CI_Model {

    public function __construct() {
        parent::__construct();

        // 独自処理
    }

    public function getAps() {
        $sql = 'SELECT ap_id, location_name, location_name_en, address, address_en, memo, memo_en, is_opendata, x, y FROM aps';
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

    public function setAp($pre, $city, $loc, $locName, $add, $x, $y, $memo, $addEn = '', $locNameEn = '', $memoEn = '') {
        $params = array(
            'local_group' => $pre,
            'prefecture' => $pre,
            'city' => $city,
            'location' => $loc,
            'address' => $add,
            'location_name' => $locName,
            'memo' => $memo,
            'x' => (double) $x,
            'y' => (double) $y,
            'address_en' => $addEn,
            'location_name_en' => $locNameEn,
            'memo_en' => $memoEn,
        );

        $sql = $this->db->insert_string('aps', $params);
        if ($this->db->query($sql)) {
            // 成功処理
            return true;
        } else {
            // 失敗処理
            return false;
        }
    }
    
    
    public function getApsDistOnekm($lon, $lat) {
        $params = array($lat, $lon);
        $sql = "SELECT ap_id, location_name, location_name_en, address, address_en, memo, memo_en, is_opendata, x, y FROM aps WHERE "
                . " GLENGTH(GEOMFROMTEXT( CONCAT('LINESTRING(',y,' ',x,',',?,' ',?, ')' )))  <= 0.008";
        $query = $this->db->query($sql, $params);
        if ($query) {
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
