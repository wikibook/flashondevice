package flexUnitTests
{
	import com.elad.calculator.utils.CalculatorLogicHelper;
	
	import flexunit.framework.TestCase;
	
	public class Calculator extends TestCase
	{
		public function Calculator(methodName:String=null)
		{
			super(methodName);
		}
		
		public function testAdditionMethod():void
		{
			var result:Number = CalculatorLogicHelper.addition(5,5);
			assertEquals(result,10);
		}
		
		public function testSubtractionMethod():void
		{
			var result:Number = CalculatorLogicHelper.subtraction(5,5);
			assertEquals(result,0);
		}
		
		public function testMultiplicationMethod():void
		{
			var result:Number = CalculatorLogicHelper.multiplication(5,5);
			assertEquals(result,25);
		}
		
		public function testDivisionMethod():void
		{
			var result:Number = CalculatorLogicHelper.division(5,5);
			assertEquals(result,1);
		}
	}
}