/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  POC project

 @internal 

 */

package com.elad.application.control
{
	import com.adobe.cairngorm.control.FrontController;
    import com.elad.application.commands.*;
    import com.elad.application.commands.services.*;
    import com.elad.application.events.*;
    
    /**
     *
     * Defines the <code>testController</code> which is 
     * utilized by the application to map each <code>Event</code>
     * object to an associated <code>ICommand</command> object.
     * 
     * @see com.adobe.cairngorm.control.FrontController
     *
     */
	public final class testController extends FrontController
	{
	    /**
	     *
	     * The <code>testController</code> constructor invokes
	     * the <code>initialize()</code> method so as to abstract the 
	     * <code>Event</code> / <code>Command</code> mappings from the
	     * constructor.
	     *
	     */
		public function testController()
		{
			this.initialize();
		}
		
	    /**
	     *
	     * The <code>initialize()</code> method maps each defined 
	     * <code>Event</code> to it's associated <code>ICommand</code>
	     * implementation.
	     *
	     */
		private function initialize() : void
		{
		    this.addCommand( StartupServicesEvent.STARTUPSERVICES_EVENT, StartupServicesCommand );
		    this.addCommand( ReadAdobeFeedsEvent.READADOBEFEEDS_EVENT, ReadAdobeFeedsCommand );
		    this.addCommand( UserSelectedFeedEvent.USERSELECTEDFEED_EVENT, UserSelectedFeedCommand );
		    //todo: add commands
		}
	}
}
