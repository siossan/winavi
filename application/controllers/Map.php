<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Map extends MY_Controller {

    public function __construct() {
        parent::__construct();

        // Ideally you would autoload the parser
//        $this->load->library('parser');
    }

    public function cesiumForm() {
        $this->view('map/cesium/form');
    }
    
    public function olForm() {
        $this->view('map/ol/form');
    }
    
    public function googleForm() {
        $this->view('map/google/form');
    }
    
}
