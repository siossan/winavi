<?php
function smarty_function_errors()
{
	$errors = validation_errors();
	echo !empty($errors) ? $errors : '';
}