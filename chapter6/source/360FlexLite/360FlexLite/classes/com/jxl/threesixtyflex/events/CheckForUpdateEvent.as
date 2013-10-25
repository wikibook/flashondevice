import org.osflash.arp.controller.ArpEvent;

class com.jxl.threesixtyflex.events.CheckForUpdateEvent extends ArpEvent
{
	public static var CHECK:String = "check";
	
	public function CheckForUpdateEvent(p_type:String, p_target:Object, p_callback:Function)
	{
		super(p_type, p_target, p_callback);
	}
}