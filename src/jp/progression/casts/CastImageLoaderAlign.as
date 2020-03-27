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
	import jp.nium.display.ExImageLoaderAlign;
	import jp.nium.utils.ClassUtil;
	
	/**
	 * <p>CastImageLoaderAlign クラスは、CastImageLoader クラスの画像の基準点となる値を提供します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastImageLoaderAlign {
		
		/**
		 * <p>イメージを左上の隅に揃えるよう指定します。</p>
		 * <p>Set the image to align to top-left.</p>
		 * 
		 * @see jp.progression.casts.CastImageLoader#align
		 */
		public static const TOP_LEFT:int = ExImageLoaderAlign.TOP_LEFT;
		
		/**
		 * <p>ステージを上揃えにするよう指定します。</p>
		 * <p>Set the stage to align to top.</p>
		 * 
		 * @see jp.progression.casts.CastImageLoader#align
		 */
		public static const TOP:int = ExImageLoaderAlign.TOP;
		
		/**
		 * <p>イメージを右上の隅に揃えるよう指定します。</p>
		 * <p>Set the image to align to top-right.</p>
		 * 
		 * @see jp.progression.casts.CastImageLoader#align
		 */
		public static const TOP_RIGHT:int = ExImageLoaderAlign.TOP_RIGHT;
		
		/**
		 * <p>イメージを左揃えにするよう指定します。</p>
		 * <p>Set the image to align to left.</p>
		 * 
		 * @see jp.progression.casts.CastImageLoader#align
		 */
		public static const LEFT:int = ExImageLoaderAlign.LEFT;
		
		/**
		 * <p>イメージを中央に揃えるよう指定します。</p>
		 * <p>Set the image to align to center.</p>
		 */
		public static const CENTER:int = ExImageLoaderAlign.CENTER;
		
		/**
		 * <p>イメージを右揃えにするよう指定します。</p>
		 * <p>Set the image to align to right.</p>
		 * 
		 * @see jp.progression.casts.CastImageLoader#align
		 */
		public static const RIGHT:int = ExImageLoaderAlign.RIGHT;
		
		/**
		 * <p>イメージを左下の隅に揃えるよう指定します。</p>
		 * <p>Set the image to align to bottom-left.</p>
		 * 
		 * @see jp.progression.casts.CastImageLoader#align
		 */
		public static const BOTTOM_LEFT:int = ExImageLoaderAlign.BOTTOM_LEFT;
		
		/**
		 * <p>イメージを下揃えにするよう指定します。</p>
		 * <p>Set the image to align to bottom.</p>
		 * 
		 * @see jp.progression.casts.CastImageLoader#align
		 */
		public static const BOTTOM:int = ExImageLoaderAlign.BOTTOM;
		
		/**
		 * <p>イメージを右下の隅に揃えるよう指定します。</p>
		 * <p>Set the image to align to bottom-right.</p>
		 * 
		 * @see jp.progression.casts.CastImageLoader#align
		 */
		public static const BOTTOM_RIGHT:int = ExImageLoaderAlign.BOTTOM_RIGHT;
		
		
		
		
		
		/**
		 * @private
		 */
		public function CastImageLoaderAlign() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
