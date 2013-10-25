/*

 Copyright (c) 2008 Elrom LLC. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny at gmail.com
 @project  Project Name

 @internal 

 */
package flexUnitTests
{
	import flexunit.framework.TestSuite;
	
	public class TestSuiteClass extends TestSuite
	{
		/**
		 * Class constructor.  If you provide a contstructor in a <code>TestCase</code> subclass, 
		 * you should ensure that this constructor is called.
		 * 
		 * @param param	The name of the test method to be called in the test run.
		 * 
		 */		
		public function TestSuiteClass(param:Object=null)
		{
			super(param);
		}
		
		/**
		 * Holds the test to be run.
		 * 
		 * @return new instance of the <code>TestSuite</code>
		 * 
		 */		
		public static function suite():TestSuite
		{
			var newTestSuite:TestSuite = new TestSuite();
			return newTestSuite;
		}
	}
}