
import mx.utils.Delegate;
import mx.rpc.ResultEvent;
import mx.rpc.Fault;
import mx.rpc.FaultEvent;
import mx.rpc.Responder;

import com.jxl.threesixtyflex.factories.ScheduleFactory;

class com.jxl.threesixtyflex.business.GetScheduleByDayDelegate
{
	private var responder:Responder;
	private var lv:LoadVars;
	private var savedList:Function;
	private var day:Number;
	private var readList:Function;
	private var events:Array;
	
	function GetScheduleByDayDelegate(p_responder:Responder)
	{
		responder = p_responder;
	}
	
	public function getScheduleByDay(day:Number):Void
	{
		trace("------------------");
		trace("GetScheduleByDayDelegate::getScheduleByDay, day: " + day);
		this.day = day;
		
		if(System.capabilities.isDebugger == false)
		{
			if(savedList == null) savedList = Delegate.create(this, onReadSO);
			SharedObject.removeListener(_global.ThreeSixtyFlexSO);
			SharedObject.addListener(_global.ThreeSixtyFlexSO, savedList);
			var so:SharedObject = SharedObject.getLocal(_global.ThreeSixtyFlexSO);
		}
		else
		{
			var so:SharedObject = SharedObject.getLocal(_global.ThreeSixtyFlexSO);
			onReadSO(so);
		}
	}
	
	private function onReadSO(so:SharedObject):Void
	{
		var now:Date = new Date();
		//so.clear();
		if(so.data.lastRead == null)
		{
			// we've never checked before,
			// or our LSO got waxed
			so.data.lastRead = now;
			so.flush();
			getServerUpdates();
		}
		else
		{
			var od:Date = so.data.lastRead;
			// 1 hour
			var readYear:Number 		= od.getFullYear();
			var readMonth:Number 		= od.getMonth();
			var readDay:Number 			= od.getDate();
			var readHour:Number 		= od.getHours();
			
			var readLocal:Boolean = false;
			if(now.getFullYear() <= readYear)
			{
				if(now.getMonth() <= readMonth)
				{
					if(now.getDate() <= readDay)
					{
						if(now.getHours() <= readHour)
						{
							readLocal = true;
						}
					}
				}
			}
			
			if(readLocal == true)
			{
				// attempt to read from the SO
				var theEvents:Array;
				trace("day: " + day);
				var theDayName:String;
				switch(day)
				{
					case 5:
						//trace("Using cache for Monday");
						theDayName = "Monday";
						theEvents = so.data.mon;
						break;
						
					case 6:
						//trace("Using cache for Tuesday");
						theDayName = "Tuesday";
						theEvents = so.data.tue;
						break;
					
					case 7:
						//trace("Using cache for Wednesday");
						theDayName = "Wednesday";
						theEvents = so.data.wed;
						break;
				}
				
				trace("theEvents: " + theEvents);
				if(theEvents != null)
				{
					// we have local data, use it
					responder.onResult(new ResultEvent("Getting " + theDayName + "\nfrom cache..."));
					ScheduleFactory.getEventsByDay(theEvents,
												   this,
												   onDoneParsing);
				}
				else
				{
					// wtf?  Fine... so saving is failing
					// load data
					getServerUpdates();
				}
			}
			else
			{
				// time to update!
				so.data.lastRead = now;
				so.flush();
				getServerUpdates();
			}
		}
		
	}
	
	private function getServerUpdates():Void
	{
		lv = new LoadVars();
		lv.onLoad = Delegate.create(this, onGetEvents);
		lv.c = "get_events_by_day";
		lv.d = day;
		lv.sendAndLoad(_global.phpURL, lv, "POST");
	}
	
	private function onGetEvents(success:Boolean):Void
	{
		trace("------------------");
		trace("GetScheduleByDayDelegate::onGetEvents, success: " + success);
		for(var p in lv)
		{
			trace(p + ": " + lv[p]);
		}
		
		if(success == true)
		{
			responder.onResult(new ResultEvent("Events received.\nParsing events..."));
			ScheduleFactory.getEventsByDay(lv,
										   this,
										   onDoneParsing);
		}
		else
		{
			var fault:Fault = new Fault("failure", "get events failure", "Failed to get events by day.", "Get Events");
			var fe:FaultEvent = new FaultEvent(fault);
			responder.onFault(fe);
		}
	}
	
	private function onDoneParsing(events:Array):Void
	{
		//trace("------------------");
		//trace("GetScheduleByDayDelegate::onDoneParsing, events: " + events);
		this.events = events;
		
		if(System.capabilities.isDebugger == false)
		{
			if(readList == null) readList = Delegate.create(this, onReadyToSave);
			SharedObject.removeListener(_global.ThreeSixtyFlexSO);
			SharedObject.addListener(_global.ThreeSixtyFlexSO, readList);
			var so:SharedObject = SharedObject.getLocal(_global.ThreeSixtyFlexSO);
		}
		else
		{
			var so:SharedObject = SharedObject.getLocal(_global.ThreeSixtyFlexSO);
			onReadyToSave(so);
		}
	}
	
	private function onReadyToSave(so:SharedObject):Void
	{
		//trace("------------------");
		//trace("GetScheduleByDayDelegate::onReadyToSave");
		//trace("this.events: " + this.events);
		//trace("this.events[0]: " + this.events[0]);
		//for(var p in this.events[0])
		//{
			//trace(p + ": " + this.events[0][p]);
		//}
		
		switch(day)
		{
			case 5:
				so.data.mon = this.events;
				break;
				
			case 6:
				so.data.tue = this.events;
				break;
			
			case 7:
				so.data.wed = this.events;
				break;
		}
		
		so.flush();
		
		SharedObject.removeListener(_global.ThreeSixtyFlexSO);
		SharedObject.removeListener(_global.ThreeSixtyFlexSO);
		delete savedList;
		delete readList;
		
		responder.onResult(new ResultEvent(this.events));
	}
	
}
