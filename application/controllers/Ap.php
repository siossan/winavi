<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Ap extends MY_Controller {

    public function __construct() {
        parent::__construct();

        // Ideally you would autoload the parser
//        $this->load->library('parser');
    }

    public function aplist() {
        $this->load->model('Aps_model', '', TRUE);
        $this->load->model('Evaluations_model', '', TRUE);
        $result = $this->Aps_model->getAps();
        // 評価取得
        foreach ($result as $k => $v) {
            $goodcount = $this->Evaluations_model->getTypeCountByApId($v['ap_id'], 1);
            $result[$k]['good'] = $goodcount;
            $badcount = $this->Evaluations_model->getTypeCountByApId($v['ap_id'], 2);
            $result[$k]['bad'] = $badcount;
            $notFndCount = $this->Evaluations_model->getTypeCountByApId($v['ap_id'], 3);
            $result[$k]['not_found'] = $notFndCount;

            if ($notFndCount > 5 && $result[$k]['is_opendata'] == 0) {
                unset($result[$k]);
            }
        }

        $this->smarty->assign('list', $result);
        $this->smarty->assign('talk', $this->lang->line('hello'));

        $this->view('ap/aplist');
    }

    public function evaluation($type, $id) {
        $this->load->model('Evaluations_model', '', TRUE);
        $result = $this->Evaluations_model->setEvaluation($id, $type, $_SERVER['HTTP_USER_AGENT']);
        redirect('https://' . $_SERVER['HTTP_HOST'] . '/winavi/ap/aplist');
    }

    public function add() {

        $this->load->model('Aps_model', '', TRUE);
        $result = $this->Aps_model->getAps();

        $this->smarty->assign('list', $result);


        $this->view('ap/add');
    }

    public function accept() {
        $this->load->model('Aps_model', '', TRUE);
        $req = 'http://www.finds.jp/ws/rgeocode.php?json';
        $req .= '&lat=43.08289968346561';
        $req .= '&lon=141.3471322830471';
        $json = file_get_contents($req);
        $json = mb_convert_encoding($json, 'UTF8', 'ASCII,JIS,UTF-8,EUC-JP,SJIS-WIN');
        $result = json_decode($json, true);

        if ($result['status'] == 200 || $result['status'] == 201 || $result['status'] == 202) {
            $prefecture = $result['result']['prefecture']['pname'];
            $city = $result['result']['municipality']['mname'];
            if (!empty($result['result']['local']['0']['section'])) {
                $location = $result['result']['local']['0']['section'];
            } else {
                $location = '';
            }

            $address = $prefecture . $city . $location;
        }

        // 自動翻訳（マイクロソフト）
        $access_token = $this->getAccessToken("MinaVi", "axz4I4ym7trCLS4RSt3eaNc5FPHo0X1wYci7M8WdXyE=")->access_token;

        $locName = $_POST['location_name'];
        $params = array('text' => $locName, 'to' => 'en', 'from' => 'ja');
        $locNameEn = $this->Translator($access_token, $params);

        $params = array('text' => $address, 'to' => 'en', 'from' => 'ja');
        $addrEn = $this->Translator($access_token, $params);

        $memo = $_POST['memo'];
        $params = array('text' => $memo, 'to' => 'en', 'from' => 'ja');
        $memoEn = $this->Translator($access_token, $params);


        $result = $this->Aps_model->setAp($prefecture, $city, $location, $_POST['location_name'], $address, $_POST['lon'], $_POST['lat'], $memo, $addrEn, $locNameEn, $memoEn);

        $this->add();
    }

    function getAccessToken($client_id, $client_secret) {
        $ch = curl_init();
        curl_setopt_array($ch, array(
            CURLOPT_URL => "https://datamarket.accesscontrol.windows.net/v2/OAuth2-13/",
            CURLOPT_SSL_VERIFYPEER => false,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POST => true,
            CURLOPT_POSTFIELDS => http_build_query(array(
                "grant_type" => "client_credentials",
                "scope" => "http://api.microsofttranslator.com",
                "client_id" => $client_id,
                "client_secret" => $client_secret
            ))
        ));
        return json_decode(curl_exec($ch));
    }

    /* 肝心の翻訳君 */

    function Translator($access_token, $params) {
        $ch = curl_init();
        curl_setopt_array($ch, array(
            CURLOPT_URL => "https://api.microsofttranslator.com/v2/Http.svc/Translate?" . http_build_query($params),
            CURLOPT_SSL_VERIFYPEER => false,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_HEADER => true,
            CURLOPT_HTTPHEADER => array(
                "Authorization: Bearer " . $access_token),
        ));
        preg_match('/>(.+?)<\/string>/', curl_exec($ch), $m);
        return $m[1];
    }

    function getaps($lon = null, $lat = null) {
        $this->load->model('Aps_model', '', TRUE);

        if (!empty($lon) && !empty($lat)) {
            $result = $this->Aps_model->getApsDistOnekm($lon, $lat);
        } else {
            $result = $this->Aps_model->getAps();
        }
        header("Content-Type: application/json; charset=utf-8");



        echo $this->json_xencode($result);
        exit;
    }

    /**
     * PHP5.4からでないと対応していないUnicodeアンエスケープをPHP5.3でもできるようにしたラッパー関数
     * @param mixed   $value
     * @param int     $options
     * @param boolean $unescapee_unicode
     */
    function json_xencode($value, $options = 0, $unescapee_unicode = true) {
        $v = json_encode($value, $options);
        if ($unescapee_unicode) {
            $v = $this->unicode_encode($v);
            // スラッシュのエスケープをアンエスケープする
            $v = preg_replace('/\\\\\//', '/', $v);
        }
        return $v;
    }

    /**
     * Unicodeエスケープされた文字列をUTF-8文字列に戻す。
     * 参考:http://d.hatena.ne.jp/iizukaw/20090422
     * @param unknown_type $str
     */
    function unicode_encode($str) {

        return preg_replace_callback("/\\\\u([0-9a-zA-Z]{4})/", array(get_class($this), 'encode_callback'), $str);
    }

    function encode_callback($matches) {
        return mb_convert_encoding(pack("H*", $matches[1]), "UTF-8", "UTF-16");
    }

}
