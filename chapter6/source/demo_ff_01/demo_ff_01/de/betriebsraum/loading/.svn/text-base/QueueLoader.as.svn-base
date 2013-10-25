/**
 * QueueLoader.
 *
 * @author: Felix Raab, E-Mail: f.raab@betriebsraum.de, Url: http://www.betriebsraum.de
 * @version: 1.1
 
 
   ChangeLog:   
   29.05.2005: 	- Changed event handling (Standard EventDispatcher Implementation)
   				- 2 new methods: addItemAt, removeItemAt
				- Fixed onItemInit event (wrong info object was passed)
				- Little code refactoring
 */ 
 

import mx.events.EventDispatcher;

 
class de.betriebsraum.loading.QueueLoader {
	

	private var dispatchEvent:Function;
	public var addEventListener:Function;
	public var removeEventListener:Function;	
	
	private var mcl:MovieClipLoader;
	private var queuedItems:Array;
	private var itemsToInit:Array;
	private var loadedItems:Array;
	private var currItem:Object;
	private var isStarted:Boolean;
	private var isStopped:Boolean;
	private var isLoading:Boolean;
		
	
	public function QueueLoader() {
		
		EventDispatcher.initialize(this);
		
		mcl = new MovieClipLoader();
		mcl.addListener(this);
		
		reset();
	
	}
	
	
	/***************************************************************************
	// PRIVATE METHODS
	***************************************************************************/	
	private function onLoadStart(target_mc:MovieClip):Void {

		if (isStarted) {
			dispatchEvent({type:"onQueueStart", target:this});
			isStarted = false;		
		}
	
		dispatchEvent({type:"onItemStart", target:this, target_mc:target_mc, info:currItem.info});
		dispatchEvent({type:"onQueueProgress", target:this, target_mc:target_mc, info:currItem.info});
		
	}
	
	
	private function onLoadProgress(target_mc:MovieClip, loadedBytes:Number, totalBytes:Number):Void {	
	
		var percentLoaded:Number = Math.ceil((loadedBytes/totalBytes)*100);
		var kBytesLoaded:Number = loadedBytes/1024;
		var kBytesTotal:Number = totalBytes/1024;
		var kBytesRemaining:Number = kBytesTotal - kBytesLoaded;	
		var kBytesSec:Number = kBytesLoaded/(getTimer()/1000);
		var secondsRemaining:Number = Math.ceil(kBytesRemaining/kBytesSec);
		
		dispatchEvent({type:"onItemProgress", 
					   target:this,
					   target_mc:target_mc, 
					   info:currItem.info,
					   loadedBytes:loadedBytes, 
					   totalBytes:totalBytes, 
					   percentLoaded:percentLoaded,
					   kBytesLoaded:kBytesLoaded,
					   kBytesTotal:kBytesTotal,
					   kBytesRemaining:kBytesRemaining,
					   kBytesSec:kBytesSec,
					   secondsRemaining:secondsRemaining			  
					  });
		
	}	
	
	
	private function onLoadComplete(target_mc:MovieClip):Void {

		dispatchEvent({type:"onItemComplete", target:this, target_mc:target_mc, info:currItem.info});	
		loadedItems.push(target_mc);		
		isQueueComplete();
		
	}	
	
	
	private function onLoadInit(target_mc:MovieClip):Void {

		dispatchEvent({type:"onItemInit", target:this, target_mc:target_mc, info:getQueueObject(target_mc).info});		
		isQueueInit(target_mc);
		
	}	
	
	
	private function onLoadError(target_mc:MovieClip, errorCode:String):Void {	
		
		dispatchEvent({type:"onItemError", target:this, target_mc:target_mc, errorCode:errorCode, info:currItem.info});		
		isQueueComplete();
		isQueueInit(target_mc);
		
	}
	
	
	private function isQueueComplete():Void {
		
		if (!isStopped) {		
			if (queuedItems.length == 0) {	
				isLoading = false;
				dispatchEvent({type:"onQueueComplete", target:this, loadedItems:loadedItems});				
			} else {
				loadNextItem();
			}			
		}
		
	}
	
	
	private function isQueueInit(target_mc:MovieClip):Void {
		
		if (!isStopped) {
			removeFromArray(itemsToInit, target_mc);			
			if (itemsToInit.length == 0) {		
				dispatchEvent({type:"onQueueInit", loadedItems:loadedItems});
			}			
		}
		
	}
	
	
	private function getQueueObject(target_mc:Object):Object {
		
		for (var i:String in itemsToInit) {
			if (itemsToInit[i].target_mc == target_mc) {
				return itemsToInit[i];
			}
		}
		
	}
	
	
	// returns 1, if target_mc is _level1...
	private function filterLevel(target_mc:Object):Object {		
		
		if (target_mc instanceof MovieClip) {
			var path:String = targetPath(target_mc);
			if (path.indexOf(".") == -1) {
				return Number(path.substr(6, path.length));
			}
		}
		
		return target_mc;		
		
	}
	
	
	private function removeFromArray(array:Array, target_mc:Object):Void {		
		
		var target:Object = filterLevel(target_mc);
		
		for (var i:Number = array.length-1; i >= 0; i--) {
			if (array[i].target_mc == target) {
				array.splice(i, 1);
			}			
		}
	
	}
	
	
	private function dequeueItem(target_mc:Object):Void {

		removeFromArray(queuedItems, target_mc);
		removeFromArray(itemsToInit, target_mc);
		
	}
	
	
	private function loadNextItem():Void {		

		currItem = queuedItems.shift();		
		
		if (currItem.target_mc == undefined) {	
			onLoadError(currItem.target_mc, "TargetUndefined");				
		} else {
			if (!isStopped) {				
				mcl.loadClip(currItem.url, currItem.target_mc);
			}
		}	
		
	}
	
	
	private function reset():Void {
		
		queuedItems = new Array();
		itemsToInit = new Array();
		loadedItems = new Array();
		
		delete currItem;		
		
	}
	

