/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  POC project

 @internal 

 */
 
package com.elad.application.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class PreInitializationCommandCompleted extends CairngormEvent
	{

	    /**
	     *
	     * Defines the constant for the unique the <code>GetSiteIntroEvent</code>
	     *
	     * <p>
	     * The fully qualified classpath "com.elad.application"
	     * is utilized to guarantee a unique Event type.
	     * </p>
	     *
	     * @see com.adobe.cairngorm.control.CairngormEvent
	     *
	     */
		public static const COMPLETED:String = "com.elad.application.events.PreInitializationCommandCompleted";


		public function PreInitializationCommandCompleted(type:String = PreInitializationCommandCompleted.COMPLETED, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}