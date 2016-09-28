<?php
/**
 *	smarty function:messages()
 *	sample:
 *	@param	array	$param 	 
 *			('errors' => エラー配列, 
 *			 'message' => メッセージ,
 *			)
 *	@return	string	HTML
 */
function smarty_function_messages($param)
{
	$html = '';
	
	if (is_array($param['errors'])) {
		foreach ($param['errors'] as $e) {
			$html .= '<span class="error">' . $e . '</span><br />';
		}
	}
	
	if ($param['message']) {
		$html .= '<span class="message">' . stripslashes($param['message']) . '</span><br />';
	}
	
	return $html;
}