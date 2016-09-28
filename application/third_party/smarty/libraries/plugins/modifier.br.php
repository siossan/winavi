<?php
/**
 * smarty modifier: br
 * 改行を<br />タグに置き換える
 * 
 * @param	string	$srt
 * @return	
 */
function smarty_modifier_br($str, $reverse = false)
{
	$source = array("\n", '\\&', '\\', '  ');
	$target = array('<br />', '&', '&#xa5;', ' &nbsp;');

	return $reverse ? str_replace($target, $source, stripslashes($str)) : str_replace($source, $target, stripslashes($str));
}