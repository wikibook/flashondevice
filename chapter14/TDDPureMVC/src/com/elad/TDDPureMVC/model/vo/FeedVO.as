/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  ProjectName

 @internal 

 */

package com.elad.TDDPureMVC.model.vo
{
    [Bindable]
	public class FeedVO
	{
		public function FeedVO() {
		}
		
		public var title:String;
		public var link:String;
		public var author:String;
		public var description:String;
		public var pubdate:String;
		public var category:String;		
	}
}