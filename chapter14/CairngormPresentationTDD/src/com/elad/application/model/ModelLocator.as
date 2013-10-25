/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  POC project

 @internal 

 */

package com.elad.application.model
{
	import com.adobe.cairngorm.CairngormError;
	import com.adobe.cairngorm.CairngormMessageCodes;
	import com.adobe.cairngorm.model.IModelLocator;
	import com.elad.application.model.domain.LibraryModel;
	import com.elad.application.model.presentation.FeedsPanelViewerPM;
	import com.elad.application.model.presentation.MainPM;
	
    [Bindable]
    /**
     *
     * Defines the application specific <code>ModelLocator</code> 
     * 
     * <p>
     * The <code>ModelLocator</code> is a Singleton class which is 
     * utilized as a centralized data repository from which used
     * to locate all data models, value objects and state reside within 
     * both the domain and the presentation model.
     * </p>
     *
     * @see com.adobe.cairngorm.model.IModelLocator
     *
     */
	public final class ModelLocator implements IModelLocator
	{
		/**
		 *
		 * Defines the Singleton instance of the application 
		 * <code>ModelLocator</code>
		 *
		 */
		private static var instance:ModelLocator;

		/**
		 *
		 * The application domain Model. The application Domain Model classes structures 
		 * our application data and defines its behavior reducing the role of the ModelLocator and 
		 * increase decoupling of the view.
		 *
		 */
		public var libraryModel:LibraryModel;

		/**
		 *
		 * The application main Presentation Model
		 *
		 */
		public var mainPM:MainPM;		

		/**
		 *
		 * Define an instance of the <code>FirstModulePM</code>
		 * 
		 */				
		public var feedsPanelViewerPM:FeedsPanelViewerPM;
		/**
		 *
		 * Defines the Singleton instance of the Application 
		 * <code>ModelLocator</code>
		 *
		 * @param inner class instance which restricts constructor access
		 *
		 */
		public function ModelLocator(access:Private)
		{
			if ( access == null )
			{
			    throw new CairngormError( CairngormMessageCodes.SINGLETON_EXCEPTION, "ModelLocator" );
			}
			instance = this;
		}
		 
		/**
		 *
		 * Retrieves the Singleton instance of the <code>ModelLocator</code>
		 * as well as an instance of <code>LibraryModel</code> and <code>mainPM</code>
		 *
		 * @return singleton instance of <code>ModelLocator</code>
		 *
		 */
		public static function getInstance() : ModelLocator
		{
			if ( instance == null )
			{
				instance = new ModelLocator( new Private() );
				instance.libraryModel = new LibraryModel();
				instance.mainPM = new MainPM( instance.libraryModel );
				instance.feedsPanelViewerPM = new FeedsPanelViewerPM( instance.libraryModel );
			}
			return instance;
		}
	}
}

/**
 * Inner class which restricts constructor access to Private
 */
class Private {}
