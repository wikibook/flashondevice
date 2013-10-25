/**
 * Component button.
 * 
 * @version 0.4.0
 * @author Raul Jimenez
 * 
 * @see AbstractObject
 * @see CheckBoxLight
 */
 
import org.asapframework.events.EventDelegate;
import com.blocketpc.AbstractObject;
 
class com.blocketpc.components.ButtonLight extends AbstractObject
{
	public var title_txt:TextField;
	public var shadow_txt:TextField;
	
	/**
	 * Constructor.
	 */
	public function ButtonLight()
	{
		this.stop();
		this.onRollOver = EventDelegate.create(this, onRollOverButton);		this.onRollOut = EventDelegate.create(this, onRollOutButton);
	}
	
	private function onRollOverButton():Void
	{
		this.gotoAndStop(2);
	}
	private function onRollOutButton():Void
	{
		this.gotoAndStop(1);
	}
	
	/**
	 * Sets the title for the text and the shadow text.
	 * 
	 * @param title: Title to show.
	 */
	public function set title(t:String):Void
	{
		title_txt.text = t;
		shadow_txt.text = t;
	}
}