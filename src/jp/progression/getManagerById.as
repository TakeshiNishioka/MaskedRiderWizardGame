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
package jp.progression {
	import jp.progression.core.ns.progression_internal;
	
	/**
	 * <p>指定された id と同じ値が設定されている Progression インスタンスを返します。</p>
	 * <p></p>
	 * 
	 * @see jp.progression.Progression#id
	 * 
	 * @param id
	 * <p>条件となるストリングです。</p>
	 * <p></p>
	 * @return
	 * <p>条件と一致するインスタンスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // Progression インスタンスを作成する
	 * var manager:Progression = new Progression( "index", stage );
	 * 
	 * // Progression インスタンスを取得する
	 * trace( getManagerById( "index" ) ); // [Progression id="index"] と出力
	 * </listing>
	 */
	public function getManagerById( id:String ):Progression {
		return Progression.progression_internal::$collections.getInstanceById( id ) as Progression;
	}
}
