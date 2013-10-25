
/**
 * ScrollBar component.
 * 
 * @version 0.4.4
 * @author Raul Jimenez
 * 
 * @see TweenLite
 */
import org.asapframework.events.EventDelegate;

import gs.easing.Back;
import gs.TweenLite;

import com.blocketpc.AbstractObject;

class com.blocketpc.components.ScrollBarLight extends MovieClip
{
	private var listScrollHandler_mc:MovieClip;
	private var listScrollBack_mc:MovieClip;
	private var _clip:MovieClip;
	private var _mask:MovieClip;
	
	private var ratioDrag:Number;
	
	private var isDragging:Boolean = false;
	
	/**
	 * Constructor.
	 */
	public function ScrollBarLight()
	{
		
	}
	
	/**
	 * Updates the scroll handle position.
	 * 
	 * @param yCont: Current container y-axis position. 
	 */
	public function update(yCont:Number):Void
	{
		var maxClip:Number = _mask._height - _clip._height;
		var r:Number = yCont * 100 / maxClip;
		var maxMask:Number = listScrollBack_mc._height - listScrollHandler_mc._height;
		
		var yHand:Number = r * maxMask / 100;
		TweenLite.to(listScrollHandler_mc, 1, {_y: yHand, ease:Back.easeOut});
	}
	
	/**
	 * Set the targets to calculate the scroll handle position.
	 * 
	 * @param clip: MovieClip to represent the scroll.
	 * @param mask: Mask of the MovieClip.
	 */
	public function setTargets(clip:MovieClip, mask:MovieClip):Void
	{
		_clip = clip;
		_mask = mask;
		
		listScrollBack_mc._height = _mask._height;
		ratioDrag = (_clip._height - _mask._height + listScrollHandler_mc._height) / listScrollBack_mc._height;
	}
	
	/**
	 * Show the scrollbar.
	 */
	public function show():Void
	{
		listScrollHandler_mc.onPress = EventDelegate.create(this, startDragScroll);
		listScrollHandler_mc.onRelease = EventDelegate.create(this, stopDragScroll);
		listScrollHandler_mc.onReleaseOutside = EventDelegate.create(this, stopDragScroll);
		
		this._visible = true;
	}

	/**
	 * Hide the scrollbar.
	 */
	public function hide():Void
	{
		this._visible = false;
	}

	
	
	private function startDragScroll():Void
	{
		var maxTop:Number = listScrollBack_mc._y;
		var maxBottom:Number = listScrollBack_mc._height - listScrollHandler_mc._height;
		listScrollHandler_mc.startDrag(false, listScrollHandler_mc._x, maxTop, listScrollHandler_mc._x, maxBottom);
		isDragging = true;
		this.onMouseMove = EventDelegate.create(this, dragScroll);
	}
	private function dragScroll():Void
	{
		if (isDragging == true)
		{
			if (_mask._height >= _clip._height) return;
			
			var yCont:Number = listScrollHandler_mc._y * ratioDrag * -1;
			TweenLite.to(_clip, 1, {_y: yCont, ease:Back.easeOut});
		}
	}
	private function stopDragScroll():Void
	{
		listScrollHandler_mc.stopDrag();
		isDragging = false;
	}
}
