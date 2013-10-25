import com.blocketpc.managers.AbstractManager;
import com.blocketpc.view.AbstractView;
 * library clips.
 * 
 * @see AbstractManager
 * @see AbstractView
 */
{
	private var addToHistory:Boolean = true;
	* 
	/**
	* 
		this._currentScreen = String(inValue);
		screen_mc = _scope.attachMovie(_currentScreen, "screen_mc", 1);
		
		if (addToHistory)
		{
			if (_currentHistory != (history.length-1)) history = history.slice(0, _currentHistory);
			
			_currentHistory = history.length;
			history.push(screen_mc);
		}
		
		dispatchEvent({type: ON_CHANGE_SCREEN, screen: screen_mc});
		
		addToHistory = true;
	
	* Public getter.
	* 
	* @param inValue: String value of current clip name
	*/
	public function get currentScreen():String
	* 
	
	/**
	* Public getter.
	* 
	* @return inValue: Number value of history limit
	*/
	 * 
	/**
	 * Loads the previous screen in history.
	 */
		addToHistory = false;
		_currentHistory--;
	/**
	 * Loads the next screen in history.
	 */
	public function next():Void
		addToHistory = false;
		_currentHistory++;