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
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	
	/**
	 * <p>MathUtil クラスは、算術演算のためのユーティリティクラスです。</p>
	 * <p>The MathUtil class is an utility class for arithmetic operation.</p>
	 */
	public class MathUtil {
		
		/**
		 * @private
		 */
		public function MathUtil() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>数値を指定された周期内に収めて返します。</p>
		 * <p>Returns the value of number put in the specified cycle.</p>
		 * 
		 * @param number
		 * <p>周期内に収めたい数値です。</p>
		 * <p>The value which want to put in the cycle.</p>
		 * @param cycle
		 * <p>周期となる数値です。</p>
		 * <p>The cycle value.</p>
		 * @return
		 * <p>変換後の数値です。</p>
		 * <p>The translated value.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function cycle( number:Number, cycle:Number ):Number {
			return ( number % cycle + cycle ) % cycle;
		}
		
		/**
		 * <p>範囲内に適合する値を返します。</p>
		 * <p>Returns the value suited within the range.</p>
		 * 
		 * @param number
		 * <p>範囲内に適合させたい数値です。</p>
		 * <p>The number which wanted to suit within the range.</p>
		 * @param min
		 * <p>範囲の最小値となる数値です。</p>
		 * <p>The mininum value of the range.</p>
		 * @param max
		 * <p>範囲の最大値となる数値です。</p>
		 * <p>The maximum value of the range.</p>
		 * @return
		 * <p>変換後の数値です。</p>
		 * <p>The translated value.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function range( number:Number, min:Number, max:Number ):Number {
			// min の方が max よりも大きい場合に入れ替える
			if ( min > max ) {
				var tmp:Number = min;
				min = max;
				max = tmp;
			}
			
			return Math.max( min, Math.min( number, max ) );
		}
		
		/**
		 * <p>分母が 0 の場合に 0 となるパーセント値を返します。</p>
		 * <p>Returns the percent value (return 0 if the denominator is 0).</p>
		 * 
		 * @param numerator
		 * <p>分子となる数値です。</p>
		 * <p>The numerator value.</p>
		 * @param denominator
		 * <p>分母となる数値です。</p>
		 * <p>The denominator value.</p>
		 * @return
		 * <p>変換後の数値です。</p>
		 * <p>The translated value.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function percent( numerator:Number, denominator:Number ):Number {
			if ( denominator == 0) { return 0; }
			return numerator / denominator * 100;
		}
		
		/**
		 * <p>数値が偶数かどうかを返します。</p>
		 * <p>Returns if the value is even number.</p>
		 * 
		 * @param number
		 * <p>テストしたい数値です。</p>
		 * <p>The number to test.</p>
		 * @return
		 * <p>偶数であれば true を、奇数であれば false を返します。</p>
		 * <p>Returns true if the value is even number, otherwise return false.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function even( number:Number ):Boolean {
			var h:Number = number / 2;
			return h == Math.ceil( h );
		}
	}
}
