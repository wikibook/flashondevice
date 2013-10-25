/*

 Copyright (c) 2008 Elrom LLC. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny at gmail.com
 @project  Project Name

 @internal 

 */
package flexUnitTests
{
    import com.elad.view.LogicClass;
    import flexunit.framework.TestCase;
    
    public class TestCaseClass extends TestCase
    {
		/**
		 * A contstructor to pass the method name.
		 * 
		 * @param methodName	The name of the test method to be called in the test run.
		 * 
		 */    	
		public function TestCaseClass(methodName:String=null)
		{
			super(methodName);
		}    	
    	
		/**
		 * First test method to do something 
		 * 
		 */    	
		public function testFirstMethod():void
		{
		    var logic:LogicClass = new LogicClass();
		    assertEquals( "Expecting zero here", 0, logic.firstMethod() );
		}
		
		/**
		 * Second test method to do something 
		 * 
		 */  		
		public function testNextMethod():void
		{
		    var logic:LogicClass = new LogicClass();
		    assertTrue( "Expecting true here", logic.NextMethod()==50 );
		}		
    }
}
