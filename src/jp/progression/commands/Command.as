/**
 * Progression 4
 * 
 * @author Copyright (C) 2007-2009 taka:nium.jp, All Rights Reserved.
 * @version 4.0.1 Public Beta 1.2
 * @see http://progression.jp/
 * 
 * Progression Software is released under the Progression Software License:
 * http://progression.jp/ja/overview/license
 * 
 * Progression Libraries is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.progression.commands {
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import jp.nium.collections.UniqueList;
	import jp.nium.collections.IdGroupCollection;
	import jp.nium.collections.IIdGroup;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.ns.nium_internal;
	import jp.nium.core.primitives.StringObject;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.core.L10N.L10NCommandMsg;
	import jp.progression.core.L10N.L10NExecuteMsg;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.events.ExecuteErrorEvent;
	import jp.progression.events.ExecuteEvent;
	
	/**
	 * <p>処理が開始された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ExecuteEvent.EXECUTE_START
	 */
	[Event( name="executeStart", type="jp.progression.events.ExecuteEvent" )]
	
	/**
	 * <p>処理が完了した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ExecuteEvent.EXECUTE_COMPLETE
	 */
	[Event( name="executeComplete", type="jp.progression.events.ExecuteEvent" )]
	
	/**
	 * <p>処理が中断された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ExecuteEvent.EXECUTE_INTERRUPT
	 */
	[Event( name="executeInterrupt", type="jp.progression.events.ExecuteEvent" )]
	
	/**
	 * <p>処理の途中でエラーが発生した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ExecuteErrorEvent.EXECUTE_ERROR
	 */
	[Event( name="executeError", type="jp.progression.events.ExecuteErrorEvent" )]
	
	/**
	 * <p>Command クラスは、全てのコマンドの基本となるクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // Command インスタンスを作成する
	 * var com:Command = new Command();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class Command extends EventDispatcher implements IIdGroup {
		
		/**
		 * <p>timeout プロパティの初期値を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #timeout
		 */
		public static function get defaultTimeOut():Number { return _defaultTimeOut; }
		public static function set defaultTimeOut( value:Number ):void {
			if ( value >= 1000 ) {
				Logger.warn( Logger.getLog( L10NCommandMsg.WARN_001 ).toString( "Command", "defaultTimeOut" ) );
			}
			
			_defaultTimeOut = value;
		}
		private static var _defaultTimeOut:Number = 0;
		
		/**
		 * <p>同一プロセス上で実行可能な最大コマンド数を取得または設定します。
		 * 設定された閾値を超えて実行された場合には、強制的に 1 ミリ秒の遅延を発生させます。
		 * この値が大きすぎる場合、スタックオーバーフローが発生する可能性があります。</p>
		 * <p></p>
		 * 
		 * @see #execute()
		 */
		public static function get thresholdLength():int { return _thresholdLength; }
		public static function set thresholdLength( value:int ):void { _thresholdLength = value; }
		private static var _thresholdLength:int = 300;
		
		/**
		 * 現在のプロセス数を取得します。
		 */
		private static var _numProcesses:uint = 0;
		
		/**
		 * @private
		 */
		progression_internal static var $collections:IdGroupCollection = new IdGroupCollection();
		
		/**
		 * 実行中の Command インスタンスがガベージコレクションされないように参照を保存します。
		 */
		private static var _runningCommands:UniqueList = new UniqueList();
		
		/**
		 * インスタンス名の接頭辞を取得します。
		 */
		private static var _prefix:String = "command";
		
		
		
		
		
		/**
		 * <p>インスタンスのクラス名を取得します。</p>
		 * <p>Indicates the instance className of the Command.</p>
		 */
		public function get className():String { return _classNameObj ? _classNameObj.toString() : ClassUtil.nium_internal::$DEFAULT_CLASS_NAME; }
		private var _classNameObj:StringObject;
		
		/**
		 * <p>インスタンスの名前を取得または設定します。</p>
		 * <p>Indicates the instance name of the Command.</p>
		 */
		public function get name():String { return _name || ( _prefix + _uniqueNum ); }
		public function set name( value:String ):void { _name = value; }
		private var _name:String;
		private var _uniqueNum:uint;
		
		/**
		 * <p>インスタンスを表すユニークな識別子を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.commands#getCommandById()
		 */
		public function get id():String { return _id; }
		public function set id( value:String ):void {
			// 既存の登録を取得する
			var instance:IIdGroup = Command.progression_internal::$collections.getInstanceById( value );
			
			// すでに存在していれば例外をスローする
			if ( instance ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_022 ).toString( value ) ); }
			
			// 登録する
			_id = Command.progression_internal::$collections.registerId( this, value ) ? value : null;
		}
		private var _id:String;
		
		/**
		 * <p>インスタンスのグループ名を取得または設定します。</p>
		 * <p>Indicates the instance group of the Command.</p>
		 * 
		 * @see jp.progression.commands#getCommandsByGroup()
		 */
		public function get group():String { return _group; }
		public function set group( value:String ):void { _group = Command.progression_internal::$collections.registerGroup( this, value ) ? value : null; }
		private var _group:String;
		
		/**
		 * <p>この Command オブジェクトを含む CommandList オブジェクトを示します。</p>
		 * <p>Indicates the CommandList object that contains this Command object.</p>
		 * 
		 * @see #root
		 * @see #next
		 * @see #previous
		 */
		public function get parent():CommandList { return progression_internal::$parent; }
		
		/**
		 * @private
		 */
		progression_internal var $parent:CommandList;
		
		/**
		 * <p>コマンドツリー構造の一番上に位置する Command インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see #parent
		 * @see #next
		 * @see #previous
		 */
		public function get root():Command { return parent ? parent.root : this; }
		
		/**
		 * <p>このコマンドが関連付けられている親の CommandList インスタンス内で、次に位置する Command インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see #parent
		 * @see #root
		 * @see #previous
		 */
		public function get next():Command {
			if ( !parent ) { return null; }
			return parent.commands[parent.getCommandIndex( this ) + 1];
		}
		
		/**
		 * <p>このコマンドが関連付けられている親の CommandList インスタンス内で、一つ前に位置する Command インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see #parent
		 * @see #root
		 * @see #next
		 */
		public function get previous():Command {
			if ( !parent ) { return null; }
			return parent.commands[parent.getCommandIndex( this ) - 1];
		}
		
		/**
		 * <p>コマンドツリー構造上での自身の深度を取得します。</p>
		 * <p></p>
		 */
		public function get depth():int { return parent ? parent.depth + 1 : 0; }
		
		/**
		 * <p>コマンドの実行状態を取得します。</p>
		 * <p></p>
		 * 
		 * @see #execute()
		 * @see #interrupt()
		 * @see jp.progression.executors.ExecutorObjectState
		 */
		public function get state():int { return _state; }
		private var _state:int = 0;
		
		/**
		 * <p>中断処理時の処理方法を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #interrupt()
		 * @see jp.progression.commands.CommandInterruptType
		 */
		public function get interruptType():int { return _interruptType; }
		public function set interruptType( value:int ):void {
			switch ( value ) {
				case 0		:
				case 1		:
				case 2		: { _interruptType = value; break; }
				default		: { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_003 ).toString( "interruptType" ) ); }
			}
		}
		private var _interruptType:int = 2;
		
		/**
		 * <p>コマンドが実際に実行されるまでの遅延時間を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #execute()
		 */
		public function get delay():Number { return _delay; }
		public function set delay( value:Number ):void {
			if ( value >= 1000 ) {
				Logger.warn( Logger.getLog( L10NCommandMsg.WARN_001 ).toString( _classNameObj.toString(), "delay" ) );
			}
			
			_delay = value;
		}
		private var _delay:Number = 0;
		
		/**
		 * <p>コマンドの実行中のタイムアウト時間を取得または設定します。
		 * 指定された時間中に executeComplete() メソッド、または interrupt() メソッドが実行されなかった場合にはエラーが送出されます。
		 * この値が 0 に設定されている場合、タイムアウト処理は発生しません。</p>
		 * <p></p>
		 * 
		 * @see #catchError
		 * @see #execute()
		 */
		public function get timeout():Number { return _timeout; }
		public function set timeout( value:Number ):void {
			if ( value >= 1000 ) {
				Logger.warn( Logger.getLog( L10NCommandMsg.WARN_001 ).toString( _classNameObj.toString(), "timeout" ) );
			}
			
			_timeout = value;
		}
		private var _timeout:Number = 0;
		
		/**
		 * <p>コマンドの実行処理、または中断処理に指定されている関数内でのスコープ対象を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #catchError
		 * @see #onStart
		 * @see #onComplete
		 * @see #onInterrupt
		 * @see #onError
		 * @see #execute()
		 * @see #interrupt()
		 */
		public function get scope():Object { return _scope; }
		public function set scope( value:Object ):void { _scope = value; }
		private var _scope:Object;
		
		/**
		 * <p>コマンドの実行処理、または中断処理の開始時に指定されているリレーオブジェクトを取得または設定します。
		 * このコマンドが親の CommandList インスタンスによって実行されている場合には、親のリレーオブジェクトを順々に引き継ぎます。</p>
		 * <p></p>
		 * 
		 * @see #execute()
		 * @see #interrupt()
		 */
		public function get extra():Object { return _extra || _executingExtra; }
		public function set extra( value:Object ):void { _extra = value; }
		private var _extra:Object;
		private var _executingExtra:Object;
		
		/**
		 * <p>自身から見て最後に関連付けられた読み込みデータを取得または設定します。
		 * このコマンドが CommandList インスタンス上に存在する場合には、自身より前、または自身の親のデータを取得します。</p>
		 * <p></p>
		 */
		public function get latestData():* {
			if ( _latestData ) { return _latestData; }
			
			var prev:Command = previous;
			if ( prev ) { return prev.latestData; }
			
			return null;
		}
		public function set latestData( value:* ):void { _latestData = value; }
		private var _latestData:*;
		
		/**
		 * <p>コマンドの実行中に例外が発生した際に実行するエラー処理関数を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #scope
		 * @see #throwError()
		 */
		public function get catchError():Function { return _catchError; }
		public function set catchError( value:Function ):void { _catchError = value; }
		private var _catchError:Function;
		
		/**
		 * <p>コマンドオブジェクトが ExecuteEvent.EXECUTE_START イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #scope
		 * @see jp.progression.events.ExecuteEvent#START
		 */
		public function get onStart():Function { return _onStart; }
		public function set onStart( value:Function ):void {
			if ( _onStart != null ) {
				super.removeEventListener( ExecuteEvent.EXECUTE_START, _executeStart );
			}
			
			_onStart = value;
			
			if ( _onStart != null ) {
				super.addEventListener( ExecuteEvent.EXECUTE_START, _executeStart );
			}
		}
		private var _onStart:Function;
		
		/**
		 * <p>コマンドオブジェクトが ExecuteEvent.EXECUTE_COMPLETE イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #scope
		 * @see jp.progression.events.ExecuteEvent#COMPLETE
		 */
		public function get onComplete():Function { return _onComplete; }
		public function set onComplete( value:Function ):void {
			if ( _onComplete != null ) {
				super.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
			}
			
			_onComplete = value;
			
			if ( _onComplete != null ) {
				super.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
			}
		}
		private var _onComplete:Function;
		
		/**
		 * <p>コマンドオブジェクトが ExecuteEvent.EXECUTE_INTERRUPT イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #scope
		 * @see jp.progression.events.ExecuteEvent#INTERRUPT
		 */
		public function get onInterrupt():Function { return _onInterrupt; }
		public function set onInterrupt( value:Function ):void {
			if ( _onInterrupt != null ) {
				super.removeEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
			}
			
			_onInterrupt = value;
			
			if ( _onInterrupt != null ) {
				super.addEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
			}
		}
		private var _onInterrupt:Function;
		
		/**
		 * <p>コマンドオブジェクトが ExecuteErrorEvent.EXECUTE_ERROR イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #scope
		 * @see jp.progression.events.ExecuteErrorEvent#ERROR
		 */
		public function get onError():Function { return _onError; }
		public function set onError( value:Function ):void {
			if ( _onError != null ) {
				super.removeEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _executeError );
			}
			
			_onError = value;
			
			if ( _onError != null ) {
				super.addEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _executeError );
			}
		}
		private var _onError:Function;
		
		/**
		 * 実行処理関数を取得します。
		 */
		private var _executeFunction:Function;
		
		/**
		 * 中断処理関数を取得します。
		 */
		private var _interruptFunction:Function;
		
		/**
		 * Timer インスタンスを取得します。 
		 */
		private var _timer:Timer;
		
		
		
		
		
		/**
		 * <p>新しい Command インスタンスを作成します。</p>
		 * <p>Creates a new Command object.</p>
		 * 
		 * @param executeFunction
		 * <p>実行関数です。</p>
		 * <p></p>
		 * @param interruptFunction
		 * <p>中断関数です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function Command( executeFunction:Function = null, interruptFunction:Function = null, initObject:Object = null ) {
			// クラス名を取得する
			_classNameObj = ClassUtil.nium_internal::$getClassString( this );
			
			// 親クラスを初期化する
			super();
			
			// コレクションに登録する
			_uniqueNum = Command.progression_internal::$collections.addInstance( this );
			
			// 引数を設定する
			_executeFunction = executeFunction;
			_interruptFunction = interruptFunction;
			
			// 初期化する
			_timeout = _defaultTimeOut;
			
			// initObject が Command であれば
			var com:Command = initObject as Command;
			if ( com ) {
				// 特定のプロパティを継承する
				_delay = com._delay;
				_timeout = com._timeout;
				_scope = com._scope;
				_extra = com._extra;
				_latestData = com._latestData;
				_catchError = com._catchError;
				onStart = com._onStart;
				onComplete = com._onComplete;
				onInterrupt = com._onInterrupt;
				onError = com._onError;
			}
			
			// 初期化する
			ObjectUtil.setProperties( this, initObject );
		}
		
		
		
		
		
		/**
		 * <p>インスタンスに対して、複数のプロパティを一括設定します。</p>
		 * <p></p>
		 * 
		 * @param parameters
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function setProperties( parameters:Object ):void {
			ObjectUtil.setProperties( this, parameters );
		}
		
		/**
		 * <p>コマンド処理を実行します。</p>
		 * <p></p>
		 * 
		 * @see #state
		 * @see #delay
		 * @see #timeout
		 * @see #scope
		 * @see #extra
		 * @see #executeComplete()
		 * @see #interrupt()
		 * 
		 * @param extra
		 * <p>実行時に設定されるリレーオブジェクトです。</p>
		 * <p></p>
		 */
		public function execute( extra:Object = null ):void {
			// 実行中であれば例外をスローする
			if ( _state > 0 ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_002 ).toString( toString() ) ); }
			
			// 引数を保存する
			_executingExtra = extra;
			
			// 実行リストに追加する
			_runningCommands.addItem( this );
			
			// イベントを送出する
			super.dispatchEvent( new ExecuteEvent( ExecuteEvent.EXECUTE_START, false, false, this ) );
			
			// 限界数以上の処理を実行していれば強制的に遅延させる
			if ( _numProcesses > _thresholdLength ) {
				_delay = _delay || 0.001;
			}
			
			// 状態を変更する
			_state = 1;
			
			// 遅延処理を実行する
			if ( _createTimer( _delay ) ) { return; }
			
			// 処理を開始する
			_executeProgress();
		}
		
		/**
		 * コマンド実行の初期処理を行います。
		 */
		private function _executeProgress():void {
			// 状態を変更する
			_state = 2;
			
			// タイムアウト処理を実行する
			_createTimer( _timeout );
			
			// プロセス数を増加させる
			_numProcesses++;
			
			try {
				// 処理を実行する
				( _executeFunction as Function || executeComplete as Function ).apply( _scope || this );
			}
			catch ( e:Error ) {
				// エラー処理をする
				throwError( this, e );
			}
			finally {
				// プロセス数を減少させる
				_numProcesses = Math.max( 0, _numProcesses - 1 );
			}
		}
		
		/**
		 * <p>実行中のコマンド処理が完了したことを通知します。
		 * このメソッドを実行するためには、事前に execute() メソッドが実行されている必要があります。</p>
		 * <p></p>
		 * 
		 * @see #state
		 * @see #interrupt()
		 */
		public function executeComplete():void {
			// 実行中でなければ例外をスローする
			if ( _state < 1 ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_003 ).toString( toString() ) ); }
			
			// 破棄処理を実行する
			_destroy();
			
			// イベントを送出する
			super.dispatchEvent( new ExecuteEvent( ExecuteEvent.EXECUTE_COMPLETE, false, false, this ) );
		}
		
		/**
		 * <p>コマンド処理を中断します。
		 * このメソッドを実行するためには、事前に execute() メソッドが実行されている必要があります。</p>
		 * <p></p>
		 * 
		 * @see #state
		 * @see #scope
		 * @see #execute()
		 * 
		 * @param enforced
		 * <p>親が存在する場合に、親の処理も中断させたい場合には true を、自身のみ中断したい場合には false を指定します。</p>
		 * <p></p>
		 */
		public function interrupt( enforced:Boolean = false ):void {
			// 実行中でなければ例外をスローする
			if ( _state < 1 ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_004 ).toString( toString() ) ); }
			
			// 状態を変更する
			_state = 3;
			
			// Timer を破棄する
			_destroyTimer();
			
			try {
				// 中断処理を実行する
				if ( _interruptFunction != null ) {
					_interruptFunction.apply( _scope || this );
				}
			}
			catch ( e:Error ) {
				// エラー処理をする
				throwError( this, e );
			}
			
			// 中断処理中であれば
			if ( _state == 3 ) {
				// 破棄処理を実行する
				_destroy();
				
				// イベントを送出する
				super.dispatchEvent( new ExecuteEvent( ExecuteEvent.EXECUTE_INTERRUPT, false, false, this, enforced ) );
			}
		}
		
		/**
		 * <p>コマンド処理中に例外が発生したことを通知します。
		 * エラー処理が発生すると、コマンド処理が停止します。
		 * 問題を解決し、通常フローに戻す場合には executeComplete() メソッドを、問題が解決されず中断処理を行いたい場合には interrupt() メソッドを実行してください。
		 * 関数内で問題が解決、または中断処理に移行しなかった場合には ExecuteErrorEvent.EXECUTE_ERROR イベントが送出されます。</p>
		 * <p></p>
		 * 
		 * @see #catchError
		 * 
		 * @param target
		 * <p>問題の発生元である Command インスタンスです。</p>
		 * <p></p>
		 * @param error
		 * <p>原因となるエラーオブジェクトです。</p>
		 * <p></p>
		 */
		protected function throwError( target:Command, error:Error ):void {
			// 実行中でなければ例外をスローする
			if ( _state < 1 ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_005 ).toString( toString(), error.message ) ); }
			
			// Timer を破棄する
			_destroyTimer();
			
			// メッセージを追記する
			if ( target == this ) {
				error.message += "\n\tat " + toString() + "\n";
			}
			
			try {
				// エラー処理を実行する
				if ( _catchError != null ) {
					_catchError.apply( _scope || this, [ target, error ] );
				}
			}
			catch ( e:Error ) {
				// エラーを上書きする
				error = e;
			}
			finally {
				// 実行中であれば
				if ( target._state > 0 ) {
					// 問題が解決されなければ
					if ( super.hasEventListener( ExecuteErrorEvent.EXECUTE_ERROR ) ) {
						// イベントを送出する
						super.dispatchEvent( new ExecuteErrorEvent( ExecuteErrorEvent.EXECUTE_ERROR, false, false, target, error ) );
					}
					else {
						// 破棄処理を実行する
						_destroy();
						
						// 例外をスローする
						throw error;
					}
				}
			}
		}
		
		/**
		 * 破棄処理を実行します。
		 */
		private function _destroy():void {
			// Timer を破棄する
			_destroyTimer();
			
			// extra を破棄する
			_executingExtra = null;
			
			// 状態を変更する
			_state = 0;
			
			// 実行リストから削除する
			_runningCommands.removeItem( this );
		}
		
		/**
		 * Timer を作成します。
		 */
		private function _createTimer( time:Number ):Boolean {
			// Timer を破棄する
			_destroyTimer();
			
			// ミリ秒に変換する
			time = Math.round( time * 1000 );
			
			// 時間が 1 未満であれば
			if ( time < 1 ) { return false; }
			
			// Timer を初期化する
			_timer = new Timer( time, 1 );
			_timer.addEventListener( TimerEvent.TIMER_COMPLETE, _timerComplete );
			_timer.start();
			
			return true;
		}
		
		/**
		 * Timer を破棄します。
		 */
		private function _destroyTimer():void {
			// 対象が存在すれば
			if ( _timer ) {
				// イベントリスナーを解除する
				_timer.removeEventListener( TimerEvent.TIMER_COMPLETE, _timerComplete );
				
				// Timer を破棄する
				_timer.stop();
				_timer = null;
			}
		}
		
		/**
		 * <p>Command インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Command subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい Command インスタンスです。</p>
		 * <p>A new Command object that is identical to the original.</p>
		 */
		public function clone():Command {
			return new Command( _executeFunction, _interruptFunction, this );
		}
		
		/**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @return
		 * <p>オブジェクトのストリング表現です。</p>
		 * <p>A string representation of the object.</p>
		 */
		public override function toString():String {
			return ObjectUtil.formatToString( this, _classNameObj.toString(), _id ? "id" : null );
		}
		
		
		
		
		
		/**
		 * Timer.repeatCount で設定された数の要求が完了するたびに送出されます。
		 */
		private function _timerComplete( e:TimerEvent ):void {
			// Timer を破棄する
			_destroyTimer();
			
			// 遅延処理中であれば
			if ( _state == 1 ) {
				// 実行開始する
				_executeProgress();
			}
			else {
				// 例外をスローする
				throwError( this, new Error( Logger.getLog( L10NExecuteMsg.ERROR_006 ).toString( toString() ) ) );
			}
		}
		
		/**
		 * 処理が開始された場合に送出されます。
		 */
		private function _executeStart( e:ExecuteEvent ):void {
			// イベントハンドラメソッドを実行する
			_onStart.apply( _scope || this );
		}
		
		/**
		 * 処理が完了した場合に送出されます。
		 */
		private function _executeComplete( e:ExecuteEvent ):void {
			// イベントハンドラメソッドを実行する
			_onComplete.apply( _scope || this );
		}
		
		/**
		 * 処理が中断された場合に送出されます。
		 */
		private function _executeInterrupt( e:ExecuteEvent ):void {
			// イベントハンドラメソッドを実行する
			_onInterrupt.apply( _scope || this );
		}
		
		/**
		 * 
		 */
		private function _executeError( e:ExecuteErrorEvent ):void {
			// イベントハンドラメソッドを実行する
			_onError.apply( _scope || this );
		}
	}
}
