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
package jp.nium.core.I18N {
	import flash.system.Capabilities;
	import flash.utils.Dictionary;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	
	/**
	 * @private
	 */
	public class Locale {
		
		/**
		 * <p>日本語を示すストリングを取得します。</p>
		 * <p></p>
		 */
		public static const JAPANESE:String = "ja";
		
		/**
		 * <p>英語を示すストリングを取得します。</p>
		 * <p></p>
		 */
		public static const ENGLISH:String = "en";
		
		/**
		 * <p>フランス語を示すストリングを取得します。</p>
		 * <p></p>
		 */
		public static const FRENCH:String = "fr";
		
		/**
		 * <p>中国語を示すストリングを取得します。</p>
		 * <p></p>
		 */
		public static const CHINESE:String = "zh-CN";
		
		
		
		
		
		/**
		 * <p>現在設定されている言語を取得または設定します。
		 * デフォルト設定は、Flash Player が実行されているシステムの言語コードになります。</p>
		 * <p>Get or set the current language.
		 * The default setting will be same as System language code which executing the Flash Player.</p>
		 */
		public static function get language():String { return _language; }
		public static function set language( value:String ):void {
			switch ( value ) {
				case JAPANESE	:
				case ENGLISH	:
				case FRENCH		:
				case CHINESE	: { _language = value; break; }
				default			: { _language = ENGLISH; }
			}
		}
		private static var _language:String = ENGLISH;
		
		/**
		 * <p>指定された言語に対応したストリングが存在しなかった場合に、代替言語として使用される言語を取得します。</p>
		 * <p></p>
		 */
		public static function get defaultLanguage():String { return _defaultLanguage; }
		private static var _defaultLanguage:String = ENGLISH;
		
		/**
		 * ローカライズ用の文字列を保持した Dictionary インスタンスを取得します。
		 */
		private static var _messages:Dictionary = new Dictionary();
		
		
		
		
		
		/**
		 * 初期化する
		 */
		( function():void {
			// 初期言語を設定する
			language = Capabilities.language;
		} )();
		
		
		
		
		
		/**
		 * @private
		 */
		public function Locale() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>指定した id に関連付けられたストリングを現在設定されている言語表現で返します。</p>
		 * <p>Returns the string which relate to the specified id by the current language expression.</p>
		 * 
		 * @param id
		 * <p>ストリングに関連付けられた識別子です。</p>
		 * <p>The identifier relates to the string.</p>
		 * @return
		 * <p>関連付けられたストリングです。</p>
		 * <p>Related string.</p>
		 */
		public static function getString( id:String ):String {
			return getStringByLang( id, _language );
		}
		
		/**
		 * <p>指定した id と言語に関連付けられたストリングを返します。</p>
		 * <p>Returns the string which relates to the specified id and language.</p>
		 * 
		 * @param id
		 * <p>ストリングに関連付けられた識別子です。</p>
		 * <p>The identifier relates to the string.</p>
		 * @param language
		 * <p>ストリングに関連付けられた言語です。</p>
		 * <p>The language relates to the string.</p>
		 * @return
		 * <p>関連付けられたストリングです。</p>
		 * <p>Related string.</p>
		 */
		public static function getStringByLang( id:String, language:String ):String {
			return ( _messages[language] || _messages[_defaultLanguage] || {} )[id];
		}
		
		/**
		 * <p>ストリングを指定した id と言語に関連付けます。</p>
		 * <p>Relate the specified string to the language.</p>
		 * 
		 * @param id
		 * <p>ストリングに関連付ける識別子です。</p>
		 * <p>The identifier relates to the string.</p>
		 * @param language
		 * <p>ストリングに関連付ける言語です。</p>
		 * <p>The language relates to the string.</p>
		 * @param value
		 * <p>関連付けるストリングです。</p>
		 * <p>Related string.</p>
		 */
		public static function setString( id:String, language:String, value:String ):void {
			// 初期化されていなければ初期化する
			_messages[language] ||= new Dictionary();
			
			// 設定する
			_messages[language][id] = value;
		}
	}
}
