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

    /**
     *
     * Defines the "StartupServices" use-case which represent a specific
     * user based event or system event.
     *
     * @see com.adobe.cairngorm.control.CairngormEvent
     *
     */
	public final class StartupServicesEvent extends CairngormEvent
	{
	    /**
	     *
	     * Defines the constant for the unique the <code>StartupServicesEvent</code>
	     *
	     * <p>
	     * The fully qualified classpath "com.elad.application.events.StartupServicesEvent"
	     * is utilized to guarantee a unique Event type.
	     * </p>
	     *
	     * @see com.adobe.cairngorm.control.CairngormEvent
	     *
	     */
		public static const STARTUPSERVICES_EVENT:String = "com.elad.application.events.StartupServicesEvent";
		
		/**
		 *
		 * Creates a new instance of <code>StartupServicesEvent</code>.
		 * 
		 * @see STARTUPSERVICES_EVENT;
		 *
		 */
		public function StartupServicesEvent() 
		{
			super( STARTUPSERVICES_EVENT );
		}
	}
}
