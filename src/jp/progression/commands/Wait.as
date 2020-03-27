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
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import jp.nium.core.debug.Logger;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.core.L10N.L10NCommandMsg;
	
	/**
	 * <p>Wait クラスは、指定された時間だけ処理を停止させるコマンドクラスです。
	 * このコマンドは任意の時間の処理を行うため、デフォルトではタイムアウトは無効化されます。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // Wait インスタンスを作成する
	 * var com:Wait = new Wait();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class Wait extends Command {
		
		/**
		 * <p>処理を停止させたい時間を秒単位で取得します。</p>
		 * <p></p>
		 */
		public function get time():Number { return _time; }
		private var _time:Number = 1.0;
		
		/**
		 * Timer インスタンスを取得します。 
		 */
		private var _timer:Timer;
		
		
		
		
		
		/**
		 * <p>新しい Wait インスタンスを作成します。</p>
		 * <p>Creates a new Wait object.</p>
		 * 
		 * @param time
		 * <p>処理を停止させたい時間です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function Wait( time:Number = 1.0, initObject:Object = null ) {
			// 引数を設定する
			_time = time;
			
			// 親クラスを初期化する
			super( _executeFunction, _interruptFunction, initObject );
			
			if ( _time >= 1000 ) {
				Logger.warn( Logger.getLog( L10NCommandMsg.WARN_001 ).toString( super.className, "time" ) );
			}
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _executeFunction():void {
			// 遅延時間が設定されていれば
			if ( _time ) {
				// Timer を作成する
				_timer = new Timer( _time * 1000, 1 );
				_timer.addEventListener( TimerEvent.TIMER_COMPLETE, _timerComplete );
				_timer.start();
			}
			else {
				// 処理を終了する
				super.executeComplete();
			}
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interruptFunction():void {
			// Timer を破棄する
			_destroyTimer();
		}
		
		/**
		 * Timer を破棄します。
		 */
		private function _destroyTimer():void {
			if ( _timer ) {
				// イベントリスナーを解除する
				_timer.removeEventListener( TimerEvent.TIMER_COMPLETE, _timerComplete );
				
				// Timer を破棄する
				_timer.stop();
				_timer = null;
			}
		}
		
		/**
		 * <p>Wait インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Wait subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい Wait インスタンスです。</p>
		 * <p>A new Wait object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new Wait( _time, this );
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
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null, "time" );
		}
		
		
		
		
		
		/**
		 * Timer.repeatCount で設定された数の要求が完了するたびに送出されます。
		 */
		private function _timerComplete( e:TimerEvent ):void {
			// Timer を破棄する
			_destroyTimer();
			
			// 処理を終了する
			super.executeComplete();
		}
	}
}
