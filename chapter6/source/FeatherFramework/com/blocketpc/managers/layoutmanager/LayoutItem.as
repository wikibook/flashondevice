import com.blocketpc.managers.layoutmanager.LayoutOrientation;
import com.blocketpc.managers.layoutmanager.LayoutPosition;
import com.blocketpc.managers.layoutmanager.LayoutType;
import gs.TweenLite;
import gs.easing.Quad;

/**
 * This class control the possition of the linked movieclip
 * relative to the LayoutManager associated with it.
 * 
 * @author Marcos
 * @version 1.0
 *  
 * @see LayoutManager
 * @see LayoutLayer
 * @see LayoutOrientation
 * @see LayoutPosition
 * @see LayoutType
 * 
 */
class com.blocketpc.managers.layoutmanager.LayoutItem
{
	/** 
	 * The id of the LayoutItem
	 */ 
	private var _identifier:String;
	
	/**
	 * Reference to the movieclip linked with the LayoutItem
	 */
	private var _target:MovieClip;
	
	/**
	 * Type of the horizontal position 
	 */ 
	private var _typePosX:String;
	
	/**
	 * Type of the vertical position
	 */
	private var _typePosY:String;
	
	/**
	 * The alignment of the LayoutItem
	 */
	private var _align: String;
	
	/**
	 * Horizontal distance relative to its alignment
	 */
	private var _disX:Number;
	
	/**
	 * Vertical distance relative to its alignment
	 */
	private var _disY:Number;
	
	/**
	 * Distance from the registration point to the left corner of the
	 * movieclip linked with this LayoutItem
	 */ 
	private var _offsetX:Number;
	
	/**
	 * Distance from the registration point to the top corner of the
	 * movieclip linked with this LayoutItem
	 */
	private var _offsetY:Number;
	
	/*
	 * This property says if the change on the screen is animated or not
	 */
	private var _animated:Boolean;
	
	/**
	* Constructor
	* Set all the properties of the LayoutItem
	* 
	* @since 16/09/2007
	* @author Marcos
	*
	*/
	public function LayoutItem(id:String, tgt:MovieClip, typX:String, typY:String, align:String, dx:Number, dy:Number, offx:Number, offy:Number, anim:Boolean)
	{	
		_identifier = id;
		_target = tgt;
		_typePosX = typX;
		_typePosY = typY;
		_align = align;
		_disX = dx;
		_disY = dy;
		_offsetX = offx;
		_offsetY = offy;
		_animated = anim;
	}

	/**
	* Update the position and orientation of the movieclip linked with it.
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	* @param posxmng: x position of the associated LayoutManager
	* @param posymng: y position of the associated LayoutManager
	* @param widthmng: width of the associated LayoutManager
	* @param heightmng: height of the associated LayoutManager
	* @param orien: orientation of the associated LayoutManager
	* 
	*/
	public function update(posxmng: Number, posymng:Number, widthmng:Number, heightmng:Number, orient:String):Void
	{
		var tempRotation:Number;
		var finalRotation:Number;
		var tempX:Number;
		var tempY:Number;
		
		tempRotation = _target._rotation;
		// Update the orientation of the movieclip
		switch (orient)
		{
			case LayoutOrientation.PORTRAIT:
				_target._rotation = 0;
				finalRotation = 0;
			break;
			
			case LayoutOrientation.LANDSCAPERIGHTHANDED:
				_target._rotation = 90;
				finalRotation = 90;
			break;
			
			case LayoutOrientation.LANDSCAPELEFTHANDED:
				_target._rotation = -90;
				finalRotation = -90;
			break;
		}

		//Update the position of the movieclip
		//_target._x = horizontalUpdate(posxmng,/*posymng,*/widthmng,/*heightmng,*/orient);
		//_target._y = verticalUpdate(/*posxmng,*/posymng,/*widthmng,*/heightmng,orient);
		
		tempX = horizontalUpdate(posxmng,/*posymng,*/widthmng,/*heightmng,*/orient);
		tempY = verticalUpdate(/*posxmng,*/posymng,/*widthmng,*/heightmng,orient);
		
		if (_animated)
		{
			_target._rotation = tempRotation;
			
			// MODIFICATION
			// Autor: Marcos
			// Date: 14.12.2008
			// Description: 
			// Use of TweenLite instead Ladislav Zigo Tweens, for better memory usage and
			// improvements in tweening rendering.
			 TweenLite.to(_target, 0.8, {delay:0, _x:tempX, _y:tempY, _rotation:finalRotation, ease:Quad.easeOut, overwrite:false});
			//_target.tween(["_x","_y","_rotation"],[tempX,tempY,finalRotation],1.5,"easeOutQuad",0);
			// END MODIFICATION
		}
		else
		{
			_target._x = tempX;
			_target._y = tempY;
		}
	}
	
