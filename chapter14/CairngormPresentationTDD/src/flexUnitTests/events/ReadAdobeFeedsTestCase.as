package flexUnitTests.events
{
	import com.elad.application.events.ReadAdobeFeedsEvent;
	import com.elad.application.model.ModelLocator;
	
	import flash.events.Event;
	
	import flexunit.framework.Assert;
	import flexunit.framework.TestCase;
	
	import mx.binding.utils.ChangeWatcher;
	
	public class ReadAdobeFeedsTestCase extends TestCase
	{

		[Bindable]
		private var modelLocator:ModelLocator = ModelLocator.getInstance();	
		
		private var watcherInstance:ChangeWatcher;	
		
		public function ReadAdobeFeedsTestCase(methodName:String=null)
		{
			super(methodName);
		}
		
		public function testReadAdobeFeedsEvent():void
		{
			watcherInstance = ChangeWatcher.watch(modelLocator.feedsPanelViewerPM,["feedsCollection"],
				addAsync(itemsChanged, 2000, {compareResults: 0}, failFunc));
				
			new ReadAdobeFeedsEvent().dispatch();
		}
		
		private function itemsChanged(event:Event, data:Object):void
		{
			var len:int = modelLocator.feedsPanelViewerPM.feedsCollection.collection.length;
			Assert.assertTrue("Collection is empty", len>data.compareResults);
		}
		
		private function failFunc(data:Object):void
		{
			fail("Couldn't connect to Adobe feeds and update application model");
		}		
	}
}