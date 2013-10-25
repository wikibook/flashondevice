import com.blocketpc.utils.GDispatcher;

/**
 * Abstract class for controllers.
 * Extend your class with AbstractController to create non-visual objects that needs to dispatch events.
 * 
 * @see AbstractManager
 * @see GDispatcher
 */
class com.blocketpc.controllers.AbstractController
{
	private var dispatchEvent:Function;
	public var addEventListener:Function;
	public var removeEventListener:Function;
	public var removeAllEventListeners:Function;
	
	/**
	 * Constructor
	 */
	public function AbstractController()
	{
		GDispatcher.initialize(this);
	}
}