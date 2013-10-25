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
	
	import mx.collections.ArrayCollection;
    
    [Bindable]
    /**
     *
     * Defines the <code>FeedsCollectionVO<code> Value Object implementation
     *
     * @see com.adobe.cairngorm.vo.IValueObject
     *
     */
	public class FeedsCollectionVO implements IValueObject
	{
		public function FeedsCollectionVO() {
		}
		
		public var collection:ArrayCollection = new ArrayCollection;
		
		public function addItem(val:FeedVO):void
		{
			collection.addItem(val);
		}
		
		public function getItem(index:Number):FeedVO
		{
			var retVal:FeedVO = new FeedVO();
			retVal = collection.getItemAt(index) as FeedVO;
			return retVal;			
		}
	}
}