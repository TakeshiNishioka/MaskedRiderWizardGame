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
package jp.progression.commands.tweens {
	import flash.display.MovieClip;
	import flash.events.Event;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.MovieClipUtil;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.commands.Command;
	
	/**
	 * <p>DoTweenFrame クラスは、指定されたタイムライン上に存在する 2 点間をアニメーション処理させるコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // DoTweenFrame インスタンスを作成する
	 * var com:DoTweenFrame = new DoTweenFrame();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class DoTweenFrame extends Command {
		
		/**
		 * <p>アニメーション処理を行いたい対象の MovieClip インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get target():MovieClip { return _target; }
		private var _target:MovieClip;
		
		/**
		 * <p>アニメーションを開始するフレーム番号、またはフレームラベル名を取得します。</p>
		 * <p></p>
		 */
		public function get startFrame():* { return _startFrame; }
		private var _startFrame:*;
		
		/**
		 * <p>アニメーションを終了するフレーム番号もしくはフレームラベル名を取得します。</p>
		 * <p></p>
		 */
		public function get endFrame():* { return _endFrame; }
		private var _endFrame:*;
		
		/**
		 * アニメーションを開始するフレーム番号を取得します。
		 */
		private var _startFrameNum:int;
		
		/**
		 * アニメーションを終了するフレーム番号を取得します。
		 */
		private var _endFrameNum:int;
		
		
		
		
		
		/**
		 * <p>新しい DoTweenFrame インスタンスを作成します。</p>
		 * <p>Creates a new DoTweenFrame object.</p>
		 * 
		 * @param target
		 * <p>アニメーション処理を行いたい対象の MovieClip インスタンスです。</p>
		 * <p></p>
		 * @param startFrame
		 * <p>アニメーションを開始するフレーム番号、またはフレームラベル名です。</p>
		 * <p></p>
		 * @param endFrame
		 * <p>アニメーションを終了するフレーム番号もしくはフレームラベル名です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function DoTweenFrame( target:MovieClip, startFrame:*, endFrame:*, initObject:Object = null ) {
			// 引数を設定する
			_target = target;
			_startFrame = startFrame;
			_endFrame = endFrame;
			
			// 親クラスを初期化する
			super( _executeFunction, _interruptFunction, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _executeFunction():void {
			// 対象のフレームが 1 つしか存在しなければ終了する
			if ( _target.totalFrames == 1 ) {
				super.executeComplete();
				return;
			}
			
			// フレームが存在しなければ
			if ( !MovieClipUtil.hasFrame( _target, _startFrame ) ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_018 ).toString( _target, _startFrame ) ); }
			if ( !MovieClipUtil.hasFrame( _target, _endFrame ) ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_018 ).toString( _target, _endFrame ) ); }
			
			// 移動先のフレーム番号を取得する
			_startFrameNum = _startFrame is Number ? _startFrame : MovieClipUtil.labelToFrames( _target, _startFrame )[0];
			_endFrameNum = _endFrame is Number ? _endFrame : MovieClipUtil.labelToFrames( _target, _endFrame )[0];
			
			// 現在位置が範囲内に存在しなければ
			if ( !MovieClipUtil.playheadWithinFrames( _target, _startFrameNum, _endFrameNum ) ) {
				// 開始フレームに移動する
				_target.gotoAndStop( _startFrameNum );
			}
			
			// 現在位置と移動先位置が同一であれば終了する
			if ( _target.currentFrame == _endFrameNum ) {
				super.executeComplete();
				return;
			}
			
			// イベントリスナーを登録する
			_target.addEventListener( Event.ENTER_FRAME, _enterFrame );
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interruptFunction():void {
			// イベントリスナーを解除する
			_target.removeEventListener( Event.ENTER_FRAME, _enterFrame );
			
			// 中断方法によって処理を振り分ける
			switch ( interruptType ) {
				case 0	: { _target.gotoAndStop( _startFrameNum ); break; }
				case 2	: { _target.gotoAndStop( _endFrameNum ); break; }
			}
		}
		
		/**
		 * <p>DoTweenFrame インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an DoTweenFrame subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい DoTweenFrame インスタンスです。</p>
		 * <p>A new DoTweenFrame object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new DoTweenFrame( _target, _startFrame, _endFrame, this );
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
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null, "target", "startFrame", "endFrame" );
		}
		
		
		
		
		
		/**
		 * 再生ヘッドが新しいフレームに入るときに送出されます。
		 */
		private function _enterFrame( e:Event ):void {
			// 現在地が終了位置だった場合
			if ( _target.currentFrame == _endFrameNum ) {
				// イベントリスナーを解除する
				_target.removeEventListener( Event.ENTER_FRAME, _enterFrame );
				
				// 実行されていなければ終了する
				if ( super.state < 1 ) { return; }
				
				// 処理を終了する
				super.executeComplete();
			}
			else {
				// 現在地が終了地より手前の場合
				if ( _target.currentFrame < _endFrameNum ) {
					_target.nextFrame();
				}
				else {
					_target.prevFrame();
				}
			}
		}
	}
}
