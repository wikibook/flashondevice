import gs.easing.Cubic;
import com.blocketpc.managers.AbstractManager;

/**
 * Manager for transitions. You can change your screen transition with this class.
 * This is a Singleton class.
 * 
 * @see AbstractManager
 * @see AbstractView
 * @see TweenLite
 */
class com.blocketpc.managers.TransitionManager extends AbstractManager
{
	private static var _instance:TransitionManager = undefined;
	private var _time:Number = 0.5;
	private var _openTransition:Object;
	private var _closeTransition:Object;
	
	/**
	 * Constructor
	 */
	private function TransitionManager()
	{
		_openTransition = {_alpha:100, ease:Cubic.easeOut};
		_closeTransition = {_alpha:0, ease:Cubic.easeOut};
	}
	
	/**
	 * Singleton constructor.
	 * 
	 * @return A single instance of the TransitionManager class.
	 */
	public static function getInstance():TransitionManager
	{
		if (_instance == undefined)
		{
			_instance = new TransitionManager();
		}
		return _instance;
	}
	
	/**
	 * The current open transition. It's an Object with the transition effect based on <TweenLite> transition objects.
	 */
	public function get openTransition():Object
	{
		return _openTransition;
	}
	public function set openTransition(obj:Object):Void
	{
		_openTransition = obj;
	}
	/**
	 * The current close transition. It's an Object with the transition effect based on <TweenLite> transition objects.
	 */
	public function get closeTransition():Object
	{
		return _closeTransition;
	}
	public function set closeTransition(obj:Object):Void
	{
		_closeTransition = obj;
	}
	/**
	 * The current time transition. A Number with the time transition effect in seconds.
	 */
	public function get time():Number
	{
		return _time;
	}
	public function set time(t:Number):Void
	{
		_time = t;
	}
}