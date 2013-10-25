package flexUnitTests.proxies
{
	import com.andculture.puremvcflexunittesting.PureMVCNotificationEvent;
	import com.andculture.puremvcflexunittesting.PureMVCTestCase;
	import com.elad.TDDPureMVC.model.FeedsPanelViewerProxy;
	
	import flexunit.framework.Assert;
	
	import org.puremvc.as3.core.View;
	import org.puremvc.as3.interfaces.IView;
	
	public class ReadAdobeFeedsTestCase extends PureMVCTestCase
	{
		override public function setUp():void
		{
			var facade:ApplicationFacade = ApplicationFacade.getInstance();
			facade.registerProxy( new FeedsPanelViewerProxy() );
		}
		
		private function get proxy():FeedsPanelViewerProxy 
		{
			var retVal:FeedsPanelViewerProxy = ApplicationFacade.getInstance().retrieveProxy(FeedsPanelViewerProxy.NAME) as FeedsPanelViewerProxy;
			return retVal;
		}
		
		private function get view():IView 
		{
			return View.getInstance();
		}
				
		public function ReadAdobeFeedsTestCase(methodName:String=null)
		{
			super(methodName);
		}
		
		public function testReadAdobeFeedsEvent():void
		{
			registerObserver(this.view, this.proxy, FeedsPanelViewerProxy.READ_ADOBE_FEEDS_SUCCESS, handleResponse, 300);
			this.proxy.getAdobeFeeds();
		}
		
		private function handleResponse(e:PureMVCNotificationEvent):void 
		{
			Assert.assertEquals("Feed title is incorrect", proxy.panelTitle, "Flex News");
		}		 
	}
}