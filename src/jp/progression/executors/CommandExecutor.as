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
	import flash.events.IEventDispatcher;
	import jp.nium.core.debug.Logger;
	import jp.progression.commands.lists.SerialList;
	import jp.progression.core.L10N.L10NExecuteMsg;
	import jp.progression.events.ExecuteErrorEvent;
	import jp.progression.events.ExecuteEvent;
	
	/**
	 * <p>CommandExecutor クラスは、コマンドを使用した非同期処理の実装を提供するための実行クラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // CommandExecutor インスタンスを作成する
	 * var executor:CommandExecutor = new CommandExecutor();
	 * 
	 * // CommandExecutor を実行する
	 * executor.execute( new Event( Event.COMPLETE ) );
	 * </listing>
	 */
	public class CommandExecutor extends ExecutorObject {
		
		/**
		 * <p>現在処理している SerialList インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get current():SerialList { return _current; }
		private var _current:SerialList;
		
		
		
		
		
		/**
		 * <p>新しい CommandExecutor インスタンスを作成します。</p>
		 * <p>Creates a new CommandExecutor object.</p>
		 * 
		 * @param target
		 * <p>関連付けたい IEventDispatcher インスタンスです。</p>
		 * <p></p>
		 */
		public function CommandExecutor( target:IEventDispatcher ) {
			// 親クラスを初期化する
			super( target, _executeFunction, _interruptFunction );
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
		public override function execute( event:Event, extra:Object = null, preRegistration:Boolean = true ):void {
			// SerialList を作成する
			_current = new SerialList();
			
			// 親のメソッドを実行する
			super.execute( event, extra, preRegistration );
		}
		
		/**
		 * 実行される ExecutorObject の実装です。
		 */
		private function _executeFunction():void {
			// イベントリスナーを登録する
			_current.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
			_current.addEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
			_current.addEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _error );
			
			// コマンドを実行する
			_current.execute( super.extra );
		}
		
		/**
		 * 中断実行される ExecutorObject の実装です。
		 */
		private function _interruptFunction():void {
			// コマンドが存在し、実行中であれば中断する
			if ( _current && _current.state > 0 ) {
				_current.interrupt();
			}
		}
		
		/**
		 * <p>特定のイベントが送出された際に、自動実行させたい Command インスタンスをリストの最後尾に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に削除されます。</p>
		 * <p></p>
		 * 
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * 
		 * @param commands
		 * <p>登録したいコマンドを含む配列です。</p>
		 * <p></p>
		 */
		public function addCommand( ... commands:Array ):void {
			if ( super.state < 1 ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_000 ).toString() ); }
			if ( commands.length == 0 ) { return; }
			
			// 登録する
			_current.addCommand.apply( null, commands );
		}
		
		/**
		 * <p>特定のイベントが送出された際に、自動実行させたい Command インスタンスをすでにリストに登録され、実行中の Command インスタンスの次の位置に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に削除されます。</p>
		 * <p></p>
		 * 
		 * @see #addCommand();
		 * @see #clearCommand();
		 * 
		 * @param commands
		 * <p>登録したいコマンドを含む配列です。</p>
		 * <p></p>
		 */
		public function insertCommand( ... commands:Array ):void {
			if ( super.state < 1 ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_000 ).toString() ); }
			if ( commands.length == 0 ) { return; }
			
			// 登録する
			_current.insertCommand.apply( null, commands );
		}
		
		/**
		 * <p>登録されている Command インスタンスを削除します。</p>
		 * <p></p>
		 * 
		 * @see #addCommand();
		 * @see #insertCommand();
		 * 
		 * @param completely
		 * <p>true が設定されている場合は登録されている全てのコマンド登録を解除し、false の場合には現在処理中のコマンド以降の登録を解除します。</p>
		 * <p></p>
		 */
		public function clearCommand( completely:Boolean = false ):void {
			if ( super.state < 1 ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_000 ).toString() ); }
			
			// 登録を削除する
			_current.clearCommand( completely );
		}
		
		/**
		 * <p>ExecutorObject の登録情報を解放します。
		 * dispose() メソッドが呼び出されると、それ以降はこのインスタンスのメソッドまたはプロパティを呼び出すと失敗し、例外がスローされます。</p>
		 * <p></p>
		 */
		public override function dispose():void {
			// 破棄する
			if ( _current ) {
				_current.clearCommand( true );
				_current = null;
			}
		}
		
		/**
		 * 破棄します。
		 */
		private function _destroy():void {
			if ( _current ) {
				// イベントリスナーを解除する
				_current.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
				_current.removeEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
				_current.removeEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _error );
				
				// 破棄する
				_current.clearCommand( true );
			}
		}
		
		
		
		
		
		/**
		 * 処理が完了した場合に送出されます。
		 */
		private function _executeComplete( e:ExecuteEvent ):void {
			// 破棄する
			_destroy();
			
			// 処理を完了する
			super.executeComplete();
		}
		
		/**
		 * 処理が中断された場合に送出されます。
		 */
		private function _executeInterrupt( e:ExecuteEvent ):void {
			// 破棄する
			_destroy();
			
			// 処理を中断する
			super.interrupt();
		}
		
		/**
		 * 処理の途中でエラーが発生した場合に送出されます。
		 */
		private function _error( e:ExecuteErrorEvent ):void {
			// 破棄する
			_destroy();
			
			// メッセージを追記する
			var messages:Array = e.errorObject.message.split( "\n" );
			messages.splice( 1, 0, "\tat " + super.className + " in the \"" + super.eventType + "\" event on " + super.target );
			e.errorObject.message = messages.join( "\n" );
			
			// イベントリスナーが設定されていれば
			if ( super.hasEventListener( e.type ) ) {
				// イベントを送出する
				super.dispatchEvent( e );
			}
			else {
				// 例外をスローする
				throw e.errorObject;
			}
		}
	}
}

