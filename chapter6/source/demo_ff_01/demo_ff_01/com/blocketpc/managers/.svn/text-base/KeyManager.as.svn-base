import com.blocketpc.managers.AbstractManager;

/**
 * Manager to map the key buttons. Dispatch an event for every key pressed and returns the code of the key.
 * This is a Singleton class.
 * 
 * @see AbstractManager
 * @see GDispatcher
 */
class com.blocketpc.managers.KeyManager extends AbstractManager
{
	private static var _instance:KeyManager = undefined;
	public static var ON_PRESS_KEY:String = "onPressKey";
	
	
	/**
	 * Constructor.
	 */
	public function KeyManager()
	{
		Key.addListener(this);
	}
	
	/**
	 * Singleton constructor.
	 * 
	 * @return A single instance of the KeyManager class.
	 */
	public static function getInstance():KeyManager
	{
		if (_instance == undefined)
		{
			_instance = new KeyManager();
		}
		return _instance;
	}
	
	/**
	 * Dispatchs an event with the code of the key pressed.
	 */
	private function onKeyDown():Void
	{
		dispatchEvent( {type: ON_PRESS_KEY, key:  Key.getCode()} );
	}
}