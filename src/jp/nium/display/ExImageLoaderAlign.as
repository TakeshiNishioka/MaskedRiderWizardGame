/**
 * jp.nium Classes
 * 
 * @author Copyright (C) 2007-2009 taka:nium.jp, All Rights Reserved.
 * @version 4.0.1 Public Beta 1.2
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.display {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	
	/**
	 * <p>ExImageLoaderAlign クラスは、ExImageLoader クラスの画像の基準点となる値を提供します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ExImageLoaderAlign {
		
		/**
		 * <p>イメージを左上の隅に揃えるよう指定します。</p>
		 * <p>Set the image to align to top-left.</p>
		 * 
		 * @see jp.nium.display.ExImageLoader#align
		 */
		public static const TOP_LEFT:int = 0;
		
		/**
		 * <p>ステージを上揃えにするよう指定します。</p>
		 * <p>Set the stage to align to top.</p>
		 * 
		 * @see jp.nium.display.ExImageLoader#align
		 */
		public static const TOP:int = 1;
		
		/**
		 * <p>イメージを右上の隅に揃えるよう指定します。</p>
		 * <p>Set the image to align to top-right.</p>
		 * 
		 * @see jp.nium.display.ExImageLoader#align
		 */
		public static const TOP_RIGHT:int = 2;
		
		/**
		 * <p>イメージを左揃えにするよう指定します。</p>
		 * <p>Set the image to align to left.</p>
		 * 
		 * @see jp.nium.display.ExImageLoader#align
		 */
		public static const LEFT:int = 3;
		
		/**
		 * <p>イメージを中央に揃えるよう指定します。</p>
		 * <p>Set the image to align to center.</p>
		 * 
		 * @see jp.nium.display.ExImageLoader#align
		 */
		public static const CENTER:int = 4;
		
		/**
		 * <p>イメージを右揃えにするよう指定します。</p>
		 * <p>Set the image to align to right.</p>
		 * 
		 * @see jp.nium.display.ExImageLoader#align
		 */
		public static const RIGHT:int = 5;
		
		/**
		 * <p>イメージを左下の隅に揃えるよう指定します。</p>
		 * <p>Set the image to align to bottom-left.</p>
		 * 
		 * @see jp.nium.display.ExImageLoader#align
		 */
		public static const BOTTOM_LEFT:int = 6;
		
		/**
		 * <p>イメージを下揃えにするよう指定します。</p>
		 * <p>Set the image to align to bottom.</p>
		 * 
		 * @see jp.nium.display.ExImageLoader#align
		 */
		public static const BOTTOM:int = 7;
		
		/**
		 * <p>イメージを右下の隅に揃えるよう指定します。</p>
		 * <p>Set the image to align to bottom-right.</p>
		 * 
		 * @see jp.nium.display.ExImageLoader#align
		 */
		public static const BOTTOM_RIGHT:int = 8;
		
		
		
		
		
		/**
		 * @private
		 */
		public function ExImageLoaderAlign() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
