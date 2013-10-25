/**
 * Component to load a WebService in a light way.
 * Use this light class in replace of the WebService AS2 component.
 * This class dispatchs two events ON_LOAD and ON_ERROR.
 * 
 * @version 0.4.0
 * @author Raul Jimenez
 * 
 * @see GDispatcher
 */

import com.blocketpc.utils.GDispatcher;
import org.asapframework.events.EventDelegate;

class com.blocketpc.components.WebServiceLight
{
	private var dispatchEvent:Function;
	public var addEventListener:Function;
	public var removeEventListener:Function;
	public var removeAllEventListeners:Function;
	
	private var data_xml:XML;
	
	public static var ON_LOAD:String = "onLoadOkWDSL";	public static var ON_ERROR:String = "onLoadErrorWDSL";
	
	/**
	 * Constructor
	 */
	public function WebServiceLight()
	{
		data_xml = new XML();
		data_xml.ignoreWhite = true;
		data_xml.onLoad = EventDelegate.create(this, onLoadWDSL);
		GDispatcher.initialize(this);
	}
	
	/**
	 * Loads the WebService.
	 * 
	 * @param url: URL of the WebService to call.
	 * @param header: Header of the WebService as an XML in String.
	 */
	public function loadWDSL(url:String, header:String):Void
	{
		data_xml = new XML(header);
		data_xml.sendAndLoad(url, data_xml);
	}
	
	private function onLoadWDSL(success:Boolean):Void
	{
		if (success)
		{
			dispatchEvent( {type: ON_LOAD, data: data_xml} );
		}
		else
		{
			dispatchEvent( {type: ON_ERROR} );
		}
	}
}