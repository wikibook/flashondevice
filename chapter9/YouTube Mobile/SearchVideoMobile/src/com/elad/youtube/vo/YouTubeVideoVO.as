package com.elad.youtube.vo
{
	public class YouTubeVideoVO
	{
		public var title:String;
		public var description:String;
		public var thumb:String;
		public var urlID:String;
		public var viewed:String;
		

		public function YouTubeVideoVO(title:String, description:String, thumb:String, urlID:String, viewed:String) 
		{
			this.title = title;
			this.description = description;
			this.thumb = thumb;
			this.urlID= urlID;
			this.viewed = viewed;
		}
	}
}