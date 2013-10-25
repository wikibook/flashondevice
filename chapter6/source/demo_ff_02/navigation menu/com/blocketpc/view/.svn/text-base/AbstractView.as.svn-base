import com.blocketpc.AbstractObject;
import com.blocketpc.managers.TransitionManager;
import com.blocketpc.managers.KeyManager;
import com.blocketpc.view.IView;

import org.asapframework.events.EventDelegate;
import org.asapframework.util.FrameDelay;

import gs.easing.Cubic;
import gs.TweenLite;


/**
 * Abstract class for screens.
 * Extend your class with AbstractView to create new screens.
 * 
 * @see AbstractObject
 * @see TransitionManager
 * @see KeyManager
 * @see IView
 * @see EventDelegate
 * @see FrameDelay
 * @see TweenLite
 */
class com.blocketpc.view.AbstractView extends AbstractObject
{
	public var changeToScreen:String;
	
	/**
	 * Constructor and waits one frame to trigger the initialize function.
	 * This is a quick way to ensure that both, class and movieclip, are initialized. 
	 */
	public function AbstractView()
	{
		var f:FrameDelay = new FrameDelay(this, initialize);
		Stage.addListener(this);
	}
	
	/**
	 * Override this function to initialize your screen class.
	 */
	public function initialize():Void
	{
		trace("OVERRIDE initialize!");
	}
	
	/**
	 * Override this function to resize your content in your class.
	 */
	public function onResize():Void
	{
		trace("OVERRIDE onResize!");
	}
	
	/**
	 * Call this function when you are ready to open your screen.
	 * You can select your transition effect with the TransitionManager.
	 * 
	 * @see TransitionManager
	 */
	public function open():Void
	{
		TransitionManager.getInstance().openTransition.onComplete = EventDelegate.create(this, onOpen);
		TransitionManager.getInstance().closeTransition.onComplete = EventDelegate.create(this, onClose);
		TweenLite.to(this, TransitionManager.getInstance().time, TransitionManager.getInstance().openTransition);
	}
	
	/**
	 * This function is triggered when the screen it's opened.
	 * For example, you can override onOpen to call a web service or start an animation.
	 */
	public function onOpen():Void
	{
		trace("OVERRIDE onOpen!");
	}
	
	/**
	 * Call this function when you are ready to close your screen.
	 * You can select your transition effect with the TransitionManager.
	 * This method erases your listeners at KeyManager.
	 * 
	 * @see TransitionManager
	 * @see KeyManager
	 */
	public function close():Void
	{
		KeyManager.getInstance().removeAllEventListeners();
		
		TweenLite.to(this, TransitionManager.getInstance().time, TransitionManager.getInstance().closeTransition);
	}
	
	/**
	 * This function is triggered when the screen it's closed.
	 * For example, you can override onClose to call another screen or close the application.
	 */
	public function onClose():Void
	{
		trace("OVERRIDE onClose!");
	}
}