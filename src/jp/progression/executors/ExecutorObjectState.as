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
package jp.progression.executors {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	
	/**
	 * <p>ExecutorObjectState クラスは、ExecutorObject クラスの実行状態を示す値を提供します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ExecutorObjectState {
		
		/**
		 * <p>コマンドが実行されていない状態となるように指定します。</p>
		 * <p></p>
		 */
		public static const IDLING:int = 0;
		
		/**
		 * <p>コマンドが遅延処理中となるように指定します。</p>
		 * <p></p>
		 */
		public static const DELAYING:int = 1;
		
		/**
		 * <pコマンドが実行されている状態となるように指定します。></p>
		 * <p></p>
		 */
		public static const EXECUTING:int = 2;
		
		/**
		 * <p>コマンドが中断処理中となるように指定します。</p>
		 * <p></p>
		 */
		public static const INTERRUPTING:int = 3;
		
		
		
		
		
		/**
		 * @private
		 */
		public function ExecutorObjectState() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
