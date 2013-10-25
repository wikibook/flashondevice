<?php

	set_include_path("/home/9936/domains/jessewarden.com/html/360Flex/");
	
	require_once("Application.php");
	require_once("JXLDebug.php");
	
	if(isset($HTTP_POST_VARS['c']))
	{
		$fc = new Application();
		$params = new stdClass();
		
		switch($HTTP_POST_VARS['c'])
		{
			case Application::GET_EVENTS_BY_DAY:
				$params->day = $HTTP_POST_VARS['d'];
				$response = $fc->runCommand(Application::GET_EVENTS_BY_DAY, $params);
				echo($response);
				break;
			
			case Application::COMMAND_CHECK_VERSION:
				$params->currentVersion		= $HTTP_POST_VARS['v'];
				$needToUpdate = $fc->runCommand(Application::COMMAND_CHECK_VERSION, $params);
				if($needToUpdate == true)
				{
					echo("n=true&v=1.0.0&u=http://www.jessewarden.com/");
				}
				else
				{
					echo("n=false");
				}
				return;
		}
	}
	
	
	
?>