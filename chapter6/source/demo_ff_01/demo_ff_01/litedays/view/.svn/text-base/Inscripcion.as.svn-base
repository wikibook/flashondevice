
/**
 * @author Administrador
 */
import com.blocketpc.components.ButtonLight;

import org.asapframework.events.EventDelegate;

import com.blocketpc.managers.Navigation;
import com.blocketpc.managers.AbstractManager;
import com.blocketpc.managers.KeyManager;
import com.blocketpc.view.AbstractView;

class litedays.view.Inscripcion extends AbstractView
{
	private var loader:LoadVars;
	private var nombre_txt:TextField;
	private var apellidos_txt:TextField;
	private var correo_txt:TextField;
	private var result_txt:TextField;
	private var send:ButtonLight;

	public function Inscripcion()
	{
		loader = new LoadVars();
		this._alpha = 0;
		nombre_txt._focusrect = true;
		apellidos_txt._focusrect = true;
		correo_txt._focusrect = true;
	}

	private function initialize():Void
	{
		KeyManager.getInstance().addEventListener(KeyManager.ON_PRESS_KEY, this, "onPressKey");
		
		send.title = "enviar";
		send.onPress = EventDelegate.create(this, sendForm);
		
		open();
	}
	
	private function sendForm():Void
	{
		loader.antispam = "blocketpc";
		loader.nombre = nombre_txt.text;
		loader.apellidos = apellidos_txt.text;
		loader.correo = correo_txt.text;
		
		loader.sendAndLoad("http://www.blocketpc.com/litedays/php/sendform_complete.php", loader, "POST");
		loader.onLoad = EventDelegate.create(this, onLoadData);
		
		result_txt.text = "enviando...";
	}
	
	private function onLoadData():Void
	{
		result_txt.text = "mail enviado";
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
