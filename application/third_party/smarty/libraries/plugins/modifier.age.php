<?php
/**
 * 年齢取得(簡易処理)
 * 
 * @param	string	$date(0000-00-00)
 * @return	int
 */
function smarty_modifier_age($date)
{
	$date = str_replace('-', '', $date);
	return intval((intval(date('Ymd')) - intval($date)) / 10000);
}