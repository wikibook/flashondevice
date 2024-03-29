﻿import com.jxl.shuriken.core.UIComponent;
import com.jxl.shuriken.events.ShurikenEvent;
import com.jxl.shuriken.events.Callback;

class com.jxl.shuriken.core.Container extends UIComponent
{
	public static var SYMBOL_NAME:String = "com.jxl.shuriken.core.Container";
	
	private static var DEPTH_RESERVED:Number = 6;
	private static var DEPTH_MASK:Number = 5;
	
	public function get numChildren():Number { return __aChild.length; }
	
	public function get clipContent():Boolean { return __clipContent; }
	
	public function set clipContent(val:Boolean):Void
	{
		__clipContent = val;
		__clipContentDirty = true;
		invalidate();
	}
	
	private var __numChildren:Number;
	private var __aChild:Array;
	private var __clipContent:Boolean;
	private var __clipContentDirty:Boolean;
	private var __childCreatedCallback:Callback;
	private var __childIndexChangeCallback:Callback;
	private var __childBeforeRemovedCallback:Callback;
	private var __childRemovedCallback:Callback;
	private var __beforeAllChildrenRemovedCallback:Callback;
	private var __allChildrenRemovedCallback:Callback;
	
	// We sometimes have the need to put stuff under all the children, what I call "ghost children".
	// For most use-cases, you could just use Composition, and instead of extending a Container
	// based class, you'd instead just make a class that attaches this class inside it, and puts the GUI
	// elements it needs underneath.  This seperation allows this class to remain clean but requires
	// more code.
	// However, in the case of masking, we need to have some reserved bottom depths.
	// Therefore, all depth calls will start from the __reservedDepth.  We do this by
	// creating a reserved MovieClip at the specified depth.  Therefore, all getNextHighestDepth
	// calls will start from that depth + 1
	private var __mcReservedDepth:MovieClip;
	private var __mcMask:MovieClip;
	
	//Constructor
	public function Container()
	{
		super();
		
		__numChildren = 0;
		__aChild = [];
		__clipContent = false;
	}
	
	private function createChildren():Void
	{
		super.createChildren();
		
		__mcReservedDepth = createEmptyMovieClip("__mcReservedDepth", DEPTH_RESERVED);
	}
	
	private function redraw():Void
	{
		super.redraw();
		
		__clipContentDirty = false;
		__mcMask.removeMovieClip();
		if(__clipContent == true)
		{
			__mcMask.removeMovieClip();
			__mcMask = createEmptyMovieClip("__mcMask", DEPTH_MASK);
			__mcMask.beginFill(0x00FF00, 50);
			__mcMask.lineTo(__width, 0);
			__mcMask.lineTo(__width, __height);
			__mcMask.lineTo(0, __height);
			__mcMask.lineTo(0, 0);
			__mcMask.endFill();
			setMask(__mcMask);
		}
		
		
	}
	
	public function createChild(p_class:Function, 
								p_name:String, 
								p_initObj:Object):UIComponent
	{
		return createChildAt(__aChild.length, p_class, p_name, p_initObj);
	}
	
	public function createChildAt(p_index:Number, 
								  p_class:Function, 
								  p_name:String, 
								  p_initObj:Object):UIComponent
	{
		if(p_class == null)
		{
			// FIXME
			//trace("Container::createChildAt, p_class is null.");
			return;
		}
		
		var d:Number = getNextHighestDepth();
		if(p_name == null) p_name = "child" + p_index + "_" + d;
		
		var linkageName:String;
		if(p_class.hasOwnProperty("SYMBOL_NAME") == true)
		{
			linkageName = p_class["SYMBOL_NAME"];	
		}
		else
		{
			linkageName = p_class.toString();
		}
		
		//var st:Number = getTimer();
		var mc = attachMovie(linkageName, p_name, d, p_initObj);
		//var ct:Number = getTimer();
		//var et:Number = ct - st;
		//trace("et: " + et);
		//var mcbtVO:MovieClipBuilderTicketVO = attachMovieDeferred(this, linkageName, p_name, d, p_initObj);
		//return mcbtVO;
		
		// FIXME: casting is failing, fix later
		var ref = mc;
		if(ref != null) __aChild.splice(p_index, 0, ref);
		var event:ShurikenEvent = new ShurikenEvent(ShurikenEvent.CHILD_CREATED, this);
		event.child = ref;
		event.newIndex = p_index;
		__childCreatedCallback.dispatch(event);
		return ref;
	}
	
