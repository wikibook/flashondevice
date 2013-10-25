import com.blocketpc.components.ListLight;
import com.blocketpc.components.NavigationMenuLight;
import com.blocketpc.view.AbstractView;
import org.asapframework.events.EventDelegate;
/**
 * @author Raul
 */
class Application extends AbstractView
{
	private var navigation:NavigationMenuLight;
	private var list_mc:ListLight;
	private var section_txt:TextField;

	public function Application()
	{
		
	}
	
	private function initialize():Void
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		_focusrect = _global.useFocusRect == false;
		
		fscommand2("fullscreen", "true");
		
		var items:Array = new Array("contacts", "explorer", "games", "messages");
		navigation.addEventListener(NavigationMenuLight.ON_ROLLOVER_ITEM, EventDelegate.create(this, onRollOverItem));
		navigation.gap = 240;
		navigation.initialize(items);
	}
	
	private function onRollOverItem(evt:Object)
	{
		trace("item: " + evt.item);
		var data:Array = new Array();
		
		for (var i=0; i<5; i++)
		{
			var tObj:Object = new Object();
			tObj.title = evt.item._name.toUpperCase() + " 0" + i;
			data[i] = tObj;
		}
		
		section_txt.text = evt.item._name.toUpperCase();
		
		list_mc.initialize(data);
		list_mc.setSize(230, 160);
	}
}
