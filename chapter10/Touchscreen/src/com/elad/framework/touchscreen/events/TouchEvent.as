package com.elad.framework.touchscreen.events
{
	import com.elad.framework.touchscreen.vo.TouchVO;
	
	import flash.events.Event;
	
	public class TouchEvent extends Event 
	{
	    /**
	     *  Holds the event string name
	     */		
	    public static var TOUCH_DOWN:String = "touchDown";
	    public static var TOUCH_UP:String = "touchUp";
	    public static var TOUCH_DRAG:String = "touchDrag";
	    public static var TOUCH_DROP:String = "touchDrop";
		
		/**
		 * Holds results object 
		 */			
		public var touchVO:TouchVO;
				
		/**
		 * Default constructor
		 *  
		 * @param type	event name
		 * @param videoList	video list collection
		 * 
		 */			
		public function TouchEvent(type:String, touchVO:TouchVO)
		{
			super(type);
			this.touchVO = touchVO;
		}
	}
}