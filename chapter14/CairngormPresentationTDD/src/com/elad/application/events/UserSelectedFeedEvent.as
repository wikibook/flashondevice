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
	import com.elad.application.vo.FeedVO;

    /**
     *
     * Defines the "UserSelectedFeed" use-case which represent a specific
     * user based event or system event.
     *
     * @see com.adobe.cairngorm.control.CairngormEvent
     *
     */
	public final class UserSelectedFeedEvent extends CairngormEvent
	{
	    /**
	     *
	     * Defines the constant for the unique the <code>UserSelectedFeedEvent</code>
	     *
	     * <p>
	     * The fully qualified classpath "com.elad.application.events.UserSelectedFeedEvent"
	     * is utilized to guarantee a unique Event type.
	     * </p>
	     *
	     * @see com.adobe.cairngorm.control.CairngormEvent
	     *
	     */
		public static const USERSELECTEDFEED_EVENT:String = "com.elad.application.events.UserSelectedFeedEvent";

		/**
		 * User selected Feed 
		 */		
		public var selectedFeed:FeedVO;
		
		/**
		 *
		 * Creates a new instance of <code>UserSelectedFeedEvent</code>.
		 * 
		 * @see USERSELECTEDFEED_EVENT;
		 *
		 */
		public function UserSelectedFeedEvent(selectedFeed:FeedVO) 
		{
			this.selectedFeed = selectedFeed;
			super( USERSELECTEDFEED_EVENT );
		}
	}
}
