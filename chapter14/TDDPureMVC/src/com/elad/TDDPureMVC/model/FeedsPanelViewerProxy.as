package com.elad.TDDPureMVC.model
{
	import com.elad.TDDPureMVC.model.vo.FeedVO;
	import com.elad.TDDPureMVC.model.vo.FeedsCollectionVO;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class FeedsPanelViewerProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String = "FeedsPanelViewerProxy";
		public static const READ_ADOBE_FEEDS_SUCCESS:String = 'readAdobeFeedsSuccess';
		public static const READ_ADOBE_FEEDS_FAILED:String = 'readAdobeFeedsFailed';
		public var service:HTTPService;
		
		public function FeedsPanelViewerProxy()
		{
			super(NAME, new FeedsCollectionVO() );
			
			service = new HTTPService();  
            service.url = "http://rss.adobe.com/en/resources_flex.rss";  
            service.resultFormat = "e4x";
			service.addEventListener( FaultEvent.FAULT, onFault );
			service.addEventListener( ResultEvent.RESULT, onResult );
		}
		
		public function getAdobeFeeds():void
		{
			service.send();
		}

		// Cast data object with implicit getter
		public function get feedsCollectionVO():FeedsCollectionVO 
		{
			return data.feedsCollectionVO as FeedsCollectionVO;
		}
		
		public function get selectedFeed():FeedVO 
		{
			return (data.feedsCollectionVO as FeedsCollectionVO).collection.getItemAt(0) as FeedVO;
		}
		
		public function get panelTitle():String 
		{
			return data.panelTitle as String;
		}				

		private function onResult( result:ResultEvent ) : void
		{
			var feed:FeedVO;
			var item:Object;
			var len:int = result.result[0].channel.item.length();
			var collection:FeedsCollectionVO = new FeedsCollectionVO;
			var dataObject:Object = new Object();
			
			for (var i:int=0; i<len; i++)
			{
				feed = new FeedVO();
				item = result.result[0].channel.item[i];
				
				feed.author = item.author;
				feed.category = item.category;
				feed.description = item.description;
				feed.link = item.link;
				feed.pubdate = item.pubdate;
				feed.title = item.title;
				
				collection.addItem(feed);
			}
			
			dataObject.feedsCollectionVO = collection;
			dataObject.panelTitle = String(result.result.*[0].*[0]);
					
			setData(dataObject);
			sendNotification(READ_ADOBE_FEEDS_SUCCESS);						
		}
		
		private function onFault( event:FaultEvent) : void
		{
			sendNotification( READ_ADOBE_FEEDS_FAILED, event.fault.faultString );
		}

	}
}