/**
 * Component navigation menu to create a vertical or horizontal container with MovieClips.
 * 
 * @version 0.4.0
 * @author Raul Jimenez
 * 
 * @see AbstractObject
 */
import org.asapframework.util.FrameDelay;

import com.blocketpc.managers.TransitionManager;

import gs.easing.Cubic;
import gs.TweenLite;

import com.blocketpc.AbstractObject; 

class com.blocketpc.components.NavigationMenuLight extends AbstractObject
{
	private var _gap:Number = 120;
	private var _direction:String = "horizontal";
	private var _axisA:String = "_x";
	private var _axisB:String = "_y";
	private var _axisSize:String = "_width";
	private var data:Array;
	private var selected:Number = 0;
	
	public static var ON_SELECT_ITEM:String = "onSelectItem";
	public static var ON_ROLLOVER_ITEM:String = "onRollOverItem";
	public static var ON_ROLLOUT_ITEM:String = "onRollOutItem";
	
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
		data = _data;
		
		for (var i:Number=0; i<data.length; i++)
		{
			var tab:MovieClip = this.attachMovie(data[i], data[i], i);
			tab.enabled = false;
			tab.id = i;
			tab.positionId = i;
		}
		
		render();
		
		var f:FrameDelay = new FrameDelay(this, firstRollOver);
	}
	
	private function firstRollOver()
	{
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
	
	public function select():Void
	{
		dispatchEvent( {type: ON_SELECT_ITEM, item: this[data[selected]]} );
	}
	
	public function previous():Void
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
	
	public function next():Void
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