
/**
 * @author Administrador
 */
import org.asapframework.util.ObjectUtils;
import org.asapframework.events.EventDelegate;

import com.blocketpc.utils.JSON;
import com.blocketpc.managers.AbstractManager;

class com.blocketpc.managers.LocaleManager extends AbstractManager
{
	private static var _instance:LocaleManager = undefined;
	private var language:Object;
	private var langLoader:LoadVars;
	private var registered:Array;
	private var currentLanguage:String = "";
	
	public static var URL_LANGUAGE:String = "./locale/";
	public static var ON_LOAD_LANGUAGE:String = "onLoadLanguage";
	public static var ON_LOAD_LANGUAGE_ERROR:String = "onLoadLanguageError";
	
	private function LocaleManager()
	{
		language = new Object();
		registered = new Array();
	}
	
	/**
	 * Singleton constructor.
	 * 
	 * @return A single instance of the TransitionManager class.
	 */
	public static function getInstance():LocaleManager
	{
		if (_instance == undefined)
		{
			_instance = new LocaleManager();
		}
		return _instance;
	}
	
	/**
	 * Loads the language selected
	 * 
	 * @param language: Language to load and represents the folder where it's the file locale.txt.
	 */
	public function loadLanguage(language:String):Void
	{
		//trace(URL_LANGUAGE + language + "/locale.txt");
		if (currentLanguage != language)
		{
			currentLanguage = language;
			langLoader = new LoadVars();
			langLoader.onLoad = EventDelegate.create(this, onLoadLanguage);
			langLoader.load(URL_LANGUAGE + language + "/locale.txt");
		}
	}
	
	private function onLoadLanguage(success:Boolean):Void
	{
		//trace("language loaded " + success + " - parsing")
		
		if (success)
		{
			var json:JSON = new JSON();
			var jsonStr:String = langLoader.toString();
			jsonStr = unescape(jsonStr.split("=&onLoad=[type Function]")[0]);
			
			try
			{
				language = json.parse(jsonStr);
				changeLanguage();
				
				dispatchEvent({type: ON_LOAD_LANGUAGE});
			}
			catch(ex)
			{
				trace(ex.name + ":" + ex.message + ":" + ex.at + ":" + ex.text);
			}
		}
		else
		{
			dispatchEvent({type: ON_LOAD_LANGUAGE_ERROR});
		}
		
		langLoader = null;
	}
	
	private function changeLanguage():Void
	{
		for (var i:Number=0; i<registered.length; i++)
		{
			registered[i].text = language[registered[i].locale];
		}
	}
	
	/**
	 * 
	 */
	public function register(box:TextField, txt:String):String
	{
		var exists:Boolean = false;
		
		box.locale = txt;
		box.text = language[box.locale];
		
		for (var i:Number=0; i<registered.length; i++)
		{
			if (registered[i] == box) exists = true;
		}
		
		if (!exists) registered.push(box);
		
		return String(language[box.locale]);
	}
	
	/**
	 * 
	 */
	public function unregister(box:TextField):Void
	{
		for (var i:Number=0; i<registered.length; i++)
		{
			if (registered[i] == box) registered.splice(i, 1);
		}
	}
	
	/**
	 * 
	 */
	public function getText(txt:String):String
	{
		return String(language[txt]);
	}
}
