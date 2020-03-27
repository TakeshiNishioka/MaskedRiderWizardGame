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
package jp.progression.casts.effects {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	
	/**
	 * <p>EffectStartPointType クラスは、startPoint プロパティの値を提供します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class EffectStartPointType {
		
		/**
		 * <p>エフェクトを左上の隅から開始するよう指定します。</p>
		 * <p></p>
		 */
		public static const TOP_LEFT:int = 1;
		
		/**
		 * <p>エフェクトを上から開始するよう指定します。</p>
		 * <p></p>
		 */
		public static const TOP:int = 2;
		
		/**
		 * <p>エフェクトを右上の隅から開始するよう指定します。</p>
		 * <p></p>
		 */
		public static const TOP_RIGHT:int = 3;
		
		/**
		 * <p>エフェクトを左から開始するよう指定します。</p>
		 * <p></p>
		 */
		public static const LEFT:int = 4;
		
		/**
		 * <p>エフェクトを中央から開始するよう指定します。</p>
		 * <p></p>
		 */
		public static const CENTER:int = 5;
		
		/**
		 * <p>エフェクトを右から開始するよう指定します。</p>
		 * <p></p>
		 */
		public static const RIGHT:int = 6;
		
		/**
		 * <p>エフェクトを左下の隅から開始するよう指定します。</p>
		 * <p></p>
		 */
		public static const BOTTOM_LEFT:int = 7;
		
		/**
		 * <p>エフェクトを下から開始するよう指定します。</p>
		 * <p></p>
		 */
		public static const BOTTOM:int = 8;
		
		/**
		 * <p>エフェクトを右下の隅から開始するよう指定します。</p>
		 * <p></p>
		 */
		public static const BOTTOM_RIGHT:int = 9;
		
		
		
		
		
		/**
		 * @private
		 */
		public function EffectStartPointType() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
