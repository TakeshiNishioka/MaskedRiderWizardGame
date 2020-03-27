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
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import jp.nium.core.debug.Logger;
	import jp.progression.core.L10N.L10NExecuteMsg;
	import jp.progression.events.ExecuteErrorEvent;
	
	/**
	 * <p>ResumeExecutor クラスは、停止・再開という状態変化による非同期処理の実装を提供するための実行クラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // ResumeExecutor インスタンスを作成する
	 * var executor:ResumeExecutor = new ResumeExecutor();
	 * 
	 * // ResumeExecutor を実行する
	 * executor.execute( new Event( Event.COMPLETE ) );
	 * </listing>
	 */
	public class ResumeExecutor extends ExecutorObject {
		
		/**
		 * <p>timeout プロパティの初期値を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #timeout
		 */
		public static function get defaultTimeOut():Number { return _defaultTimeOut; }
		public static function set defaultTimeOut( value:Number ):void { _defaultTimeOut = value; }
		private static var _defaultTimeOut:Number = 15.0;
		
		
		
		
		
		/**
		 * <p>ExecutorObject インスタンス実行中のタイムアウト時間を取得または設定します。
		 * 指定された時間中に executeComplete() メソッド、または interrupt() メソッドが実行されなかった場合にはエラーが送出されます。
		 * この値が 0 に設定されている場合、タイムアウト処理は発生しません。</p>
		 * <p></p>
		 */
		public function get timeout():Number { return _timeout; }
		public function set timeout( value:Number ):void { _timeout = value; }
		private var _timeout:Number = 0.0;
		
		/**
		 * <p>待機処理が実行中であるかどうかを取得します。</p>
		 * <p></p>
		 */
		public function get waiting():Boolean { return _pausing; }
		private var _pausing:Boolean = false;
		
		/**
		 * Timer インスタンスを取得します。 
		 */
		private var _timer:Timer;
		
		
		
		
		
		/**
		 * <p>新しい ResumeExecutor インスタンスを作成します。</p>
		 * <p>Creates a new ResumeExecutor object.</p>
		 * 
		 * @param target
		 * <p>関連付けたい IEventDispatcher インスタンスです。</p>
		 * <p></p>
		 */
		public function ResumeExecutor( target:IEventDispatcher ) {
			// 親クラスを初期化する
			super( target, _executeFunction, _interruptFunction );
			
			// 初期化する
			_timeout = _defaultTimeOut;
		}
		
		
		
		
		
		/**
		 * 実行される ExecutorObject の実装です。
		 */
		private function _executeFunction():void {
			// 実行されていなければ終了する
			if ( super.state < 1 ) { return; }
			
			// 待機状態でなければ終了する
			if ( !_pausing ) {
				super.executeComplete();
				return;
			}
			
			// ミリ秒に変換する
			var time:Number = Math.round( _timeout * 1000 );
			
			// 時間が 1 未満であれば
			if ( time < 1 ) { return; }
			
			// Timer を作成する
			_timer = new Timer( time, 1 );
			_timer.addEventListener( TimerEvent.TIMER_COMPLETE, _timerComplete );
			_timer.start();
		}
		
		/**
		 * 中断実行される ExecutorObject の実装です。
		 */
		private function _interruptFunction():void {
			// Timer を破棄する
			_destroyTimer();
			
			// 待機状態を無効化する
			_pausing = false;
		}
		
		/**
		 * <p>現在の処理を待機状態にします。</p>
		 * <p></p>
		 * 
		 * @see #wating
		 * @see #resume()
		 */
		public function pause():void {
			_pausing = true;
		}
		
		/**
		 * <p>待機状態にある処理を再開させます。</p>
		 * <p></p>
		 * 
		 * @see #wating
		 * @see #wait()
		 */
		public function resume():void {
			// 実行中でなければ
			if ( super.state < 1 ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_008 ).toString() ); }
			
			// Timer を破棄する
			_destroyTimer();
			
			// 待機状態を無効化する
			_pausing = false;
			
			// 処理を完了する
			super.executeComplete();
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
		 * Timer.repeatCount で設定された数の要求が完了するたびに送出されます。
		 */
		private function _timerComplete( e:TimerEvent ):void {
			// Timer を破棄する
			_destroyTimer();
			
			// Error オブジェクトを作成する
			var error:Error = new Error( Logger.getLog( L10NExecuteMsg.ERROR_006 ).toString( toString() ) );
			
			// イベントリスナーが設定されていれば
			if ( super.hasEventListener( ExecuteErrorEvent.EXECUTE_ERROR ) ) {
				// イベントを送出する
				super.dispatchEvent( new ExecuteErrorEvent( ExecuteErrorEvent.EXECUTE_ERROR, false, false, this, error ) );
			}
			else {
				// 例外をスローする
				throw error;
			}
		}
	}
}
