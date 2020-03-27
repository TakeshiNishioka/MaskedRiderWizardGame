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
	import adobe.utils.MMExecute;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ArrayUtil;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.StringUtil;
	
	/**
	 * <p>JSFL クラスは、SWF ファイルを再生中の Flash オーサリングツールと、JSFL を使用して通信を行うクラスです。</p>
	 * <p>The JSFL class communicates with the Flash authoring tool which are playing the SWF file, using JSFL.</p>
	 */
	public class JSFL {
		
		/**
		 * <p>Flash オーサリングツールとの JSFL 通信が可能かどうかを取得します。</p>
		 * <p>Returns if it is able to communicate with Flash authoring tool via JSFL.</p>
		 */
		public static function get enabled():Boolean { return _enabled; }
		private static var _enabled:Boolean = false;
		
		/**
		 * <p>Flash オーサリングツールが実行されている OS 情報を取得します。</p>
		 * <p></p>
		 */
		public static function get platform():String { return _platform; }
		private static var _platform:String;
		
		/**
		 * <p>Flash オーサリングツールが実行されている環境の言語情報を取得します。</p>
		 * <p></p>
		 */
		public static function get language():String { return _platform; }
		private static var _language:String;
		
		/**
		 * <p>Flash オーサリングツールのメジャーバージョンを取得します。</p>
		 * <p></p>
		 */
		public static function get majorVersion():int { return _majorVersion; }
		private static var _majorVersion:int;
		
		/**
		 * <p>Flash オーサリングツールのマイナーバージョンを取得します。</p>
		 * <p></p>
		 */
		public static function get minorVersion():int { return _minorVersion; }
		private static var _minorVersion:int;
		
		/**
		 * <p>Flash オーサリングツールのリビジョンバージョンを取得します。</p>
		 * <p></p>
		 */
		public static function get revisionVersion():int { return _revisionVersion; }
		private static var _revisionVersion:int;
		
		/**
		 * <p>Flash オーサリングツールのビルドバージョンを取得します。</p>
		 * <p></p>
		 */
		public static function get buildVersion():int { return _buildVersion; }
		private static var _buildVersion:int;
		
		/**
		 * <p>ローカルユーザーの "Configuration" ディレクトリを file:/// URI として表す完全パスを指定するストリングを取得します。</p>
		 * <p>a string that specifies the full path for the local user's Configuration directory as a file:/// URI.</p>
		 */
		public static function get configURI():String { return _configURI; }
		private static var _configURI:String;
		
		
		
		
		
		/**
		 * 初期化する
		 */
		( function():void {
			try {
				_configURI = MMExecute( '( function() { return fl.configURI; } )()' ) || null;
			}
			catch ( e:Error ) {}
			
			// MMExecute の引数が存在しなければ終了する
			if ( !_configURI ) { return; }
			
			// 有効化する
			_enabled = true;
			
			// Flash オーサリングツールの情報を取得する
			var flversion:String = MMExecute( '( function() { return fl.version; } )()' );
			
			var flversions:Array = flversion.split( " " );
			_platform = flversions[0];
			
			var versions:Array = String( flversions[1] ).split( "," );
			_majorVersion = parseInt( versions[0] );
			_minorVersion = parseInt( versions[1] );
			_buildVersion = parseInt( versions[2] );
			_revisionVersion = parseInt( versions[3] );
			
			_language = _configURI.split( "/" ).slice( -3, -2 ).join( "/" );
		} )();
		
		
		
		
		
		/**
		 * @private
		 */
		public function JSFL() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>Flash JavaScript アプリケーションプログラミングインターフェイスを経由して、関数を実行します。</p>
		 * <p>Execute function via Flash JavaScript Application Programming Interface.</p>
		 * 
		 * @param funcName
		 * <p>実行したい関数名です。</p>
		 * <p>The name of the function to execute.</p>
		 * @param args
		 * <p>funcName に渡すパラメータです。</p>
		 * <p>The parameter to pass to funcName.</p>
		 * @return
		 * <p>funcName を指定した場合に、関数の結果をストリングで返します。</p>
		 * <p>Return the result of the function as string if funcName specified.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function call( funcName:String, ... args:Array ):* {
			// 無効化されていれば終了する例外をスローする
			if ( !_enabled ) { return; }
			
			// 引数を String に変換する
			var argString:String = ArrayUtil.toString( args );
			argString = StringUtil.collectBreak( argString, "\\n" );
			
			// 実行する
			return StringUtil.toProperType( MMExecute( "( function() { return eval( decodeURI( \"( " + encodeURI( funcName ) + " ).apply( null, " + encodeURI( argString ) + " );\" ) ); } )()" ) );
		}
		
		/**
		 * <p>JavaScript ファイルを実行します。関数をパラメータの 1 つとして指定している場合は、その関数が実行されます。また関数内にないスクリプトのコードも実行されます。スクリプト内の他のコードは、関数の実行前に実行されます。</p>
		 * <p>executes a JavaScript file. If a function is specified as one of the arguments, it runs the function and also any code in the script that is not within the function. The rest of the code in the script runs before the function is run.</p>
		 * 
		 * @param fileURL
		 * <p>実行するスクリプトファイルの名前を指定した file:/// URI で表されるストリングです。</p>
		 * <p>string, expressed as a file:/// URI, that specifies the name of the script file to execute.</p>
		 * @param funcName
		 * <p>fileURI で指定した JSFL ファイルで実行する関数を識別するストリングです。</p>
		 * <p>A string that identifies a function to execute in the JSFL file that is specified in fileURI. This parameter is optional.</p>
		 * @param args
		 * <p>funcName に渡す省略可能なパラメータです。</p>
		 * <p>optional parameter that specifies one or more arguments to be passed to funcname.</p>
		 * @return
		 * <p>funcName を指定すると、関数の結果をストリングで返します。指定しない場合は、何も返されません。</p>
		 * <p>The function's result as a string, if funcName is specified; otherwise, nothing.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function runScript( fileURL:String, funcName:String = null, ... args:Array ):* {
			return call.apply( null, [ "fl.runScript", fileURL, funcName || "" ].concat( args ) );
		}
		
		
		/**
		 * <p>テキストストリングを [出力] パネルに送ります。</p>
		 * <p>Sends a text string to the Output panel.</p>
		 * 
		 * @param messages
		 * <p>[出力] パネルに表示するストリングです。</p>
		 * <p>string that appears in the Output panel.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function fltrace( ... messages:Array ):void {
			var message:String = StringUtil.collectBreak( messages.join( " " ), "\\n" );
			
			if ( _enabled ) {
				call( "fl.trace", message );
			}
			else {
				Logger.info( "JSFL.fltrace(", message, ")" );
			}
		}
		
		/**
		 * <p>モーダル警告ダイアログボックスに、ストリングおよび [OK] ボタンを表示します。</p>
		 * <p>displays a string in a modal Alert dialog box, along with an OK button.</p>
		 * 
		 * @param messages
		 * <p>警告ダイアログボックスに表示するメッセージを指定するストリングです。</p>
		 * <p>A string that specifies the message you want to display in the Alert dialog box.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function alert( ... messages:Array ):void {
			var message:String = StringUtil.collectBreak( messages.join( " " ), "\\n" );
			
			if ( _enabled ) {
				call( "alert", message );
			}
			else {
				Logger.info( "JSFL.alert(", message, ")" );
			}
		}
		
		/**
		 * <p>モーダル警告ダイアログボックスに、ストリングおよび [OK] ボタンと [キャンセル] ボタンを表示します。</p>
		 * <p>displays a string in a modal Alert dialog box, along with OK and Cancel buttons.</p>
		 * 
		 * @param messages
		 * <p>警告ダイアログボックスに表示するメッセージを指定するストリングです。</p>
		 * <p>A string that specifies the message you want to display in the Alert dialog box.</p>
		 * @return
		 * <p>ユーザーが [OK] をクリックしたときは true、[キャンセル] をクリックしたときは false を返します。</p>
		 * <p>true if the user clicks OK; false if the user clicks Cancel.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function confirm( ... messages:Array ):Boolean {
			var message:String = StringUtil.collectBreak( messages.join( " " ), "\\n" );
			
			if ( _enabled ) {
				return !!StringUtil.toProperType( call( "confirm", message ) );
			}
			else {
				Logger.info( "JSFL.confirm(", message, ")" );
			}
			
			return false;
		}
		
		/**
		 * <p>モーダル警告ダイアログボックスに、プロンプトとオプションのテキストおよび [OK] ボタンと [キャンセル] ボタンを表示します。</p>
		 * <p>displays a prompt and optional text in a modal Alert dialog box, along with OK and Cancel buttons.</p>
		 * 
		 * @param title
		 * <p>プロンプトダイアログボックスに表示するストリングです。</p>
		 * <p>A string to display in the Prompt dialog box.</p>
		 * @param messages
		 * <p>プロンプトダイアログボックスに表示するストリングです。</p>
		 * <p>An optional string to display as a default value for the text field.</p>
		 * @return
		 * <p>ユーザーが [OK] をクリックした場合はユーザーが入力したストリング、[キャンセル] をクリックした場合は null を返します。</p>
		 * <p>The string the user typed if the user clicks OK; null if the user clicks Cancel.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function prompt( title:String, ... messages:Array ):String {
			var message:String = StringUtil.collectBreak( messages.join( " " ), "\\n" );
			
			if ( _enabled ) {
				return call( "prompt", title, message );
			}
			else {
				Logger.info( "JSFL.prompt(", title, ",", message, ")" );
			}
			
			return null;
		}
		
		/**
		 * <p>ファイルを開く、またはファイルを保存システムダイアログボックスを開き、ユーザーは開いたり保存したりするファイルを指定できます。</p>
		 * <p>Opens a File Open or File Save system dialog box and lets the user specify a file to be opened or saved.</p>
		 * 
		 * @param browseType
		 * <p>ファイルの参照操作の種類を指定するストリングです。</p>
		 * <p>A string that specifies the type of file browse operation.</p>
		 * @param title
		 * <p>ファイルを開くダイアログボックスまたはファイルを保存ダイアログボックスのタイトルを指定するストリングです。</p>
		 * <p>A string that specifies the title for the File Open or File Save dialog box.</p>
		 * @return
		 * <p>file:/// URI で表したファイルの URL です。</p>
		 * <p>The URL of the file, expressed as a file:/// URI.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function browseForFileURL( browseType:String, title:String = null ):String {
			if ( _enabled ) {
				return call( "fl.browseForFileURL", browseType, title );
			}
			else {
				Logger.info( "JSFL.browseForFileURL(", browseType, ",", title, ")" );
			}
			
			return null;
		}
		
		/**
		 * <p>フォルダを参照ダイアログボックスを表示し、ユーザーがフォルダを選択できるようにします。</p>
		 * <p>Displays a Browse for Folder dialog box and lets the user select a folder.</p>
		 * 
		 * @param description
		 * <p>フォルダを参照ダイアログボックスの説明を指定する省略可能なストリングです。</p>
		 * <p>An optional string that specifies the description of the Browse For Folder dialog box.</p>
		 * @return
		 * <p>file:/// URI で表したフォルダの URL です。</p>
		 * <p>The URL of the folder, expressed as a file:/// URI.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function browseForFolderURL( description:String = null ):String {
			if ( _enabled ) {
				return call( "fl.browseForFolderURL", description );
			}
			else {
				Logger.info( "JSFL.browseForFolderURL(", description, ")" );
			}
			
			return null;
		}
	}
}
