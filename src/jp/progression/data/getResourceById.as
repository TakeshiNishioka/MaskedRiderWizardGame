/**
 * Progression 4
 * 
 * @author Copyright (C) 2007-2009 taka:nium.jp, All Rights Reserved.
 * @version 4.0.1 Public Beta 1.2
 * @see http://progression.jp/
 * 
 * Progression Software is released under the Progression Software License:
 * http://progression.jp/ja/overview/license
 * 
 * Progression Libraries is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.progression.data {
	import jp.progression.core.ns.progression_internal;
	
	/**
	 * <p>指定された id と同じ値が設定されている Resource インスタンスを返します。</p>
	 * <p></p>
	 * 
	 * @see jp.progression.data.Resource#id
	 * 
	 * @param id
	 * <p>条件となるストリングです。</p>
	 * <p></p>
	 * @return
	 * <p>条件と一致するインスタンスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public function getResourceById( id:String ):Resource {
		return Resource.progression_internal::$collections.getInstanceById( id ) as Resource;
	}
}
