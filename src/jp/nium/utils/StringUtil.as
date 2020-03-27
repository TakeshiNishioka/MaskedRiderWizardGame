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
	 * <p>StringUtil クラスは、文字列操作のためのユーティリティクラスです。</p>
	 * <p>The StringUtil class is an utility class for string operation.</p>
	 */
	public class StringUtil {
		
		/**
		 * 改行コードを判別する正規表現を取得します。
		 */
		private static const _COLLECTBREAK_REGEXP:String = "(\r\n|\r|\n)";
		
		
		
		
		
		/**
		 * @private
		 */
		public function StringUtil() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>指定されたストリングを適切な型のオブジェクトに変換して返します。</p>
		 * <p>Convert the specified string to the proper object type and returns.</p>
		 * 
		 * @param str
		 * <p>変換したいストリングです。</p>
		 * <p>The string to convert.</p>
		 * @param priority
		 * <p>数値化を優先するかどうかです。</p>
		 * <p>Whether it gives priority to expressing numerically or not?</p>
		 * @return
		 * <p>変換後のオブジェクトです。</p>
		 * <p>The converted object.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function toProperType( str:String, priority:Boolean = false ):* {
			// Number 型に変換する
			var num:Number = parseFloat( str );
			
			// モードが true なら
			if ( priority ) {
				// 数値化を優先する
				if ( !isNaN( num ) ) { return num; }
			}
			else {
				// 元データの維持を優先する
				if ( num.toString() == str ) { return num; }
			}
			
			// グローバル定数、プライマリ式キーワードで返す
			switch ( str ) {
				case "true"			: { return true; }
				case "false"		: { return false; }
				case ""				:
				case "null"			: { return null; }
				case "undefined"	: { return undefined; }
				case "Infinity"		: { return Infinity; }
				case "-Infinity"	: { return -Infinity; }
				case "NaN"			: { return NaN; }
			}
			
			return str;
		}
		
		/**
		 * <p>指定された文字列を指定された数だけリピートさせた文字列を返します。</p>
		 * <p>Returns the string which repeats the specified string with specified times.</p>
		 * 
		 * @param str
		 * <p>リピートしたい文字列です。</p>
		 * <p>The string to repeat.</p>
		 * @param count
		 * <p>リピート回数です。</p>
		 * <p>Repeat time.</p>
		 * @return
		 * <p>リピートされた文字列です。</p>
		 * <p>Repeated string.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function repeat( str:String, count:int = 0 ):String {
			var result:String = "";
			for ( var i:int = 0, l:int = count; i < l; i++ ) {
				result += str;
			}
			return result;
		}
		
		/**
		 * <p>String の最初の文字を大文字にし、以降の文字を小文字に変換して返します。</p>
		 * <p>Convert the first character to upper case and remain character to lower case of the specified string.</p>
		 * 
		 * @param str
		 * <p>変換したい文字列です。</p>
		 * <p>The string to convert.</p>
		 * @return
		 * <p>変換後の文字列です。</p>
		 * <p>The converted string.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function toUpperCaseFirstLetter( str:String ):String {
			return str.charAt( 0 ).toUpperCase() + str.slice( 1 ).toLowerCase();
		}
		
		/**
		 * <p>改行コードを変換して返します。</p>
		 * <p>Convert the line feed code of the specified string and returns.</p>
		 * 
		 * @param str
		 * <p>変換したい文字列です。</p>
		 * <p>The string to convert.</p>
		 * @param newLine
		 * <p>変換後の改行コードです。</p>
		 * <p>The line feed code to convert to.</p>
		 * @return
		 * <p>変換後の文字列です。</p>
		 * <p>The converted string.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function collectBreak( str:String, newLine:String = null ):String {
			return str.replace( new RegExp( _COLLECTBREAK_REGEXP, "g" ), newLine || "\\n" );
		}
	}
}
