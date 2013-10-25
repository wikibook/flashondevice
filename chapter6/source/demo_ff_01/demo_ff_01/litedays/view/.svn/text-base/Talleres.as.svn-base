
/**
 * @author Administrador
 */
import org.asapframework.util.ObjectUtils;
import org.asapframework.events.EventDelegate;

import com.blocketpc.utils.JSON;
import com.blocketpc.components.ListLight;
import com.blocketpc.managers.Navigation;
import com.blocketpc.managers.AbstractManager;
import com.blocketpc.managers.KeyManager;
import com.blocketpc.view.AbstractView;

class litedays.view.Talleres extends AbstractView
{
	private var list:ListLight;
	private var dataLoader:LoadVars;

	public function Talleres()
	{
		this._alpha = 0;
	}
	
	private function initialize():Void
	{
		KeyManager.getInstance().addEventListener(KeyManager.ON_PRESS_KEY, this, "onPressKey");
		
		
		dataLoader = new LoadVars();
		dataLoader.onLoad = EventDelegate.create(this, onLoadData);
		dataLoader.load("http://www.blocketpc.com/litedays/json/talleres.txt");
	}
	
	private function onLoadData():Void
	{
		var oResult:Object;
		var temp_array:Array = new Array();
		var json:JSON = new JSON();
		var jsonStr:String = dataLoader.toString();
		jsonStr = unescape(jsonStr.split("=&onLoad=[type Function]")[0]);
		
		try
		{
			oResult = json.parse(jsonStr);
			for (var i=0; i<oResult.talleres.length; i++)
			{
				var tObj:Object = new Object();
				tObj.hour = oResult.talleres[i].hora;
				tObj.title = oResult.talleres[i].titulo;
				tObj.autor = oResult.talleres[i].autor;
				temp_array.push(tObj);
			}
		}
		catch(ex)
		{
			trace(ex.name + ":" + ex.message + ":" + ex.at + ":" + ex.text);
		}
		
		dataLoader = null;
		
		list.listButtonRender = "talleresListButtonLight";
		list.initialize(temp_array);
		list.setSize(235, 220);
		
		open();
	}
	
	private function onPressKey(evt:Object):Void
	{
		switch (evt.key)
		{
			case ExtendedKey.SOFT1:
				KeyManager.getInstance().removeEventListener(KeyManager.ON_PRESS_KEY, this, "onPressKey");
				changeToScreen = "Home";
				close();
			break;
		}
	}
	
	private function onClose():Void
	{
		Navigation.getInstance().currentScreen = changeToScreen;
	}
}
