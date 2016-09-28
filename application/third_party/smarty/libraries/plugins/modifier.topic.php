<?php
/**
 * smarty modifier: topic
 * 
 * @param	string	$str
 * @param	int	$length
 * @param	string	$etc
 * @return	string
 */
function smarty_modifier_topic($str, $length = 80, $etc = '...')
{
	return mb_strlen($str, 'utf8') > $length 
		? mb_substr($str, 0, $length, 'utf8') . $etc 
		: $str;
}