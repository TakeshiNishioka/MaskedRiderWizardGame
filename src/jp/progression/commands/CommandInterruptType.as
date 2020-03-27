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
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	
	/**
	 * <p>CommandInterruptType クラスは、Command クラスの interrupt() メソッドを実行した際の中断方法を示す値を提供します。</p>
	 * <p></p>
	 * 
	 * @see jp.progression.commands.Command#interruptType
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CommandInterruptType {
		
		/**
		 * <p>コマンド中断時、処理が実行される以前の状態に戻すように指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.commands.Command#interruptType
		 */
		public static const RESTORE:int = 0;
		
		/**
		 * <p>コマンド中断時、その時点の状態で停止するように指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.commands.Command#interruptType
		 */
		public static const ABORT:int = 1;
		
		/**
		 * <p>コマンド中断時、処理が完了された状態と同様になるように指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.commands.Command#interruptType
		 */
		public static const SKIP:int = 2;
		
		
		
		
		
		/**
		 * @private
		 */
		public function CommandInterruptType() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
