package com.elad.mp3tunes.view.W800H480.components
{
	import mx.controls.sliderClasses.SliderThumb;

	public class TrackSliderThumb extends SliderThumb
	{
		public function TrackSliderThumb()
		{
			super();
		}		
	
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
	        super.updateDisplayList(unscaledWidth,unscaledHeight);
	        
	        var x:Number = -5;
	        var y:Number = 5;
	        
	        // Grey border
	        this.graphics.beginFill(0x898989,1);
	        this.graphics.drawCircle(x,y,20);
	        	        
	        // outer circle
	        this.graphics.beginFill(0x000000,1);
	        this.graphics.drawCircle(x,y,18);
	        
	        // inner circle
	        this.graphics.beginFill(0xffffff,1);
	        this.graphics.drawCircle(x,y,9);	        
	       	
	       	this.graphics.endFill();
		}
	}
}