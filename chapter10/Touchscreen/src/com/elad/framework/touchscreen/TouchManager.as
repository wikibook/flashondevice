package com.elad.framework.touchscreen
{
	import com.elad.framework.touchscreen.events.TouchEvent;
	import com.elad.framework.touchscreen.vo.TouchVO;
	
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	
	import mx.core.UIComponent;

	public class TouchManager extends EventDispatcher
	{
		private var moveTimer:Timer;
		private var previousX:int = 0;
		private var previousY:int = 0;
		private var component:UIComponent;
					
		public function TouchManager(component:UIComponent)
		{
			this.component = component;
		}
		
		public function start():void
		{
			initialize();
			this
		}
		
		public function stop():void
		{
			component.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			component.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			
			moveTimer.stop();
			moveTimer = null;
		}		

		protected function initialize():void
		{
			component.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			component.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
		}
		
		private function startTimer():void
		{
			moveTimer = new Timer(100,1000);
			moveTimer.start();
		}
		
		private function onMouseDownHandler(event:MouseEvent):void
		{
			startTimer();
			component.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			
			var touch:TouchVO = new TouchVO(this.previousX, this.previousY, event.localX, event.localY, this.moveTimer.currentCount);
			this.dispatchEvent( new TouchEvent(	TouchEvent.TOUCH_DOWN, touch ) );		
		}
		
		private function onMouseUpHandler(event:MouseEvent):void
		{
			moveTimer.stop();
			component.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			
			var touch:TouchVO = new TouchVO(this.previousX, this.previousY, event.localX, event.localY, this.moveTimer.currentCount);
			this.dispatchEvent( new TouchEvent(	TouchEvent.TOUCH_UP, touch ) );				
		}
		
		private function onMouseMoveHandler(event:MouseEvent):void
		{
			var isMove:Boolean = isTouchMove(event.localX, event.localY);
			var touch:TouchVO = new TouchVO(this.previousX, this.previousY, event.localX, event.localY, this.moveTimer.currentCount);
			
			if (isMove)
			{
				this.dispatchEvent( new TouchEvent(TouchEvent.TOUCH_DRAG, touch) );
			}
		}
		
		private function isTouchMove(x:int, y:int):Boolean
		{
			var retVal:Boolean = false;
			var ignore:int = 3;
			var isXmoved:Boolean;
			var isYmoved:Boolean;
			
			if (previousX != 0 && previousY != 0)
			{
				isXmoved = (x > previousX+ignore || x < previousX-ignore) ? true : false;
				isYmoved = (y > previousY+ignore || y < previousY-ignore) ? true : false;
				
				if ( isXmoved || isYmoved )
				{
					retVal=true;
				}					
			}
			
			previousX = x;
			previousY = y;
			
			return retVal;
		}		
		
	}
}