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
package com.elad.mp3tunes.view
{
	import com.elad.mp3tunes.view.W320H480.MusicPlayerMain;
	import com.elad.mp3tunes.view.W530H520.MusicPlayerMain;
	import com.elad.mp3tunes.view.W695H362.MusicPlayerMain;
	import com.elad.mp3tunes.view.W800H480.MusicPlayerMain;
	
	import flash.errors.IllegalOperationError;

	public final class MusicPlayerFactory
	{
		/**
		 * Music player types enums 
		 */		
		public static const W800H480:int = 0;
		public static const W320H480:int = 1;
		public static const W530H520:int = 2;
		public static const W695H362:int = 3;
		
		public static function createView(musicPlayerType:Number):AbstractMusicPlayerMain
		{
			var retVal:AbstractMusicPlayerMain;
			
			switch (musicPlayerType)
			{
				case W800H480:
					retVal = new com.elad.mp3tunes.view.W800H480.MusicPlayerMain;
				break;
				case W320H480:
					retVal = new com.elad.mp3tunes.view.W320H480.MusicPlayerMain;
				break;
				case W530H520:
					retVal = new com.elad.mp3tunes.view.W530H520.MusicPlayerMain;
				break;
				case W695H362:
					retVal = new com.elad.mp3tunes.view.W695H362.MusicPlayerMain;
				break;									
				throw new IllegalOperationError("The view type " + musicPlayerType + " is not recognized.");
			}
			
			return retVal;
		}
	}
}