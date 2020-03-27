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
package jp.progression.commands.lists {
	import flash.events.IEventDispatcher;
	
	/**
	 * <p>IRepeatable インターフェイスは、対象のコマンドに対してループ処理操作を実装します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public interface IRepeatable extends IEventDispatcher {
		
		/**
		 * <p>実行したいループ処理数を取得または設定します。
		 * この値が 0 に設定されている場合には、stop() メソッドで終了させるまで処理し続けます。</p>
		 * <p></p>
		 * 
		 * @see #count
		 * @see #stop()
		 */
		function get repeatCount():int;
		function set repeatCount( value:int ):void;
		
		/**
		 * <p>現在のループ処理回数です。</p>
		 * <p></p>
		 * 
		 * @see #repeatCount
		 * @see #stop()
		 */
		function get count():int;
		
		
		
		
		
		/**
		 * <p>実行中のループ処理を停止させます。</p>
		 * <p></p>
		 * 
		 * @see #count
		 * @see #repeatCount
		 */
		function stop():void;
	}
}
