/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  POC project

 @internal 

 */

package com.elad.application.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.elad.application.commands.services.ReadAdobeFeedsCommand;
	import com.elad.application.events.PreInitializationCommandCompleted;
	import com.elad.application.events.StartupServicesEvent;
	import com.elad.application.model.ModelLocator;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.logging.Log;
	
    /**
     *
     * Defines the associated <code>ICommand</code> implementation for 
     * the "StartupServices" use-case.
     *
     * <p>
     * The <code>StartupServicesCommand</code> is utilized to abstract the 
     * handling of an <code>StartupServicesEvent</code>
     * </p>
     *
     * @see com.elad.application.events.StartupServicesEvent
     * @see com.adobe.cairngorm.commands.ICommand
     *
     */
	public final class StartupServicesCommand implements ICommand
	{
		/**
		 *
		 * Defines a local convenience reference to the application 
		 * <code>ModelLocator</code> implementations
		 *
		 */	
		private var modelLocator:ModelLocator = ModelLocator.getInstance();
		
		/**
		 * 
		 */		
		private var timer:Timer;
		
	    /**
	     *
	     * <code>ICommand</code> implementation which handles an 
	     * <code>StartupServicesEvent</code>.
	     * 
	     * <p>
         * The <code>StartupServicesCommand</code> does not require a specific 
         * service invocation to be made, therefore the handling of an 
         * <code>StartupServicesEvent</code> is completely managed by the 
         * <code>StartupServicesCommand</code>.
	     * </p>
	     *
	     */
		public function execute(event:CairngormEvent) : void
		{
			Log.getLogger("com.elad.application.commands.StartupServicesCommand").info("execute");
			var evt:StartupServicesEvent = event as StartupServicesEvent;
			
			new ReadAdobeFeedsCommand().execute(null);
		}		
	}
}