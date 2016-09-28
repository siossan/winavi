<?php
####################################################################
#
# ◇◇◇◇◇◇◇◇◇◇◇ JPHPMailer - PHPMailer Japanese Edition
# ◇■■■■◇■■■■◇ (PHPMailer:http://phpmailer.sourceforge.net/)
# ◇■◇◇◇◇■◇◇◇◇ 
# ◇■■■■◇■◇◇◇◇ 
# ◇■◇◇◇◇■◇◇◇◇ 株式会社 EC studio  Masaki Yamamoto
# ◇■■■■◇■■■■◇ http://www.ecstudio.jp
# ◇◇◇◇◇◇◇◇◇◇◇ copyright (c): 2007,all rights reserved
#
# ISO-2022-JP-MS/UTF-8 patch by VERSION2, Inc. (http://ver2.jp/)
#
####################################################################

//PHPMailerを読み込む
//require("jphpmailer/phpmailer/class.phpmailer.php");
require(dirname(__FILE__) . "/phpmailer/class.phpmailer.php");
/**
 * JPHPMailer - PHPMailer Japanese Edition
 *
 * @author    Masaki Yamamoto
 * @version   0.11
 * @copyright 2007 EC studio
 * @license   LGPL
 * @link http://techblog.ecstudio.jp/tech-tips/mail-japanese-advance.html
 */
class JPHPMailer extends PHPMailer {
	var $CharSet = "iso-2022-jp";
	var $Encoding = "7bit";
	var $in_enc = "UTF-8"; //内部エンコード
	var $cnvCharSet = "ISO-2022-JP-MS";
	
	/**
	 * MS機種既存文字を置換
	 * 
	 * @param string $s
	 * @return string
	 */
	public function unMS($s)
	{
		return strtr($s, array(
			// ローマ数字
			'Ⅰ' => 'I',    'Ⅱ' => 'II',   'Ⅲ' => 'III',  'Ⅳ' => 'IV',   'Ⅴ' => 'V',
			'Ⅵ' => 'VI',   'Ⅶ' => 'VII',  'Ⅷ' => 'VIII', 'Ⅸ' => 'IX',   'Ⅹ' => 'X',
			
			// 丸囲み数字
			'①' => '(1)',   '②' => '(2)',   '③' => '(3)',   '④' => '(4)',   '⑤' => '(5)',
			'⑥' => '(6)',   '⑦' => '(7)',   '⑧' => '(8)',   '⑨' => '(9)',   '⑩' => '(10)',
			'⑪' => '(11)',  '⑫' => '(12)',  '⑬' => '(13)',  '⑭' => '(14)',  '⑮' => '(15)',
			'⑯' => '(16)',  '⑰' => '(17)',  '⑱' => '(18)',  '⑲' => '(19)',  '⑳' => '(20)',
			
			// TODO: 「㍉」「㌔」など
			));
	}
	
	/**
	 * 宛先を追加
	 * 
	 * $name <$address> という書式になる。
	 * 
	 * @param string $address メールアドレス
	 * @param string $name 名前
	 */
	public function addAddress($address,$name="") {
		if ($name){
			$name = $this->encodeMimeHeader(mb_convert_encoding($this->unMS($name),"ISO-2022-JP-MS",$this->in_enc),$this->cnvCharSet);
		}
		parent::addAddress($address,$name);
	}

	/**
	 * 宛先を追加 (addAddressのエイリアス)
	 * 
	 * $name <$address> という書式になる。
	 * 
	 * @param string $address メールアドレス
	 * @param string $name 名前
	 */
	public function addTo($address,$name="") {
		$this->addAddress($address,$name);
	}

	/**
	 * CCを追加
	 * 
	 * $name <$address> という書式になる。
	 * 
	 * @param string $address メールアドレス
	 * @param string $name 名前
	 */
	public function addCc($address,$name="") {
		if ($name){
			$name = $this->encodeMimeHeader(mb_convert_encoding($this->unMS($name),"ISO-2022-JP-MS",$this->in_enc),$this->cnvCharSet);
		}
		parent::addCc($address,$name);
	}

	/**
	 * BCCを追加
	 * 
	 * $name <$address> という書式になる。
	 * 
	 * @param string $address メールアドレス
	 * @param string $name 名前
	 */
	public function addBcc($address,$name="") {
		if ($name){
			$name = $this->encodeMimeHeader(mb_convert_encoding($this->unMS($name),"ISO-2022-JP-MS",$this->in_enc),$this->cnvCharSet);
		}
		parent::addBcc($address,$name);
	}

