<?php
/**
 * smarty modifier: html
 * 
 * @param	string	$str
 * @param	bool	$isBr	TRUE:<BR>タグ自動付加
 * @return
 */
function smarty_modifier_html($str, $isBr = true, $isQuot = false)
{
	$source = array('&lt;', '&gt;', '\\&', '\\', '  ', '&quot;', '&amp;');
	$target = array('<', '>', '&', '&#xa5;', ' &nbsp;', '"', '&');
	if ($isBr) {
		$source[] = "\n";
		$target[] = '<br />';
	}

	// セキュリティ
	$str = preg_replace('/<form/i', '<span', $str);
	$str = preg_replace('/<\/form/i', '</span', $str);
	$str = preg_replace('/<script/i', '<!--', $str);
	$str = preg_replace('/<\/script>/i', '-->', $str);

	return str_replace($source, $target, stripslashes($str));
}