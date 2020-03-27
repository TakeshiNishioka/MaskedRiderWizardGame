/**
 * jp.nium Classes
 * 
 * @author Copyright (C) 2007-2009 taka:nium.jp, All Rights Reserved.
 * @version 4.0.1 Public Beta 1.2
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.display {
	import flash.display.DisplayObject;
	import jp.nium.core.ns.nium_internal;
	
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
