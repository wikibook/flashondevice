﻿
import org.osflash.arp.controller.ArpEvent;

import com.jxl.goocal.vo.EntryVO;

class com.jxl.goocal.events.GetEntryEvent extends ArpEvent
{
	public static var GET_ENTRY:String = "getEntry";
	
	public var entryVO:EntryVO;
	
	public function GetEntryEvent(p_type:String, p_target:Object, p_callback:Function)
	{
		super(p_type, p_target, p_callback);
	}
}