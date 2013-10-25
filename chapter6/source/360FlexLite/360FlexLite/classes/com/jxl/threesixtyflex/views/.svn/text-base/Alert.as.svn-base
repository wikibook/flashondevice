import com.jxl.shuriken.core.UIComponent;
import com.jxl.shuriken.controls.LinkButton;
import com.jxl.shuriken.events.ShurikenEvent;
import com.jxl.shuriken.events.Event;
import com.jxl.shuriken.events.Callback;

class com.jxl.threesixtyflex.views.Alert extends UIComponent
{
	public static var SYMBOL_NAME:String 		= "com.jxl.threesixtyflex.views.Alert";
	
	public static var EVENT_OK:String 			= "ok";
	
	private var __msg_txt:TextField;
	private var __ok_lb:LinkButton;
	
	private var __okCallback:Callback;
	
	public function Alert()
	{
	}
	
	public function onLoad():Void
	{
		Selection.setFocus(__ok_lb);
	}
	
	private function createChildren():Void
	{
		super.createChildren();
		
		if(__msg_txt == null)
		{
			__msg_txt = createLabel("__msg_txt");
			__msg_txt.autoSize = "left";
			var tf:TextFormat = __msg_txt.getTextFormat();
			tf.align = TextField.ALIGN_CENTER;
			__msg_txt.setNewTextFormat(tf);
			__msg_txt.multiline = true;
			__msg_txt.wordWrap = false;
		}
		
		if(__ok_lb == null)
		{
			__ok_lb = LinkButton(createComponent(LinkButton, "__ok_lb"));
			__ok_lb.setReleaseCallback(this, onOK);
			var oTF:TextFormat = __ok_lb.textField.getTextFormat();
			oTF.bold = true;
			__ok_lb.textField.setNewTextFormat(oTF);
			__ok_lb.label = "OK";
		}
	}
	
	private function redraw():Void
	{
		super.redraw();
		
		__msg_txt.setSize(__width, __msg_txt.textField.textHeight + 4);
		__msg_txt.move( (__width / 2) - (__msg_txt._width / 2), (__height / 2) - (__msg_txt._height / 2) - 8);
		
		__ok_lb.setSize(__ok_lb.textField.textWidth + 4, __ok_lb.textField.textHeight + 4);
		__ok_lb.move( (__width / 2) - (__ok_lb.width / 2), __msg_txt._y + __msg_txt._height);
	}
	
	private function onOK(event:ShurikenEvent):Void
	{
		__okCallback.dispatch(new Event(EVENT_OK, this));
	}
	
	public function setMessage(str:String):Void
	{
		__msg_txt.text = str;
		invalidate();
	}
	
	public function setOkCallback(scope:Object, func:Function):Void
	{
		__okCallback = new Callback(scope, func);
	}
}