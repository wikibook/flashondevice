package com.elad.calculator.utils
{
	public final class CalculatorLogicHelper
	{
		public static function addition(value1:Number, value2:Number):Number
		{
			var retVal:Number = value1+value2;
			return retVal;
		}
		
		public static function subtraction(value1:Number, value2:Number):Number
		{
			var retVal:Number = value1-value2;
			return retVal;
		}
		
		public static function multiplication(value1:Number, value2:Number):Number
		{
			var retVal:Number = value1*value2;
			return retVal;
		}
		
		public static function division(value1:Number, value2:Number):Number
		{
			var retVal:Number = value1/value2;
			return retVal;
		}
	}
}