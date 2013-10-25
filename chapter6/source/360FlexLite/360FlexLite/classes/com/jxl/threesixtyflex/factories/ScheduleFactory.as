import com.jxl.shuriken.factories.FactoryTemplate;
import com.jxl.shuriken.utils.DateUtils;
import com.jxl.shuriken.utils.LoopUtils;

import com.jxl.threesixtyflex.vo.EventVO;
import com.jxl.threesixtyflex.views.ThreeSixtyFlexSchedule;


class com.jxl.threesixtyflex.factories.ScheduleFactory extends FactoryTemplate
{
	
	private static var __callbackScope:Object;
	private static var __callbackFunction:Function;
	
	private static var __lv:LoadVars;
	private static var __list:Array;
	private static var __entries_array:Array;
	private static var __event_lu:LoopUtils;
	private static var __currentEventVO:EventVO;
	
	public static function getEventsByDay(data, scope:Object, func:Function):Void
	{
		trace("----------------------");
		trace("ScheduleFactory::getEventsByDay");
		
		var len:Number;
		if(data instanceof LoadVars)
		{
			__lv = data;
		 	len = parseInt(__lv.l);
		}
		else if(data instanceof Array)
		{
			__list = data;
			len = __list.length;
		}
		
		__callbackScope			= scope;
		__callbackFunction		= func;
		
		__entries_array = [];
		
		if(__event_lu != null) __event_lu.destroy(false);
		__event_lu = new LoopUtils(ThreeSixtyFlexSchedule.loop_mc);
		
		__event_lu.forLoop(0, 
						   len,
						   1,
						   ScheduleFactory,
						   onEventListParse,
						   onEventListParseDone);
	}
	
	private static function onEventListParseDone():Void
	{
		//trace("----------------------");
		//trace("ScheduleFactory::onEventListParseDone");
	
		if(__event_lu != null) __event_lu.destroy(false);
		delete __event_lu;
		__callbackFunction.call(__callbackScope, __entries_array);
		delete __lv;
		delete __list;
		delete __entries_array;
		delete __currentEventVO;
		delete __callbackScope;
		delete __callbackFunction;
	}
	
	private static function onEventListParse(index:Number):Void
	{
		//trace("----------------------");
		//trace("ScheduleFactory::onEventListParse, index: " + index);
		
		if(__lv != null)
		{
			__currentEventVO 				= new EventVO();
			__currentEventVO.name 			= __lv["n" + index];
			__currentEventVO.track 			= __lv["t" + index];
			__currentEventVO.speaker		= __lv["s" + index];
			
			var startTimeVal:String 		= __lv["r" + index];
			__currentEventVO.startTime 		= parseTime(startTimeVal);
			
			var endTimeVal:String			= __lv["e" + index];
			__currentEventVO.endTime		= parseTime(endTimeVal);
		}
		else
		{
			var o:Object = __list[index];
			//trace("o: " + o);
			//for(var p in o)
			//{
				//trace(p + ": " + o[p]);
			//}
			__currentEventVO 				= new EventVO();
			__currentEventVO.name 			= o.name;
			__currentEventVO.track 			= o.track;
			__currentEventVO.speaker		= o.speaker;
			__currentEventVO.startTime 		= o.startTime;
			__currentEventVO.endTime		= o.endTime;
		}
		
		__entries_array.push(__currentEventVO);
	}
	
	// 8:50, or 14:20
	public static function parseTime(timeStr:String):Date
	{
		var splitStr:Array = timeStr.split(":");
		var hours:Number = parseInt(splitStr[0]);
		var minutes:Number = parseInt(splitStr[1]);
		var date:Date = new Date();
		date.setHours(hours);
		date.setMinutes(minutes);
		return date;
	}
	
	public static function parseDateTime(p_dateStr:String):Date
	{
		//DebugWindow.debugHeader();
		//DebugWindow.debug("p_dateStr: " + p_dateStr);
		// 2006-04-17T17:00:00.000Z
		// Wed May 17 17:00:00 GMT-0400 2006
		var splitDateString:Array = p_dateStr.split("T");
		var dateInfo:String = splitDateString[0];
		var timeInfo:String = splitDateString[1];
		
		var splitDateInfo:Array = dateInfo.split("-");
		var theFullYear:Number = parseInt(splitDateInfo[0]);
		var theMonth:Number = parseInt(splitDateInfo[1]) - 1;
		var theDay:Number = parseInt(splitDateInfo[2]);
		
		var theDate:Date;
		if(splitDateString.length > 1)
		{
			var splitTimeInfo:Array = timeInfo.split(".");
			var hmsPart:Array = splitTimeInfo[0].split(":");
			var theHours:Number = parseInt(hmsPart[0]);
			var theMins:Number = parseInt(hmsPart[1]);
			var theSeconds:Number = parseInt(hmsPart[2]);
			
			theDate = new Date(theFullYear, theMonth, theDay, theHours, theMins, theSeconds);
		}
		else
		{
			theDate = new Date(theFullYear, theMonth, theDay);
		}
		return theDate;
	}
	
}