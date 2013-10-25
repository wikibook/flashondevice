/**
 * Component to show the activated keys.
 * 
 * @version 0.4.0
 * @author Raul Jimenez
 * 
 * @see: AbstractObject
 * @see: KeyManager
 * 
 */

import com.blocketpc.AbstractObject;

class com.blocketpc.components.ArrowsLight extends AbstractObject
{
	private var arrowUp:MovieClip;
	private var arrowRight:MovieClip;
	private var arrowDown:MovieClip;
	private var arrowLeft:MovieClip;	private var arrowEnter:MovieClip;
	
	/**
	 * Constructor
	 */
	public function ArrowsLight()
	{
		
	}
	
	/**
	 * Activates and deactivates the arrows
	 * 
	 * @param showUp: Boolean to show activated or deactivated the Up arrow.
	 * @param showRight: Boolean to show activated or deactivated the Right arrow.
	 * @param showDown: Boolean to show activated or deactivated the Down arrow.
	 * @param showLeft: Boolean to show activated or deactivated the Left arrow.
	 * @param showEnter: Boolean to show activated or deactivated the Enter arrow. 
	 */
	public function setArrows(showUp:Boolean, showRight:Boolean, showDown:Boolean, showLeft:Boolean, showEnter:Boolean):Void
	{
		if (showUp == true) arrowUp.gotoAndStop(1);
		else arrowUp.gotoAndStop(2);
		
		if (showRight == true) arrowRight.gotoAndStop(1);
		else arrowRight.gotoAndStop(2);
		
		if (showDown == true) arrowDown.gotoAndStop(1);
		else arrowDown.gotoAndStop(2);
		
		if (showLeft == true) arrowLeft.gotoAndStop(1);
		else arrowLeft.gotoAndStop(2);
		
		if (showEnter == true) arrowEnter.gotoAndStop(1);
		else arrowEnter.gotoAndStop(2);
	}
}
