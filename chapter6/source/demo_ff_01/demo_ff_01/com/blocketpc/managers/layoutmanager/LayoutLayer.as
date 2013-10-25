import com.blocketpc.managers.layoutmanager.LayoutOrientation;
import com.blocketpc.managers.layoutmanager.LayoutPosition;
import com.blocketpc.managers.layoutmanager.LayoutType;
import com.blocketpc.managers.layoutmanager.LayoutItem;

/**
 * 
 * This class represents the layer created to linked LayoutItems to it. 
 * It's a virutal Layer created with the drawing API, but it's always invisible.  It's a 
 * screen zone where the clips linked to it are placed.
 * 
 * @see LayoutLayer
 * @see LayoutItem
 * @see LayoutOrientastion
 * @see LayoutPosition
 * @see LayoutType
 *
 *
 */
 
class com.blocketpc.managers.layoutmanager.LayoutLayer
{
	/**
	 * Reference to the timeline of the system
	 */
	private var _base:MovieClip;
	
	/**
	 * Depth of the layer that this class is going to create
	 */
	private var _depth:Number;
	
	/**
	 * List of LayoutItems associated to it
	 */
	private var _itemList:Array;
	
	/**
	 * Reference
	 */ 
	private var _reference:MovieClip;
	
	/**
	 * The layer's name that identifies it into the system
	 */ 
	private var _id:String;
	
	/**
	 * The layer orientation
	 */ 
	private var _orientation:String = LayoutOrientation.PORTRAIT;
	
	/**
	 * The layer alingment
	 */
	private var _align:String = LayoutPosition.MC;
	
	/**
	 * Horizontal type position of the layer
	 */
	private var _typePosX:String;
	
	/**
	 * Vertical type position of the layer
	 */
	private var _typePosY:String;
	
	/**
	 * This property is used to control the horizontal position of the layer
	 */
	private var _disX:Number;
	
	/**
	 * This property is used to control the vertical position of the layer
	 */
	private var _disY:Number;
	
	/**
	 * Width type of the layer
	 */
	private var _typeWidth:String;
	
	/**
	 * Height type of the layer
	 */
	private var _typeHeight:String;
	
	/**
	 * Layer's width
	 */
	private var _width:Number;
	
	/**
	 * Layer's height
	 */
	private var _height:Number;
	
	/**
	 * This property is used to control some changes related to the layer's width
	 */
	private var _finalWidth:Number;
	
	/**
	 * This property is used to control some changes related to the layer's height
	 */
	private var _finalHeight:Number;

	/**
	 * This property manage the virtual screen width dimension
	 */
	private var _screenWidth:Number;
	
	/**
	 * This property manage the virtual screen height dimension
	 */
	private var _screenHeight: Number;
	
	/**
	* Constructor
	*
	* Set all the properties of the LayoutLayer
	* 
	* @since 16/09/2007
	* @author Marcos
	*
	*/
	public function LayoutLayer(base:MovieClip, identifier:String, d:Number)
	{
		_itemList = new Array();
		_base = base;
		_id = identifier;
		_depth = d;
		_screenWidth = Stage.width;
		_screenHeight = Stage.height;
	}
	
	/**
	* Getter for the id property
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	* 
	*/
	public function getId():String
	{
		return _id;
	}
	
	/**
	* Update the alingment of the layer.
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	* @param mode: the new alingment for this Layer
	* 
	*/
	public function setAlignment(mode:String): Void
	{
		if (mode != undefined && mode != _align)
		{
			_align = mode;
		}
	}
	
