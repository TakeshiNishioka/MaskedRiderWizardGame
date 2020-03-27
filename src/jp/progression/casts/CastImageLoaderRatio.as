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
	 * <p>CastImageLoaderRatio クラスは、CastImageLoader クラスの画像比率の処理方法を示す値を提供します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastImageLoaderRatio {
		
		/**
		 * <p>イメージの比率を保持せずに指定された調整サイズに変形するよう指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.nium.display.ExImageLoader#adjustWidth
		 * @see jp.nium.display.ExImageLoader#adjustHeight
		 * @see jp.nium.display.ExImageLoader#ratio
		 */
		public static const NONE:int = 0;
		
		/**
		 * <p>縦または横のいずれか短い辺が、指定された調整サイズと一致させながら変形するよう指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.nium.display.ExImageLoader#adjustWidth
		 * @see jp.nium.display.ExImageLoader#adjustHeight
		 * @see jp.nium.display.ExImageLoader#ratio
		 */
		public static const OVERFLOW:int = 1;
		
		/**
		 * <p>縦または横のいずれか長い辺が、指定された調整サイズと一致させながら変形するよう指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.nium.display.ExImageLoader#adjustWidth
		 * @see jp.nium.display.ExImageLoader#adjustHeight
		 * @see jp.nium.display.ExImageLoader#ratio
		 */
		public static const SQUEEZE:int = 2;
		
		
		
		
		
		/**
		 * @private
		 */
		public function CastImageLoaderRatio() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
