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
package com.elad.mp3tunes.view.presenter
{
	import com.elad.mp3tunes.Music;
	import com.elad.mp3tunes.enum.SortType;
	import com.elad.mp3tunes.events.AlbumDataEvent;
	import com.elad.mp3tunes.events.ArtistsResultEvent;
	import com.elad.mp3tunes.events.TrackDataEvent;
	import com.elad.mp3tunes.vo.AlbumItemVO;
	import com.elad.mp3tunes.vo.AlbumListVO;
	import com.elad.mp3tunes.vo.ArtistItemVO;
	import com.elad.mp3tunes.vo.ArtistListVO;
	import com.elad.mp3tunes.vo.TrackItemVO;
	import com.elad.mp3tunes.vo.TrackListVO;
	import com.elad.mp3tunes.view.AbstractMusicPlayerMain;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.ListEvent;

	/**
	 * Presentation Pattern - Passive View
	 *  
	 * @author Elad
	 * 
	 */	
	 [Bindable]
	public class MusicPlayerMainPresenter
	{
		
	    //--------------------------------------------------------------------------
	    //
	    //  Variables
	    //
	    //--------------------------------------------------------------------------
	    		
		private var music:Music = Music.getInstance();
		
		private var artistList:ArtistListVO = null;
		private var albumList:AlbumListVO = null;
		private var trackList:TrackListVO = null;
		private var tileResultType:String;
		
		// Corresponding view
		private var musicPlayerMain:AbstractMusicPlayerMain;
		
        // Sub-presenters
        private var musicPlayerPresenter:MusicPlayerPresenter;

	    //--------------------------------------------------------------------------
	    //
	    //  Constructor
	    //
	    //--------------------------------------------------------------------------
	    
		public function MusicPlayerMainPresenter(musicPlayerMain:AbstractMusicPlayerMain)
		{
			this.musicPlayerMain = musicPlayerMain;
			
			musicPlayerPresenter = new MusicPlayerPresenter(musicPlayerMain.musicPlayer);
			
			musicPlayerMain.dg.addEventListener(Event.CHANGE, dgChangeHandler);
			musicPlayerMain.tileList.addEventListener(Event.CHANGE, selectTileListItem);
			musicPlayerMain.musicPlayer.addEventListener(MusicPlayerPresenter.NEXT_TRACK_EVENT, nextTrack);
			musicPlayerMain.musicPlayer.addEventListener(MusicPlayerPresenter.PREVIOUS_TRACK_EVENT, previousTrack);
			musicPlayerMain.musicPlayer.addEventListener(MusicPlayerPresenter.ARTISTS_CLICK_EVENT, getAllArtists);
			musicPlayerMain.musicPlayer.addEventListener(MusicPlayerPresenter.ALBUMS_CLICK_EVENT, getAllAlbums);			
			musicPlayerMain.musicPlayer.addEventListener(MusicPlayerPresenter.PLAYING_COMPLETED, function():void { nextTrack(null); } );			
			
			getAllArtists();
		}

	    //--------------------------------------------------------------------------
	    //
	    //  Class methods
	    //
	    //--------------------------------------------------------------------------
		
		private function nextTrack(event:Event):void
		{
			var trackItem:TrackItemVO = trackList.getItem(++musicPlayerMain.dg.selectedIndex);
			musicPlayerPresenter.playSong(trackItem);
		}
		
		private function previousTrack(event:Event):void
		{
			var trackItem:TrackItemVO = trackList.getItem(--musicPlayerMain.dg.selectedIndex);
			musicPlayerPresenter.playSong(trackItem);
		}
		
		private function getAllAlbums(event:Event=null):void
		{
			music.addEventListener(AlbumDataEvent.ALL_ALBUMS_DATA_COMPLETED, onAllAlbumCompleted);
			music.getAllAlbums(artistList);				
		}			
		
		private function getAllArtists(event:Event=null):void
		{								
			music.addEventListener(ArtistsResultEvent.ARTIST_RESULT_COMPLETED, onArtistsResult);
			music.addEventListener(ArtistsResultEvent.ARTIST_RESULT_ERROR, function(event:ArtistsResultEvent):void { Alert.show(String(event.message)); });
			
			music.getMusicByArtists();
		}

	    //--------------------------------------------------------------------------
	    //
	    //  Event handlers
	    //
	    //--------------------------------------------------------------------------			
		
		protected function selectTileListItem(event:ListEvent):void
		{
			var index:Number;
			
			if (event.currentTarget.className == "HorizontalList")
			{
				index = event.columnIndex;
			}
			else // type: List
			{
				index = event.rowIndex;
			}
			
			getTrackList(index);
		}
		
		protected function getTrackList(index:Number):void
		{
			var id:String;
			
			music.addEventListener(TrackDataEvent.TRACK_DATA_COMPLETED, onTrackDataComplete);
			music.addEventListener(TrackDataEvent.TRACK_DATA_ERROR, function():void { Alert.show("Error getting track data"); });
			
			// based on the type in the tile list
			switch (tileResultType)
			{
				case SortType.ALBUMS:
					var albumItem:AlbumItemVO = albumList.getItem(index);
					id = albumItem.albumId;
				break
				
				case SortType.ARTISTS:
					var artistItem:ArtistItemVO = artistList.getItem(index);
					id = artistItem.artistId;					
				break
			}
			
			music.getTrackData(id, tileResultType);				
		}


		protected function dgChangeHandler(event:ListEvent):void
		{
			var index:Number = event.rowIndex;
			
			var trackItem:TrackItemVO = trackList.getItem(index);
			musicPlayerPresenter.playSong(trackItem);
		}
					
		private function onArtistsResult(event:ArtistsResultEvent):void
		{
			music.removeEventListener(ArtistsResultEvent.ARTIST_RESULT_COMPLETED, onArtistsResult);
			tileResultType = SortType.ARTISTS;
			
			artistList = new ArtistListVO(event.artistList.list.source);
			var item:ArtistItemVO = artistList.getItem(0);
			
			
			var dp:ArrayCollection = new ArrayCollection();
			for (var i:Number = 0; i<artistList.list.length; i++)
			{
				item = artistList.getItem(i);
				dp.addItem({name: item.artistName, count: item.trackCount});
			}
			
			musicPlayerMain.tileList.dataProvider = dp;
			musicPlayerMain.tileList.selectedIndex = 0;
			getTrackList(0);	
		}
		
		private function onAllAlbumCompleted(event:AlbumDataEvent):void
		{
			music.removeEventListener(AlbumDataEvent.ALL_ALBUMS_DATA_COMPLETED, onAllAlbumCompleted);
			tileResultType = SortType.ALBUMS;
			
			albumList = new AlbumListVO(event.collection.list.source);
			var item:AlbumItemVO;
							
			var dp:ArrayCollection = new ArrayCollection();
			for (var i:Number = 0; i<albumList.list.length; i++)
			{
				item = albumList.getItem(i);
				dp.addItem({name: item.albumTitle, count: item.trackCount});
			}
			
			musicPlayerMain.tileList.dataProvider = dp;
			musicPlayerMain.tileList.selectedIndex = 0;
			getTrackList(0);			
		}
		
		private function onAlbumDataComplete(event:AlbumDataEvent):void
		{
			music.removeEventListener(AlbumDataEvent.ALBUM_DATA_COMPLETED, onAlbumDataComplete);
			music.removeEventListener(AlbumDataEvent.ALBUM_DATA_ERROR, onAlbumDataComplete);
			
			var albumList:AlbumListVO = new AlbumListVO(event.collection.list.source);
			var albumId:String = albumList.getItem(0).albumId;
			
			music.addEventListener(TrackDataEvent.TRACK_DATA_COMPLETED, onTrackDataComplete);
			music.addEventListener(TrackDataEvent.TRACK_DATA_ERROR, function():void { Alert.show("Error getting track data"); });
			
			music.getTrackData(albumId);
		}
		
		private function onTrackDataComplete(event:TrackDataEvent):void
		{
			music.removeEventListener(AlbumDataEvent.ALBUM_DATA_COMPLETED, onAlbumDataComplete);
			music.removeEventListener(TrackDataEvent.TRACK_DATA_ERROR, function():void { Alert.show("Error getting track data"); });
			
			trackList = new TrackListVO(event.collection.list.source);
			
			// show track list
			musicPlayerMain.dg.dataProvider = trackList.list.source;
			
			// play first song
			var trackItem:TrackItemVO = trackList.getItem(0);
			musicPlayerPresenter.playSong(trackItem);
			
			// set selected song
			musicPlayerMain.dg.selectedIndex = 0;
		}

	}
}