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
	 * <p>URLUtil クラスは、URL 操作のためのユーティリティクラスです。</p>
	 * <p>The URLUtil class is an utility class for URL operation.</p>
	 */
	public class URLUtil {
		
		/**
		 * ウィンドウズ上のかどうかを判別する正規表現を取得します。
		 */
		private static const _WINDOWS_LOCAL_REGEXP:String = "^file://([a-z]):\\\\";
		
		/**
		 * 絶対パスかどうかを判別する正規表現を取得します。
		 */
		private static const _ABSOLUTE_PATH_REGEXP:String = "^(http://|https://|file://)";
		
		
		
		
		
		/**
		 * @private
		 */
		public function URLUtil() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>指定された URL を file プロトコルを使用した書式に整形します。</p>
		 * <p></p>
		 * 
		 * @param url
		 * <p>整形したい URL です。</p>
		 * <p></p>
		 * @return
		 * <p>整形後の URL です。</p>
		 * <p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function normalize( url:String ):String {
			if ( new RegExp( _WINDOWS_LOCAL_REGEXP, "gi" ).test( url ) ) {
				url = url.replace( new RegExp( _WINDOWS_LOCAL_REGEXP, "gi" ), "file:///$1:/" );
				url = url.split( "\\" ).join( "/" );
			}
			
			return url;
		}
		
		/**
		 * <p>URL からファイル名を抽出して返します。</p>
		 * <p></p>
		 * 
		 * @param url
		 * <p>ファイル名を抽出したい URL を示すストリングです。</p>
		 * <p></p>
		 * @return
		 * <p>抽出されたストリングです。</p>
		 * <p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getFileName( url:String ):String {
			var fileName:String = normalize( url ).split( "/" ).pop();
			
			if ( !fileName ) { return ""; }
			
			var segments:Array = fileName.split( "." );
			
			return segments.slice( 0, Math.max( 1, segments.length - 1 ) ).join( "." );
		}
		
		/**
		 * <p>URL からファイルの拡張子名を抽出して返します。</p>
		 * <p></p>
		 * 
		 * @param url
		 * <p>ファイルの拡張子名を抽出したい URL を示すストリングです。</p>
		 * <p></p>
		 * @return
		 * <p>抽出されたストリングです。</p>
		 * <p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getExtension( url:String ):String {
			var fileName:String = normalize( url ).split( "/" ).pop();
			
			if ( !fileName ) { return ""; }
			
			var segments:Array = fileName.split( "." );
			
			if ( segments.length < 2 ) { return ""; }
			
			return segments.reverse()[0];
		}
		
		/**
		 * <p>URL からフォルダまでのパスのみを抽出して返します。</p>
		 * <p></p>
		 * 
		 * @param url
		 * <p>パスを抽出したい URL を示すストリングです。</p>
		 * <p></p>
		 * @return
		 * <p>抽出されたストリングです。</p>
		 * <p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getFolderPath( url:String ):String {
			// パスを分解する
			var path:Array = normalize( url ).split( "/" );
			
			// すでにフォルダを指していればそのまま返す
			if ( path[path.length -1] == "" ) { return url; }
			
			return path.slice( 0, -1 ).join( "/" ) + "/";
		}
		
		/**
		 * <p>URL を絶対パスに変換します。</p>
		 * <p></p>
		 * 
		 * @param url
		 * <p>変換したい URL を示すストリングです。</p>
		 * <p></p>
		 * @param baseUrl
		 * <p>基準として使用する URL を示すストリングです。</p>
		 * <p></p>
		 * @return
		 * <p>変換後の URL を示すストリングです。</p>
		 * <p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getAbsolutePath( url:String, baseUrl:String ):String {
			// すでに絶対パスであればそのまま返す
			if ( new RegExp( _ABSOLUTE_PATH_REGEXP, "gi" ).test( url ) ) { return url; }
			return getFolderPath( baseUrl ) + url;
		}
	}
}
