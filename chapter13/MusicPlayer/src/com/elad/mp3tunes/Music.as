/*
        Copyright (c) 2009 Elad Elrom.  Elrom LLC. All rights reserved. 
        
        Permission is hereby granted, free of charge, to any person
        obtaining a copy of this software and associated documentation
        files (the "Software"), to deal in the Software without
        restriction, including without limitation the rights to use,
        copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the
        Software is furnished to do so, subject to the following
        conditions:
        
        The above copyright notice and this permission notice shall be
        included in all copies or substantial portions of the Software.
        
        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
        EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
        OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
        NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
        HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
        WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
        FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
        OTHER DEALINGS IN THE SOFTWARE.

        @author  Elad Elrom
 */
package com.elad.mp3tunes
{
	import com.elad.mp3tunes.enum.SortType;
	import com.elad.mp3tunes.events.AlbumDataEvent;
	import com.elad.mp3tunes.events.ArtistsResultEvent;
	import com.elad.mp3tunes.events.MusicEvent;
	import com.elad.mp3tunes.events.TrackDataEvent;
	import com.elad.mp3tunes.service.SetServiceParamHelper;
	import com.elad.mp3tunes.vo.AlbumItemVO;
	import com.elad.mp3tunes.vo.AlbumListVO;
	import com.elad.mp3tunes.vo.ArtistItemVO;
	import com.elad.mp3tunes.vo.ArtistListVO;
	import com.elad.mp3tunes.vo.TrackItemVO;
	import com.elad.mp3tunes.vo.TrackListVO;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	/**
	 *  Dispatched when the user login successfully.
	 *
	 *  @eventType com.elad.mp3tunes.events.MusicEvent.LOGIN_SUCCESSFULL
	 */
	[Event(name="loginSuccessfull", type="com.elad.mp3tunes.events.MusicEvent")]

	/**
	 *  Dispatched when the there was an error during login.
	 *
	 *  @eventType com.elad.mp3tunes.events.MusicEvent.LOGIN_ERROR
	 */
	[Event(name="loginError", type="com.elad.mp3tunes.events.MusicEvent")]

	/**
	 *  Dispatched when the artist result was retrieved.
	 *
	 *  @eventType com.elad.mp3tunes.events.ArtistsResultEvent.ARTIST_RESULT_COMPLETED
	 */
	[Event(name="artistResultCompleted", type="com.elad.mp3tunes.events.ArtistsResultEvent")]

	/**
	 *  Dispatched when there was an error during artist result service call.
	 *
	 *  @eventType com.elad.mp3tunes.events.ArtistsResultEvent.ARTIST_RESULT_ERROR
	 */
	[Event(name="artistResultError", type="com.elad.mp3tunes.events.ArtistsResultEvent")]
	
	/**
	 *  Dispatched when album data information was completed.
	 *
	 *  @eventType com.elad.mp3tunes.events.AlbumDataEvent.ALBUM_DATA_COMPLETED
	 */
	[Event(name="albumDataCompleted", type="com.elad.mp3tunes.events.AlbumDataEvent")]

	/**
	 *  Dispatched when all albums data information was retrieved.
	 *
	 *  @eventType com.elad.mp3tunes.events.AlbumDataEvent.ALL_ALBUMS_DATA_COMPLETED
	 */
	[Event(name="allAlbumsDataCompleted", type="com.elad.mp3tunes.events.AlbumDataEvent")]

	/**
	 *  Dispatched when there was an error during service call to retrieve album information.
	 *
	 *  @eventType com.elad.mp3tunes.events.AlbumDataEvent.ALBUM_DATA_ERROR
	 */
	[Event(name="albumDataError", type="com.elad.mp3tunes.events.AlbumDataEvent")]	

	/**
	 *  Dispatched when the track data was retrieved.
	 *
	 *  @eventType com.elad.mp3tunes.events.AlbumDataEvent.TRACK_DATA_COMPLETED
	 */
	[Event(name="trackDataCompleted", type="com.elad.mp3tunes.events.TrackDataEvent")]

	/**
	 *  Dispatched when the track data service call failed.
	 *
	 *  @eventType com.elad.mp3tunes.events.AlbumDataEvent.TRACK_DATA_ERROR
	 */
	[Event(name="albumDataError", type="com.elad.mp3tunes.events.TrackDataEvent")]	
	
	/**
	 * Singleton manager to implements the mp3tunes Music API 
	 * The api consists of REST interface which gives you access to all data for a user within 
	 * the mp3tunes Locker service.
	 *  
	 * @author Elad Elrom
	 * 
	 */	
	public class Music extends EventDispatcher implements IMusic
	{
	    //--------------------------------------------------------------------------
	    //
	    //  Variables
	    //
	    //--------------------------------------------------------------------------
	    		
		private static const AUTHENTICATION_URL:String = "http://shop.mp3tunes.com/api/v1/login";
		private static const LOCKERDATA_URL:String = "http://ws.mp3tunes.com/api/v1/lockerData";

		// Singleton instance.
		protected static var instance:Music;
		
		/**
		 * Variable to store weather the user is login or not.
		 */		
		private var isLogin:Boolean = false;
		
		/**
		 * Component to be used on each service call. 
		 */		
		private var service:HTTPService;
		
		/**
		 * token and session id needed for service call.  Token was provided when signing to the API.
		 * sid is provided once the user login. 
		 */		
		private var _token:String;
		private var _sid:String;
		
		private var callBack:Function = null;
		private var artistsListLenght:Number;
		private var artistList:ArtistListVO;
		private var allAlbumList:AlbumListVO;
		
	    //--------------------------------------------------------------------------
	    //
	    //  Getters and setters
	    //
	    //--------------------------------------------------------------------------
                		
		public function set token(val:String):void
		{
			_token = val;
		}
		
		public function get token():String
		{
			return _token;
		}
		
		public function get sid():String
		{
			return _sid;
		}		

	    //--------------------------------------------------------------------------
	    //
	    //  Constructor
	    //
	    //--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * Once the class gets instantiate we need to pass the token id which was provided when 
		 * you sign to a developer account with mp3tunes.
		 *  
		 * @param token	unique string for each developer.
		 * @param isLogin	indicated weather the user already logged in.
		 * 
		 */		
		public function Music(enforcer:AccessRestriction)
		{
			if (enforcer == null)
				throw new Error("Error enforcer input param is undefined" );
		}

	    //--------------------------------------------------------------------------
	    //
	    //  Class methods
	    //
	    //--------------------------------------------------------------------------
	 	
		/**
		 * Method to login into user's account.  Once user is logged in a session id (sid) is created
		 * and allow to retireve account information and music information.
		 *  
		 * @param userName
		 * @param password
		 * 
		 */	 	
		public function login(userName:String, password:String, token:String):void
		{
			if (isLogin)
			{
				this.dispatchEvent(new MusicEvent(MusicEvent.LOGIN_ERROR, "User already logged in."));
				return;
			}
			
			if (userName == "" || password == "" || token == "")
			{
				this.dispatchEvent(new MusicEvent(MusicEvent.LOGIN_ERROR, "User name and/or password have no values."));
				return;				
			}
			
			if (token == "")
			{
				this.dispatchEvent(new MusicEvent(MusicEvent.LOGIN_ERROR, "Partner token is empty."));
				return;					
			}
			
			 _token = token;
			
	        var params:Object = SetServiceParamHelper.getloginParam(token, userName, password);
	        setNewService();
	        
	        service.url = AUTHENTICATION_URL;
	        service.addEventListener(ResultEvent.RESULT, onLoginResult);
	        service.addEventListener(FaultEvent.FAULT, onLoginFault);
	        service.send(params);	
		}
		
		/**
		 * Method to retrieve music by an artist 
		 * 
		 */		
		public function getMusicByArtists(callBack:Function=null):void
		{
			if (!isLogin)
			{
				this.dispatchEvent(new ArtistsResultEvent(ArtistsResultEvent.ARTIST_RESULT_ERROR, null, "You must login before calling this service via 'login' method")); 
				return;
			}
			
			if (callBack!=null)
			{
				this.callBack = callBack;
			}
			
			var params:Object = SetServiceParamHelper.getMusicByArtistsParam(sid);

			setNewService();            
            service.url = LOCKERDATA_URL;
            service.addEventListener(ResultEvent.RESULT, onArtistsResult);
            service.addEventListener(FaultEvent.FAULT, onArtistsFault);
            service.send(params);  			
		}
		
		/**
		 * Method to retrieve album data. 
		 *  
		 * @param artistId	artistId was provided in the <code>getMusicByArtists</code> service call.
		 * 
		 */		
		public function getAlbumData(artistId:String, callBack:Function=null):void
		{
			if (!isLogin)
			{
				this.dispatchEvent(new AlbumDataEvent(AlbumDataEvent.ALBUM_DATA_ERROR, null, "You must login before calling this service via 'login' method"));
				return;
			}
			
			if (callBack!=null)
			{
				this.callBack = callBack;
			}			
			
			var params:Object = SetServiceParamHelper.getAlbumDataParam(sid, artistId);	

			setNewService();           
            service.url = LOCKERDATA_URL;
            service.addEventListener(ResultEvent.RESULT, onAlbumDataResult);
            service.addEventListener(FaultEvent.FAULT, onAlbumDataFault);
            service.send(params);  			
		}
		
		public function getAllAlbums(artistList:ArtistListVO=null):void
		{
			if (!isLogin)
			{
				this.dispatchEvent(new AlbumDataEvent(TrackDataEvent.TRACK_DATA_ERROR, null, "You must login before calling this service via 'login' method"));
				return;
			}
			
			// in case the artist list wasn't provided by user we need to get it
			if (artistList == null && this.callBack == null)
			{
				getMusicByArtists(getAllAlbums);
				return;
			}
			else if (artistList != null)
			{
				this.artistList = artistList;
				artistsListLenght = artistList.list.length;
			}
			
			if (artistsListLenght>0)
			{
				// in case we started the loop, we need to reset the list
				if (artistsListLenght == this.artistList.list.length)
					allAlbumList = new AlbumListVO();
				
				// get each album
				artistsListLenght--;				
				getAlbumData(this.artistList.getItem(artistsListLenght).artistId, getAllAlbums);
			}
			else  // retrieved the entire list dispatch an event
			{
				this.dispatchEvent( new AlbumDataEvent(AlbumDataEvent.ALL_ALBUMS_DATA_COMPLETED, allAlbumList) );
				
				callBack = null;
				artistList = null;
			}
		}
		
		/**
		 * Method to retrieve track data information.  The information is based on an album Id which 
		 * was given during <code>getAlbumData</code> service call.
		 *  
		 * @param albumId
		 * 
		 */	
		public function getTrackData(id:String, sortType:String=SortType.ALBUMS):void
		{
			if (!isLogin)
			{
				this.dispatchEvent(new AlbumDataEvent(TrackDataEvent.TRACK_DATA_ERROR, null, "You must login before calling this service via 'login' method"));
				return;
			}
			
			var params:Object = SetServiceParamHelper.getTrackDataParam(sid, id, sortType);
				
			setNewService();
            service.url = LOCKERDATA_URL;
            service.addEventListener(ResultEvent.RESULT, onTrackDataResult);
            service.addEventListener(FaultEvent.FAULT, onTrackDataFault);
            service.send(params);  			
		}
		
		/**
		 * Method to create a new instance of the service component. 
		 * 
		 */		
		private function setNewService():void
		{
			service = new HTTPService();
			service.resultFormat = "e4x"; 
		}			

	    //--------------------------------------------------------------------------
	    //
	    //  Event handlers
	    //
	    //--------------------------------------------------------------------------
        
        /**
         * Handler to set the session id once login was successful.
         * @param event
         * 
         */        
        private function onLoginResult(event:ResultEvent):void
        {
			if (event.result.errorMessage != "")
			{
				this.dispatchEvent(new MusicEvent(MusicEvent.LOGIN_ERROR, String(event.result.errorMessage)));
				return;				
			}
        	
        	isLogin = true;
        	service.removeEventListener(ResultEvent.RESULT, onLoginResult);
        	service.removeEventListener(FaultEvent.FAULT, onLoginFault);
        	
            var result:XML = event.result as XML;
            _sid = result.session_id;
            
            this.dispatchEvent(new MusicEvent(MusicEvent.LOGIN_SUCCESSFULL));
        }
        
        /**
         * Login fault event handler
         * @param event
         * 
         */        
        private function onLoginFault(event:FaultEvent):void
        {
         	service.removeEventListener(ResultEvent.RESULT, onLoginResult);
        	service.removeEventListener(FaultEvent.FAULT, onLoginFault);
        	
        	var errorMessage:String = event.message.toString();
        	this.dispatchEvent(new MusicEvent(MusicEvent.LOGIN_ERROR, errorMessage));
        }
        
        /**
         * Method to handle Artists Result.  Creates an collection and pass the collection through an event.
         * @param event
         * 
         */        
        private function onArtistsResult(event:ResultEvent):void
        {
        	service.removeEventListener(ResultEvent.RESULT, onArtistsResult);
        	service.removeEventListener(FaultEvent.FAULT, onArtistsFault);
        	
        	var result:XML = event.result as XML;            
            var collection:ArtistListVO = new ArtistListVO();
            var len:int = int(result.summary.totalResults);
            var item:ArtistItemVO;
            
            for (var i:int; i<len; i++)
            {
            	item = new ArtistItemVO(String(result.artistList.item[i].artistId), String(result.artistList.item[i].artistName), String(result.artistList.item[i].albumCount), String(result.artistList.item[i].trackCount));
            	collection.addItem(item);
            }
            
            if (callBack != null)
            {
            	artistList = collection;
            	artistsListLenght = artistList.list.length;
            	callBack();
            }
            else
            {
            	this.dispatchEvent(new ArtistsResultEvent(ArtistsResultEvent.ARTIST_RESULT_COMPLETED, collection));
            }
        }
        
        /**
         * Artists fault event handler
         * @param event
         * 
         */        
        private function onArtistsFault(event:FaultEvent):void
        {
        	service.removeEventListener(ResultEvent.RESULT, onArtistsResult);
        	service.removeEventListener(FaultEvent.FAULT, onArtistsFault); 
        	
        	this.dispatchEvent(new ArtistsResultEvent(ArtistsResultEvent.ARTIST_RESULT_ERROR, null, String(event.message)));       	
        }
		
		/**
		 * Album data result handler, handles results by creating a collection of albums and pass it through an event.
		 * @param event
		 * 
		 */		
		private function onAlbumDataResult(event:ResultEvent):void
		{
            service.removeEventListener(ResultEvent.RESULT, onAlbumDataResult);
            service.removeEventListener(FaultEvent.FAULT, onAlbumDataFault);
            
        	var result:XML = event.result as XML;            
            var collection:AlbumListVO = new AlbumListVO();
            var len:int = int(result.summary.totalResults);
            var item:AlbumItemVO;
            
            for (var i:int; i<len; i++)
            {
            	item = new AlbumItemVO(result.albumList.item[i].albumId, result.albumList.item[i].albumTitle, result.albumList.item[i].artistId, result.albumList.item[i].artistName, result.albumList.item[i].trackCount, result.albumList.item[i].albumSize, result.albumList.item[i].releaseDate, result.albumList.item[i].purchaseDate, int(result.albumList.item[i].hasArt));
            	collection.addItem(item);
            	
            	if (callBack!=null)
            		allAlbumList.addItem(item);
            }
            
			if (callBack!=null)
			{
				callBack();
			} 
			else
			{
				this.dispatchEvent(new AlbumDataEvent(AlbumDataEvent.ALBUM_DATA_COMPLETED, collection));
			}           
		}
		
		/**
		 * Album data Fault event handler
		 * @param event
		 * 
		 */		
		private function onAlbumDataFault(event:FaultEvent):void
		{
            service.removeEventListener(ResultEvent.RESULT, onAlbumDataResult);
            service.removeEventListener(FaultEvent.FAULT, onAlbumDataFault);
            
            this.dispatchEvent(new AlbumDataEvent(AlbumDataEvent.ALBUM_DATA_ERROR, null, event.message.toString()));				
		}
		
		private function onTrackDataResult(event:ResultEvent):void
		{
            service.removeEventListener(ResultEvent.RESULT, onTrackDataResult);
            service.removeEventListener(FaultEvent.FAULT, onTrackDataFault);
            
        	var result:XML = event.result as XML;            
            var collection:TrackListVO = new TrackListVO();
            var len:int = int(result.summary.totalResults);
            var item:TrackItemVO;
            
            for (var i:int; i<len; i++)
            {
            	item = new TrackItemVO(result.trackList.item[i].trackId, result.trackList.item[i].trackTitle, result.trackList.item[i].trackNumber, Number(result.trackList.item[i].trackLength), result.trackList.item[i].trackFileName, result.trackList.item[i].trackFileKey, result.trackList.item[i].trackFileSize, result.trackList.item[i].downloadURL+token, result.trackList.item[i].playURL, result.trackList.item[i].albumId, result.trackList.item[i].albumTitle, result.trackList.item[i].albumYear, result.trackList.item[i].artistId, result.trackList.item[i].artistName);
            	collection.addItem(item);
            }
            
            this.dispatchEvent(new TrackDataEvent(TrackDataEvent.TRACK_DATA_COMPLETED, collection));
            
		}
		
		/**
		 * Track data fault event handler
		 * @param event
		 * 
		 */		
		private function onTrackDataFault(event:FaultEvent):void
		{
            service.removeEventListener(ResultEvent.RESULT, onTrackDataResult);
            service.removeEventListener(FaultEvent.FAULT, onTrackDataFault);
            
            this.dispatchEvent(new AlbumDataEvent(TrackDataEvent.TRACK_DATA_ERROR, null, event.message.toString()));				
		}
		
		/**
		 * Method function to retrieve instance of the class
		 *  
		 * @return The same instance of the class
		 * 
		 */
		public static function getInstance():Music
		{
			if( instance == null )
				instance = new  Music(new AccessRestriction());
			
			return instance;
		}				
	}
}

class AccessRestriction {}