	/**
	* Update the orientation of the layer. Depending the change of the 
	* orientation, the class needs to update some properties swapping their
	* values. 
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	* @param o: the new orientation for this Layer
	* 
	*/
	public function setOrientation(o:String):Void 
	{
		var swap:String;
		
		if (o != _orientation)
		{
			// When the orientation changes, we need to swap these porperties:
			// _typePosX & _typePosY
			// _screenWidth & _screenHeight
			
			switch (o)
			{
				case LayoutOrientation.PORTRAIT:
					swap = _typePosX;
					_typePosX = _typePosY;
					_typePosY = swap;
					
					_screenWidth = Stage.width;
					_screenHeight = Stage.height;
				break;
				
				case LayoutOrientation.LANDSCAPERIGHTHANDED:
				case LayoutOrientation.LANDSCAPELEFTHANDED:
					
					if (_orientation == LayoutOrientation.PORTRAIT)
					{
						swap = _typePosX;
						_typePosX = _typePosY;
						_typePosY = swap;
					}
					
					_screenWidth = Stage.height;
					_screenHeight = Stage.width;
				break;
			}
			
			_orientation = o;
			
			// call to render the new orientation on the screen
			refresh();
		}
	}
	
	/**
	* Set the size of the LayoutLayer
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	* @param typeW: type of the horizontal dimension
	* @param typeH: type of the vertical dimension
	* @param w: with of the layer
	* @param h: height of the layer 
	* 
	*/
	public function setSize(typeW:String, typeH:String, w:Number, h:Number):Void
	{	
		switch (_typeWidth)
		{
			case LayoutType.ABSOLUTE:
				_finalWidth = w;
			break;
			case LayoutType.RELATIVE:
				if (w<0)
				{
					// when the type it's relative and the width  is 0 or less, set the value to 1.
					w = 1;
				}
				else if (w>100)
				{
					// if the type it's relative and the width is more than 100, set the value to 100
					w = 100;
				}
				_finalWidth = _screenWidth*w/100;
			break;
		}
		_typeWidth = typeW;
		_width = w;

		switch (_typeHeight)
		{
			case LayoutType.ABSOLUTE:
				_finalHeight = h;
			break;
			case LayoutType.RELATIVE:
				if (h<0)
				{
					// when the type it's relative and the height  is 0 or less, set the value to 1.
					h = 1;
				}
				else if (h>100)
				{
					// if the type it's relative and the height is more than 100, set the value to 100
					h = 100;
				}
				_finalHeight = _screenHeight*h/100;
			break;
		}
		_typeHeight = typeH;
		_height = h;
		
		// Create a rectangular shape to position de items 
		// over it
		_reference.clear();
		_reference.removeMovieClip();
		_reference = _base.createEmptyMovieClip(_id,_depth);
		_reference.beginFill(0xffcc00,100);
		//_reference.lineStyle(0,0xdddddd,100);
		_reference.moveTo(0,0);
		_reference.lineTo(_finalWidth,0);
		_reference.lineTo(_finalWidth,_finalHeight);
		_reference.lineTo(0,_finalHeight);
		_reference.lineTo(0,0);
		_reference.endFill();
		
		// Hide the reference clip
		_reference._visible = false;
		
		switch (_orientation)
		{
			case LayoutOrientation.PORTRAIT:
				// no _rotation
			break;
			
			case LayoutOrientation.LANDSCAPERIGHTHANDED:
				if (_align != LayoutPosition.SOFT1 && _align != LayoutPosition.SOFT2)
				{
					_reference._rotation = 90;
				}
			break;
			
			case LayoutOrientation.LANDSCAPELEFTHANDED:
				if (_align != LayoutPosition.SOFT1 && _align != LayoutPosition.SOFT2)
				{
					_reference._rotation = -90;
				}
			break;
		}
	}
	
	/**
	* Set the position of the LayoutLayer in the x axis and the y axis
	* 
	* @author Marcos
	* @since 16/09/2007 
	* 
	* @param typePX: type of the x position
	* @param typePY: type of the y position
	* @param dx: the distance to the reference point in the x axis
	* @param dy: the distance to the reference point in the y axis 
	* 
	*/
	public function setPosition(typePX:String,typePY:String,dx:Number,dy:Number): Void
	{
		_typePosX = typePX;
		_typePosY = typePY;
		_disX = dx;
		_disY = dy;
		
		_reference._x = setHorizontalPosition();
		_reference._y = setVerticalPosition();
	}
	
