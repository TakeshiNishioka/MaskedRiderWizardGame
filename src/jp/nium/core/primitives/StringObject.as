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
	public class StringObject {
		
		/**
		 * プリミティブな文字列を取得します。
		 */
		private var _str:String;
		
		
		
		
		
		/**
		 * @private
		 */
		public function StringObject( str:String ) {
			// 引数を設定する
			_str = str;
		}
		
		
		
		
		
		/**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @return
		 * <p>オブジェクトのストリング表現です。</p>
		 * <p>A string representation of the object.</p>
		 */
		public function toString():String {
			return _str;
		}
	}
}
