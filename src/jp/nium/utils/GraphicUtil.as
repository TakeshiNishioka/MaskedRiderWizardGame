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
package jp.nium.utils {
	import flash.display.Sprite;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	
	/**
	 * <p>GraphicUtil クラスは、グラフィック描画操作のためのユーティリティクラスです。</p>
	 * <p></p>
	 */
	public class GraphicUtil {
		
		/**
		 * @private
		 */
		public function GraphicUtil() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>円を描画します。</p>
		 * <p>Draws a circle.</p>
		 * 
		 * @param target
		 * <p>描画対象となる Sprite です。</p>
		 * <p></p>
		 * @param color
		 * <p>描画する色です。</p>
		 * <p></p>
		 * @param alpha
		 * <p>描画するアルファです。</p>
		 * <p></p>
		 * @param x
		 * <p>親表示オブジェクトの基準点からの円の中心の相対 x 座標（ピクセル単位）です。</p>
		 * <p>The x location of the center of the circle relative to the registration point of the parent display object (in pixels).</p>
		 * @param y
		 * <p>親表示オブジェクトの基準点からの円の中心の相対 y 座標（ピクセル単位）です。</p>
		 * <p>The y location of the center of the circle relative to the registration point of the parent display object (in pixels).</p>
		 * @param radius
		 * <p>円の半径（ピクセル単位）です。</p>
		 * <p>The radius of the circle (in pixels).</p>
		 * @return
		 * <p>target パラメータで渡す Sprite インスタンスです。</p>
		 * <p>The Sprite instance that you pass in the target parameter.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function drawCircle( target:Sprite, color:int = -1, alpha:Number = 1.0, x:Number = 0.0, y:Number = 0.0, radius:Number = 100.0 ):Sprite {
			if ( color < 0 ) {
				color = int( 0xFFFFFF * Math.random() );
			}
			
			target.graphics.beginFill( color, alpha );
			target.graphics.drawCircle( x, y, radius );
			target.graphics.endFill();
			
			return target;
		}
		
		/**
		 * <p>楕円を描画します。</p>
		 * <p>Draws an ellipse.</p>
		 * 
		 * @param target
		 * <p>描画対象となる Sprite です。</p>
		 * <p></p>
		 * @param color
		 * <p>描画する色です。</p>
		 * <p></p>
		 * @param alpha
		 * <p>描画するアルファです。</p>
		 * <p></p>
		 * @param x
		 * <p>親表示オブジェクトの基準点からの楕円の境界ボックスの左上の相対 x 座標（ピクセル単位）です。</p>
		 * <p>The x location of the top-left of the bounding-box of the ellipse relative to the registration point of the parent display object (in pixels).</p>
		 * @param y
		 * <p>親表示オブジェクトの基準点からの楕円の境界ボックスの左上の相対 y 座標（ピクセル単位）です。</p>
		 * <p>The y location of the top left of the bounding-box of the ellipse relative to the registration point of the parent display object (in pixels).</p>
		 * @param width
		 * <p>楕円の幅（ピクセル単位）です。</p>
		 * <p>The width of the ellipse (in pixels).</p>
		 * @param height
		 * <p>楕円の高さ（ピクセル単位）です。</p>
		 * <p>The height of the ellipse (in pixels).</p>
		 * @return
		 * <p>target パラメータで渡す Sprite インスタンスです。</p>
		 * <p>The Sprite instance that you pass in the target parameter.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function drawEllipse( target:Sprite, color:int = -1, alpha:Number = 1.0, x:Number = 0.0, y:Number = 0.0, width:Number = 100.0, height:Number = 100.0 ):Sprite {
			if ( color < 0 ) {
				color = int( 0xFFFFFF * Math.random() );
			}
			
			target.graphics.beginFill( color, alpha );
			target.graphics.drawEllipse( x, y, width, height );
			target.graphics.endFill();
			
			return target;
		}
		
		/**
		 * <p>矩形を描画します。</p>
		 * <p>Draws a rectangle.</p>
		 * 
		 * @param target
		 * <p>描画対象となる Sprite です。</p>
		 * <p></p>
		 * @param color
		 * <p>描画する色です。</p>
		 * <p></p>
		 * @param alpha
		 * <p>描画するアルファです。</p>
		 * <p></p>
		 * @param x
		 * <p>親表示オブジェクトの基準点からの相対的な水平座標を示す数値（ピクセル単位）です。</p>
		 * <p>A number indicating the horizontal position relative to the registration point of the parent display object (in pixels).</p>
		 * @param y
		 * <p>親表示オブジェクトの基準点からの相対的な垂直座標を示す数値（ピクセル単位）です。</p>
		 * <p>A number indicating the vertical position relative to the registration point of the parent display object (in pixels).</p>
		 * @param width
		 * <p>矩形の幅（ピクセル単位）です。</p>
		 * <p>The width of the rectangle (in pixels).</p>
		 * @param height
		 * <p>矩形の高さ（ピクセル単位）です。</p>
		 * <p>The height of the rectangle (in pixels).</p>
		 * @return
		 * <p>target パラメータで渡す Sprite インスタンスです。</p>
		 * <p>The Sprite instance that you pass in the target parameter.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function drawRect( target:Sprite, color:int = -1, alpha:Number = 1.0, x:Number = 0.0, y:Number = 0.0, width:Number = 100.0, height:Number = 100.0 ):Sprite {
			if ( color < 0 ) {
				color = int( 0xFFFFFF * Math.random() );
			}
			
			target.graphics.beginFill( color, alpha );
			target.graphics.drawRect( x, y, width, height );
			target.graphics.endFill();
			
			return target;
		}
		
		/**
		 * <p>角丸矩形を描画します。</p>
		 * <p>Draws a rounded rectangle.</p>
		 * 
		 * @param target
		 * <p>描画対象となる Sprite です。</p>
		 * <p></p>
		 * @param color
		 * <p>描画する色です。</p>
		 * <p></p>
		 * @param alpha
		 * <p>描画するアルファです。</p>
		 * <p></p>
		 * @param x
		 * <p>親表示オブジェクトの基準点からの相対的な水平座標を示す数値（ピクセル単位）です。</p>
		 * <p>A number indicating the horizontal position relative to the registration point of the parent display object (in pixels).</p>
		 * @param y
		 * <p>親表示オブジェクトの基準点からの相対的な垂直座標を示す数値（ピクセル単位）です。</p>
		 * <p>A number indicating the vertical position relative to the registration point of the parent display object (in pixels).</p>
		 * @param width
		 * <p>角丸矩形の幅（ピクセル単位）です。</p>
		 * <p>The width of the round rectangle (in pixels).</p>
		 * @param height
		 * <p>角丸矩形の高さ（ピクセル単位）です。</p>
		 * <p>The height of the round rectangle (in pixels).</p>
		 * @param ellipseWidth
		 * <p>丸角の描画に使用される楕円の幅（ピクセル単位）です。</p>
		 * <p>The width of the ellipse used to draw the rounded corners (in pixels).</p>
		 * @param ellipseHeight
		 * <p>丸角の描画に使用される楕円の高さ（ピクセル単位）。
		 * （オプション）値を指定しない場合は、ellipseWidth パラメータに指定された値がデフォルトで適用されます。</p>
		 * <p>The height of the ellipse used to draw the rounded corners (in pixels).
		 * Optional; if no value is specified, the default value matches that provided for the ellipseWidth parameter.</p>
		 * @return
		 * <p>target パラメータで渡す Sprite インスタンスです。</p>
		 * <p>The Sprite instance that you pass in the target parameter.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function drawRoundRect( target:Sprite, color:int = -1, alpha:Number = 1.0, x:Number = 0.0, y:Number = 0.0, width:Number = 100.0, height:Number = 100.0, ellipseWidth:Number = 20.0, ellipseHeight:Number = NaN ):Sprite {
			if ( color < 0 ) {
				color = int( 0xFFFFFF * Math.random() );
			}
			
			target.graphics.beginFill( color, alpha );
			target.graphics.drawRoundRect( x, y, width, height, ellipseWidth, ellipseHeight );
			target.graphics.endFill();
			
			return target;
		}
		
		/**
		 * <p>角丸矩形を描画します。</p>
		 * <p>Draws a rounded rectangle.</p>
		 * 
		 * @param target
		 * <p>描画対象となる Sprite です。</p>
		 * <p></p>
		 * @param color
		 * <p>描画する色です。</p>
		 * <p></p>
		 * @param alpha
		 * <p>描画するアルファです。</p>
		 * <p></p>
		 * @param x
		 * <p>親表示オブジェクトの基準点からの相対的な水平座標を示す数値（ピクセル単位）です。</p>
		 * <p>A number indicating the horizontal position relative to the registration point of the parent display object (in pixels).</p>
		 * @param y
		 * <p>親表示オブジェクトの基準点からの相対的な垂直座標を示す数値（ピクセル単位）です。</p>
		 * <p>A number indicating the vertical position relative to the registration point of the parent display object (in pixels).</p>
		 * @param width
		 * <p>角丸矩形の幅（ピクセル単位）です。</p>
		 * <p>The width of the round rectangle (in pixels).</p>
		 * @param height
		 * <p>角丸矩形の高さ（ピクセル単位）です。</p>
		 * <p>The height of the round rectangle (in pixels).</p>
		 * @param topLeftRadius
		 * <p>左上の楕円サイズです。</p>
		 * <p></p>
		 * @param topRightRadius
		 * <p>右上の楕円サイズです。</p>
		 * <p></p>
		 * @param bottomLeftRadius
		 * <p>左下の楕円サイズです。</p>
		 * <p></p>
		 * @param bottomRightRadius
		 * <p>右下の楕円サイズです。</p>
		 * <p></p>
		 * @return
		 * <p>target パラメータで渡す Sprite インスタンスです。</p>
		 * <p>The Sprite instance that you pass in the target parameter.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function drawRoundRectComplex( target:Sprite, color:int = -1, alpha:Number = 1.0, x:Number = 0.0, y:Number = 0.0, width:Number = 100.0, height:Number = 100.0, topLeftRadius:Number = 10.0, topRightRadius:Number = 10.0, bottomLeftRadius:Number = 10.0, bottomRightRadius:Number = 10.0 ):Sprite {
			if ( color < 0 ) {
				color = int( 0xFFFFFF * Math.random() );
			}
			
			target.graphics.beginFill( color, alpha );
			target.graphics.drawRoundRectComplex( x, y, width, height, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius );
			target.graphics.endFill();
			
			return target;
		}
	}
}