	/**
	* Updates the horizontal position of the Layer on the screen, 
	* depending of its type, alignment and position.
	* 
	* @author Marcos
	* @since 16/09/2007
	*
	* @return the new x position for the layer 
	* 
	*/
	private function setHorizontalPosition():Number
	{
		var posx: Number;

		if (_orientation == LayoutOrientation.PORTRAIT)
		{		
			if (_typePosX == LayoutType.ABSOLUTE)
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.ML:
					case LayoutPosition.BL:
						posx = _disX;
					break;
					
					case LayoutPosition.TC:
					case LayoutPosition.MC:
					case LayoutPosition.BC:
						posx = Math.round((_screenWidth - _finalWidth)/2);
					break;
					
					case LayoutPosition.TR:
					case LayoutPosition.MR:
					case LayoutPosition.BR:
						posx = _screenWidth - _finalWidth - _disX;
					break;
				}
			}
			else
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.ML:
					case LayoutPosition.BL:
						posx = _screenWidth * _disX/100;
					break;
					
					case LayoutPosition.TC:
					case LayoutPosition.MC:
					case LayoutPosition.BC:
						posx = Math.round((_screenWidth - _finalWidth)/2);						
					break;
					
					case LayoutPosition.TR:
					case LayoutPosition.MR:
					case LayoutPosition.BR:
						posx = _screenWidth - _finalWidth - _screenWidth * _disX/100;						
					break;
				}
			}
		}
		else if (_orientation == LayoutOrientation.LANDSCAPERIGHTHANDED)
		{
			if (_typePosX == LayoutType.ABSOLUTE)
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.TC:
					case LayoutPosition.TR:
						posx = _screenHeight - _disY;
					break;
					
					case LayoutPosition.ML:
					case LayoutPosition.MC:
					case LayoutPosition.MR:
						posx = Math.round(_screenHeight/2 + _finalHeight/2);
					break;
					
					case LayoutPosition.BL:
					case LayoutPosition.BC:
					case LayoutPosition.BR:
						posx = _finalHeight + _disY;
					break;
				}
			}
			else
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.TC:
					case LayoutPosition.TR:
						posx = _screenHeight - _screenHeight * _disY/100;
					break;
					
					case LayoutPosition.ML:
					case LayoutPosition.MC:
					case LayoutPosition.MR:
						posx = Math.round(_screenHeight/2 + _finalHeight/2);						
					break;
					
					case LayoutPosition.BL:
					case LayoutPosition.BC:
					case LayoutPosition.BR:
						posx = _finalHeight + _screenHeight * _disY/100;						
						break;
					}
				}	
		}
		else // LANDSCAPELEFTHANDED
		{
			if (_typePosX == LayoutType.ABSOLUTE)
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.TC:
					case LayoutPosition.TR:
						posx = _disY;
					break;
					
					case LayoutPosition.ML:
					case LayoutPosition.MC:
					case LayoutPosition.MR:
						posx = Math.round(_screenHeight/2 - _finalHeight/2);
					break;
					
					case LayoutPosition.BL:
					case LayoutPosition.BC:
					case LayoutPosition.BR:
						posx = _screenHeight - _finalHeight - _disY;
					break;
				}
			}
			else
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.TC:
					case LayoutPosition.TR:
						posx = _screenHeight * _disY/100;
					break;
					
					case LayoutPosition.ML:
					case LayoutPosition.MC:
					case LayoutPosition.MR:
						posx = Math.round(_screenHeight/2 - _finalHeight/2);						
					break;
					
					case LayoutPosition.BL:
					case LayoutPosition.BC:
					case LayoutPosition.BR:
						posx = _screenHeight - _finalHeight - _screenHeight * _disY/100;						
					break;
				}
			}
		}
		
		// This two cases are wrote for softkeys layers,
		// which have a different behavior
		if (_align == LayoutPosition.SOFT1)
		{
			return 0;
		}
		else if (_align == LayoutPosition.SOFT2)
		{
			return (_screenWidth - _finalWidth);
		}	
		
		return posx;
	}
	
	/**
	* Updates the vertical position of the Layer on the screen, 
	* depending of its type, alignment and position.
	* 
	* @author Marcos
	* @since 16/09/2007
	*
	* @return the new y position for the layer 
	* 
	*/
	private function setVerticalPosition():Number
	{
		var posy:Number;
		
		if (_orientation == LayoutOrientation.PORTRAIT)
		{
			if (_typePosY == LayoutType.ABSOLUTE)
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.TC:
					case LayoutPosition.TR:
						posy = _disY;
					break;
					
					case LayoutPosition.ML:
					case LayoutPosition.MC:
					case LayoutPosition.MR:
						posy = Math.round((_screenHeight - _finalHeight)/2);
					break;
					
					case LayoutPosition.BL:
					case LayoutPosition.BC:
					case LayoutPosition.BR:
						posy = _screenHeight - _finalHeight - _disY;
					break;
				}
			}
			else
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.TC:
					case LayoutPosition.TR:
						posy = _screenHeight * _disY/100;
					break;
					
					case LayoutPosition.ML:
					case LayoutPosition.MC:
					case LayoutPosition.MR:
						posy = Math.round((_screenHeight - _finalHeight)/2);
					break;
					
					case LayoutPosition.BL:
					case LayoutPosition.BC:
					case LayoutPosition.BR:
						posy = _screenHeight - _finalHeight - _screenHeight * _disY/100;
					break;
				}
			}
		}
		else if (_orientation == LayoutOrientation.LANDSCAPERIGHTHANDED)
		{
			if (_typePosY == LayoutType.ABSOLUTE)
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.ML:
					case LayoutPosition.BL:
						posy = _disX;
					break;
					
					case LayoutPosition.TC:
					case LayoutPosition.MC:
					case LayoutPosition.BC:
						posy = Math.round(_screenWidth/2 - _finalWidth/2);					
					break;
					
					case LayoutPosition.TR:
					case LayoutPosition.MR:
					case LayoutPosition.BR:
						posy = _screenWidth - _finalWidth - _disX;
					break;
				}
			}
			else
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.ML:
					case LayoutPosition.BL:
						posy = _screenWidth * _disX/100;
					break;
					
					case LayoutPosition.TC:
					case LayoutPosition.MC:
					case LayoutPosition.BC:
						posy = Math.round(_screenWidth/2 - _finalWidth/2);
					break;
					
					case LayoutPosition.TR:
					case LayoutPosition.MR:
					case LayoutPosition.BR:
						posy = _screenWidth - _finalWidth - _screenWidth * _disX/100;
					break;
				}
			}
		}
		else // LANDSCAPELEFTHANDED
		{
			if (_typePosY == LayoutType.ABSOLUTE)
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.ML:
					case LayoutPosition.BL:
						posy = _screenWidth - _disX;
					break;
					
					case LayoutPosition.TC:
					case LayoutPosition.MC:
					case LayoutPosition.BC:
						posy = Math.round(_screenWidth/2 + _finalWidth/2);
					break;
					
					case LayoutPosition.TR:
					case LayoutPosition.MR:
					case LayoutPosition.BR:
						posy = _disX + _finalWidth;
					break;
				}
			}
			else
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.ML:
					case LayoutPosition.BL:
						posy = _screenWidth - _screenWidth * _disX/100;
					break;
					
					case LayoutPosition.TC:
					case LayoutPosition.MC:
					case LayoutPosition.BC:
						posy = Math.round(_screenWidth/2 + _finalWidth/2);
					break;
					
					case LayoutPosition.TR:
					case LayoutPosition.MR:
					case LayoutPosition.BR:
						posy = _screenWidth * _disX/100 + _finalWidth;
					break;
				}
			}
		}
		
		// This two cases are wrote for softkeys layers,
		// which have a different behavior
		if (_align == LayoutPosition.SOFT1 || _align == LayoutPosition.SOFT2)
		{
			return _screenHeight - _finalHeight;
		}
		
		return posy;
	}
	
	/**
	* Refresh the aspect and the position of the layer on the screen, setting its size,
	* its position and updating all the LayoutItems linked to it.
	* 
	* @author Marcos
	* @since 16/09/2007
	
	*/
	public function refresh():Void 
	{	
		setSize(_typeWidth, _typeHeight, _width, _height);
		setPosition(_typePosX,_typePosY,_disX,_disY);
		
		updateItems();
	}
	
	/**
	* This method returns the index of an LayoutItem in the item list (an array)
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	*/
	private function getIndexOf(idItem:String):Number
	{
		var position:Number = -1;
		var count: Number = 0;
		
		while (position==-1 && count < _itemList.length)
		{
			if (_itemList[count].getIdentifier() == idItem)
			{
				position = count;
			}
			else
			{
				count++;
			}
		}
		
		return position;
	}
	
	/**
	* Link a new LayoutItem to the Layer, and insert it into the item list of the layer 
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	* @param id: the identifier of the LayoutItem to link
	* @param mc: the reference to the movieclip in the stage, associated to the LayoutItem
	* @param typX: the type of the horizontal position
	* @param typY: the type of the vertical position
	* @param algn: the alignment of the new LayoutItem
	* @param dx: distance to the reference point in the x axis
	* @param dy: distance to the reference point in the y axis
	* @param offx: offset in the x axis of the clip associated to the LayouItem
	* @param offy: offset in the y axis of the clip associated to the LayoutItem
	* @param anim: boolean value that indicates if the changes are animated or not
	* 
	*/
	public function addItem(id:String, mc:MovieClip, typX:String, typY:String, algn:String, dx:Number, dy:Number, offx:Number, offy:Number, anim:Boolean):Void
	{
		var newLayoutItem:LayoutItem = new LayoutItem(id, mc, typX, typY, algn, dx, dy, offx, offy, anim);
		_itemList.push(newLayoutItem);
	}
	
	/**
	* This method remove the item with the identifier id from the item list of the
	* LayoutLayer.
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	* @param id: the identifier of the LayoutItem to remove
	* 
	* @return true if the LayoutItem is removed, or false in other case.
	* 
	*/
	public function removeItem(id:String):Boolean
	{
		var pos:Number = getIndexOf(id);
		if (pos == -1)
		{
			// The item is not in the list
			return false;
		}
		else
		{
			_itemList[pos].destroy();
			_itemList.splice(pos,1);
			return true;
		}
	}
	
	/**
	* Update the LayoutItems associated to this LayoutLayer. 
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	*/
	private function updateItems():Void
	{
		var i:Number = 0;
		for (i=0; i<_itemList.length; i++)
		{
			_itemList[i].update(_reference._x, _reference._y, _reference._width, _reference._height, _orientation);
		}
	}
	
	/**
	* Event triggered when the screen size changes
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	*/
	public function onResize():Void 
	{
		_screenWidth = Stage.width;
		_screenHeight = Stage.height;
		
		/*
			trace("************** ON RESIZE ***********");
			trace("screen width: "+_screenWidth);
			trace("screen height: "+_screenHeight);
			trace("************************************");
		*/
	
		refresh();
	}
	
	/**
	* Destroy all the LayoutItems of the Layer and destroy the Layer
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	*/
	public function destroy():Void
	{
		var i:Number;
		for (i=_itemList.length-1; i>=0; i--)
		{
			_itemList[i].destroy();
			_itemList.pop();
		}
	}
}
