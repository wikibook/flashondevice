/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  ProjectName

 @internal 

 */

package com.elad.application.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	
    /**
     *
     * Defines the associated Business Delegate for the "ReadAdobeFeeds"  
     * use-case.
     *
     * <p>
     * The <code>ReadAdobeFeedsDelegate</code> is utilized to abstract 
     * an asynchronous service invocation in which the response is
     * to be relayed to an <code>IResponder</code> implementation.
     * </p>
     *
     */
	public final class ReadAdobeFeedsDelegate
	{
	    /**
	     *
	     * Defines the reference to the <code>ReadAdobeFeedsCommand<code>
	     * instance.
	     *
	     */
		private var responder:IResponder;

	    /**
	     *
	     * Define reference to the service which can be one of the RPC (HttpService, WebService or RemoteService)
	     *
	     */		
		private var service:HTTPService;	
				
		/**
		 *
		 * Instantiates a new instance of <code>ReadAdobeFeedsDelegate</code>
		 * and initializes a reference to the <code>IResponder<code> instance.
		 *
		 */
		public function ReadAdobeFeedsDelegate(responder:IResponder)
		{
			service = ServiceLocator.getInstance().getHTTPService(Services.ADOBE_FEEDS);
			this.responder = responder;
		}
		
		/**
		 * Method to get information.
		 * 
		 */		
		public function readAdobeFeeds():void
		{
            var token:AsyncToken = service.send()
            token.addResponder( responder );
		}		
	}
}
