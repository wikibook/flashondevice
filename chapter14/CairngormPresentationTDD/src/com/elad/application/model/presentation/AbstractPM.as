/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  POC project

 @internal 

 */

package com.elad.application.model.presentation
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * Abstract class to include the first time the class run as well as the subsequent init of the class
	 * Also included initialize methods and handler to be used in the view.
	 * 
	 */	

	public class AbstractPM extends EventDispatcher
	{

		/**
		 *
		 * Define a var to store weather the application state was shown already
		 * 
		 */		
		private var firstShow:Boolean = true;
		
		/**
		 *
		 * Default constructor
		 * 
		 */		
		public function AbstractPM()
		{
		}

		/**
		 * Method to handle first show of the application
		 * 
		 */			
		public function handleShow():void
		{
			if( firstShow )
			{
				handleFirstShow();
				firstShow = false ;				
			}
			
			else handleSubsequentShows();
		}

		/**
		 * Method to be called on preinitialize
		 * 
		 */
		public function preinitialize():void
		{
			handlePreInitialize();
		}
		
		/**
		 * Method to be called on initialize
		 * 
		 */
		public function initialize():void
		{
			handleInitialize();
		}

		/**
		 * Method to handle preinitialize
		 * 
		 */			
		protected function handlePreInitialize():void
		{
			// to be overriden
		}

		/**
		 * Method to handle initialize of the application
		 * 
		 */			
		protected function handleInitialize():void
		{
			// to be overriden
		}

		
		/**
		 * Method to handle the view once preinit and init is completed
		 * 
		 */		
		protected function handleCompleted():void
		{
			// to be overriden
		}					
				
		/**
		 * Method to implement first show of the application
		 * 
		 */			
		protected function handleFirstShow():void
		{
			// to be overriden
		}	

		/**
		 * Method to handle dubsequent shows of the application
		 * 
		 */			
		protected function handleSubsequentShows():void
		{
			// to be overriden
		}

		/**
		 * Method invoke once the Initialize is completed.
		 *  
		 * @param event
		 * 
		 */			
		public function preInitializeCompletedHandler(event:Event):void
		{
			handleInitialize();
		}
		
		/**
		 * Method invoke once the Initialize is completed.
		 *  
		 * @param event
		 * 
		 */			
		public function initializeCompletedHandler(event:Event):void
		{
			handleShow();
		}		
	}
}