	public function getChildAt(p_index:Number):UIComponent
	{
		return __aChild[p_index];
	}
	
	public function getChildIndex(p_child:UIComponent):Number
	{
		var i:Number = __aChild.length;
		while(i--)
		{
			if(__aChild[i] == p_child)
			{
				return i;
			}
		}
		return -1;
	}
	
	public function setChildIndex(p_child:UIComponent, p_index:Number):Boolean
	{
		var currentIndex:Number = getChildIndex(p_child);
		if(currentIndex == p_index) return false;
		// if higher, remove first to prevent index from getting confused
		if(currentIndex > p_index)
		{
			__aChild.splice(currentIndex, 1);
			__aChild.splice(p_index, 0, p_child);
		}
		// otherwise, it's lower, can't get confused
		else
		{
			__aChild.splice(p_index, 0, p_child);
			__aChild.splice(currentIndex, 1);
		}
		
		var ce:ShurikenEvent = new ShurikenEvent(ShurikenEvent.CHILD_INDEX_CHANGED, this);
		ce.child = p_child;
		ce.oldIndex = currentIndex;
		ce.newIndex = p_index;
		__childIndexChangeCallback.dispatch(ce);
	}
	
	public function removeChildAt(p_index:Number):Void
	{
		var child:UIComponent = __aChild[p_index];
		if(child != null)
		{
			var ce:ShurikenEvent = new ShurikenEvent(ShurikenEvent.CHILD_BEFORE_REMOVED, this);
			ce.child = child;
			ce.index = p_index;
			__childBeforeRemovedCallback.dispatch(ce);
			
			removeAndCleanup_child(child, p_index);
			
			var cer:ShurikenEvent = new ShurikenEvent(ShurikenEvent.CHILD_REMOVED, this);
			cer.child = child;
			cer.index = p_index;
			__childRemovedCallback.dispatch(cer);
		}
	}
	
	public function removeChild(p_child:UIComponent):Void
	{
		var childIndex:Number = getChildIndex(p_child);
		removeChildAt(childIndex);
	}
	
	public function removeAllChildren():Void
	{
		__beforeAllChildrenRemovedCallback.dispatch(new ShurikenEvent(ShurikenEvent.BEFORE_ALL_CHILDREN_REMOVED, this));
		var i:Number = __aChild.length;
		while(i--)
		{
			removeAndCleanup_child(__aChild[i], i);
		}
		__aChild = [];
		__allChildrenRemovedCallback.dispatch(new ShurikenEvent(ShurikenEvent.ALL_CHILDREN_REMOVED, this));
	}
	
	private function removeAndCleanup_child(p_child:UIComponent, p_index:Number):Void
	{
		p_child.removeMovieClip();
		__aChild.splice(p_index, 1);
	}
	
	private function getNextNonChildDepth():Number
	{
		for(var i:Number = 0; i<DEPTH_MASK; i++)
		{
			var mc:MovieClip = getInstanceAtDepth(i);
			if(mc == undefined) return i;
		}
		return -1;
	}
	
	public function setChildCreatedCallback(scope:Object, func:Function):Void
	{
		__childCreatedCallback = new Callback(scope, func);
	}
	
	public function setChildIndexChangeCallback(scope:Object, func:Function):Void
	{
		__childIndexChangeCallback = new Callback(scope, func);
	}
	
	public function setChildBeforeRemovedCallback(scope:Object, func:Function):Void
	{
		__childBeforeRemovedCallback = new Callback(scope, func);
	}
	
	public function setChildRemovedCallback(scope:Object, func:Function):Void
	{
		__childRemovedCallback = new Callback(scope, func);
	}
	
	public function setBeforeAllChildrenRemovedCallback(scope:Object, func:Function):Void
	{
		__beforeAllChildrenRemovedCallback = new Callback(scope, func);
	}
	
	public function setAllChildrenRemovedCallback(scope:Object, func:Function):Void
	{
		__allChildrenRemovedCallback = new Callback(scope, func);
	}
}