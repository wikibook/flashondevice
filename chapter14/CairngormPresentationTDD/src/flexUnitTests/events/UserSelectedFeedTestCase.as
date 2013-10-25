package flexUnitTests.events
{
	import com.elad.application.events.UserSelectedFeedEvent;
	import com.elad.application.model.ModelLocator;
	import com.elad.application.vo.FeedVO;
	
	import flash.events.Event;
	
	import flexunit.framework.Assert;
	import flexunit.framework.TestCase;
	
	import mx.binding.utils.ChangeWatcher;
	
	public class UserSelectedFeedTestCase extends TestCase
	{

		[Bindable]
		private var modelLocator:ModelLocator = ModelLocator.getInstance();	

		private var watcherInstance:ChangeWatcher;	
		
		public function UserSelectedFeedTestCase(methodName:String=null)
		{
			super(methodName);
		}
		
		public function testUserSelectedFeedEvent():void
		{
			watcherInstance = ChangeWatcher.watch(modelLocator.feedsPanelViewerPM,["selectedFeed"],
				addAsync(itemChanged, 2000, {compareResults: "Elad"}, failFunc));
			
			var feed:FeedVO = new FeedVO();
			feed.author = "Elad";
			
			new UserSelectedFeedEvent(feed).dispatch();		
		}
		
		private function itemChanged(event:Event, data:Object):void
		{
			var author:String = modelLocator.feedsPanelViewerPM.selectedFeed.author;
			Assert.assertEquals(data.compareResults, author);
		}
		
		private function failFunc(data:Object):void
		{
			fail("Couldn't change selected feed");
		}		
	}
}