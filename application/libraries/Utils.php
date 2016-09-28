<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$logClassFile = dirname(__FILE__) . '/Logs.php';
require_once $logClassFile;

class Utils extends Logs
{
	function __construct()
	{

	}
	
	/**
	 * ランダム文字列生成
	 * @param type $nLengthRequired
	 * @return string
	 */
	public function getRandomString($nLengthRequired = 8)
	{
		$sCharList = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_@-!?";
		mt_srand();
		$sRes = '';
		for($i = 0; $i < $nLengthRequired; $i++) {
			$sRes .= $sCharList{mt_rand(0, strlen($sCharList) - 1)};
		}

		return $sRes;
	}
	
	/**
	 * 色コードを変換(#FFFFFF -> 255 255 255)
	 * @param string $rgb
	 * @return array
	 */
	public function convertColorCodeHexToDec($rgb = '#FFFFFF')
	{
		$rgbCode = ltrim($rgb, '#');
		$tmp = str_split($rgbCode, 2);
		$code = array();
		if (!empty($tmp) && is_array($tmp)) {
			$code = array(
				'r'	=> hexdec($tmp[0]),
				'g'	=> hexdec($tmp[1]),
				'b'	=> hexdec($tmp[2])
			);
			
			return $code;
		}
		
		return false;
	}
	
	/**
	 * リダイレクト処理
	 * @param String $url
	 */
	public function redirect($url = '')
	{
		// get custom config data. (/application/config/my_custom_config.php)
		$host = $this->config->get('url');
		header(sprintf("Location: %s%s", $host, $url));
		
		exit;
	}
	
	// クライアントのIPアドレスを取得する
	public function getClientIp($isRemote = false)
	{
		/*
		 *  プロキシサーバ経由の場合は、プロキシサーバではなく
		 *  接続もとのIPアドレスを取得するために、サーバ変数
		 *  HTTP_CLIENT_IP および HTTP_X_FORWARDED_FOR を取得する。
		 */
		if (!empty($_SERVER["HTTP_CLIENT_IP"])) {
			//check for ip from share internet
			$ip = $isRemote ? $_SERVER["HTTP_CLIENT_IP"] : gethostbyaddr($_SERVER['HTTP_CLIENT_IP']);
		} elseif (!empty($_SERVER["HTTP_X_FORWARDED_FOR"])) {
			// Check for the Proxy User
			$ip = $isRemote ? $_SERVER["HTTP_X_FORWARDED_FOR"] : gethostbyaddr($_SERVER['HTTP_X_FORWARDED_FOR']);
		} else {
			$ip = $isRemote ? $_SERVER['REMOTE_ADDR'] : gethostbyaddr($_SERVER['REMOTE_ADDR']);
		}

		return $ip;
	}
	
	/**
	 * CSV出力　
	 * 
	 * @param String    $callBack
	 * @param Object   $params
	 * @param String    $fileName
	 */
	public function outputCsvData($callBack, $params = null, $fileName = '')
	{
		define('CSV_DATA_HEADER_ERROR', 'csv data header error!!');
		define('CSV_CALLBACK_DATA_ERROR', 'csv callback data error!!');
		define('CSV_CALLABLE_ERROR', 'csv callable error!!');
		
		try {
			$file  = array();
			if (is_callable($callBack)) {
				// コールバック関数読み出し
				$datas = call_user_func($callBack, $params);
				if (!empty($datas)) {
					// header set
					if (!empty($datas['header'])) {
						// 縦軸No
						$tmp = '';
						for ($i = 0; $i < count($datas['header']); $i++) {
							$headerData = mb_convert_encoding($datas['header'][$i], 'sjis-win', 'utf-8');
							$tmp .= sprintf('"%s",', $headerData);
						}
						// ヘッダーセット
						$file = rtrim($tmp,',') ."\r\n";
					} else {
						throw new Exception(CSV_DATA_HEADER_ERROR);
					}

					//body set
					if (!empty($datas['body'])) {
						$tmp = '';
						foreach ($datas['body'] as $body) {
							for ($i = 0; $i < count($body); $i++) {
								// 横軸No
								$bodyData = mb_convert_encoding($body[$i], 'sjis-win', 'utf-8');
								$tmp .= sprintf('"%s",', $bodyData);
							}
							$tmp = rtrim($tmp,',') . "\r\n";
						}
						// Bodyセット
						$file .= $tmp;
					} else {
						throw new Exception(CSV_DATA_BODY_ERROR);
					}
					header('Content-Type: application/octet-stream');
					header('Content-Disposition: attachment; filename=' . $fileName);

					echo $file;
					exit;
				} else {
					self::writeLog('### callback data is empty.');
					throw new Exception(CSV_CALLBACK_DATA_ERROR);
				}
			} else {
				self::writeLog($callBack, '### callable error!!');
				throw new Exception(CSV_CALLABLE_ERROR . var_export($callBack, true));
			}
			return false;
		} catch (Exception $e) {
			self::outputExceptionMessage($e);
		}
	}
	
