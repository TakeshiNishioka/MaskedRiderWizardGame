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
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	
	/**
	 * <p>CastButtonState クラスは、CastButton クラスの状態に対応した値を提供します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastButtonState {
		
		/**
		 * <p>ボタンが無効化されている状態であることを指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.casts.CastButton#state
		 */
		public static const DISABLE:int = 0;
		
		/**
		 * <p>現在のシーン位置がボタンに設定されているシーンの子以下に位置していることを指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.casts.CastButton#state
		 */
		public static const CHILD:int = 1;
		
		/**
		 * <p>現在のシーン位置がボタンに設定されているシーンと同じであることを指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.casts.CastButton#state
		 */
		public static const CURRENT:int = 2;
		
		/**
		 * <p>現在のシーン位置がボタンに設定されているシーンの親以上に位置していることを指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.casts.CastButton#state
		 */
		public static const PARENT:int = 3;
		
		/**
		 * <p>ボタンが通常状態であることを指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.casts.CastButton#state
		 */
		public static const NEUTRAL:int = 4;
		
		
		
		
		
		/**
		 * @private
		 */
		public function CastButtonState() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
