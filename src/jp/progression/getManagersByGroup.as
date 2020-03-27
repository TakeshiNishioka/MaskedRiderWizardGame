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
	 * <p>指定された group と同じ値を持つ Progression インスタンスを含む配列を返します。</p>
	 * <p></p>
	 * 
	 * @see jp.progression.Progression#group
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
	 * // Progression インスタンスを作成する
	 * var manager1:Progression = new Progression( "index1", stage );
	 * var manager2:Progression = new Progression( "index2", stage );
	 * var manager3:Progression = new Progression( "index3", stage );
	 * 
	 * // グループを設定する
	 * manager1.group = "mygroup";
	 * manager3.group = "mygroup";
	 * 
	 * // Progression インスタンスを取得する
	 * trace( getManagersByGroup( "mygroup" ) ); // [Progression id="index1"], [Progression id="index3"] と出力
	 * </listing>
	 */
	public function getManagersByGroup( group:String, sort:Boolean = false ):Array {
		return Progression.progression_internal::$collections.getInstancesByGroup( group, sort );
	}
}
