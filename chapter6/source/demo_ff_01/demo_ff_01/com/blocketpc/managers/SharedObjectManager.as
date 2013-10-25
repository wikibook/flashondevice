import com.blocketpc.managers.AbstractManager;

/**
 * Manager for SharedObjects. Dispatch an event when the data it's created, saved or loaded.
 * 
 * @see AbstractManager
 * @see GDispatcher
 */
class com.blocketpc.managers.SharedObjectManager extends AbstractManager
{
	private var object_so:SharedObject;
	
	public static var ON_INIT_SO = "onInitSO";
	public static var ON_SAVE_SO = "onSaveSO";	public static var ON_LOAD_SO = "onLoadSO";
	
	/**
	 * Constructor.
	 */
	public function SharedObjectManager()
	{
		object_so = new SharedObject();
	}
	
	/**
	 * Creates the SharedObject file.
	 * 
	 * @param name_str: Name of the SharedObject to create.
	 */
	public function init(name_str:String):Void 
	{
		//trace("init()");
		
		SharedObject.addListener(name_str, onLoad);
		object_so = SharedObject.getLocal(name_str);
		object_so._scope = this;
	}
	
	/**
	 * Triggered when the SharedObject file has been created.
	 * Dispatchs an event with true if the file exists, or false if the file not exists.
	 * 
	 * @param data_so: SharedObject created.
	 */
	private function onLoad(data_so:SharedObject):Void 
	{
		//trace("onLoad(): " + data_so.getSize());
		
		var exists_bol:Boolean = new Boolean();
		
		if (data_so.getSize() != 0)
		{
			exists_bol =  true;
		}
		else
		{
			exists_bol =  false;
		}
		
		data_so._scope.dispatchEvent({type:ON_INIT_SO, target:exists_bol});
	}
	
	/**
	 * Loads the SharedObject file.
	 * Dispatchs an event with the data loaded.
	 */
	public function loadSO():Void 
	{
		//trace("loadSO()");
		
		dispatchEvent({type:ON_LOAD_SO, target:object_so});
	}
	
	/**
	 * Saves the SharedObject file.
	 * Dispatchs an event with "ok" if the data has been successfully saved.
	 * 
	 * @param data_obj: Data to save.
	 */
	public function saveSO(data_obj:Object):Void 
	{
		//trace("saveSO()");
		
		for (var i in data_obj)
		{
			object_so.data[i] = data_obj[i];
		}
		
		object_so.data.initialized = true;
		object_so.flush();
				
		
		dispatchEvent({type:ON_SAVE_SO, target:"ok"});
	}
}

