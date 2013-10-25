package flexUnitTests
{
	import flexunit.framework.TestSuite;
	
	public class GesturesTestSuite extends TestSuite
	{
		public function GesturesTestSuite(param:Object=null)
		{
			super(param);
		}
		
		// this method shall be called when this suite is selected for running.
		public static function suite():TestSuite
		{
			var newTestSuite:TestSuite = new TestSuite();
			return newTestSuite;
		}
	}
}