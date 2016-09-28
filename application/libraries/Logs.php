<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Logs 
{
	function __construct()
	{

	}
	
	/**
	 * アクセスホストの取得
	 * 
	 * @return
	 */
	private function getHost()
	{
		if (!empty($_SERVER['REMOTE_ADDR'])) {
			$addr = $_SERVER['REMOTE_ADDR'];

			return $addr ? gethostbyaddr($addr) : null;
		}

		return false;
	}
	
	/**
	 * ログ書き出し
	 * 
	 * @param	string	$string
	 * @param	string	$directory
	 * @return
	 */
	public function _writeLog($string = '', $directory = null)
	{
		$log = date('Y-m-d H:i:s') . "\t" . self::getHost() . "\t" . $string . "\n";
		
		if (is_null($directory) && file_exists(APPPATH . 'logs/')) {
			$directory = APPPATH . 'logs/';
		} else {
			return false;
		}
		if ($directory) {
			$fh = fopen($directory . date('Ymd') . '.log', 'a');
			fputs($fh, $log);
			fclose($fh);
			@chmod($directory . date('Ymd') . '.log', 0777);
		}
	}
	
	public function writeLog($var, $name = '')
	{
		self::_writeLog(($name ? sprintf('%s : ', $name) : '') . var_export($var, true));
	}
}