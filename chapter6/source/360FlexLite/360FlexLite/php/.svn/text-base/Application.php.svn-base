<?php

	set_include_path("/home/9936/domains/jessewarden.com/html/360Flex/php/");
	
	class Application
	{
		const GET_EVENTS_BY_DAY						= "get_events_by_day";
		const COMMAND_CHECK_VERSION					= "check_version";
		
		public function Application()
		{
		}
		
		public function runCommand($p_cmd, $params)
		{
			switch($p_cmd)
			{
				case self::GET_EVENTS_BY_DAY:
					return $this->getScheduleByDay($params->day);
				
				
				case self::COMMAND_CHECK_VERSION:
					return $this->checkVersion($params->currentVersion);
			}
		}
		
		protected function getScheduleByDay($day)
		{
			$scheduleStr = file_get_contents("schedule.xml", true);
			
			
			//JXLDebug::header();
			//JXLDebug::debug("day: " . $day);
			
			$targetDay = "";
			switch($day)
			{
				case 5:
					$targetDay = "Monday";
					break;
				
				case 6:
					$targetDay = "Tuesday";
					break;
				
				case 7:
					$targetDay = "Wednesday";
					break;
			}
			
			//JXLDebug::header();
			//JXLDebug::debug("targetDay: " . $targetDay);
			
			if($targetDay == "")
			{
				return false;
			}
			
			// parse the XML to objects
			$response = "";
			$counter = 0;
			$xml = new SimpleXMLElement($scheduleStr);
			foreach($xml->day as $mainNode)
			{
				$dayOfWeek = $mainNode['name'];
				//JXLDebug::header();
				//JXLDebug::debug("dayOfWeek: " . $dayOfWeek);
				if($dayOfWeek != $targetDay)
				{
					continue;
				}
				
				/*
				__currentEventVO.name 			= __lv["name" + index];
				__currentEventVO.track 			= __lv["track" + index];
				__currentEventVO.speaker		= __lv["speaker" + index];
				
				var startTimeVal:String 		= __lv["start" + index];
				__currentEventVO.startTime 		= parseDateTime(startTimeVal);
				
				var endTimeVal:String			= __lv["endTime" + index];
				*/
				foreach($mainNode as $dayNode)
				{
					//JXLDebug::header();
					//JXLDebug::debug("response: " . $response);
				
					$track = $dayNode['track'];
					$name = $dayNode['name'];
					$speaker = $dayNode['speaker'];
					$start = $dayNode['start'];
					$end = $dayNode['end'];
					
					$response .= "&n$counter=$name";
					$response .= "&t$counter=$track";
					$response .= "&s$counter=$speaker";
					$response .= "&r$counter=$start";
					$response .= "&e$counter=$end";
					
					$counter++;
				}
			}
			$response .= "&l=$counter";
			return $response;
		}
		
		protected function checkVersion($currentVersion)
		{
			$major = 1;
			$minor = 0;
			$build = 0;
			
			$arr = explode(".", $currentVersion);
			$clientMajor = $arr[0];
			$clientMinor = $arr[1];
			$clientBuild = $arr[2];
			
			if($major > $clientMajor)
			{
				return true;
			}
			else if($major == $clientMajor)
			{
				if($minor > $clientMinor)
				{
					return true;
				}
				else if($build == $clientBuild)
				{
					if($build > $clientBuild)
					{
						return true;
					}
				}
			}
			
			return false;
		}
	}

?>