	/**
	* Update the x position of the movieclip. It's important to know that 90º degrees rotation of a movieclip
	* produces a swap between the values of his width and height. First of all we check the value of the
	* orientation, and then check the LayoutType. The last step is update the x value depending the alignment.
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	* @param posxmng: the x value of the manager associated with the clip
	* @param widthmng: the with of the manager associated with the clip
	* @param o: the orientation selected 
	* 
	* @return the new movieclip x position
	*
	*/
	private function horizontalUpdate(posxmng:Number, /*posymng:Number,*/ widthmng:Number/*, heightmng:Number*/, o:String):Number
	{
		var posx:Number;
		
		if (o == LayoutOrientation.PORTRAIT)
		{
			if (_typePosX == LayoutType.ABSOLUTE)
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.ML:
					case LayoutPosition.BL:
						posx = posxmng + _disX + _offsetX;
					break;
					
					case LayoutPosition.TC:
					case LayoutPosition.MC:
					case LayoutPosition.BC:
						posx = posxmng + Math.round((widthmng - _target._width)/2) + _offsetX;
					break;
					
					case LayoutPosition.TR:
					case LayoutPosition.MR:
					case LayoutPosition.BR:
						posx = posxmng + (widthmng - _target._width - _disX) + _offsetX;
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
						posx = posxmng + widthmng * _disX/100 + _offsetX;
					break;
					
					case LayoutPosition.TC:
					case LayoutPosition.MC:
					case LayoutPosition.BC:
						posx = posxmng + Math.round((widthmng - _target._width)/2) + _offsetX;						
					break;
					
					case LayoutPosition.TR:
					case LayoutPosition.MR:
					case LayoutPosition.BR:
						posx = posxmng + (widthmng - _target._width - widthmng * _disX/100) + _offsetX;						
					break;
				}
			}
		}
		else if (o == LayoutOrientation.LANDSCAPERIGHTHANDED)
		{
			if (_typePosX == LayoutType.ABSOLUTE)
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.TC:
					case LayoutPosition.TR:
						posx = posxmng - _disY;
					break;
					
					case LayoutPosition.ML:
					case LayoutPosition.MC:
					case LayoutPosition.MR:
						posx = posxmng - Math.round((widthmng - _target._width)/2) - _offsetY;
					break;
					
					case LayoutPosition.BL:
					case LayoutPosition.BC:
					case LayoutPosition.BR:
						posx = posxmng - (widthmng - _target._width - _disY) - _offsetY;
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
						posx = posxmng - widthmng * _disY/100;
					break;
					
					case LayoutPosition.ML:
					case LayoutPosition.MC:
					case LayoutPosition.MR:
						posx = posxmng - Math.round((widthmng - _target._width)/2) - _offsetY;
					break;
					
					case LayoutPosition.BL:
					case LayoutPosition.BC:
					case LayoutPosition.BR:
						posx = posxmng - (widthmng - _target._width - widthmng * _disY/100) - _offsetY;
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
						posx = posxmng + _disY + _offsetY;
					break;
					
					case LayoutPosition.ML:
					case LayoutPosition.MC:
					case LayoutPosition.MR:
						posx = posxmng + Math.round((widthmng - _target._width)/2) + _offsetY;
					break;
					
					case LayoutPosition.BL:
					case LayoutPosition.BC:
					case LayoutPosition.BR:
						posx = posxmng + (widthmng - _target._width - _disY) + _offsetY;
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
						posx = posxmng + widthmng * _disY/100 + _offsetY;
					break;
					
					case LayoutPosition.ML:
					case LayoutPosition.MC:
					case LayoutPosition.MR:
						posx = posxmng + Math.round((widthmng - _target._width)/2) + _offsetY;
					break;
					
					case LayoutPosition.BL:
					case LayoutPosition.BC:
					case LayoutPosition.BR:
						posx = posxmng + (widthmng - _target._width - widthmng * _disY/100) + _offsetY;
					break;
				}
			}
		}
			
		return posx;
	}
	
	/**
	* Update the y position of the movieclip. It's important to know that 90º degrees rotation of a movieclip
	* produces a swap between the values of his width and height. First of all we check the value of the
	* orientation, and then check the LayoutType. The last step is update the y value depending the alignment.
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	* @param posymng: the y value of the manager associated with the clip
	* @param heightmng: the height of the manager associated with the clip
	* @param o: the orientation selected 
	* 
	* @return the new movieclip y position
	*
	*/
	private function verticalUpdate(/*posxmng:Number,*/ posymng:Number, /*widthmng:Number,*/ heightmng:Number, o:String):Number
	{
		var posy:Number;
		if (o == LayoutOrientation.PORTRAIT)
		{
			if (_typePosY == LayoutType.ABSOLUTE)
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.TC:
					case LayoutPosition.TR:
						posy = posymng + _disY + _offsetY;
					break;
					
					case LayoutPosition.ML:
					case LayoutPosition.MC:
					case LayoutPosition.MR:
						posy = posymng + Math.round(heightmng/2 - _target._height/2) + _offsetY;
					break;
					
					case LayoutPosition.BL:
					case LayoutPosition.BC:
					case LayoutPosition.BR:
						posy = posymng + (heightmng - _target._height - _disY) + _offsetY;
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
						posy = posymng + heightmng * _disY/100 + _offsetY;
					break;
					
					case LayoutPosition.ML:
					case LayoutPosition.MC:
					case LayoutPosition.MR:
						posy = posymng + Math.round(heightmng/2 - _target._height/2) + _offsetY;
					break;
					
					case LayoutPosition.BL:
					case LayoutPosition.BC:
					case LayoutPosition.BR:
						posy = posymng + (heightmng - _target._height - heightmng * _disY/100) + _offsetY;
					break;
				}
			}
		}
		else if (o == LayoutOrientation.LANDSCAPERIGHTHANDED)
		{
			if (_typePosY == LayoutType.ABSOLUTE)
			{
				switch (_align)
				{
					case LayoutPosition.TL:
					case LayoutPosition.ML:
					case LayoutPosition.BL:
						posy = posymng + _disX;
					break;
					
					case LayoutPosition.TC:
					case LayoutPosition.MC:
					case LayoutPosition.BC:
						posy = posymng + Math.round(heightmng/2 - _target._height/2) + _offsetX;
					break;
					
					case LayoutPosition.TR:
					case LayoutPosition.MR:
					case LayoutPosition.BR:
						posy = posymng + (heightmng - _target._height - _disX) + _offsetX;
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
						posy = posymng + heightmng * _disX/100;
					break;
					
					case LayoutPosition.TC:
					case LayoutPosition.MC:
					case LayoutPosition.BC:
						posy = posymng + Math.round(heightmng/2 - _target._height/2) + _offsetX;
					break;
					
					case LayoutPosition.TR:
					case LayoutPosition.MR:
					case LayoutPosition.BR:
						posy = posymng + (heightmng - _target._height - heightmng * _disX/100) + _offsetX;
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
						posy = posymng - _disX - _offsetX;
					break;
					
					case LayoutPosition.TC:
					case LayoutPosition.MC:
					case LayoutPosition.BC:
						posy = posymng - Math.round(heightmng/2 - _target._height/2)- _offsetX;
					break;
					
					case LayoutPosition.TR:
					case LayoutPosition.MR:
					case LayoutPosition.BR:
						posy = posymng - (heightmng - _target._height - _disX) - _offsetX;
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
						posy = posymng - heightmng * _disX/100 - _offsetX;
					break;
					
					case LayoutPosition.TC:
					case LayoutPosition.MC:
					case LayoutPosition.BC:
						posy = posymng - Math.round(heightmng/2 - _target._height/2) - _offsetX;
					break;
					
					case LayoutPosition.TR:
					case LayoutPosition.MR:
					case LayoutPosition.BR:
						posy = posymng - (heightmng - _target._height - heightmng * _disX/100) - _offsetX;
					break;
				}
			}
		}		
		
		return posy;
	}
	
	/**
	* Destroy the movieclip reference and the LayoutItem object
	* 
	* @author Marcos
	* @since 16/09/2007
	*
	*/
	public function destroy():Void 
	{
		_target = null;
		delete this;
	}
}