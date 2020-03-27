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
package jp.progression.casts {
	import flash.display.DisplayObject;
	import jp.nium.core.ns.nium_internal;
	import jp.nium.display.ExMovieClip;
	
	/**
	 * <p>指定された id と同じ値が設定されている IExDisplayObject インスタンスを返します。</p>
	 * <p></p>
	 * 
	 * @see jp.nium.core.display.IExDisplayObject#id
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
	public function getInstanceById( id:String ):DisplayObject {
		return ExMovieClip.nium_internal::$collections.getInstanceById( id ) as DisplayObject;
	}
}
