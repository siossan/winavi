<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

class MY_Controller extends CI_Controller
{
	protected $template;
	
	public $userTableName = 'users';
	public $newsTableName = 'articles';
	
	function __construct()
	{
		try {
			parent::__construct();
			$this->load->library('session');
			$this->load->database();
			
                        $lang = $this->lang->load('default','japan', TRUE);
                        $this->smarty->assign('lang', $lang);
                        
			// Smarty setting.
			$this->smarty->template_dir = APPPATH . 'views/templates';
			$this->smarty->compile_dir  = APPPATH . 'views/templates_c';
			$this->template = 'layout.tpl';

			// auto loading config data.
			// /application/config/config.php
			// /application/config/my_custom_config.php
			$conf = $this->config->getAll();
			if (!empty($conf)) {
				$this->smarty->assign('config', $conf);
			}
		} catch (Exception $e) {
			$this->utils->outputExceptionMessage($e);
		}
	}
	
	public function view($template)
	{
		//$this->template = $template;
		$this->template = $template . '.tpl';
	}

	public function _output($output)
	{
		if (strlen($output) > 0) {
			echo $output;
		} else {
			$this->smarty->display($this->template); 
		}
	}
}
