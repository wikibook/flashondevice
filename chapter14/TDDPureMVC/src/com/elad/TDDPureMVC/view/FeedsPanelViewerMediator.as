package com.elad.TDDPureMVC.view
{
	import com.elad.TDDPureMVC.events.UserSelectedFeedEvent;
	import com.elad.TDDPureMVC.model.FeedsPanelViewerProxy;
	import com.elad.TDDPureMVC.model.vo.FeedVO;
	import com.elad.TDDPureMVC.view.components.FeedsPanelViewer;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class FeedsPanelViewerMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'FeedsPanelViewerMediator';
		
		private var feedsPanelViewerProxy:FeedsPanelViewerProxy;
		
		public function FeedsPanelViewerMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			feedsPanelViewer.addEventListener(UserSelectedFeedEvent.USERSELECTEDFEED_EVENT, changeSelectedFeed);
		}

		private function changeSelectedFeed(event:UserSelectedFeedEvent):void
		{
			setDetail(event.selectedFeed);
		}
		
		public function get feedsPanelViewer():FeedsPanelViewer
		{
			return viewComponent as FeedsPanelViewer;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				FeedsPanelViewerProxy.READ_ADOBE_FEEDS_SUCCESS,
				   ];		
		}
		
		private function setDetail(feed:FeedVO):void
		{
			feedsPanelViewer.author.text = feed.author;
			feedsPanelViewer.category.text = feed.category;
			feedsPanelViewer.description.text = feed.description;
			feedsPanelViewer.link.text = feed.link;
			feedsPanelViewer.pubdate.text = feed.pubdate;
		}	
				
		override public function handleNotification(notification:INotification):void
		{
			feedsPanelViewerProxy = facade.retrieveProxy(FeedsPanelViewerProxy.NAME) as FeedsPanelViewerProxy;
			
			switch ( notification.getName() )
			{
				case FeedsPanelViewerProxy.READ_ADOBE_FEEDS_SUCCESS:
					feedsPanelViewer.feedList.dataProvider = feedsPanelViewerProxy.feedsCollectionVO.collection;
					setDetail(feedsPanelViewerProxy.selectedFeed);
					feedsPanelViewer.title = feedsPanelViewerProxy.panelTitle;
					
				break;
			}
		}
	}
}