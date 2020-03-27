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
	import flash.utils.Dictionary;
	import jp.nium.core.I18N.Locale;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	
	/**
	 * @private
	 */
	public class Logger {
		
		/**
		 * <p>通常の情報を出力するように設定します。</p>
		 * <p></p>
		 */
		public static const INFO:int = 0;
		
		/**
		 * <p>警告情報を出力するように設定します。</p>
		 * <p></p>
		 */
		public static const WARN:int = 1;
		
		/**
		 * <p>問題情報を出力するように設定します。</p>
		 * <p></p>
		 */
		public static const ERROR:int = 2;
		
		/**
		 * 未知のエラーです。
		 */
		private static var _unknownLog:Log = new Log( "UNKNOWN", "The error is unknown." );
		
		
		
		
		
		/**
		 * <p>ログ出力を有効化するかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		public static function get enabled():Boolean { return _enabled; }
		public static function set enabled( value:Boolean ):void { _enabled = value; }
		private static var _enabled:Boolean = true;
		
		/**
		 * <p>監視レベルを取得または設定します。</p>
		 * <p></p>
		 */
		public static function get level():int { return _level; }
		public static function set level( value:int ):void {
			switch ( value ) {
				case INFO		:
				case WARN		:
				case ERROR		: { _level = value; break; }
				default			: { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_003 ).toString( "level" ) ); }
			}
		}
		private static var _level:int = INFO;
		
		/**
		 * <p>出力されるメッセージに対して連番を付加するかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		public static function get insertSerialNums():Boolean { return _insertSerialNums; }
		public static function set insertSerialNums( value:Boolean ):void { _insertSerialNums = value; }
		private static var _insertSerialNums:Boolean = false;
		
		/**
		 * 現在の連番値を取得します。
		 */
		private static var _serialNums:uint = 1;
		
		/**
		 * <p>ログ出力に使用するロギング関数を取得または設定します。</p>
		 * <p></p>
		 */
		public static function get loggingFunction():Function { return _loggingFunction; }
		public static function set loggingFunction( value:Function ):void { _loggingFunction = value; }
		private static var _loggingFunction:Function;
		
		/**
		 * 登録された Log インスタンスを保持している Dictionary インスタンスを取得します。
		 */
		private static var _logs:Dictionary = new Dictionary();
		
		
		
		
		
		/**
		 * @private
		 */
		public function Logger() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>ログを登録します。</p>
		 * <p></p>
		 * 
		 * @see #getLog()
		 * 
		 * @param log
		 * <p>登録したいログです。</p>
		 * <p></p>
		 * @param language
		 * <p>ログが対応する言語です。</p>
		 * <p></p>
		 */
		public static function setLog( log:Log, language:String ):void {
			_logs[language] ||= new Dictionary();
			_logs[language][log.id] = log;
		}
		
		/**
		 * <p>指定された識別子で登録されているログを返します。</p>
		 * <p></p>
		 * 
		 * @see #setLog()
		 * 
		 * @param id
		 * <p>取得したいログの識別子です。</p>
		 * <p></p>
		 * @return
		 * <p>条件に合致したログです。</p>
		 * <p></p>
		 */
		public static function getLog( id:String ):Log {
			return getLogByLang( id, Locale.language );
		}
		
		/**
		 * <p>指定された識別子で登録されているログを返します。</p>
		 * <p></p>
		 * 
		 * @see #setLog()
		 * 
		 * @param id
		 * <p>取得したいログの識別子です。</p>
		 * <p></p>
		 * @param language
		 * <p>取得したいログが対応する言語です。</p>
		 * <p></p>
		 * @return
		 * <p>条件に合致したログです。</p>
		 * <p></p>
		 */
		public static function getLogByLang( id:String, language:String ):Log {
			for ( var p:String in _logs ) {
				if ( p != language ) { continue; }
				
				for each ( var log:Log in _logs[p] ) {
					if ( id == log.id ) { return log; }
				}
			}
			
			return _unknownLog;
		}
		
		/**
		 * <p>メッセージを出力します。</p>
		 * <p></p>
		 * 
		 * @see #info()
		 * @see #warn()
		 * @see #error()
		 * 
		 * @param messages
		 * <p>出力されるストリングを含む配列です。</p>
		 * <p></p>
		 */
		public static function output( ... messages:Array ):void {
			// 出力条件を満たしていなければ終了する
			if ( !_enabled ) { return; }
			
			_trace( messages.join( " " ) );
		}
		
		/**
		 * <p>情報メッセージを出力します。</p>
		 * <p></p>
		 * 
		 * @see #output()
		 * @see #warn()
		 * @see #error()
		 * 
		 * @param messages
		 * <p>出力されるストリングを含む配列です。</p>
		 * <p></p>
		 */
		public static function info( ... messages:Array ):void {
			// 出力条件を満たしていなければ終了する
			if ( !_enabled || _level > INFO ) { return; }
			
			_trace( "  [info]", messages.join( " " ) );
		}
		
		/**
		 * <p>メッセージを警告文として出力します。</p>
		 * <p></p>
		 * 
		 * @see #output()
		 * @see #info()
		 * @see #error()
		 * 
		 * @param messages
		 * <p>出力されるストリングを含む配列です。</p>
		 * <p></p>
		 */
		public static function warn( ... messages:Array ):void {
			// 出力条件を満たしていなければ終了する
			if ( !_enabled || _level > WARN ) { return; }
			
			_trace( "  [warn]", messages.join( " " ) );
		}
		
		/**
		 * <p>メッセージをエラー文として出力します。</p>
		 * <p></p>
		 * 
		 * @see #output()
		 * @see #info()
		 * @see #warn()
		 * 
		 * @param messages
		 * <p>出力されるストリングを含む配列です。</p>
		 * <p></p>
		 */
		public static function error( ... messages:Array ):void {
			// 出力条件を満たしていなければ終了する
			if ( !_enabled || _level > ERROR ) { return; }
			
			_trace( "  [error]", messages.join( " " ) );
		}
		
		/**
		 * <p>区切り線を出力します。</p>
		 * <p></p>
		 */
		public static function separate():void {
			// 出力条件を満たしていなければ終了する
			if ( !_enabled ) { return; }
			
			_trace( "\n----------------------------------------------------------------------" );
		}
		
		/**
		 * <p>行を送ります。</p>
		 * <p></p>
		 */
		public static function br():void {
			// 出力条件を満たしていなければ終了する
			if ( !_enabled ) { return; }
			
			_trace( " " );
		}
		
		/**
		 * 任意の出力関数でトレースします。
		 */
		private static function _trace( ... messages:Array ):void {
			// シリアルナンバーを付加するのであれば
			if ( _insertSerialNums ) {
				messages.unshift( "#" + _serialNums++ + ":" );
			}
			
			if ( _loggingFunction != null ) {
				_loggingFunction.apply( null, messages );
			}
			else {
				trace.apply( null, messages );
			}
		}
	}
}
