package com.elad.framework.touchscreen.vo
{
	public class TouchVO
	{
		public function TouchVO(previousX:int=0, previousY:int=0, currentX:int=0, currentY:int=0, moveTimer:int=0)
		{
			this.previousX = previousX;
			this.previousY = previousY;
			this.currentX = currentX;
			this.currentY = currentY;
			this.moveTimer = moveTimer;			
		}
		
		public var previousX:int;
		public var previousY:int;
		public var currentX:int;
		public var currentY:int;
		public var moveTimer:int;
	}
}