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
package jp.progression.commands.media {
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import jp.progression.commands.Command;
	
	/**
	 * <p>DoSound クラスは、Sound の再生を制御するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // DoSound インスタンスを作成する
	 * var com:DoSound = new DoSound();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class DoSound extends Command {
		
		/**
		 * <p>再生する Sound オブジェクトを取得します。</p>
		 * <p></p>
		 */
		public function get sound():Sound { return _sound; }
		private var _sound:Sound;
		
		/**
		 * <p>再生を開始する初期位置（ミリ秒単位）を取得します。</p>
		 * <p></p>
		 */
		public function get startTime():Number { return _startTime; }
		private var _startTime:Number = 0;
		
		/**
		 * <p>サウンドチャンネルの再生が停止するまで startTime 値に戻ってサウンドの再生を繰り返す回数を取得します。</p>
		 * <p></p>
		 */
		public function get loops():int { return _loops; }
		private var _loops:int = 0;
		
		/**
		 * <p>サウンドチャンネルに割り当てられる初期 SoundTransform オブジェクトを取得します。</p>
		 * <p></p>
		 */
		public function get soundTransform():SoundTransform { return _soundTransform; }
		private var _soundTransform:SoundTransform;
		
		/**
		 * <p>サウンドの再生完了を待って、コマンド処理の完了とするかどうかを取得します。</p>
		 * <p></p>
		 */
		public function get waitForComplete():Boolean { return _waitForComplete; }
		private var _waitForComplete:Boolean = false;
		
		/**
		 * <p>再生中の SoundChannel インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get soundChannel():SoundChannel { return _soundChannel; }
		private var _soundChannel:SoundChannel;
		
		
		
		
		
		/**
		 * <p>新しい DoSound インスタンスを作成します。</p>
		 * <p>Creates a new DoSound object.</p>
		 * 
		 * @param sound
		 * <p>再生する Sound オブジェクトです。</p>
		 * <p></p>
		 * @param startTime
		 * <p>再生を開始する初期位置（ミリ秒単位）です。</p>
		 * <p>The initial position in milliseconds at which playback should start.</p>
		 * @param loops
		 * <p>サウンドチャンネルの再生が停止するまで startTime 値に戻ってサウンドの再生を繰り返す回数を定義します。 </p>
		 * <p>Defines the number of times a sound loops back to the startTime value before the sound channel stops playback.</p>
		 * @param waitForComplete
		 * <p>サウンドの再生完了を待って、コマンド処理の完了とするかどうかです。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function DoSound( sound:Sound, startTime:Number = 0, loops:int = 0, waitForComplete:Boolean = false, initObject:Object = null ) {
			// 引数を設定する
			_sound = sound;
			_startTime = startTime;
			_loops = loops;
			_waitForComplete = waitForComplete;
			
			// 親クラスを初期化する
			super( _executeFunction, _interruptFunction, initObject );
			
			// initObject が DoSound であれば
			var com:DoSound = initObject as DoSound;
			if ( com ) {
				// 特定のプロパティを継承する
				_soundTransform = com._soundTransform;
			}
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _executeFunction():void {
			// イベントリスナーを登録する
			_sound.addEventListener( IOErrorEvent.IO_ERROR, _ioError, false );
			
			// 再生する
			_soundChannel = _sound.play( _startTime, _loops, _soundTransform );
			
			// 再生完了を待つのであれば
			if ( _waitForComplete ) {
				// イベントリスナーを登録する
				_soundChannel.addEventListener( Event.SOUND_COMPLETE, _soundComplete );
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
			// 破棄する
			_destroy();
		}
		
		/**
		 * 破棄します。
		 */
		private function _destroy():void {
			// 対象が存在すれば
			if ( _soundChannel ) {
				// イベントリスナーを解除する
				_soundChannel.removeEventListener( Event.SOUND_COMPLETE, _soundComplete );
				
				// SoundChannel を破棄する
				_soundChannel.stop();
				_soundChannel = null;
			}
		}
		
		/**
		 * <p>DoSound インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an DoSound subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい DoSound インスタンスです。</p>
		 * <p>A new DoSound object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new DoSound( _sound, _startTime, _loops, _waitForComplete, this );
		}
		
		
		
		
		
		/**
		 * 入出力エラーが発生してロード操作が失敗したときに送出されます。
		 */
		private function _ioError( e:IOErrorEvent ):void {
			super.throwError( this, new IOError( e.text ) );
		}
		
		/**
		 * サウンドの再生が終了したときに送出されます。
		 */
		private function _soundComplete( e:Event ):void {
			// 破棄する
			_destroy();
			
			// 処理を終了する
			super.executeComplete();
		}
	}
}
