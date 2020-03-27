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
	import jp.nium.core.ns.nium_internal;
	import jp.nium.display.ExMovieClip;
	
	/**
	 * <p>指定された group と同じ値を持つ IExDisplayObject インスタンスを含む配列を返します。</p>
	 * <p></p>
	 * 
	 * @see jp.nium.core.display.IExDisplayObject#group
	 * 
	 * @param group
	 * <p>条件となるストリングです。</p>
	 * <p></p>
	 * @param sort
	 * <p>結果の配列をソートして返すかどうかを指定します。</p>
	 * <p></p>
	 * @return
	 * <p>条件と一致するインスタンスを含む配列です。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public function getInstancesByGroup( group:String, sort:Boolean = false ):Array {
		return ExMovieClip.nium_internal::$collections.getInstancesByGroup( group, sort );
	}
}
