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
package com.elad.mp3tunes.vo
{
	public class AlbumItemVO
	{
		public function AlbumItemVO(albumId:String, albumTitle:String, artistId:String, artistName:String, trackCount:String, albumSize:String, releaseDate:String, purchaseDate:String, hasArt:int)
		{
			this.albumId = albumId;
			this.albumTitle = albumTitle;
			this.artistId = artistId;
			this.artistName = artistName;
			this.trackCount = trackCount;
			this.albumSize = albumSize;
			this.releaseDate = releaseDate;
			this.purchaseDate = purchaseDate;
			this.hasArt = hasArt;
		}
		
		public var albumId:String;
		public var albumTitle:String;
		public var artistId:String;
		public var artistName:String;
		public var trackCount:String;
		public var albumSize:String;
		public var releaseDate:String;
		public var purchaseDate:String;
		public var hasArt:int;
	}
}