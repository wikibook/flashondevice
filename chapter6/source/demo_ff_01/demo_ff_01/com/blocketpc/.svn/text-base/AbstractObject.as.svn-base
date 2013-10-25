import com.blocketpc.utils.GDispatcher;

/**
 * Abstract class for AbstractView and components.
 * Extend your class with AbstractObject to create new visual components or objects that needs to extend MovieClip.
 * With AbstractObject you can dispatch events.
 * 
 * @version 0.4.0
 * @author Raul Jimenez
 * 
 * @see AbstractView
 * @see GDispatcher
 * 
 */
class com.blocketpc.AbstractObject extends MovieClip
{
	private var dispatchEvent:Function;
	public var addEventListener:Function;
	public var removeEventListener:Function;
	public var removeAllEventListeners:Function;
	
	/**
	 * Constructor
	 */
	public function AbstractObject()
	{
		GDispatcher.initialize(this);
	}
}