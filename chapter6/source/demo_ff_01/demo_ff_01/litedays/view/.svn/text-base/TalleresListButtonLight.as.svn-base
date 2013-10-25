
/**
 * @author Administrador
 */
import com.blocketpc.components.ListButtonLight;

class litedays.view.TalleresListButtonLight extends ListButtonLight
{
	private var hour_txt:TextField;
	private var autor_txt:TextField;
	
	public function TalleresListButtonLight()
	{
		super();
	}
	
	public function set data(obj:Object):Void
	{
		_data = obj;
		hour_txt.text = data.hour;
		title_txt.text = data.title;
		autor_txt.text = data.autor;
	}
	public function get data():Object
	{
		return _data;
	}
}
