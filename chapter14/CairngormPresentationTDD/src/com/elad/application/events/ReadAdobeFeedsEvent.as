/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  ProjectName

 @internal 

 */

package com.elad.application.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

    /**
     *
     * Defines the "ReadAdobeFeeds" use-case which represent a specific
     * user based event or system event.
     *
     * @see com.adobe.cairngorm.control.CairngormEvent
     *
     */
	public final class ReadAdobeFeedsEvent extends CairngormEvent
	{
	    /**
	     *
	     * Defines the constant for the unique the <code>ReadAdobeFeedsEvent</code>
	     *
	     * <p>
	     * The fully qualified classpath "com.elad.application.events.ReadAdobeFeedsEvent"
	     * is utilized to guarantee a unique Event type.
	     * </p>
	     *
	     * @see com.adobe.cairngorm.control.CairngormEvent
	     *
	     */
		public static const READADOBEFEEDS_EVENT:String = "com.elad.application.events.ReadAdobeFeedsEvent";
		
		/**
		 *
		 * Creates a new instance of <code>ReadAdobeFeedsEvent</code>.
		 * 
		 * @see READADOBEFEEDS_EVENT;
		 *
		 */
		public function ReadAdobeFeedsEvent() 
		{
			super( READADOBEFEEDS_EVENT );
		}
	}
}
