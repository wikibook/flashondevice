<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>360 Flex Schedule</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>

<?php

	set_include_path("/home/9936/domains/jessewarden.com/html/360Flex/");
	
	require_once("JXLDebug.php");
	
	$scheduleStr = file_get_contents("schedule.xml", true);
	
	$days_array = array();
	
	// parse the XML to objects
	$xml = new SimpleXMLElement($scheduleStr);
	$days_array = array();
	foreach($xml->day as $mainNode)
	{
		$dayOfWeek = $mainNode['name'];
		if(!isset($days_array["$dayOfWeek"]))
		{
			$days_array["$dayOfWeek"] = array();
		}
		foreach($mainNode as $dayNode)
		{
			$track = $dayNode['track'];
			if(!isset($days_array["$dayOfWeek"]["$track"]))
			{
				$days_array["$dayOfWeek"]["$track"] = array();
			}
			$event = new stdClass();
			$event->name = $dayNode['name'];
			$event->speaker = $dayNode['speaker'];
			$event->start = $dayNode['start'];
			$event->end = $dayNode['end'];
			array_push($days_array["$dayOfWeek"]["$track"], $event);
		}
	}
	
	// print the objects to the screen
	foreach ($days_array as $day => $trackArr)
	{
		//echo('<card id="$day" title="360 Flex $day Schedule">');
		echo("<p><h1>$day</h1></p>");
		//echo("<p><big><b>$day</b></big></p>");
		foreach ($trackArr as $trackName => $listOfEvents)
		{
			echo("<p><b>$trackName</b></p>");
			//echo("<p><b>$trackName</b></p>");
			$len = count($listOfEvents);
			for($i=0; $i<$len; $i++)
			{
				$event = $listOfEvents[$i];
				echo($event->name . '<br />');
			}
		}
		/*
		echo('<p>');
		switch($day)
		{
			case "Monday":
				echo('<a href="#Tuesday" />Tuesday</a><br />');
				echo('<a href="#Wednesday" />Wednesday</a><br />');
				break;
			
			case "Tuesday":
				echo('<a href="#Monday" />Monday</a><br />');
				echo('<a href="#Wednesday" />Wednesday</a><br />');
				break;
			
			case "Wednesday":
				echo('<a href="#Monday" />Monday</a><br />');
				echo('<a href="#Tuesday" />Tuesday</a><br />');
				break;
			
		}
		echo('</p>');
		echo('</card>');
		*/
	}
	
?>

</body>
</html>