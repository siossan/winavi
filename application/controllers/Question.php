<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Question extends MY_Controller {

    public function __construct() {
        parent::__construct();

        // Ideally you would autoload the parser
//        $this->load->library('parser');
    }
    
    
    public function questions(){
        
    }
    
    public function form(){
$this->load->model('Questions_model', '', TRUE);
$result = $this->Questions_model->getQuestionById($_GET['question_id']);


foreach ($result as $row)
{
$this->smarty->assign('emeFlg', $row['eme_flg']); 
$this->smarty->assign('lon', $row['starting_point_lon']); 
$this->smarty->assign('lat', $row['starting_point_lat']); 
}

        $this->view('question/form');
    }
    
    public function start(){
        
    }
    
    public function end(){
        
    }
    
    public function add(){
        
    }

    public function qlist(){
        $this->view('question/qlist');
    }
}
    