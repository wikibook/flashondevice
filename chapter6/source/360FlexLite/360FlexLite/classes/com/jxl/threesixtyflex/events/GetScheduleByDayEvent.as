import org.osflash.arp.controller.ArpEvent;

class com.jxl.threesixtyflex.events.GetScheduleByDayEvent extends ArpEvent
{
	public static var GET_SCHEDULE_BY_DAY:String = "getScheduleByDay";
	
	public var day:Number;
	
	public function GetScheduleByDayEvent(p_type:String, p_target:Object, p_callback:Function)
	{
		super(p_type, p_target, p_callback);
	}
}