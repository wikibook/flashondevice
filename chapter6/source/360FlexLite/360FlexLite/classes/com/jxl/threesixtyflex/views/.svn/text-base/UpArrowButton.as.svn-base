import com.jxl.shuriken.controls.Button;
import com.jxl.shuriken.utils.DrawUtils;

class com.jxl.threesixtyflex.views.UpArrowButton extends Button
{
	public static var SYMBOL_NAME:String = "com.jxl.threesixtyflex.views.UpArrowButton";
	
	private var __alignIcon:String = ALIGN_ICON_CENTER;
	private var __left_mc:MovieClip;
	private var __center_mc:MovieClip;
	private var __right_mc:MovieClip;
	
	public function UpArrowButton()
	{
	}
	
	private function createChildren():Void
	{
		super.createChildren();
		
		icon = "UpArrowButtonGraphic";
	}
	
	private function redraw():Void
	{
		super.redraw();
		
		clear();
		
		__left_mc._x = __left_mc._y = 0;
		__left_mc._height = __height;
		
		__right_mc._y = 0;
		__right_mc._x = __width - __right_mc._width;
		__right_mc._height = __height;
		
		__center_mc._x = __left_mc._x + __left_mc._width;
		__center_mc._y = 0;
		__center_mc._width = __width - __center_mc._x - __right_mc._width;
		__center_mc._height = __height;
	}
}