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
	 * <p>EffectDirectionType クラスは、directionType プロパティの値を提供します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class EffectDirectionType {
		
		/**
		 * <p>エフェクトが開始方向のイージングをするよう指定します。</p>
		 * <p></p>
		 */
		public static const IN:String = "in";
		
		/**
		 * <p>エフェクトが終了方向のイージングをするよう指定します。</p>
		 * <p></p>
		 */
		public static const OUT:String = "out";
		
		/**
		 * <p>エフェクトが開始・終了方向のイージングをするよう指定します。</p>
		 * <p></p>
		 */
		public static const IN_OUT:String = "inOut";
		
		
		
		
		
		/**
		 * @private
		 */
		public function EffectDirectionType() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
