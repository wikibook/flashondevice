
/**
 * @author Administrador
 */
import com.blocketpc.managers.Navigation;
import com.blocketpc.managers.AbstractManager;
import com.blocketpc.managers.KeyManager;
import com.blocketpc.view.AbstractView;

class litedays.view.Evento extends AbstractView
{
	public function Evento()
	{
		this._alpha = 0;
	}
	
	private function initialize():Void
	{
		KeyManager.getInstance().addEventListener(KeyManager.ON_PRESS_KEY, this, "onPressKey");
		
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
