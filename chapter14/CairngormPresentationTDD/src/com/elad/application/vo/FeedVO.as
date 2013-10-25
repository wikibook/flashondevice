/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  ProjectName

 @internal 

 */

package com.elad.application.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
    
    [Bindable]
    /**
     *
     * Defines the <code>FeedVO<code> Value Object implementation
     *
     * @see com.adobe.cairngorm.vo.IValueObject
     *
     */
	public class FeedVO implements IValueObject
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