	/**
	 * Reply-Toを追加
	 * 
	 * $name <$address> という書式になる。
	 * 
	 * @param string $address メールアドレス
	 * @param string $name 名前
	 */
	public function addReplyTo($address,$name="") {
		if ($name){
			$name = $this->encodeMimeHeader(mb_convert_encoding($this->unMS($name),"ISO-2022-JP-MS",$this->in_enc),$this->cnvCharSet);
		}
		parent::addReplyTo($address,$name);
	}
	
	/**
	 * 題名をセットする
	 * 
	 * @param string $subject 題名
	 */
	public function setSubject($subject){
		$this->Subject = $this->encodeMimeHeader(mb_convert_encoding($this->unMS($subject),"ISO-2022-JP-MS",$this->in_enc),$this->cnvCharSet);
	}
	
	/**
	 * 差出人アドレスをセットする
	 * 
	 * @param string $from 差出人のメールアドレス
	 * @param string $fromname 差し出し人名
	*/
	public function setFrom($from, $fromname = "", $auto = 1){
		$this->From = $from;
		if ($fromname){
			$this->setFromName($fromname);
		}
	}
	
	/**
	 * 差し出し人名をセットする
	 * @param string $fromname 差し出し人名
	 */
	public function setFromName($fromname){
		$this->FromName = $this->encodeMimeHeader(mb_convert_encoding($this->unMS($fromname),"ISO-2022-JP-MS",$this->in_enc),$this->cnvCharSet);
	}

	/**
	 * 本文をセットする。(text/plain)
	 * 
	 * @param string $body 本文
	 */
	public function setBody($body){
		$this->Body = mb_convert_encoding($body,"ISO-2022-JP-MS",$this->in_enc);
		$this->AltBody = "";
		$this->IsHtml(false);
	}

	/**
	 * 本文をセットする。(text/html)
	 * 
	 * @param string $htmlbody 本文 (HTML)
	 */
	public function setHtmlBody($htmlbody){
		$this->Body = mb_convert_encoding($htmlbody,"ISO-2022-JP-MS",$this->in_enc);
		$this->IsHtml(true);
	}
	
	/**
	 * 代替え本文をセットする。(text/plain)
	 * setHtmlBody()を使った時、HTMLを読めないメールクライアント用の平文をセットできる。
	 * 
	 * @param string $altbody 本文
	 */
	public function setAltBody($altbody){
		$this->AltBody = mb_convert_encoding($altbody,"ISO-2022-JP-MS",$this->in_enc);
	}
	
	/**
	 * カスタムヘッダーを追加
	 * 
	 * @param string $key ヘッダーキー
	 * @param string $value ヘッダー値
	 */
	public function addHeader($key,$value){
		if (!$value){
			return;
		}
		$this->addCustomHeader($key.":".$this->encodeMimeHeader(mb_convert_encoding($value,"ISO-2022-JP-MS",$this->in_enc)),$this->cnvCharSet);
	}
	
	/**
	 * エラーメッセージを取得する
	 * 
	 * @return string エラーメッセージ
	 */
	public function getErrorMessage(){
		return $this->ErrorInfo;
	}
	
	/**
	 * PHPMailerのencodeHeaderをオーバーライドして無効化
	 */
	public function encodeHeader($str, $position='text'){
		return $str;
	}
	
	/**
	 * Mimeエンコード処理
	 * 
	 * phpのmb_encode_mimeheaderでは、長い文字列で改行されずメールヘッダの規則にあわない。
	 */
	public function encodeMimeHeader($string,$charset=null,$linefeed="\r\n"){
		if (!strlen($string)){
			return "";
		}
		
		if (!$charset)
			$charset = $this->CharSet;
	
		//$start = "=?$charset?B?";
		$start = "=?$this->CharSet?B?";
		$end = "?=";
		$encoded = '';
	
		/* Each line must have length <= 75, including $start and $end */
		$length = 75 - strlen($start) - strlen($end);
		/* Average multi-byte ratio */
		$ratio = mb_strlen($string, $charset) / strlen($string);
		/* Base64 has a 4:3 ratio */
		$magic = $avglength = floor(3 * $length * $ratio / 4);
	
		for ($i=0; $i <= mb_strlen($string, $charset); $i+=$magic) {
			$magic = $avglength;
			$offset = 0;
			/* Recalculate magic for each line to be 100% sure */
			do {
				$magic -= $offset;
				$chunk = mb_substr($string, $i, $magic, $charset);
				$chunk = base64_encode($chunk);
				$offset++;
			} while (strlen($chunk) > $length);
			
			if ($chunk)
				$encoded .= ' '.$start.$chunk.$end.$linefeed;
		}
		/* Chomp the first space and the last linefeed */
		$encoded = substr($encoded, 1, -strlen($linefeed));
	
		return $encoded;
	}
}