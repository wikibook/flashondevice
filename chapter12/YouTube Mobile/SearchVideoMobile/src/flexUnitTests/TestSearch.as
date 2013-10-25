package flexUnitTests
{
	import flexunit.framework.TestCase;
	
	public class TestSearch extends TestCase
	{
		// please note that all test methods should start with 'test' and should be public
		
		public function TestSearch(methodName:String=null)
		{
			//TODO: implement function
			super(methodName);
		}
		
		//This method will be called before every test function
		override public function setUp():void
		{
			//TODO: implement function
			super.setUp();
		}
		
		//This method will be called after every test function
		override public function tearDown():void
		{
			//TODO: implement function
			super.tearDown();
		}
		
		public function testSampleMethod():void
		{
			// Add your test logic here
			fail("Test method Not yet implemented");
		}
	}
}