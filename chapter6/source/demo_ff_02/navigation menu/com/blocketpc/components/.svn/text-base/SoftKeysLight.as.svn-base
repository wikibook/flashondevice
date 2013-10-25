/**
 * Component to show the softkeys.
 * This component sets also the fscommand2 SetSoftKeys and controls the screen position with the
 * fscommand2 GetSoftKeyLocation.
 *
 * @version 0.4.0
 * @author Raul Jimenez
 * 
 * @see AbstractObject
 */

import com.blocketpc.AbstractObject;

class com.blocketpc.components.SoftKeysLight extends AbstractObject
{
	private var softLeft:MovieClip;
	private var softRight:MovieClip;
	private var screenPos:Number;
	
	/**
	 * Constructor
	 */
	public function SoftKeysLight()
	{
		Stage.addListener(this);
	}
	
	private function onResize():Void
	{
		screenPos = fscommand2("GetSoftKeyLocation");
		
		this._x = 0;
		this._y = 0;
		
		switch (screenPos)
		{
			case 0:
				//TOP
				softLeft._x = 0;
				softLeft._y = 0;
				
				softRight._x = Stage.width - softRight._width;
				softRight._y = 0;
			break;
			
			case 1:
				//LEFT
				softLeft._x = 0;
				softLeft._y = Stage.height - softLeft._height;
				
				softRight._x = 0;
				softRight._y = Stage.height - softRight._height;
			break;
			
			case 2:
				//BOTTOM
				softLeft._x = 0;
				softLeft._y = Stage.height - softLeft._height;
				
				softRight._x = Stage.width - softRight._width;
				softRight._y = Stage.height - softRight._height;
			break;
			
			case 3:
				//RIGHT
				softLeft._x = Stage.width - softLeft._width;
				softLeft._y = Stage.height - softLeft._height;
				
				softRight._x = Stage.width - softRight._width;
				softRight._y = 0;
			break;
		}
	}
	
	/**
	 * Set the names for the softkeys. Pass null or undefined if you want to disable the softkey.
	 * 
	 * @param leftKey: The name to show for the left softkey.
	 * @param rightKey: The name to show for the right softkey.
	 */
	public function setSoftKeys(leftKey:String, rightKey:String):Void
	{
		fscommand2("SetSoftKeys", leftKey, rightKey);
		
		softLeft.title_txt.text = leftKey;		softRight.title_txt.text = rightKey;
		
		if (leftKey == null || leftKey == undefined || leftKey == "") softLeft._visible = false;
		else  softLeft._visible = true;
		if (rightKey == null || rightKey == undefined || rightKey == "") softRight._visible = false;
		else  softRight._visible = true;
	}
}
