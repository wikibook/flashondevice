/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  POC project

 @internal 

 */

package com.elad.application.model.presentation
{
	import com.elad.application.events.UserSelectedFeedEvent;
	import com.elad.application.model.domain.LibraryModel;
	import com.elad.application.vo.FeedVO;
	import com.elad.application.vo.FeedsCollectionVO;
	
    [Bindable]
    /**
     *
     * Defines the <code>MainPM<code> Value Object implementation
     *
     */
	public class FeedsPanelViewerPM extends AbstractPM
	{
		/**
		 *
		 * Define an instance of the <code>LibraryModel</code>
		 * 
		 */				
		public var libraryModel:LibraryModel;
		
		public var panelTitle:String;
		public var selectedFeed:FeedVO;

		private var _feedsCollection:FeedsCollectionVO = new FeedsCollectionVO();
		public function set feedsCollection(value:FeedsCollectionVO):void
		{
			_feedsCollection = value;
		}
		public function get feedsCollection():FeedsCollectionVO
		{
			return _feedsCollection;
		}
						
		/**
		 * Defualt constractor set the <code>LibraryModel</code>
		 * 
		 * @param LibraryModel
		 * 
		 */				
		public function FeedsPanelViewerPM(libraryModel:LibraryModel)
		{
			this.libraryModel = libraryModel;
		}
		
		/**
		 * Method to update selected feed item uppon selecting item in list
		 *  
		 * @param feed	selected feed
		 * 
		 */		
		public function changeSelectedFeed(feed:FeedVO):void
		{
			new UserSelectedFeedEvent(feed).dispatch();
		}
	}
}
