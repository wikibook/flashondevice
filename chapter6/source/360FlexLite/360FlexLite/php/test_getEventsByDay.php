<?php

	set_include_path("/home/9936/domains/jessewarden.com/html/goocal/php/");
	
	require_once("Application.php");
	require_once("JXLDebug.php");
	
	$fc = new Application();
	$params = new stdClass();
	$params->year = "2007";
	$params->month = "3";
	$params->day = "5";
	$response = $fc->runCommand(Application::GET_EVENTS_BY_DAY, $params);
	JXLDebug::header();
	JXLDebug::debug("response: " . $response);
	
?>