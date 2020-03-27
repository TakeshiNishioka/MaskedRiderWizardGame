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
package jp.progression.scenes {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	
	/**
	 * <p>PRMLContentType クラスは、PRML 形式のフォーマットを示す値を提供します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class PRMLContentType {
		
		/**
		 * <p>XML データがもっとも基本的な PRML 形式となるように指定します。</p>
		 * <p></p>
		 */
		public static const PLAIN:String = "text/prml.plain";
		
		/**
		 * <p>XML データが EasyCasting 用に拡張された PRML 形式となるように指定します。</p>
		 * <p></p>
		 */
		public static const EASYCASTING:String = "text/prml.easycasting";
		
		
		
		
		
		/**
		 * @private
		 */
		public function PRMLContentType() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
