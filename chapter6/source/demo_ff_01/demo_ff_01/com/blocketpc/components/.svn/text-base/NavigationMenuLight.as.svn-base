/**
 * Component navigation menu to create a vertical or horizontal container with MovieClips.
 * 
 * @version 0.4.0
 * @author Raul Jimenez
 * 
 * @see AbstractObject
 */
import com.blocketpc.managers.TransitionManager;

import gs.easing.Cubic;
import gs.TweenLite;

import org.asapframework.events.EventDelegate;

import com.blocketpc.managers.AbstractManager;
import com.blocketpc.managers.KeyManager;
import com.blocketpc.AbstractObject; 

class com.blocketpc.components.NavigationMenuLight extends AbstractObject
{
	private var _gap:Number = 120;
	private var _activated:Boolean = true;
	private var _direction:String = "horizontal";
	private var _axisA:String = "_x";
	private var _axisB:String = "_y";
	private var _axisSize:String = "_width";
	private var data:Array;
	private var selected:Number = 0;
	
	public static var ON_SELECT_ITEM:String = "onSelectItem";
	public static var ON_ROLLOVER_ITEM:String = "onRollOverItem";
	
	/**
	 * Constructor
	 */
	public function NavigationMenuLight()
	{
		
	}
	
	/**
	 * Create the items in the navigation menu.
	 * 
	 * @param _data: Array with the items to create.
	 * This array must contains a list of string with the linkage names of the library clips to attach. 
	 */
	public function initialize(_data:Array):Void
	{
		KeyManager.getInstance().addEventListener(KeyManager.ON_PRESS_KEY, this, "onPressKey");
		
		data = _data;
		
		for (var i:Number=0; i<data.length; i++)
		{
			var tab:MovieClip = this.attachMovie(data[i], data[i], i);
			tab.enabled = false;
			tab.id = i;
			tab.positionId = i;
		}
		
		render();
		
		dispatchEvent( {type: ON_ROLLOVER_ITEM, item: this[data[selected]]} );
	}
	
	private function render()
	{
		for (var i:Number=0; i<data.length; i++)
		{
			var tab:MovieClip = this[data[i]];
			tab[_axisA] = tab.positionId * _gap;
			tab[_axisB] = 0;
			
			for (var j=1; j<3; j++)
			{
				if (tab.positionId > (data.length-j))
				{
					tab.positionId = 1 - j;
					tab[_axisA] = -_gap * (j - 1);
				}
			}
			
			tab.startAxisA = tab[_axisA];
		}
	}
	
	private function select():Void
	{
		dispatchEvent( {type: ON_SELECT_ITEM, item: this[data[selected]]} );
	}
	
	private function previous():Void
	{
		selected--;
		if (selected < 0) selected = data.length-1;
		
		for (var i:Number=0; i<data.length; i++)
		{
			var tab:MovieClip = this[data[i]];
			tab.positionId += 1;
			
			for (var j=1; j<3; j++)
			{
				if (tab.positionId > (data.length-j))
				{
					tab.positionId = 1 - j;
					tab[_axisA] = -_gap * j;
				}
			}
			
			tab.endAxisA = tab.positionId * _gap;
			
			//trace(selected + "/" + tab.positionId + " + " + tab._name + ": " + tab.endAxisA);
		}
		
		move();
	}
	
	private function next():Void
	{
		selected++;
		if (selected == data.length) selected = 0;
		
		for (var i:Number=0; i<data.length; i++)
		{
			var tab:MovieClip = this[data[i]];
			tab.positionId -= 1;
			
			if (tab.positionId < -1)
			{
				tab.positionId = data.length - 2;
				tab[_axisA] = (getLastPosition() + 1) * _gap;
			}
			
			tab.endAxisA = tab.positionId * _gap;
			
			//trace(selected + "/" + tab.positionId + " - " + tab._name + ": " + tab.endAxisA);
		}
		
		move();
	}
	
	private function getLastPosition():Number
	{
		var p:Number = 0;
		
		for (var i:Number=0; i<data.length; i++)
		{
			var tab:MovieClip = this[data[i]];
			if (tab.positionId > p) p = tab.positionId;
		}
		
		return p;
	}
	
	private function move():Void
	{
		for (var i:Number=0; i<data.length; i++)
		{
			var tr:Object = new Object();
			tr[_axisA] = this[data[i]].endAxisA;
			tr.ease = Cubic.easeOut;
			
			TweenLite.to(this[data[i]], TransitionManager.getInstance().time, tr);
		}
		
		dispatchEvent( {type: ON_ROLLOVER_ITEM, item: this[data[selected]]} );
	}
	
	private function onPressKey(evt:Object)
	{
		switch (evt.key)
		{
			case Key.LEFT:
				if (_axisSize == "_width") previous();
			break;
			case Key.UP:
				if (_axisSize == "_height") previous();
			break;
			
			case Key.RIGHT:
				if (_axisSize == "_width") next();
			break;
			case Key.DOWN:
				if (_axisSize == "_height") next();
			break;
			
			case Key.ENTER:
				select();
			break;
		}
	}
	
	/**
	 * Public getter/setter to set the item separation size.
	 * @param g: Number in pixels of the separation.
	 */
	public function set gap(g:Number):Void
	{
		_gap = g;
		
		render();
	}
	public function get gap():Number
	{
		return _gap;
	}
	
	/**
	 * Public getter/setter for enable the NavigationMenu. This method remove all the KeyManager listeners.
	 * @param a: Boolean value for enable or disable.
	 */
	public function set activated(a:Boolean):Void
	{
		_activated = a;
		
		if (_activated) KeyManager.getInstance().addEventListener(KeyManager.ON_PRESS_KEY, this, "onPressKey");
		else KeyManager.getInstance().removeEventListener(KeyManager.ON_PRESS_KEY, this, "onPressKey");
	}
	public function get activated():Boolean
	{
		return _activated;
	}
	
	/**
	 * Public getter/setter that sets the direction of the NavigationMenu.
	 * @param d: This method accepts two values "horizontal" or "vertical".
	 */
	public function set direction(d:String):Void
	{
		_direction = d;
		
		switch (_direction)
		{
			case "horizontal":
				_axisA = "_x";
				_axisB = "_y";
				_axisSize = "_width";
			break;
			
			case "vertical":
				_axisA = "_y";
				_axisB = "_x";
				_axisSize = "_height";
			break;
		}
		
		render();
	}
	public function get direction():String
	{
		return _direction;
	}
	
	/**
	 * Public getter/setter that changes the axis to calculate the item positions.
	 * @param a: Property name to change, it could be "_x", "_y", "_rotation", etc.
	 */
	public function set axis(a:String):Void
	{
		_axisA = a;
		
		render();
	}
	public function get axis():String
	{
		return _axisA;
	}
}