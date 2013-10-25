
/**
 * @author Administrador
 */
import org.asapframework.events.EventDelegate;

import com.blocketpc.components.ButtonLight;
import com.blocketpc.managers.Navigation;
import com.blocketpc.managers.AbstractManager;
import com.blocketpc.managers.KeyManager;
import com.blocketpc.view.AbstractView;

class litedays.view.Home extends AbstractView
{
	private var evento:ButtonLight;
	private var talleres:ButtonLight;
	private var lugar:ButtonLight;
	private var inscripcion:ButtonLight;

	public function Home()
	{
		this._alpha = 0;
	}

	private function initialize():Void
	{
		evento.title = "Evento";
		talleres.title = "Talleres";
		lugar.title = "Lugar";
		inscripcion.title = "Inscripcion";
		
		evento.onPress = EventDelegate.create(this, onPressButton, "Evento");
		talleres.onPress = EventDelegate.create(this, onPressButton, "Talleres");
		lugar.onPress = EventDelegate.create(this, onPressButton, "Lugar");
		inscripcion.onPress = EventDelegate.create(this, onPressButton, "Inscripcion");
		
		open();
	}
	
	private function onPressButton(section:String):Void
	{
		changeToScreen = section;
		close();
	}

	private function onClose():Void
	{
		Navigation.getInstance().currentScreen = changeToScreen;
	}
}
