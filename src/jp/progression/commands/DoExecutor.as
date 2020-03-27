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
	import flash.events.Event;
	import jp.progression.events.ExecuteErrorEvent;
	import jp.progression.events.ExecuteEvent;
	import jp.progression.executors.ExecutorObject;
	
	/**
	 * <p>DoExecutor クラスは、指定された対象の ExecutorObject を実行するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // DoExecutor インスタンスを作成する
	 * var com:DoExecutor = new DoExecutor();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class DoExecutor extends Command {
		
		/**
		 * <p>実行したい ExecutorObject インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get executor():ExecutorObject { return _executor; }
		private var _executor:ExecutorObject;
		
		/**
		 * <p>ExecutorObject に登録された対象に対して送出するトリガーイベントを取得します。</p>
		 * <p></p>
		 */
		public function get event():Event { return _event; }
		private var _event:Event;
		
		
		
		
		
		/**
		 * <p>新しい DoExecutor インスタンスを作成します。</p>
		 * <p>Creates a new DoExecutor object.</p>
		 * 
		 * @param executor
		 * <p>実行したい ExecutorObject です。</p>
		 * <p></p>
		 * @param event
		 * <p>ExecutorObject に登録された対象に対して送出するトリガーイベントです。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function DoExecutor( executor:ExecutorObject, event:Event, initObject:Object = null ) {
			// 引数を設定する
			_executor = executor;
			_event = event;
			
			// スーパークラスを初期化する
			super( _executeFunction, _interruptFunction, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _executeFunction():void {
			// イベントリスナーを登録する
			_executor.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
			_executor.addEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
			_executor.addEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _error );
			
			// 実行する
			_executor.execute( _event, super.extra );
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interruptFunction():void {
			// 実行中であれば
			if ( _executor.state > 0 ) {
				// 実行する
				_executor.interrupt();
			}
			else {
				// イベントリスナーを解除する
				_removeExecutorListeners();
			}
		}
		
		/**
		 * CommandExecutor のイベントリスナーを解除します。
		 */
		private function _removeExecutorListeners():void {
			if ( _executor ) {
				// イベントリスナーを解除する
				_executor.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
				_executor.removeEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
				_executor.removeEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _error );
			}
		}
		
		/**
		 * <p>DoExecutor インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an DoExecutor subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい DoExecutor インスタンスです。</p>
		 * <p>A new DoExecutor object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new DoExecutor( _executor, _event, this );
		}
		
		
		
		
		
		/**
		 * 処理が完了した場合に送出されます。
		 */
		private function _executeComplete( e:ExecuteEvent ):void {
			// イベントリスナーを解除する
			_removeExecutorListeners();
			
			// 処理を終了する
			super.executeComplete();
		}
		
		/**
		 * 処理が中断された場合に送出されます。
		 */
		private function _executeInterrupt( e:ExecuteEvent ):void {
			// イベントリスナーを解除する
			_removeExecutorListeners();
		}
		
		/**
		 * 処理の途中でエラーが発生した場合に送出されます。
		 */
		private function _error( e:ExecuteErrorEvent ):void {
			super.throwError( this, e.errorObject );
		}
	}
}
