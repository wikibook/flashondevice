import com.blocketpc.managers.AbstractManager;

import org.asapframework.events.EventDelegate;
{
	private var addToHistory:Boolean = true;
	public static var ON_CHANGE_SCREEN:String = "onChangeScreen";
	/**
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
	public function get currentScreen():String
		addToHistory = false;
		_currentHistory--;
	/**
		addToHistory = false;
		_currentHistory++;