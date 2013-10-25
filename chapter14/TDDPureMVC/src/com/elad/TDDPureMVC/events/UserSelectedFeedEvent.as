/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  ProjectName

 @internal 

 */

package com.elad.TDDPureMVC.events
{
	import com.elad.TDDPureMVC.model.vo.FeedVO;
	
	import flash.events.Event;

	public final class UserSelectedFeedEvent extends Event
	{
		public static const USERSELECTEDFEED_EVENT:String = "com.elad.application.events.UserSelectedFeedEvent";
	
		public var selectedFeed:FeedVO;

		public function UserSelectedFeedEvent(selectedFeed:FeedVO) 
		{
			this.selectedFeed = selectedFeed;
			super( USERSELECTEDFEED_EVENT );
		}
	}
}
