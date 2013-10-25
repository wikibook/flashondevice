import com.blocketpc.managers.AbstractManager;

import org.asapframework.events.EventDelegate;import com.blocketpc.view.AbstractView;/** * Class to create a navigation */class com.blocketpc.managers.Navigation extends AbstractManager
{	private static var _instance:Navigation;	private var _currentScreen:String;	private var _scope:MovieClip;	private var screen_mc:MovieClip;	private var history:Array;	private var _historyLength:Number = 10;	private var _currentHistory:Number = 0;
	private var addToHistory:Boolean = true;	
	public static var ON_CHANGE_SCREEN:String = "onChangeScreen";		/**	* Constructor	*/	private function Navigation()	{			}		/**	* Singleton Constructor	* 	* @return A single instance of the Navigation class.	*/	public static function getInstance():Navigation	{		if (_instance == undefined)_instance = new Navigation ();		return _instance;	}		/**	* Initializes the class, needs a target clip to attach the movieclip library instances	* @param target MovieClip where you will attach the clips	*/	public function initialize(target:MovieClip):Void	{		_scope = target;		history = new Array(_historyLength);	}	
	/**	* Public getter/setter needs a String with the linkage clip name in the library to attach a clip	* @param inValue Linkage clip name in the Library as String	*/	public function set currentScreen(inValue:String):Void	{
		this._currentScreen = String(inValue);
		screen_mc = _scope.attachMovie(_currentScreen, "screen_mc", 1);
		
		if (addToHistory)
		{
			if (_currentHistory != (history.length-1)) history = history.slice(0, _currentHistory);
			
			_currentHistory = history.length;
			history.push(screen_mc);
		}
		
		dispatchEvent({type: ON_CHANGE_SCREEN, screen: screen_mc});
		
		addToHistory = true;	}
	public function get currentScreen():String	{		return String(this._currentScreen);	}		/**	* Public getter/setter	* @param inValue: Number value to set the history limit	*/	public function set historyLength(inValue:Number):Void	{		this._historyLength = Number(inValue);	}	public function get historyLength():Number	{		return Number(this._historyLength);	}		/**	 * Returns the current AbstractView	 * @return The current attached clip in the Navigation as an AbstractView	 */	public function getClip():AbstractView	{		return AbstractView(screen_mc);	}		/**	 * 	 */	public function back():Void	{
		addToHistory = false;
		_currentHistory--;		currentScreen = history[_currentHistory];	}	
	/**	 * 	 */	public function next():Void	{
		addToHistory = false;
		_currentHistory++;		currentScreen = history[_currentHistory];	}}