<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

class MY_Form_validation extends CI_Form_validation
{
	function __construct($config = array())
	{
		parent::__construct($config);
	}
	
	public function getValues()
	{
		$result = array();
		foreach ($this->_field_data as $key => $val) {
			$result[$key] = !is_array($val['postdata']) ? $val['postdata'] : implode("\0", $val['postdata']);
		}
		
		return $result;
	}
}