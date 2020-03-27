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
package jp.nium.core.primitives {
	
	/**
	 * @private
	 */
	public class NumberObject {
		
		/**
		 * プリミティブな数値を取得します。
		 */
		private var _num:Number;
		
		
		
		
		
		/**
		 * @private
		 */
		public function NumberObject( num:Number ) {
			// 引数を設定する
			_num = num;
		}
		
		
		
		
		
		/**
		 * <p>指定された Number オブジェクト（ myNumber ）のストリング表現を返します。 Number オブジェクトの値が先行ゼロを持たない小数（.4 など）の場合、Number.toString() は先行ゼロを追加（0.4）します。</p>
		 * <p>Returns the string representation of the specified Number object (myNumber). If the value of the Number object is a decimal number without a leading zero (such as .4), Number.toString() adds a leading zero (0.4).</p>
		 * 
		 * @param radix
		 * <p>数値からストリングへの変換に使用する基数（2 ～ 36）を指定します。radix パラメータを指定しない場合、デフォルト値は 10 です。</p>
		 * <p>Specifies the numeric base (from 2 to 36) to use for the number-to-string conversion. If you do not specify the radix parameter, the default value is 10.</p>
		 * @return
		 * <p>Number オブジェクトの数値表現のストリングです。</p>
		 * <p>The numeric representation of the Number object as a string.</p>
		 */
		public function toString( radix:Number = 10.0 ):String {
			return _num.toString( radix );
		}
		
		/**
		 * <p>指定された Number オブジェクトのプリミティブな値のタイプを返します。</p>
		 * <p>Returns the primitive value type of the specified Number object.</p>
		 * 
		 * @return
		 * <p>Number オブジェクトのプリミティブな型の値です。</p>
		 * <p>The primitive type value of the Number object.</p>
		 */
		public function valueOf():Number {
			return _num;
		}
	}
}
