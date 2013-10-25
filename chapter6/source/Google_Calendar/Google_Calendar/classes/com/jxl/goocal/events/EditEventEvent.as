﻿/*
	EventTemplate
	
	Template for a ARP Event class.
	
    Created by Jesse R. Warden a.k.a. "JesterXL"
	jesterxl@jessewarden.com
	http://www.jessewarden.com
	
	This is release under a Creative Commons license. 
    More information can be found here:
    
    http://creativecommons.org/licenses/by/2.5/
*/
import org.osflash.arp.controller.ArpEvent;

class com.jxl.goocal.events.EditEventEvent extends ArpEvent
{
	public static var EDIT_EVENT:String = "editEvent";
	
	public var id:String;
	public var startDate:Date;
	public var endDate:Date;
	public var title:String;
	public var description:String;
	public var where:String;
	public var calendar:String;
	
	public function EditEventEvent(p_type:String, p_target:Object, p_callback:Function)
	{
		super(p_type, p_target, p_callback);
	}
}