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
	import com.elad.framework.musicplayer.Player;
	import com.elad.framework.musicplayer.events.DownloadEvent;
	import com.elad.framework.musicplayer.events.Id3Event;
	import com.elad.framework.musicplayer.events.PlayProgressEvent;
	import com.elad.framework.musicplayer.events.PlayerEvent;
	import com.elad.mp3tunes.vo.TrackItemVO;
	import com.elad.mp3tunes.view.AbstractMusicPlayer;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	import mx.events.SliderEvent;
	import mx.managers.CursorManager;
	
	[Bindable]
	public class MusicPlayerPresenter
	{

	    //--------------------------------------------------------------------------
	    //
	    //  Event const
	    //
	    //--------------------------------------------------------------------------
		
		public static const PLAYING_COMPLETED:String = "PlayingCompleted";
		public static const ARTISTS_CLICK_EVENT:String = "artistsClickEvent";
		public static const ALBUMS_CLICK_EVENT:String = "albumsClickEvent";
		public static const NEXT_TRACK_EVENT:String = "nextTrackEvent";
		public static const PREVIOUS_TRACK_EVENT:String = "previousTrackEvent";
		
	    //--------------------------------------------------------------------------
	    //
	    //  Variables
	    //
	    //--------------------------------------------------------------------------
	    		
		private var trackItem:TrackItemVO;
		private var player:Player = new Player();		
		private var musicPlayer:AbstractMusicPlayer;

	    //--------------------------------------------------------------------------
	    //
	    //  Constructor
	    //
	    //--------------------------------------------------------------------------
	    		
		public function MusicPlayerPresenter(musicPlayer:AbstractMusicPlayer)
		{
			this.musicPlayer = musicPlayer;
			
			musicPlayer.playButton.addEventListener(MouseEvent.CLICK, onPlayButtonClicked);
			musicPlayer.pauseButton.addEventListener(MouseEvent.CLICK, onPauseButtonClicked);
			musicPlayer.volumeSlider.addEventListener(Event.CHANGE, volumeDragDropHandler);
			musicPlayer.artistsButton.addEventListener(Event.CHANGE, artistsClickHandler);
			musicPlayer.albumsButton.addEventListener(Event.CHANGE, albumsClickHandler);
			musicPlayer.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			musicPlayer.forwardButton.addEventListener(MouseEvent.CLICK, onForwardButtonClicked);
			musicPlayer.rewindButton.addEventListener(MouseEvent.CLICK, onRewindButtonClicked);
		}

	    //--------------------------------------------------------------------------
	    //
	    //  Class methods
	    //
	    //--------------------------------------------------------------------------
		
		public function playSong(trackItem:TrackItemVO):void
		{
			this.trackItem = trackItem;
			
			player.stopTrack();
			player.addEventListener(PlayProgressEvent.PLAYER_PROGRESS, onPlayerProgress);
			player.addEventListener(DownloadEvent.DOWNLOAD_PROGRESS, onDownloadProgress);
			player.addEventListener(PlayerEvent.PLAYER_ERROR, onPlayerError);
			player.addEventListener(PlayerEvent.TRACK_COMPLETED, playingCompletedHandler);
			player.playTrack(trackItem.downloadURL, trackItem.trackLength);
			
			CursorManager.setBusyCursor();
			
			musicPlayer.pauseButton.visible = true;
			musicPlayer.playButton.visible = false;
			
			musicPlayer.songInfoText.text = trackItem.artistName+" - "+trackItem.trackTitle+" - "+trackItem.albumTitle;
		}
		
		private function removePlayerEventListener():void
		{
			player.removeEventListener(PlayProgressEvent.PLAYER_PROGRESS, onPlayerProgress);
			player.removeEventListener(PlayerEvent.PLAYER_ERROR, onPlayerError);
			player.removeEventListener(DownloadEvent.DOWNLOAD_PROGRESS, onDownloadProgress);
			player.removeEventListener(PlayerEvent.TRACK_COMPLETED, playingCompletedHandler);
		}			
		
	    //--------------------------------------------------------------------------
	    //
	    //  Event handlers
	    //
	    //--------------------------------------------------------------------------			

		private function onPlayButtonClicked(event:MouseEvent):void 
		{
			musicPlayer.playButton.visible=false;
			musicPlayer.pauseButton.visible=true;
			player.playTrack(trackItem.downloadURL);
			
		}

		private function onPauseButtonClicked(event:MouseEvent):void
		{ 
			musicPlayer.playButton.visible=true;
			musicPlayer.pauseButton.visible=false;
			player.pauseTrack();
		}
		
		private function onCreationComplete(event:FlexEvent):void
		{
			if (this.musicPlayer.songSlider.className == "HSlider")
			{
				musicPlayer.songSlider.addEventListener(MouseEvent.MOUSE_DOWN, dragStartHandler);
				musicPlayer.songSlider.addEventListener(MouseEvent.MOUSE_UP, dragDropHandler);				
			}
			else  // FxHScrollBar
			{
				musicPlayer.songSlider.thumb.addEventListener(MouseEvent.MOUSE_DOWN, dragStartHandler);
				musicPlayer.songSlider.thumb.addEventListener(MouseEvent.MOUSE_UP, dragDropHandler);				
			}
			
			// set progress bar
			musicPlayer.volumeProgressBar.setProgress(100, 100);			
		}
		
		private function onPlayerProgress(event:PlayProgressEvent):void
		{
			CursorManager.removeBusyCursor();
			
			musicPlayer.songSlider.value = event.playPosition;
			musicPlayer.currentTimeText.text = Player.formatTimeInSecondsToString(event.playPosition);
			musicPlayer.totalTimeText.text = Player.formatTimeInSecondsToString(event.total);
			musicPlayer.songSlider.maximum = event.total;
			
			musicPlayer.trackProgressBar.setProgress(event.playPosition, event.total);
		}
		
		private function onPlayerError(event:PlayerEvent):void
		{
			throw new Error(event.message);
			removePlayerEventListener();
		}

		protected function volumeDragDropHandler(event:Event=null):void
		{
			musicPlayer.volumeProgressBar.setProgress(musicPlayer.volumeSlider.value, musicPlayer.volumeSlider.maximum);
			player.setVolume(musicPlayer.volumeSlider.value/100);
		}			
		
		protected function dragStartHandler(event:MouseEvent):void
		{
			player.removeEventListener(PlayProgressEvent.PLAYER_PROGRESS, onPlayerProgress);
		}
		
		private function onDownloadProgress(event:DownloadEvent):void
		{
			musicPlayer.downloadProgressBar.setProgress(event.bytesLoaded, event.bytesTotal);
		}

		protected function dragDropHandler(event:MouseEvent):void
		{
			player.setTrackPosition(musicPlayer.songSlider.value);
			player.addEventListener(PlayProgressEvent.PLAYER_PROGRESS, onPlayerProgress);
		}			
		
		protected function dragVolumeHandler(event:SliderEvent):void
		{
			player.setVolume(musicPlayer.volumeSlider.value);
		}

		private function playingCompletedHandler(event:Event):void
		{
			removePlayerEventListener();
			musicPlayer.dispatchEvent(new Event(PLAYING_COMPLETED));
		}

		protected function artistsClickHandler(event:MouseEvent):void
		{
			musicPlayer.dispatchEvent(new Event(ARTISTS_CLICK_EVENT));
		}

		protected function albumsClickHandler(event:MouseEvent):void
		{
			musicPlayer.dispatchEvent(new Event(ALBUMS_CLICK_EVENT));
		}
		
		protected function onForwardButtonClicked(event:MouseEvent):void
		{
			musicPlayer.dispatchEvent(new Event(NEXT_TRACK_EVENT));
		}
		
		protected function onRewindButtonClicked(event:MouseEvent):void
		{
			musicPlayer.dispatchEvent(new Event(PREVIOUS_TRACK_EVENT));
		}			
	}
}