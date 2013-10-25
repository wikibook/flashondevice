package flexUnitTests
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import flexunit.framework.TestCase;
	
	public class TimerTestCase extends TestCase
	{
        private var timer:Timer;
        private var timerIntervalFlag:Boolean;
		
		public function TimerTestCase(methodName:String=null)
		{
			super(methodName);
		}
		
		override public function setUp():void
		{
			timerIntervalFlag = false;
		}
		
		override public function tearDown():void
		{
            timer.stop();
            timer = null;
		}
		
		public function testTimer():void 
		{
		    timer = new Timer(1500, 1);
		    timer.addEventListener(TimerEvent.TIMER, function():void { timerIntervalFlag = true } );
		    timer.addEventListener(TimerEvent.TIMER_COMPLETE, addAsync(onTimerCompleteEventHandler, 2000, {expectedResults: true}));
		    timer.start();
		}
		
		private function onTimerCompleteEventHandler(timerEvent:TimerEvent, data:Object):void 
		{
			assertTrue("Interval flag should be true", timerIntervalFlag, data.expectedResults);
		}		
	}
}