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
	 * <p>Version クラスは、バージョン情報を保持し、バージョンの比較などを行うためのモデルクラスです。</p>
	 * <p>Version class is a model class to store the version information and compare the version.</p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class Version {
		
		/**
		 * バージョン情報のフォーマットを判別する正規表現を取得します。
		 */
		private static const _FORMAT_REGEXP:String = "^([0-9]+)(\.[0-9]+)?(\.[0-9]+)?( .*$)?";
		
		/**
		 * バージョン情報を切り分ける正規表現を取得します。
		 */
		private static const _SPLIT_REGEXP:String = "^([0-9]+)([^0-9]([0-9]*))?([^0-9]([0-9]*))?.*$";
		
		
		
		
		
		/**
		 * <p>メジャーバージョンを取得します。</p>
		 * <p>Get the major version.</p>
		 */
		public function get majorVersion():int { return _majorVersion; }
		private var _majorVersion:int = 0;
		
		/**
		 * <p>マイナーバージョンを取得します。</p>
		 * <p>Get the minor version.</p>
		 */
		public function get minorVersion():int { return _minorVersion; }
		private var _minorVersion:int = 0;
		
		/**
		 * <p>ビルドバージョンを取得します。</p>
		 * <p>Get the build version.</p>
		 */
		public function get buildVersion():int { return _buildVersion; }
		private var _buildVersion:int = 0;
		
		/**
		 * <p>リリース情報を取得します。</p>
		 * <p>Get the release information.</p>
		 */
		public function get release():String { return _release; }
		private var _release:String;
		
		
		
		
		
		/**
		 * <p>新しい Version インスタンスを作成します。</p>
		 * <p>Creates a new Version object.</p>
		 * 
		 * @param majorVersionOrVersionValue
		 * <p>メジャーバージョン、またはバージョンを表すストリング値です。</p>
		 * <p>The major version or the string value to express the version.</p>
		 * @param minorVersion
		 * <p>マイナーバージョンです。</p>
		 * <p>The minor version.</p>
		 * @param buildVersion
		 * <p>ビルドバージョンです。</p>
		 * <p>The build version.</p>
		 * @param release
		 * <p>リリース情報です。</p>
		 * <p>The release information.</p>
		 */
		public function Version( majorVersionOrVersionValue:*, minorVersion:int = 0, buildVersion:int = 0, release:String = null ) {
			switch ( true ) {
				case majorVersionOrVersionValue is String	: {
					// フォーマットを確認する
					if ( !new RegExp( _FORMAT_REGEXP ).test( majorVersionOrVersionValue ) ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_005 ).toString( "version" ) ); }
					
					// 引数を設定する
					var items:Array = String( majorVersionOrVersionValue ).split( " " );
					
					var versions:Array = new RegExp( _SPLIT_REGEXP ).exec( items.shift() );
					if ( !versions ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_005 ).toString( "version" ) ); }
					
					_majorVersion = parseInt( versions[1] );
					_minorVersion = parseInt( versions[3] );
					_buildVersion = parseInt( versions[5] );
					
					_release = String( items.join( " " ) );
					break;
				}
				case majorVersionOrVersionValue is Number	: {
					// 引数を設定する
					_majorVersion = Math.floor( majorVersionOrVersionValue );
					_minorVersion = minorVersion;
					_buildVersion = buildVersion;
					_release = release || "";
					break;
				}
				default										: { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_005 ).toString( "version" ) ); }
			}
		}
		
		
		
		
		
		/**
		 * <p>対象の Version インスタンスを比較した結果を返します。
		 * この比較結果にリリース情報の値は影響しません。</p>
		 * <p>Returns the result of comparison of the Version instance.
		 * The result of comparison do not affect to the value of release information.</p>
		 * 
		 * @param version
		 * <p>比較したい Version インスタンスです。</p>
		 * <p>The Version instance to compare.</p>
		 * @return
		 * <p>自身のバージョンが高ければ 1 以上の数値を、バージョンが同じであれば 0 を、バージョンが低ければ -1 以下の数値です。</p>
		 * <p></p>
		 */
		public function compare( version:Version ):int {
			// メジャーバージョンが高ければ 3 を返す
			if ( _majorVersion > version._majorVersion ) { return 3; }
			
			// メジャーバージョンが低ければ -3 を返す
			if ( _majorVersion < version._majorVersion ) { return -3; }
			
			// マイナーバージョンが高ければ 2 を返す
			if ( _minorVersion > version._minorVersion ) { return 2; }
			
			// マイナーバージョンが低ければ -2 を返す
			if ( _minorVersion < version._minorVersion ) { return -2; }
			
			// ビルドバージョンが高ければ 1 を返す
			if ( _buildVersion > version._buildVersion ) { return 1; }
			
			// ビルドバージョンが低ければ -1 を返す
			if ( _buildVersion < version._buildVersion ) { return -1; }
			
			return 0;
		}
		
		/**
		 * <p>2 つのバージョンをリリース情報も含めて完全に一致するかどうかを比較した結果を返します。</p>
		 * <p>Returns the value above 1 if the own version is higher, returns 0 if the version is same and return the value below -1 if the own version is lower.</p>
		 * 
		 * @param version
		 * <p>比較したい Version インスタンスです。</p>
		 * <p>The Version instance to compare.</p>
		 * @return
		 * <p>完全に一致する場合には true を、一致しない場合には false です。</p>
		 * <p>Returns true if completly same, otherwise return false.</p>
		 */
		public function equals( version:Version ):Boolean {
			return ( toString() == version.toString() );
		}
		
		/**
		 * <p>Version インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Version subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい Version インスタンスです。</p>
		 * <p>A new Version object that is identical to the original.</p>
		 */
		public function clone():Version {
			return new Version( _majorVersion, _minorVersion, _buildVersion, _release );
		}
		
		/**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @param format
		 * <p>取得したいバージョンストリングを構成するフォーマットです。</p>
		 * <p></p>
		 * @return
		 * <p>オブジェクトのストリング表現です。</p>
		 * <p>A string representation of the object.</p>
		 */
		public function toString( format:String = null ):String {
			format ||= "M.m.b r";
			
			format = format.replace( new RegExp( "M", "g" ), _majorVersion );
			format = format.replace( new RegExp( "m", "g" ), _minorVersion );
			format = format.replace( new RegExp( "b", "g" ), _buildVersion );
			format = format.replace( new RegExp( "r", "g" ), _release );
			
			return format;
		}
	}
}
