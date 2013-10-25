
import org.osflash.arp.CommandRegistryTemplate;

import com.jxl.threesixtyflex.events.GetScheduleByDayEvent;
import com.jxl.threesixtyflex.commands.GetScheduleByDayCommand;

import com.jxl.threesixtyflex.events.CheckForUpdateEvent;
import com.jxl.threesixtyflex.commands.CheckForUpdateCommand;

class com.jxl.threesixtyflex.controller.CommandRegistry extends CommandRegistryTemplate
{
	private static var inst:CommandRegistry; 	// instance of self
	
	public static function getInstance()
	{
		if (inst == null) inst = new CommandRegistry();
		return inst;
	}	
	
	private function addCommands()
	{
		addCommand(GetScheduleByDayEvent.GET_SCHEDULE_BY_DAY, 	GetScheduleByDayCommand);
		addCommand(CheckForUpdateEvent.CHECK, 					CheckForUpdateCommand);
	}
}
