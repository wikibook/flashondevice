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
package com.elad.mp3tunes.enum
{
	/**
	 *  Holds the enums for the locker data sort types
	 */	
	public final class SortType
	{
		public static const ALBUMS:String = "album_id"; // Used when type=track to filter list of tracks by album. To retrieve a list of albums, set type=album.
		public static const ARTISTS:String = "artist_id"; // Used when type=album to filter list of albums by artist, or when type=track to filter list of tracks by artist. To retrieve a list of artists, set type=artist.
		public static const PLAYLISTS:String = "playlist_id"; // Used when type=track to filter list of tracks by playlist. To retrieve a list of playlists, set type=playlist or type=playmix.		
	}
}