/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  ProjectName

 @internal 

 */

package com.elad.application.commands.services
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.elad.application.business.ReadAdobeFeedsDelegate;
	import com.elad.application.events.PreInitializationCommandCompleted;
	import com.elad.application.events.ReadAdobeFeedsEvent;
	import com.elad.application.model.ModelLocator;
	import com.elad.application.vo.FeedVO;
	import com.elad.application.vo.FeedsCollectionVO;
	
	import mx.logging.Log;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
    /**
     *
     * Defines the associated <code>ICommand</code> implementation for 
     * an "ReadAdobeFeeds" use-case.
     *
     * <p>
     * The <code>ReadAdobeFeedsCommand</code> is utilized to abstract the 
     * handling of a <code>ReadAdobeFeedsEvent</code>.
     * </p>
     *    
     * @see com.elad.application.events.ReadAdobeFeedsEvent
     * @see com.adobe.cairngorm.commands.ICommand
     *
     */
	public final class ReadAdobeFeedsCommand implements ICommand, IResponder
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
	     * Concrete <code>ICommand</code> implementation which handles 
	     * an <code>ReadAdobeFeedsEvent</code>.
	     *
	     */
		public function execute(event:CairngormEvent) : void
		{
			Log.getLogger("com.elad.application.commands.ReadAdobeFeedsCommand").info("execute");
			
			var evt:ReadAdobeFeedsEvent = event as ReadAdobeFeedsEvent;
			var delegate:ReadAdobeFeedsDelegate = new ReadAdobeFeedsDelegate( this );
			
			delegate.readAdobeFeeds();
		}
		
	    /**
	     *
	     * Handles the service result of the <code>ReadAdobeFeedsDelegate</code> 
	     * service invocation.
	     *
	     * @see mx.rpc.events.ResultEvent
	     *
	     */
		public function result(data:Object) : void
		{
			Log.getLogger("com.elad.application.commands.ReadAdobeFeedsCommand").info("result");
			var result:ResultEvent = data as ResultEvent;
			var feed:FeedVO;
			var ob:Object;
			var len:int = result.result[0].channel.item.length();
			var collection:FeedsCollectionVO = new FeedsCollectionVO;
			
			for (var i:int=0; i<len; i++)
			{
				feed = new FeedVO();
				ob = result.result[0].channel.item[i];
				
				feed.author = ob.author;
				feed.category = ob.category;
				feed.description = ob.description;
				feed.link = ob.link;
				feed.pubdate = ob.pubdate;
				feed.title = ob.title;
				
				collection.addItem(feed);
			}
			
			modelLocator.feedsPanelViewerPM.feedsCollection = collection;
			modelLocator.feedsPanelViewerPM.panelTitle = result.result.*[0].*[0];
			modelLocator.feedsPanelViewerPM.selectedFeed = 	collection.collection.getItemAt(0) as FeedVO;
			
			// Initialization completed since we don't have any more services
			new PreInitializationCommandCompleted().dispatch();
		}
		
	    /**
	     *
	     * Handles the service fault of the <code>ReadAdobeFeedsDelegate</code> 
	     * service invocation.
	     *
	     * @see mx.rpc.events.ResultEvent
	     *
	     */
		public function fault(info:Object) : void
		{
			var fault:FaultEvent = info as FaultEvent;
			Log.getLogger("com.elad.application.commands.ReadAdobeFeedsCommand").error("fault", fault);
		}
	}
}
