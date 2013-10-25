
/**
 * @author Administrador
 */
import com.blocketpc.managers.KeyManager;

import org.asapframework.util.ObjectUtils;

import com.blocketpc.managers.AbstractManager;
import com.blocketpc.components.SoftKeysLight;
import com.blocketpc.managers.Navigation;
import com.blocketpc.view.AbstractView;

class litedays.Application extends AbstractView
{
	private var softKeys:SoftKeysLight;

	public function Application()
	{
		softKeys._visible = false;
	}
	
	private function initialize():Void
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		softKeys.setSoftKeys(null, "Salir");
		softKeys._visible = true;
		
		_focusrect = _global.useFocusRect == false;
		
		System.security.loadPolicyFile("http://www.blocketpc.com/crossdomain.xml");
		fscommand2("fullscreen", "true");
		
		Navigation.getInstance().initialize(this);
		Navigation.getInstance().currentScreen = "Home";
		Navigation.getInstance().addEventListener(Navigation.ON_CHANGE_SCREEN, this, "onChangeScreen");
		
		KeyManager.getInstance().addEventListener(KeyManager.ON_PRESS_KEY, this, "onPressKey");
	}
	
	private function onPressKey(evt:Object):Void
	{
		switch (evt.key)
		{
			case ExtendedKey.SOFT2:
				fscommand2("Quit");
			break;
		}
	}
	
	private function onChangeScreen(evt:Object):Void
	{
		switch (Navigation.getInstance().currentScreen)
		{
			case "Home":
				softKeys.setSoftKeys(null, "Salir");
			break;
			
			default:
				softKeys.setSoftKeys("Inicio", "Salir");
			break;
		}
	}
}
