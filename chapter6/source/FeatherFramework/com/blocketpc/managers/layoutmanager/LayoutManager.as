/**
 *
 * This class manage all the system of Layers. It has a reference to the main timeline and
 * an array of LayoutLayers objects. This class control de depths for the LayoutLayers and 
 * prevent the duplication of Layers.
 * 
 * This class also listen to changes of the Stage size. 
 * 
 * @see LayoutLayer
 * @see LayoutItem
 * @see LayoutOrientation
 * @see LayoutPosition
 * @see LayoutType
 * 
 */
import com.blocketpc.managers.layoutmanager.LayoutLayer;

class com.blocketpc.managers.layoutmanager.LayoutManager 
{
	/**
	 * A reference to the main timeline
	 */ 
	private var _refClip_mc:MovieClip;
	
	/**
	 * The list of LayoutLayers
	 */ 
	private var _layerList_arr:Array;
	
	/**
	 * A property to control the depths of the LayoutLayers the system
	 * will create.
	 */
	private var _depth:Number;
	
	/**
	 * The clip where all the LayoutLayers will be created
	 */
	private var _container_mc:MovieClip;
	
	
	/**
	* Constructor
	* Set the reference to the main timeline, and the depth of clip where all the layers
	* will be created.
	* 
	* @since 16/09/2007
	* @author Marcos
	* 
	*/
	public function LayoutManager(base_mc:MovieClip, d: Number)
	{
		_refClip_mc = base_mc;
		_depth = 0;
		_layerList_arr = new Array();
		_container_mc = _refClip_mc.createEmptyMovieClip("_container_mc",d);
		
		Stage.addListener(this);
	}
	
	/**
	* Create a new LayoutLayer in the system with the identifier pass to it. If
	* a Layer exists with this identifier, return undefined.
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	* @param identifier: the new LayoutLayer identifier
	* 
	* @return the reference to the new LayoutLayer object
	* 
	*/
	public function createLayer(identifier:String):LayoutLayer
	{
		var layerTemp:LayoutLayer;
		var exist:Number = existLayer(identifier);
		
		if (exist < 0)
		{
			_depth++;
			
			layerTemp = new LayoutLayer(_container_mc, identifier, _depth);
			_layerList_arr.push(layerTemp);
			
			return layerTemp;
		}
		else
		{
			return undefined;
		}
	}
	
	/**
	* Set the alignment of the Layer named with the identifier passed to 
	* this method.
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	* @param identifier: the identifier of the Layer that will be changed its alignment
	* @param mode: the new alignment for the layer
	* 
	* @return 1 if the operation was successful, or -1 if not
	* 
	*/
	public function setLayerAlignment(identifier:String, mode:String):Number
	{
		var exist:Number = existLayer(identifier);
		
		if (exist >= 0)
		{
			_layerList_arr[exist].setAlignment(mode);
			return 1;
		}
		else
		{
			return -1;
		}
	}
	
	/**
	* Set the orientation of the Layer named with the identifier passed to 
	* this method.
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	* @param identifier: the identifier of the Layer that will be changed its orientation
	* @param 0: the new orientation for the layer
	* 
	* @return 1 if the operation was successful, or -1 if not
	* 
	*/
	public function setLayerOrientation(identifier:String, o:String):Number
	{
		var exist:Number = existLayer(identifier);
		
		if (exist >= 0)
		{
			_layerList_arr[exist].setOrientation(o);
			return 1;
		}
		else
		{
			return -1;
		}
	}
	
	/**
	* Set the size of the Layer named with the identifier passed to 
	* this method.
	* 
	* @author Marcos
	* @since 16/09/2007 
	* 
	* @param identifier: the identifier of the Layer that will be changed its size
	* @param typeW: the type of the width (relative or absolute)
	* @param typeH: the type of the height (relative or absolute)
	* @param w: the new width value for the layer
	* @param h: the new height value for the layer
	* 
	* @return 1 if the operation was successful, or -1 if not
	* 
	*/
	public function setLayerSize(identifier:String, typeW:String, typeH:String, w:Number, h:Number):Number
	{
		var exist:Number = existLayer(identifier);
		
		if (exist >= 0)
		{
			_layerList_arr[exist].setSize(typeW, typeH, w, h);
			return 1;
		}
		else
		{
			return -1;
		}
	}
	
	/**
	* Set the position of the Layer named with the identifier passed to 
	* this method.
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	* @param identifier: the identifier of the Layer that will be changed its position
	* @param typePX: the type of the horizontal position
	* @param typePY: the type of the vertical position
	* @param dx: distance to the reference point in the x axis
	* @param dy: distance to the reference point in the y axis
	* 
	* @return 1 if the operation was successful, or -1 if not
	* 
	*/
	public function setLayerPosition(identifier:String, typePX:String, typePY:String, dx:Number, dy:Number):Number
	{
		var exist:Number = existLayer(identifier);
		
		if (exist >= 0)
		{
			_layerList_arr[exist].setPosition(typePX,typePY,dx,dy);
			return 1;
		}
		else
		{
			return -1;
		}
	}
	
	/**
	* Link a new LayoutItem to the Layer named with the identifier passed to this method,
	* via addItem method of tye LayoutLayer
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	* @param identifier: the identifier of the LayoutLayer that will be associated with the new LayoutItem
	* @param idItem: the identifier of the new LayoutItem that will be created and linked to the LayoutLayer 
	* named as the idenfifier passed to this method
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
	public function addItem(identifier:String, idItem:String, mc:MovieClip, typX:String, typY:String, algn:String, dx:Number, dy:Number, offx:Number, offy:Number, anim:Boolean):Number
	{
		var exist:Number = existLayer(identifier);
		
		if (exist >= 0)
		{
			_layerList_arr[exist].addItem(idItem, mc, typX, typY, algn, dx, dy, offx, offy, anim);
			return 1;
		}
		else
		{
			return -1;
		}
	}
	
	/**
	* Search a LayoutLayer in the Layers list named with the value of the
	* idSearched passed to this method
	* 
	* @author Marcos
	* @since 16/09/2007
	* 
	* @param idSearched: the identifier of the Layer that will be searched in the layers list
	* 
	* @return A number with the possition in the layers list, or -1 if is not in the layers list.
	* 
	*/
	private function existLayer(idSearched:String):Number
	{
		var finded:Boolean = false;
		var count:Number = 0;
		var totalLayers: Number = _layerList_arr.length;
		
		if (totalLayers == 0)
		{
			return -1;
		}
		else
		{
			while (!finded && count < totalLayers)
			{
				if (_layerList_arr[count].getId() == idSearched)
				{
					finded = true;
					return count;
				}
				else
				{
					count++;
				}
			}
			
			return -1;	
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
		var i:Number = 0;
		
		for (i=0; i<_layerList_arr.length; i++)
		{
			_layerList_arr[i].onResize();
		};
		
		_container_mc._x = 0;
		_container_mc._y = 0;		
	}
}
