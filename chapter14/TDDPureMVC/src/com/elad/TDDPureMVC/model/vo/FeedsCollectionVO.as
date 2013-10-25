/*

 Copyright (c) 2008 Elrom LLC, Inc. All Rights Reserved 

 @author   Elad Elrom
 @contact  elad.ny@gmail.com
 @project  ProjectName

 @internal 

 */

package com.elad.TDDPureMVC.model.vo
{
	import mx.collections.ArrayCollection;
    
    [Bindable]
	public class FeedsCollectionVO
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