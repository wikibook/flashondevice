/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  ProjectName

 @internal 

 */

package com.elad.application.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.elad.application.events.UserSelectedFeedEvent;
	import com.elad.application.model.ModelLocator;
	import com.elad.application.vo.FeedVO;
	
	import mx.logging.Log;
	
    /**
     *
     * Defines the associated <code>ICommand</code> implementation for 
     * the "UserSelectedFeed" use-case.
     *
     * <p>
     * The <code>UserSelectedFeedCommand</code> is utilized to abstract the 
     * handling of an <code>UserSelectedFeedEvent</code>
     * </p>
     *
     * @see com.elad.application.events.UserSelectedFeedEvent
     * @see com.adobe.cairngorm.commands.ICommand
     *
     */
	public final class UserSelectedFeedCommand implements ICommand
	{
		/**
		 *
		 * Defines a local convenience reference to the application 
		 * <code>ModelLocator</code> implementations
		 *
		 */	
		private var modelLocator:ModelLocator = ModelLocator.getInstance();
		
	    /**
	     *
	     * <code>ICommand</code> implementation which handles an 
	     * <code>UserSelectedFeedEvent</code>.
	     * 
	     * <p>
         * The <code>UserSelectedFeedCommand</code> does not require a specific 
         * service invocation to be made, therefore the handling of an 
         * <code>UserSelectedFeedEvent</code> is completely managed by the 
         * <code>UserSelectedFeedCommand</code>.
	     * </p>
	     *
	     */
		public function execute(event:CairngormEvent) : void
		{
			Log.getLogger("com.elad.application.commands.UserSelectedFeedCommand").info("execute");
			var evt:UserSelectedFeedEvent = event as UserSelectedFeedEvent;
			
			modelLocator.feedsPanelViewerPM.selectedFeed = evt.selectedFeed;
		}
	}
}