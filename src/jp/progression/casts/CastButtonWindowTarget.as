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
	 * <p>CastButtonWindowTarget クラスは、CastButton クラスの移動先を展開する対象のブラウザウィンドウを示す値を提供します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastButtonWindowTarget {
		
		/**
		 * <p>対象を自身のウィンドウで開くように指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.casts.CastButton#windowTarget
		 * @see jp.progression.casts.CastButton#navitateTo()
		 */
		public static const SELF:String = "_self";
		
		/**
		 * <p>対象を最上位のフレームで開くように指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.casts.CastButton#windowTarget
		 * @see jp.progression.casts.CastButton#navitateTo()
		 */
		public static const TOP:String = "_top";
		
		/**
		 * <p>対象を親のフレームで開くように指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.casts.CastButton#windowTarget
		 * @see jp.progression.casts.CastButton#navitateTo()
		 */
		public static const PARENT:String = "_parent";
		
		/**
		 * <p>対象を新しいウィンドウで開くように指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.casts.CastButton#windowTarget
		 * @see jp.progression.casts.CastButton#navitateTo()
		 */
		public static const BLANK:String = "_blank";
		
		
		
		
		
		/**
		 * @private
		 */
		public function CastButtonWindowTarget() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