	/***************************************************************************
	// PUBLIC METHODS
	***************************************************************************/
	public function addItem(url:String, target_mc:Object, info:Object):Void {
		addItemAt(queuedItems.length, url, target_mc, info);
	}
	
	
	public function addItemAt(index:Number, url:String, target_mc:Object, info:Object):Void {
		
		if (target_mc == undefined) trace("QueueLoader: target undefined for "+url);
		queuedItems.splice(index, 0, {url:url, target_mc:target_mc, info:info});
		itemsToInit.splice(index, 0, {url:url, target_mc:target_mc, info:info});
		
	}
	
	
	public function removeByTarget(target_mc:Object):Void {		
		(currItem.target_mc == target_mc) ? mcl.unloadClip(target_mc) : dequeueItem(target_mc);
	}
	
	
	public function removeByUrl(url:String):Void {
		
		for (var i:String in itemsToInit) {
			if (itemsToInit[i].url == url) {
				removeByTarget(itemsToInit[i].target_mc);					
			}
		}	
		
	}
	
	
	public function removeItemAt(index:Number):Void {		
		removeByTarget(itemsToInit[index].target_mc);		
	}
	
	
	public function unloadItem(target_mc:Object):Void {		
		mcl.unloadClip(target_mc);	
	}
	
	
	public function execute():Void {
		
		isStarted = true;
		isLoading = true;
		isStopped = false;		
		loadNextItem();	
		
	}
	
	
	public function pause():Void {
		
		if (!isStopped) {		
			isStopped = true;		
			mcl.unloadClip(currItem.target_mc);			
		}
		
	}
	
	
	public function resume():Void {
		
		if (isStopped) {		
			isStopped = false;			
			queuedItems.unshift({url:currItem.url, target_mc:currItem.target_mc, info:currItem.info});			
			loadNextItem();			
		}
		
	}
	
	
	public function clear():Void {
		
		reset();		
		pause();
		
	}	
	
	
	public function destroy():Void {	
	
		clear();
		mcl.removeListener(this);
		
	}
	
	
	public function getLength():Number {
		return queuedItems.length;
	}
	
	
	public function getNextItem():Object {
		return queuedItems[0];
	}
	
	
	public function getIsLoading():Boolean {		
		return (!isStopped && isLoading);		
	}
	
	
}