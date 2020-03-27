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
package jp.progression.commands {
	import jp.progression.core.ns.progression_internal;
	
	/**
	 * <p>指定された group と同じ値を持つ Command インスタンスを含む配列を返します。</p>
	 * <p></p>
	 * 
	 * @see jp.progression.commands.Command#group
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
	public function getCommandsByGroup( group:String, sort:Boolean = false ):Array {
		return Command.progression_internal::$collections.getInstancesByGroup( group, sort );
	}
}
