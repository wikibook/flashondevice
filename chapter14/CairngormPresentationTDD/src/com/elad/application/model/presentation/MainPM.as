/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  POC project

 @internal 

 */

package com.elad.application.model.presentation
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.elad.application.events.InitializationCommandCompleted;
	import com.elad.application.events.PreInitializationCommandCompleted;
	import com.elad.application.events.StartupServicesEvent;
	import com.elad.application.model.ModelLocator;
	import com.elad.application.model.domain.LibraryModel;
	
	import mx.logging.Log;
	
	import org.osflash.thunderbolt.ThunderBoltTarget;
	
    [Bindable]
    /**
     *
     * Defines the <code>MainPM<code> Value Object implementation
     *
     */
	public class MainPM extends AbstractPM
	{

		/**
		 *
		 * Define an instance of <code>ThunderBoltTarget</code>
		 * 
		 * @see org.osflash.thunderbolt.ThunderBoltTarget
		 * @see mx.logging.Log
		 * 
		 */		
		private var _target:ThunderBoltTarget = new ThunderBoltTarget();

		/**
		 *
		 * Define an instance of the <code>firstModulePM</code>
		 * 
		 */	
		public var firstModulePM:FeedsPanelViewerPM;		 

		/**
		 *
		 * Define an instance of the <code>LibraryModel</code>
		 * 
		 */				
		public var libraryModel:LibraryModel;	
		
		/**
		 * Defualt constractor set the <code>LibraryModel</code>
		 * @param LibraryModel
		 * 
		 */				
		public function MainPM(libraryModel:LibraryModel)
		{
			this.libraryModel = libraryModel;
			firstModulePM = new FeedsPanelViewerPM(libraryModel);
		}


		/**
		 * Method to handle first show of the application
		 * 
		 */		
		override protected function handlePreInitialize():void
		{
			// set filter for logging API and inject thunder bolt
			_target.filters = ["com.elad.application.commands.*"];
			Log.addTarget(_target);
		    
		    // track once pre-initialize completed
		    CairngormEventDispatcher.getInstance().addEventListener( PreInitializationCommandCompleted.COMPLETED, preInitializeCompletedHandler );
		    
		    // call startup services
		    new StartupServicesEvent().dispatch();
		}
				
		/**
		 * Method to handle first show of the application
		 * 
		 */		
		override protected function handleInitialize():void
		{
			// track once initialize completed
		    CairngormEventDispatcher.getInstance().addEventListener( InitializationCommandCompleted.COMPLETED, initializeCompletedHandler );
		    
		    new InitializationCommandCompleted().dispatch();
		}

		/**
		 * Method to handle first show of the application
		 * 
		 */		
		override protected function handleFirstShow():void
		{
			// implements or leave default
			handleCompleted();
		}
		
		/**
		 * Method to handle dubsequent shows of the application
		 * 
		 */			
		override protected function handleSubsequentShows():void
		{
			// implements or leave default
			handleCompleted();
		}		

		/**
		 * Method to handle the view once preinit and init are completed
		 * 
		 */		
		override protected function handleCompleted():void
		{
			// remove event listeners
			CairngormEventDispatcher.getInstance().removeEventListener(	PreInitializationCommandCompleted.COMPLETED, preInitializeCompletedHandler );		
			CairngormEventDispatcher.getInstance().removeEventListener(	InitializationCommandCompleted.COMPLETED, initializeCompletedHandler );		
			
			// TODO: implements changes in view
		}		
		
	}
}
