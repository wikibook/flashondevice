import com.jxl.shuriken.core.Collection;
import com.jxl.threesixtyflex.vo.EventVO;
import com.jxl.shuriken.utils.DateUtils;

class com.jxl.threesixtyflex.model.ModelLocator
{
	private static var inst:ModelLocator;
	
	public function ModelLocator()
	{
	}
	
	public static function getInstance():ModelLocator
	{
		if(inst == null)
		{
			inst = new ModelLocator();
			inst.timeZoneOffset = DateUtils.getLocalOffset();
		}
		return inst;
	}
	
	public var currentEntry:EventVO;
	public var currentVersion:String = "1.0.0";
	public var timeZoneOffset:Number;
	public var events:Collection; // array full of EventVO's
	public var selectedDay:Number;
}