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
package jp.progression.core.components {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	
	/**
	 * @private
	 */
	public class ComponentProperties {
		
		/**
		 * <p>アニメーションの登録情報を保持するプロパティ名として指定します。</p>
		 * <p></p>
		 */
		public static const CURRENT_ANIMATION:String = "__progressionCurrentAnimation__";
		
		/**
		 * <p>ボタンの登録情報を保持するプロパティ名として指定します。</p>
		 * <p></p>
		 */
		public static const CURRENT_BUTTON:String = "__progressionCurrentButton__";
		
		/**
		 * <p>エフェクトの登録情報を保持するプロパティ名として指定します。</p>
		 * <p></p>
		 */
		public static const CURRENT_EFFECTS:String = "__progressionCurrentEffects__";
		
		/**
		 * <p>ローダーの登録情報を保持するプロパティ名として指定します。</p>
		 * <p></p>
		 */
		public static const CURRENT_LOADER:String = "__progressionCurrentLoader__";
		
		
		
		
		
		/**
		 * @private
		 */
		public function ComponentProperties() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
