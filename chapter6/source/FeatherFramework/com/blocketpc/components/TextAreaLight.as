import com.blocketpc.components.ScrollBarLight;

import org.asapframework.events.EventDelegate;
import com.blocketpc.AbstractObject;
import gs.TweenLite;
import mx.transitions.easing.Back;

/**
 * Component text area.
 * 
 * @version 0.4.4
 * @author Raul Jimenez
 * 
 * @see AbstractObject
 * @see TweenLite
 */
class com.blocketpc.components.TextAreaLight extends AbstractObject
{
	private var content:MovieClip;
	private var listMask_mc:MovieClip;
	
	private var scrollBar:ScrollBarLight;

	private var ratioContainer:Number = 0;
	
	private var _jumpCount:Number = 0;
	private var jumpScroll:Number = 0;
	
	/**
	 * Constructor
	 */
	public function TextAreaLight()
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
	public function initialize(text:String):Void
	{
		content.field.multiline = true;
		content.field.wordWrap = true;
		content.field.autoSize = true;
		content.field.htmlText = text;
		
		_jumpCount = content._height / 60;
		
		if (listMask_mc._height > content.field._height ) scrollBar.hide();
		else scrollBar.show();
	}
	
	/**
	 * Removes all the items in the list.
	 */
	public function clear():Void
	{
		content.field.text = "";
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
		content.field._width = w;
		content.field._height = h;
		
		scrollBar._x = listMask_mc._width + 2;
		
		ratioContainer = (content._height - listMask_mc._height) / _jumpCount;
		
		scrollBar.setTargets(content, listMask_mc);
		
		if (listMask_mc._height > content.field._height ) scrollBar.hide();
		else scrollBar.show();
	}
	
	/**
	 * Scrolls up the content.
	 */
	public function scrollUp():Void
	{
		if (jumpScroll == 0) return;
		
		jumpScroll--;
		var yCont:Number = jumpScroll * ratioContainer * -1;
		TweenLite.to(content, 1, {_y: yCont, ease:Back.easeOut});
		
		scrollBar.update(yCont);
	}
	
	/**
	 * Scrolls down the content.
	 */
	public function scrollDown():Void
	{
		if (jumpScroll == Math.ceil(_jumpCount)) return;
		
		jumpScroll++;
		var yCont:Number = jumpScroll * ratioContainer * -1;
		TweenLite.to(content, 1, {_y: yCont, ease:Back.easeOut});
		
		scrollBar.update(yCont);
	}
	
	/**
	 * Public setter to change the height of jump
	 */
	public function set jumpCount(j:Number):Void
	{
		_jumpCount = j;
		ratioContainer = (content._height - listMask_mc._height) / _jumpCount;
	}
	/**
	 * Public getter to get the height of jump
	 */
	public function get jumpCount():Number
	{
		return _jumpCount;
	}
}
