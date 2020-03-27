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
package jp.nium.core.debug {
	
	/**
	 * @private
	 */
	public class Log {
		
		/**
		 * <p>インスタンスを表すユニークな識別子を取得します。</p>
		 * <p></p>
		 */
		public function get id():String { return _id; }
		private var _id:String;
		
		/**
		 * <p>ログ内容を取得します。</p>
		 * <p></p>
		 */
		public function get message():String { return _message; }
		private var _message:String;
		
		
		
		
		/**
		 * <p>新しい Log インスタンスを作成します。</p>
		 * <p>Creates a new Log object.</p>
		 * 
		 * @param id
		 * <p>ログの識別子です。</p>
		 * <p></p>
		 * @param message
		 * <p>ログ内容です。</p>
		 * <p></p>
		 */
		public function Log( id:String, message:String ) {
			// 引数を設定する
			_id = id;
			_message = message;
		}
		
		
		
		
		
		/**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @param replaces
		 * <p>特定のコードを置換する文字列です。</p>
		 * <p>The string to replace the perticular code.</p>
		 * @return
		 * <p>オブジェクトのストリング表現です。</p>
		 * <p>A string representation of the object.</p>
		 */
		public function toString( ... replaces:Array ):String {
			var message:String = _message;
			
			// 特定のコードを置換する
			for ( var i:int = 0, l:int = replaces.length; i < l; i++ ) {
				message = message.replace( new RegExp( "%" + i, "g" ), replaces[i] );
			}
			
			return message;
		}
	}
}
