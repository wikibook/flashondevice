
import mx.rpc.ResultEvent;
import mx.rpc.FaultEvent;
import mx.rpc.Responder;

import org.osflash.arp.CommandTemplate;

import com.jxl.threesixtyflex.events.CheckForUpdateEvent;
import com.jxl.threesixtyflex.business.CheckForUpdateDelegate;
import com.jxl.threesixtyflex.callbacks.CheckForUpdateCallback;
import com.jxl.threesixtyflex.model.ModelLocator;

class com.jxl.threesixtyflex.commands.CheckForUpdateCommand extends CommandTemplate implements Responder
{
	private function executeOperation(event:CheckForUpdateEvent):Void
	{
		var cfud:CheckForUpdateDelegate = new CheckForUpdateDelegate(this);
		cfud.checkForUpdate(ModelLocator.getInstance().currentVersion);
	}
	
	public function onResult(result:ResultEvent):Void
	{
		var callback:CheckForUpdateCallback = new CheckForUpdateCallback();
		callback.failed = false;
		if(result.result == false)
		{
			callback.newerVersionAvailable = false;
		}
		else
		{
			callback.newerVersionAvailable = true;
			callback.newVersion = result.result.newVersion;
			callback.updateURL = result.result.updateURL;
		}
		super.result(callback);
	}
	
	public function onFault(status:FaultEvent):Void
	{
		var callback:CheckForUpdateCallback = new CheckForUpdateCallback();
		callback.failed = true;
		super.fault(callback);
	}
}
