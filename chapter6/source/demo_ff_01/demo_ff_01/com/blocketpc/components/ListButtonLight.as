﻿/**
 * Class to renderize the cells in ListLight
 * 
 * @version 0.4.0
 * @author Raul Jimenez
 * 
 * @see AbstractView
 * @see ListLight
 */
import com.blocketpc.AbstractObject;

import org.asapframework.events.EventDelegate;
import org.asapframework.util.ObjectUtils;
import com.blocketpc.view.AbstractView;

class com.blocketpc.components.ListButtonLight extends AbstractObject
{
	private var _data:Object;
	private var title_txt:TextField;
	
	/**
	 * Constructor
	 */
	public function ListButtonLight()
	{
		this.stop();
	}
	
	public function set data(obj:Object):Void
	{
		_data = obj;
		title_txt.text = data.title;
	}
	public function get data():Object
	{
		return _data;
	}
}