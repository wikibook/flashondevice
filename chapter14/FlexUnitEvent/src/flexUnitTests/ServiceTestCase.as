package flexUnitTests
{
	import flexunit.framework.TestCase;
	
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class ServiceTestCase extends TestCase
	{
		private var service:HTTPService;
		
		public function ServiceTestCase(methodName:String=null)
		{
			super(methodName);
		}
		
		override public function setUp():void
		{
			service = new HTTPService();
			service.url = "http://rss.adobe.com/en/resources_flex.rss";
			service.resultFormat = "e4x";
		}
		
		override public function tearDown():void
		{
			service = null;
		}
		
		public function testServiceCall():void
		{
		    service.addEventListener(ResultEvent.RESULT, addAsync(serviceResultEventHandler, 2000, {expectedResults: "Flex News"}, failFunction));
		    service.send();			
		}
		
		private function serviceResultEventHandler(event:ResultEvent, data:Object):void 
		{
			var val:String = event.result[0].channel.title;
			assertTrue("Unable to retrieve Flex News feeds", val, data.expectedResults);
		}
		
		private function failFunction(data:Object):void 
		{
			fail("Unable to connect to Flex News feeds");
		}
	}
}