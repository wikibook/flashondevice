import com.blocketpc.utils.GDispatcher;

/**
 * Abstract class for managers.
 * Extend your class with AbstractManager to create non-visual objects that needs to dispatch events.
 * 
 * @see AbstractController
 * @see GDispatcher
 */
class com.blocketpc.managers.AbstractManager
{
	private var dispatchEvent:Function;
	public var addEventListener:Function;
	public var removeEventListener:Function;
	public var removeAllEventListeners:Function;
	
	/**
	 * Constructor
	 */
	public function AbstractManager()
	{
		GDispatcher.initialize(this);
	}
}