	/**
	 * ダウンロードファイルの出力
	 * 
	 * @param	string	$sourceFilename	// 絶対パス
	 * @param	string	$text			// テキスト
	 * @param	string	$downloadFilename	// ダウンロード時のファイル名
	 * @param	bool	$isAttach	// TRUE:添付ファイル, FALSE:拡張子別
	 * @return	binary
	 */
	public function getDownload($sourceFilename = null, $text = null, $downloadFilename = null, $isAttach = false)
	{
		// ファイルの存在チェック
		if (!file_exists($sourceFilename) && is_null($text)) {
			return false;
		}

		// ファイルタイプ別ヘッダ
		if ($isAttach) {
			// 必ずダウンロードさせる
			$type = 'application/octet-stream';
			$disposition = 'attachment';
		} else {
			// ブラウザで表示
			$disposition = 'inline';
			$pathParts = pathinfo($sourceFilename);
			switch ($pathParts['extension']) {
				case 'jpg':
				case 'jpeg':
					$type = 'image/jpeg';
					break;
				case 'tif':
				case 'tiff':
					$type = 'image/tiff';
					break;
				case 'gif':
				case 'png':
				case 'bmp':
					$type = 'image/' . $pathParts['extension'];
					break;
				case 'pdf':
					$type = 'application/pdf';
					break;
				case 'doc':
					$type = 'application/msword';
					break;
				case 'xls':
					$type = 'application/msexcel';
					break;
				case 'wav':
					$type = 'audio/wav';
					break;
				case 'mp3':
					$type = 'audio/x-mp3';
					break;
				default:
					$type = 'application/octet-stream';
					$disposition = 'attachement';
					break;
			}
		}

		if (is_null($downloadFilename)) {
			$downloadFilename = $sourceFilename;
		}

		// ヘッダ出力
		header('Content-type: ' . $type);
		header('Content-length: ' . filesize($sourceFilename));
		header('Content-Disposition: ' . $disposition . '; filename="' . mb_convert_encoding($downloadFilename, 'SJIS-win', 'utf8') . '"');

		if ($sourceFilename) {
			// ファイルを読んで出力 
			readfile($sourceFilename, "rb");
		} elseif ($text) {
			// テキストを出力
			echo ($text);
		}

		return true;
	}
	
	public function outputExceptionMessage($e)
	{
		if (empty($e)) {
			exit;
		}
		
		$exceptionMessage = 'Exception : ' . $e->getMessage();
		self::writeLog($exceptionMessage);
		echo $exceptionMessage;
		exit;
	}
	
	public function hash_pbkdf2_sha256($pwd = '', $saltStr = '', $iteration = 1000, $delimiter = '_')
	{
		$saltStr = self::trimEmspace($saltStr);
		if ($saltStr) {
			$salt = hash('sha256', $saltStr);
			$hash = hash('sha256', $pwd . $delimiter . $salt);
		} else {
			$hash = hash('sha256', $pwd);
		}
		
		for ($i = 0; $i < $iteration; $i++) {
			$hash = hash('sha256', $hash);
		}
		
		return $hash;
	}
	
	public function trimEmspace($str)
	{
		// 先頭の半角、全角スペースを、空文字に置き換える
		$str = preg_replace('/^[ 　]+/u', '', $str);
		// 最後の半角、全角スペースを、空文字に置き換える
		$str = preg_replace('/[ 　]+$/u', '', $str);
		
		return $str;
	}
	
	public function getCurrentDatetime()
	{
		return date('Y-m-d H:i:s');
	}
}