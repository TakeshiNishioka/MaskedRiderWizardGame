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
package jp.nium.external {
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;
	import flash.system.Security;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.StringUtil;
	
	/**
	 * <p>JavaScript クラスは、SWF ファイルを再生中のブラウザと、JavaScript を使用して通信を行うクラスです。</p>
	 * <p>The JavaScript class communicates with the browser which are playing the SWF file, using JavaScript.</p>
	 */
	public class JavaScript {
		
		/**
		 * <p>再生中のブラウザと JavaScript 通信が可能かどうかを取得します。</p>
		 * <p>Returns if it is able to communicate with Browser via JavaScript.</p>
		 */
		public static function get enabled():Boolean { return _enabled; }
		private static var _enabled:Boolean = false;
		
		/**
		 * <p>SWF ファイルを再生中のブラウザのコード名を取得します。</p>
		 * <p>Returns the code name of the browser which playing the SWF file.</p>
		 */
		public static function get appCodeName():String { return _appCodeName; }
		private static var _appCodeName:String;
		
		/**
		 * <p>SWF ファイルを再生中のブラウザからアプリケーション名を取得します。</p>
		 * <p>Get the application name from the browser which playing the SWF file.</p>
		 */
		public static function get appName():String { return _appName; }
		private static var _appName:String;
		
		/**
		 * <p>SWF ファイルを再生中のブラウザからバージョンと機種名を取得します。</p>
		 * <p>Get the version and machine name from the browser which playing the SWF file.</p>
		 */
		public static function get appVersion():String { return _appVersion; }
		private static var _appVersion:String;
		
		/**
		 * <p>SWF ファイルを再生中のブラウザからプラットフォーム名を取得します。</p>
		 * <p>Get the platform name from the browser which playing the SWF file.</p>
		 */
		public static function get platform():String { return _platform; }
		private static var _platform:String;
		
		/**
		 * <p>SWF ファイルを再生中のブラウザからエージェント名を取得します。</p>
		 * <p>Get the agent name from the browser which playing the SWF file.</p>
		 */
		public static function get userAgent():String { return _userAgent; }
		private static var _userAgent:String;
		
		/**
		 * <p>SWF ファイルを再生中のブラウザのタイトルを取得または設定します。</p>
		 * <p></p>
		 */
		public static function get documentTitle():String { return call( 'function() { return document.title; }' ) || ""; }
		public static function set documentTitle( value:String ):void {
			if ( _enabled ) {
				call( 'function( value ) { document.title = value; }', value );
			}
			else {
				Logger.info( "Browser.title" );
			}
		}
		
		/**
		 * <p>SWF ファイルを再生中のブラウザから URL を取得または設定します。</p>
		 * <p></p>
		 */
		public static function get locationHref():String { return call( 'function() { return window.location.href; }' ) || ""; }
		public static function set locationHref( value:String ):void {
			if ( _enabled ) {
				call( 'function( value ) { window.location.href = value; }', value );
			}
			else {
				Logger.info( "Browser.locationHref" );
			}
		}
		
		
		
		
		
		/**
		 * 初期化する
		 */
		( function():void {
			// プレイヤー種別が対応していなければ終了する
			switch ( Capabilities.playerType ) {
				case "ActiveX"		:
				case "PlugIn"		: { break; }
				case "Desktop"		:
				case "External"		:
				case "StandAlone"	: { return; }
			}
			
			// セキュリティサンドボックスが対応していなければ終了する
			switch ( Security.sandboxType ) {
				case Security.REMOTE				:
				case Security.LOCAL_TRUSTED			: { break; }
				case Security.LOCAL_WITH_FILE		:
				case Security.LOCAL_WITH_NETWORK	: { return; }
			}
			
			// ExternalInterface が有効でなければ終了する
			if ( !ExternalInterface.available ) { return; }
			if ( !ExternalInterface.objectID ) { return; }
			
			// 実際にスクリプトが実行できなければ終了する
			try {
				if ( ExternalInterface.call( 'function() { return "enabled"; }' ) != "enabled" ) { return; }
			}
			catch ( e:Error ) { return; }
			
			// 有効化する
			_enabled = true;
			
			// ブラウザ情報を取得する
			_appCodeName = call( 'function() { return navigator.appCodeName; }' );
			_appName = call( 'function() { return navigator.appName; }' );
			_appVersion = call( 'function() { return navigator.appVersion; }' );
			_platform = call( 'function() { return navigator.platform; }' );
			_userAgent = call( 'function() { return navigator.userAgent; }' );
		} )();
		
		
		
		
		
		/**
		 * @private
		 */
		public function JavaScript() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>Flash Player コンテナで公開されている関数を呼び出し、必要に応じてパラメータを渡します。</p>
		 * <p>Call the function which the Flash Player container opens and pass the parameter if needed.</p>
		 * 
		 * @param funcName
		 * <p>実行したい関数名です。</p>
		 * <p>The name of the function to execute.</p>
		 * @param args
		 * <p>引数に指定したい配列です。</p>
		 * <p>The array to specify as argument.</p>
		 * @return
		 * <p>関数の戻り値を返します。</p>
		 * <p>The return value of the function.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function call( funcName:String, ... args:Array ):* {
			args.unshift( funcName );
			return _enabled ? StringUtil.toProperType( ExternalInterface.call.apply( null, args ) ) : null;
		}
		
		/**
		 * <p>ActionScript メソッドをコンテナから呼び出し可能なものとして登録します。</p>
		 * <p>Register the ActionScript method as callable from the container.</p>
		 * 
		 * @param funcName
		 * <p>コンテナが関数を呼び出すことができる名前です。</p>
		 * <p>The name that the container can function call.</p>
		 * @param closure
		 * <p>呼び出す関数閉包です。これは独立した関数にすることも、オブジェクトインスタンスのメソッドを参照するメソッド閉包とすることもできます。メソッド閉包を渡すことで、特定のオブジェクトインスタンスのメソッドでコールバックを実際にダイレクトできます。</p>
		 * <p>The function closure to call. This can be an independent function or method closure which refer the method of the object instance. By passing the method closure, it is actually able to direct the callback by method of the perticular object instance.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function addCallback( funcName:String, closure:Function ):void {
			if ( !enabled ) { return; }
			ExternalInterface.addCallback( funcName, closure );
		}
		
		/**
		 * <p>JavaScript を使用したアラートを表示します。</p>
		 * <p>Displays the alert using JavaScript.</p>
		 * 
		 * @param messages
		 * <p>出力したいストリングです。</p>
		 * <p>The strings to display.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function alert( ... messages:Array ):void {
			var message:String = messages.join( " " );
			
			if ( _enabled ) {
				call( 'function() { alert( "' + message + '" ); }' );
			}
			else {
				Logger.info( "Browser.alert(", message, ")" );
			}
		}
		
		/**
		 * <p>JavaScript を使用した問い合わせダイアログを表示します。</p>
		 * <p>Displays the inquiry dialog using JavaScript.</p>
		 * 
		 * @param messages
		 * <p>出力したいストリングです。</p>
		 * <p>The strings to display.</p>
		 * @return
		 * <p>ユーザーが [OK] をクリックしたときは true、[キャンセル] をクリックしたときは false を返します。</p>
		 * <p>Returns true when the user clicked "OK" and false when clicked "Cancel".</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function confirm( ... messages:Array ):Boolean {
			var message:String = messages.join( " " );
			
			if ( _enabled ) {
				return !!StringUtil.toProperType( call( 'function() { alert( "' + message + '" ); }' ) );
			}
			else {
				Logger.info( "Browser.confirm(", message, ")" );
			}
			
			return false;
		}
		
		/**
		 * <p>ブラウザを再読み込みします。</p>
		 * <p>Reload the browser.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function reload():void {
			if ( _enabled ) {
				call( 'function() { window.location.reload(); }' );
			}
			else {
				Logger.info( "Browser.reload()" );
			}
		}
		
		/**
		 * <p>ブラウザの印刷ダイアログを表示します。</p>
		 * <p>Displays the print dialog of the browser.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function print():void {
			if ( _enabled ) {
				call( 'function() { window.print(); }' );
			}
			else {
				Logger.info( "Browser.print()" );
			}
		}
	}
}
