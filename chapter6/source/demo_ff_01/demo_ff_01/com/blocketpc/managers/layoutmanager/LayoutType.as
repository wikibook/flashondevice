/**
 * This class stores the different values for the type of the position, relative or absolute.
 * 
 * @author Marcos
 * @version 1.0
 * 
 * @see LayoutManager
 * @see LayoutLayer
 * @see LayoutItem
 * @see LayoutOrientation
 * @see LayoutPosition
 * 
 */
class com.blocketpc.managers.layoutmanager.LayoutType
{
	/**
	 * Indicates that the coordinates of the layer are taken in pixels from the origin of the Stage or Layer
	 */
	public static var ABSOLUTE:String = "0";
	
	/**
	 * Indicates that the coordinates of the layer are taken as a percent relative to the 
	 * whole Stage or Layer
	 */
	public static var RELATIVE:String = "1";
}