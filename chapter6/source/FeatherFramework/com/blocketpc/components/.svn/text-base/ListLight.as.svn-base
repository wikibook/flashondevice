import com.blocketpc.components.ScrollBarLight;

import org.asapframework.events.EventDelegate;
import com.blocketpc.AbstractObject;
import gs.TweenLite;
import mx.transitions.easing.Back;

/**
 * Component list component.
 * With this component you can create your own cellrender setting the listButtonRender variable.
 * This variable it's an string with the linkage name of a MovieClip.
 * 
 * @version 0.4.0
 * @author Raul Jimenez
 * 
 * @see AbstractObject
 * @see TweenLite
 */
class com.blocketpc.components.ListLight extends AbstractObject
{
	private var data:Array;
	
	private var listContainer_mc:MovieClip;
	private var listMask_mc:MovieClip;
	
	private var scrollBar:ScrollBarLight;

	private var ratioContainer:Number = 0;
	
	public var vSeparation:Number = 2;
	public var scrollJump:Number = 10;
	
	public var _listButtonRender:String = "listButtonLight";
	
	public static var ON_PRESS_BUTTON:String = "onPressButton";
	public static var ON_ROLLOVER_BUTTON:String = "onRollOverButton";
	public static var ON_ROLLOUT_BUTTON:String = "onRollOutButton";
	//public var scrollBarAutoHide:Boolean = true;
	
	/**
	 * Constructor
	 */
	public function ListLight()
	{
		
	}
	
	/**
	 * Constructor and create the items in the list.
	 * 
	 * @param data_array: Array with the items to create.
	 * This array must contains a list of objects with two properties called title and data.
	 * The title property it's an string to show the name of the item.
	 * The data property it's an object with all the data to initialize the cellrender.
	 */
	public function initialize(data_array:Array):Void
	{
		data = new Array();
		data = data_array;
		
		createButtons();
	}
	
	private function createButtons():Void
	{
		clear();
		for (var i=0; i<data.length; i++)
		{
			var temp_mc:MovieClip = listContainer_mc.attachMovie(_listButtonRender, "button" + i, i);
			temp_mc._x = 0;
			temp_mc._y = (temp_mc._height + vSeparation) * i;
			
			temp_mc.id = i;
			temp_mc.data = data[i];
			
			temp_mc.onPress = EventDelegate.create(this, onPressButton, temp_mc.data);
			temp_mc.onRollOver = EventDelegate.create(this, onRollOverButton, temp_mc);
			temp_mc.onRollOut = EventDelegate.create(this, onRollOutButton, temp_mc);
		}
		
		if (listMask_mc._height > listContainer_mc._height) scrollBar.hide();
		else scrollBar.show();
	}
	
	/**
	 * Removes all the items in the list.
	 */
	public function clear():Void
	{
		for (var i in listContainer_mc)
		{
			listContainer_mc[i].removeMovieClip();
		}
	}
	
	/**
	 * Moves the item to a specified screen position.
	 * 
	 * @param x: Moves the list to an horizontal position.
	 * @param y: Moves the list to a vertical position. 
	 */
	public function move(x:Number, y:Number):Void
	{
		this._x = x;
		this._y = y;
	}
	
	/**
	 * Sets a new size to the list.
	 * 
	 * @param w: Number with the new width.
	 * @param h: Number with the new height. 
	 */
	public function setSize(w:Number, h:Number):Void
	{
		listMask_mc._width = w;
		listMask_mc._height = h;
		
		scrollBar._x = listMask_mc._width + 2;
		
		ratioContainer = (listContainer_mc._height - listMask_mc._height) / (data.length - 1);
		
		scrollBar.setTargets(listContainer_mc, listMask_mc);
		
		if (listMask_mc._height > listContainer_mc._height) scrollBar.hide();
		else scrollBar.show();
	}
	
	private function onPressButton(data:Object):Void
	{
		dispatchEvent( {type: ON_PRESS_BUTTON, data: data} );
	}
	
	private function onRollOverButton(target:MovieClip):Void
	{
		dispatchEvent( {type: ON_ROLLOVER_BUTTON, data: target.data} );
		
		target.onRollOverItem();
		
		if (listMask_mc._height >= listContainer_mc._height) return;
		
		var yCont:Number = target.id * ratioContainer * -1;
		TweenLite.to(listContainer_mc, 1, {_y: yCont, ease:Back.easeOut});
		
		scrollBar.update(yCont);
	}
	
	private function onRollOutButton(target:MovieClip):Void
	{
		target.onRollOutItem();
		
		dispatchEvent( {type: ON_ROLLOUT_BUTTON, data: target.data} );
	}
	
	/**
	 * Sets the list cellrender. It must be an string with the linkage name of a MovieClip. 
	 */
	public function set listButtonRender(inValue: String):Void
	{
		this._listButtonRender = String(inValue);
	}
	public function get listButtonRender():String
	{
		return String(this._listButtonRender);
	}
}
