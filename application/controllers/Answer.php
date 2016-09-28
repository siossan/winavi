<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Answer extends MY_Controller {

    public function __construct() {
        parent::__construct();

        // Ideally you would autoload the parser
//        $this->load->library('parser');
    }
    
    public function form(){
        
    }
    
    public function add(){
        
    }
    
    public function result(){

$this->smarty->assign('lon', $_POST['slon']); 
$this->smarty->assign('lat', $_POST['slat']);
$this->smarty->assign('elon', $_POST['elon']); 
$this->smarty->assign('elat', $_POST['elat']);  
$this->smarty->assign('dist', $_POST['dist']);  
$this->smarty->assign('time', $_POST['time']);
$this->smarty->assign('emeFlg', $_POST['eme_flg']);
$this->load->model('Questions_model', '', TRUE);
$this->Questions_model->setAnswer($_POST['slon'],$_POST['slat'],$_POST['elon'],$_POST['elat'],'hogehoge', $_POST['dist'], $_POST['time']);
        $this->view('answer/result');
    }

    public function qlist(){
        $this->view('answer/qlist');
    }
    
}
