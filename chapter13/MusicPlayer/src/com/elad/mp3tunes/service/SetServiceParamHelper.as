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
package com.elad.mp3tunes.service
{
	import com.elad.mp3tunes.enum.LockerDataTypes;
	
	import mx.utils.StringUtil;

	/**
	 *  Helper to generate an object for each service call.
	 */
	public final class SetServiceParamHelper
	{
		public static function getloginParam(token:String, userName:String, password:String):Object
		{
	        var params:Object = {};
	        params["username"] = StringUtil.trim(userName);
	        params["password"] = StringUtil.trim(password);
	        params["partner_token"] = token;
	        params["output"] = "xml";
	        
	        return params;			
		}
		
		public static function getMusicByArtistsParam(sid:String):Object
		{
            var params:Object = {};
            params["sid"] = sid;
            params["type"] = LockerDataTypes.ARTIST;
            params["output"] = "xml";
            
            return params;  			
		}
		
		public static function getAlbumDataParam(sid:String, artistId:String):Object
		{
            var params:Object = {};
            params["sid"] = sid;
            params["type"] = LockerDataTypes.ALBUM;
            params["output"] = "xml";
            params["artist_id"] = artistId;
            
            return params;			
		}
		
		public static function getTrackDataParam(sid:String, id:String, sortType:String):Object
		{
            var params:Object = {};
            params["sid"] = sid;
            params["type"] = LockerDataTypes.TRACK;
            params["output"] = "xml";
            params[sortType] = id; 
            
            return params;			
		}			
	}
}