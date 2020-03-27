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
package jp.progression.executors {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import jp.nium.collections.UniqueList;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.core.ns.nium_internal;
	import jp.nium.core.primitives.StringObject;
	import jp.nium.events.EventAggregater;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.core.L10N.L10NExecuteMsg;
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
	 * <p>ExecutorObject クラスは、非同期処理を実装するための汎用的な実行クラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ExecutorObject extends EventDispatcher {
		
		/**
		 * 実行中の ExecutorObject インスタンスがガベージコレクションされないように参照を保存します。
		 */
		private static var _runningExecutors:UniqueList = new UniqueList();
		
		
		
		
		
		/**
		 * <p>インスタンスのクラス名を取得します。</p>
		 * <p>Indicates the instance className of the SceneObject.</p>
		 */
		public function get className():String { return _classNameObj ? _classNameObj.toString() : ClassUtil.nium_internal::$DEFAULT_CLASS_NAME; }
		private var _classNameObj:StringObject;
		
		/**
		 * <p>IEventDispatcher インターフェイスを実装したインスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get target():IEventDispatcher { return _target; }
		private var _target:IEventDispatcher;
		
		/**
		 * <p>この ExecutorObject オブジェクトを含む ExecutorObject オブジェクトを示します。</p>
		 * <p>Indicates the ExecutorObject object that contains this ExecutorObject object.</p>
		 * 
		 * @see #root
		 * @see #next
		 * @see #previous
		 */
		public function get parent():ExecutorObject { return _parent; }
		private var _parent:ExecutorObject;
		
		/**
		 * <p>ExecutorObject ツリー構造の一番上に位置する ExecutorObject インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see #parent
		 * @see #next
		 * @see #previous
		 */
		public function get root():ExecutorObject { return _parent ? _parent.root : this; }
		
		/**
		 * <p>子 ExecutorObject オブジェクトが保存されている配列です。
		 * この配列を操作することで元の配列を変更することはできません。</p>
		 */
		public function get executors():Array { return _executors ? _executors.toArray() : []; }
		private var _executors:UniqueList;
		
		/**
		 * <p>登録されている ExecutorObject インスタンス数を取得します。</p>
		 * <p>Returns the number of children of this ExecutorObject.</p>
		 */
		public function get numExecutors():int { return _executors ? _executors.numItems : 0; }
		
		/**
		 * <p>ExecutorObject インスタンスツリー構造上での自身の深度を取得します。</p>
		 * <p></p>
		 */
		public function get depth():int { return _parent ? _parent.depth + 1 : 0; }
		
		/**
		 * <p>現在のイベントタイプを取得します。</p>
		 * <p></p>
		 */
		public function get eventType():String { return _event ? _event.type : null; }
		
		/**
		 * <p>イベントが送出状態であるかどうかを取得します。</p>
		 * <p></p>
		 */
		public function get dispatching():Boolean { return _dispatching; }
		private var _dispatching:Boolean = false;
		
		/**
		 * <p>現在の処理状態を取得します。</p>
		 * <p></p>
		 * 
		 * @see #execute()
		 * @see #interrupt()
		 * @see jp.progression.executors.ExecutorObjectState
		 */
		public function get state():int { return _state; }
		private var _state:int = 0;
		
		/**
		 * <p>ExecutorObject インスタンスの実行処理、または中断処理の開始時に指定されているリレーオブジェクトを取得または設定します。
		 * この ExecutorObject インスタンスが親の ExecutorObject インスタンスによって実行されている場合には、親のリレーオブジェクトを順々に引き継ぎます。</p>
		 * <p></p>
		 * 
		 * @see #execute()
		 * @see #interrupt()
		 */
		public function get extra():Object { return _extra; }
		public function set extra( value:Object ):void { _extra = value; }
		private var _extra:Object;
		
		/**
		 * 実行処理関数を取得します。
		 */
		private var _executeFunction:Function;
		
		/**
		 * 中断処理関数を取得します。
		 */
		private var _interruptFunction:Function;
		
		/**
		 * Event インスタンスを取得します。
		 */
		private var _event:Event;
		
		/**
		 * EventAggregater インスタンスを取得します。
		 */
		private var _aggregater:EventAggregater;
		
		/**
		 * 実行予定の ExecutorObject を保持した配列を取得します。
		 */
		private var _executeExecutors:Array;
		
		/**
		 * 実行中の ExecutorObject を保持した配列を取得します。
		 */
		private var _executingExecutors:Array;
		
		
		
		
		/**
		 * <p>新しい ExecutorObject インスタンスを作成します。</p>
		 * <p>Creates a new ExecutorObject object.</p>
		 * 
		 * @param target
		 * <p>関連付けたい IEventDispatcher インスタンスです。</p>
		 * <p></p>
		 * @param executeFunction
		 * <p>実行関数です。</p>
		 * <p></p>
		 * @param interruptFunction
		 * <p>中断関数です。</p>
		 * <p></p>
		 */
		public function ExecutorObject( target:IEventDispatcher, executeFunction:Function = null, interruptFunction:Function = null ) {
			// クラス名を取得する
			_classNameObj = ClassUtil.nium_internal::$getClassString( this );
			
			// 親クラスを初期化する
			super();
			
			// 引数を設定する
			_target = target;
			_executeFunction = executeFunction;
			_interruptFunction = interruptFunction;
		}
		
		
		
		
		
		/**
		 * <p>処理を実行します。</p>
		 * <p></p>
		 * 
		 * @see #state
		 * @see #extra
		 * @see #executeComplete()
		 * @see #interrupt()
		 * 
		 * @param event
		 * <p>ExecutorObject に登録された対象に対して送出するトリガーイベントです。</p>
		 * <p></p>
		 * @param extra
		 * <p>実行時に設定されるリレーオブジェクトです。</p>
		 * <p></p>
		 * @param preRegistration
		 * <p>実行対象の ExecutorObject を処理を行う前に登録するようにするかどうかです。</p>
		 * <p></p>
		 */
		public function execute( event:Event, extra:Object = null, preRegistration:Boolean = true ):void {
			// 実行中であれば例外をスローする
			if ( _state > 0 ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_002 ).toString( _classNameObj.toString() ) ); }
			
			// 引数を保存する
			_event = event;
			_extra = extra;
			
			// 実行リストに追加する
			_runningExecutors.addItem( this );
			
			// イベントを送出する
			super.dispatchEvent( new ExecuteEvent( ExecuteEvent.EXECUTE_START, false, false, this ) );
			
			// 実行予定の ExecutorObject を取得します。
			if ( preRegistration ) {
				_executeExecutors = _executors ? _executors.toArray() : [];
			}
			
			// 状態を変更する
			_state = 2;
			
			// 状態を変更する
			_dispatching = true;
			
			// イベントを送出する
			_target.dispatchEvent( _event );
			
			// 状態を変更する
			_dispatching = false;
			
			// 処理を実行する
			if ( _executeFunction != null ) {
				_executeFunction();
			}
			else {
				_executeComplete();
			}
		}
		
		/**
		 * <p>実行中の処理が完了したことを通知します。
		 * このメソッドを実行するためには、事前に execute() メソッドが実行されている必要があります。</p>
		 * <p></p>
		 */
		protected function executeComplete():void {
			// 実行中でなければ例外をスローする
			if ( _state < 1 ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_003 ).toString( _classNameObj.toString() ) ); }
			
			// 処理を完了する
			_executeComplete();
		}
		
		/**
		 * 完了処理を行います。
		 */
		private function _executeComplete():void {
			// 処理を実行する
			if ( numExecutors > 0 ) {
				_executeChildren();
				return;
			}
			
			// 破棄する
			_destroy();
			
			// イベントを送出する
			super.dispatchEvent( new ExecuteEvent( ExecuteEvent.EXECUTE_COMPLETE, false, false, this ) );
		}
		
		/**
		 * 子の ExecutorObject を実行する
		 */
		private function _executeChildren():void {
			// 初期化する
			_executingExecutors = [];
			
			// EventAggregater を作成する
			_aggregater = new EventAggregater();
			_aggregater.addEventListener( Event.COMPLETE, _complete );
			
			// 実行予定の ExecutorObject を取得します。
			_executeExecutors ||= _executors ? _executors.toArray() : [];
			
			// 子 ExecutorObject を登録します。
			for ( var i:int = 0, l:int = _executeExecutors.length; i < l; i++ ) {
				var executor:ExecutorObject = ExecutorObject( _executeExecutors[i] );
				
				// イベント待ち対象に登録する
				_aggregater.addEventDispatcher( executor, ExecuteEvent.EXECUTE_COMPLETE );
				
				// イベントリスナーを登録する
				executor.addEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
				executor.addEventListener( ExecuteErrorEvent.EXECUTE_ERROR, super.dispatchEvent );
				
				// 登録する
				_executingExecutors.push( executor );
			}
			
			// 実行中の ExecutorObject が存在しなければ
			if ( _executingExecutors.length == 0 ) {
				_complete( null );
				return;
			}
			
			// 子 ExecutorObject を実行します。
			for ( i = 0, l = _executingExecutors.length; i < l; i++ ) {
				executor = ExecutorObject( _executingExecutors[i] );
				
				// すでに実行中であれば中断する
				if ( executor.state > 0 ) {
					executor.interrupt();
				}
				
				// 実行する
				if ( _event ) {
					executor.execute( _event, _extra );
				}
			}
		}
		
		/**
		 * <p>処理を中断します。
		 * このメソッドを実行するためには、事前に execute() メソッドが実行されている必要があります。</p>
		 * <p></p>
		 * 
		 * @see #state
		 * @see #execute()
		 */
		public function interrupt():void {
			// 実行中でなければ例外をスローする
			if ( _state < 1 ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_003 ).toString( _classNameObj.toString() ) ); }
			
			// 状態を変更する
			_state = 3;
			
			// 中断処理を実行する
			if ( _interruptFunction != null ) {
				_interruptFunction();
			}
			
			// 中断処理中であれば
			if ( _state == 3 ) {
				// 破棄処理を実行する
				_destroy();
				
				// イベントを送出する
				super.dispatchEvent( new ExecuteEvent( ExecuteEvent.EXECUTE_INTERRUPT, false, false, this ) );
			}
		}
		
		/**
		 * <p>この ExecutorObject インスタンスに子 ExecutorObject インスタンスを追加します。</p>
		 * <p>Adds a child ExecutorObject instance to this ExecutorObject instance.</p>
		 * 
		 * @param executor
		 * <p>対象の ExecutorObject インスタンスの子として追加する ExecutorObject インスタンスです。</p>
		 * <p>The ExecutorObject instance to add as a executor of this ExecutorObject instance.</p>
		 * @return
		 * <p>executor パラメータで渡す ExecutorObject インスタンスです。</p>
		 * <p>The ExecutorObject instance that you pass in the executor parameter.</p>
		 */
		public function addExecutor( executor:ExecutorObject ):ExecutorObject {
			// すでに親が存在していれば解除する
			var parent:ExecutorObject = executor.parent;
			if ( parent ) {
				parent.removeExecutor( executor );
			}
			
			// 存在しなければ作成する
			_executors ||= new UniqueList();
			
			// 登録する
			_executors.addItem( executor );
			executor._parent = this;
			
			return executor;
		}
		
		/**
		 * <p>ExecutorObject インスタンスの子リストから指定の ExecutorObject インスタンスを削除します。</p>
		 * <p>Removes the specified child ExecutorObject instance from the executor list of the ExecutorObject instance.</p>
		 * 
		 * @param executor
		 * <p>対象の ExecutorObject インスタンスの子から削除する ExecutorObject インスタンスです。</p>
		 * <p>The ExecutorObject instance to remove.</p>
		 * @return
		 * <p>executor パラメータで渡す ExecutorObject インスタンスです。</p>
		 * <p>The ExecutorObject instance that you pass in the executor parameter.</p>
		 */
		public function removeExecutor( executor:ExecutorObject ):ExecutorObject {
			if ( !_executors ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_011 ).toString( executor ) ); }
			
			// 登録を解除する
			_executors.removeItem( executor );
			executor._parent = null;
			
			// 登録情報が存在しなければ
			if ( _executors.numItems < 1 ) {
				_executors.dispose();
				_executors = null;
			}
			
			return executor;
		}
		
		/**
		 * <p>ExecutorObject に追加されている全ての子 ExecutorObject インスタンスを削除します。</p>
		 * <p></p>
		 */
		public function removeAllExecutors():void {
			while ( numExecutors > 0 ) {
				removeExecutor( _executors.getItemAt( 0 ) as ExecutorObject );
			}
		}
		
		/**
		 * <p>指定された ExecutorObject インスタンスが ExecutorObject インスタンスの子であるか、オブジェクト自体であるかを指定します。</p>
		 * <p>Determines whether the specified ExecutorObject is a executor of the ExecutorObject instance or the instance itself.</p>
		 * 
		 * @param executor
		 * <p>テストする子 ExecutorObject インスタンスです。</p>
		 * <p>The executor object to test.</p>
		 * @return
		 * <p>executor インスタンスが ExecutorObject の子であるか、コンテナ自体である場合は true となります。そうでない場合は false となります。</p>
		 * <p>true if the executor object is a executor of the ExecutorObject or the container itself; otherwise false.</p>
		 */
		public function contains( executor:ExecutorObject ):Boolean {
			// 自身であれば true を返す
			if ( executor == this ) { return true; }
			
			// 子または孫に存在すれば true を返す
			for ( var i:int = 0, l:int = numExecutors; i < l; i++ ) {
				if ( _executors.contains( executor ) ) { return true; }
				if ( ExecutorObject( _executors.getItemAt( i ) ).contains( executor ) ) { return true; }
			}
			
			return false;
		}
		
		/**
		 * <p>ExecutorObject の登録情報を解放します。
		 * dispose() メソッドが呼び出されると、それ以降はこのインスタンスのメソッドまたはプロパティを呼び出すと失敗し、例外がスローされます。</p>
		 * <p></p>
		 */
		public function dispose():void {
			// 親が存在すれば削除する
			if ( _parent ) {
				_parent.removeExecutor( this );
			}
			
			// 破棄する
			_target = null;
		}
		
		/**
		 * 破棄します。
		 */
		private function _destroy():void {
			// EventAggregater が存在したら破棄する
			if ( _aggregater ) {
				for ( var i:int = 0, l:int = _executingExecutors.length; i < l; i++ ) {
					var executor:ExecutorObject = ExecutorObject( _executingExecutors[i] );
					
					_aggregater.removeEventDispatcher( executor, ExecuteEvent.EXECUTE_COMPLETE );
					
					executor.removeEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
					executor.removeEventListener( ExecuteErrorEvent.EXECUTE_ERROR, super.dispatchEvent );
				}
				
				_aggregater.removeEventListener( Event.COMPLETE, _complete );
				_aggregater = null;
				
				_executingExecutors = [];
			}
			
			// 破棄する
			_event = null;
			_extra = null;
			_executeExecutors = null;
			
			// 状態を変更する
			_state = 0;
			
			// 実行リストから削除する
			_runningExecutors.removeItem( this );
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
			return ObjectUtil.formatToString( this, _classNameObj.toString() );
		}
		
		
		
		
		
		/**
		 * 登録されている全ての EventDispatcher インスタンスがイベントを送出した場合に送出されます。
		 */
		private function _complete( e:Event ):void {
			// 破棄する
			_destroy();
			
			// イベントを送出する
			super.dispatchEvent( new ExecuteEvent( ExecuteEvent.EXECUTE_COMPLETE, false, false, this ) );
		}
		
		/**
		 * 処理が中断された場合に送出されます。
		 */
		private function _executeInterrupt( e:ExecuteEvent ):void {
			// 中断する
			interrupt();
		}
	}
}

