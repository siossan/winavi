<?php
function smarty_modifier_password($str)
{
	$length = mb_strlen($str, 'UTF-8');
	return str_repeat('*', $length);
}