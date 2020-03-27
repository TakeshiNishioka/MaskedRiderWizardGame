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
	 * <p>NumberUtil クラスは、数値操作のためのユーティリティクラスです。</p>
	 * <p>The NumberUtil class is an utility class for numeric operation.</p>
	 */
	public class NumberUtil {
		
		/**
		 * @private
		 */
		public function NumberUtil() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>数値を 1000 桁ごとにカンマをつけて返します。</p>
		 * <p>Returns the numerical value applying the comma every 1000 digits.</p>
		 * 
		 * @param number
		 * <p>変換したい数値です。</p>
		 * <p>The numerical value to convert.</p>
		 * @param radix
		 * <p>数値からストリングへの変換に使用する基数（2 ～ 36）を指定します。</p>
		 * <p>Specifies the numeric base (from 2 to 36) to use for the number-to-string conversion.</p>
		 * @return
		 * <p>変換後の数値です。</p>
		 * <p>The converted numerical value.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function format( number:Number, radix:Number = 10 ):String {
			var words:Array = number.toString( radix ).split( "" ).reverse();
			for ( var i:int = 3, l:int = words.length; i < l; i += 3 ) {
				if ( words[i] ) {
					words.splice( i, 0, "," );
					i++;
					l++;
				}
			}
			return words.reverse().join( "" );
		}
		
		/**
		 * <p>数値の桁数を 0 で揃えて返します。</p>
		 * <p>Arrange the digit of numerical value by 0.</p>
		 * 
		 * @param number
		 * <p>変換したい数値です。</p>
		 * <p>The numerical value to convert.</p>
		 * @param figure
		 * <p>揃えたい桁数です。</p>
		 * <p>The number of digit to arrange.</p>
		 * @param radix
		 * <p>数値からストリングへの変換に使用する基数（2 ～ 36）を指定します。</p>
		 * <p>Specifies the numeric base (from 2 to 36) to use for the number-to-string conversion.</p>
		 * @return
		 * <p>変換後の数値です。</p>
		 * <p>The converted numerical value.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function digit( number:Number, figure:int, radix:Number = 10 ):String {
			var str:String = number.toString( radix );
			
			for ( var i:int = 0; i < figure; i++ ) {
				str = "0" + str;
			}
			
			return str.substr( str.length - figure, str.length );
		}
	}
}
