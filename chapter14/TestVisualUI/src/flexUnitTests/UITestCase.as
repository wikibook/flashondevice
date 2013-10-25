package flexUnitTests
{
	import com.gorillalogic.flexmonkey.commands.CommandRunner;
	import com.gorillalogic.flexmonkey.commands.FlexCommand;
	import com.gorillalogic.flexmonkey.commands.PauseCommand;
	import com.gorillalogic.flexmonkey.core.MonkeyEvent;
	import com.gorillalogic.flexmonkey.core.MonkeyUtils;
	import com.gorillalogic.flexmonkey.ui.FlexMonkey;
	
	import flash.display.DisplayObject;
	
	import flexunit.framework.Assert;
	import flexunit.framework.TestCase;
	
	import mx.controls.Button;
	import mx.controls.TextInput;
	import mx.events.FlexEvent;


	[Mixin]
	public class UITestCase extends TestCase
	{
		public static function init(root:DisplayObject) : void 
		{
			root.addEventListener(FlexEvent.APPLICATION_COMPLETE, function():void {
			// To run with the FlexMonkey UI
			  FlexMonkey.addTestSuite(UITestCase);
			
			// Uncomment the following line to start tests immediately upon opening the FlexMonkey window (not needed for Ant)
			// FlexMonkey.enableAutoStart();
			
			// To run without the FlexMonkeyUI, use the lines below instead of the ones obove (and link FlexMonkey.swc instead of FlexMonkeyUI.swc)
			// var	antRunner:JUnitTestRunner = new JUnitTestRunner();
			// antRunner.run(new TestSuite(FlexUnitTests));
			   });
		}
		
		// Test test method
		public function testSomething():void 
		{
			var cmdRunner:CommandRunner = new CommandRunner();
			cmdRunner.addEventListener(MonkeyEvent.READY_FOR_VALIDATION, addAsync(verifySomething, 10000));
			cmdRunner.runCommands([
				new FlexCommand("textInput", "SelectText", ["0", "0"], "automationName"),
				new FlexCommand("textInput", "Input", ["150"], "automationName"),
				new FlexCommand("Change button width size", "Click", ["0"], "automationName"),
				new PauseCommand(2500)			
				]);
		}

		// Called after commands have been run
		private function verifySomething(event:MonkeyEvent):void 
		{
			var btn:Button = MonkeyUtils.findComponentWith("clickButton", "id") as Button;
			var txtInput:TextInput = MonkeyUtils.findComponentWith("textInput") as TextInput;
			
			Assert.assertEquals(txtInput.text, btn.width);
		}   
	
	}
}