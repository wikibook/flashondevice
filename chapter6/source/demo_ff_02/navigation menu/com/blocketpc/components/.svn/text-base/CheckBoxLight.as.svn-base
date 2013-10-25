/**
 * Component checkbox.
 * 
 * @version 0.4.0
 * @author Raul Jimenez
 * 
 * @see AbstractObject
 * @see ButtonLight
 */

import org.asapframework.events.EventDelegate;
import com.blocketpc.AbstractObject;
import com.blocketpc.components.ButtonLight;

class com.blocketpc.components.CheckBoxLight extends ButtonLight
{
	public var _selected:Boolean;
	private var selected_mc:MovieClip;
	
	public static var ON_CHECK:String = "onCheck";
	
	/**
	 * Constructor.
	 */
	public function CheckBoxLight()
	{
		_selected = false;
		selected_mc._visible = _selected;
		
		this.stop();
	}
	
	private function onPressButton():Void
	{
		if (_selected == true)
		{
			_selected = false;
		}
		else
		{
			_selected = true;
		}
		
		selected_mc._visible = _selected;
		
		dispatchEvent( {type: ON_CHECK, data: _selected} );
	}
	
	/**
	 * Sets the status of the component
	 * 
	 * @param inValue: Boolean to check or uncheck the checkbox.
	 */
	public function set selected(inValue: Boolean):Void
	{
		this._selected = Boolean(inValue);
		selected_mc._visible = inValue;
	}
	public function get selected():Boolean
	{
		return Boolean(this._selected);
	}
}