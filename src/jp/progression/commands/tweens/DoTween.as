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
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.events.Event;
	import jp.nium.events.EventAggregater;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.commands.Command;
	
	/**
	 * <p>DoTweener クラスは、fl.transitions パッケージのイージング機能を実行するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // DoTween インスタンスを作成する
	 * var com:DoTween = new DoTween();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class DoTween extends Command {
		
		/**
		 * <p>イージング処理を行いたい対象のオブジェクトを取得します。</p>
		 * <p></p>
		 */
		public function get target():Object { return _target; }
		private var _target:Object;
		
		/**
		 * <p>イージング処理を行いたいプロパティを含んだオブジェクトを取得します。</p>
		 * <p></p>
		 */
		public function get parameters():Object { return _parameters; }
		private var _parameters:Object;
		
		/**
		 * <p>イージング処理を行う関数を取得します。</p>
		 * <p></p>
		 */
		public function get easing():Function { return _easing; }
		private var _easing:Function;
		
		/**
		 * <p>イージング処理の継続時間です。負の数、または省略されている場合、infinity に設定されます。</p>
		 * <p></p>
		 */
		public function get duration():Number { return _duration; }
		private var _duration:Number;
		
		/**
		 * Tween インスタンスを配列で取得します。
		 */
		private var _tweens:Array;
		
		/**
		 * EventAggregater インスタンスを取得します。 
		 */
		private var _aggregater:EventAggregater;
		
		
		
		
		
		/**
		 * <p>新しい DoTween インスタンスを作成します。</p>
		 * <p>Creates a new DoTween object.</p>
		 * 
		 * @param target
		 * <p>Tween のターゲットになるオブジェクトです。</p>
		 * <p></p>
		 * @param props
		 * <p>影響を受ける (target パラメータ値) のプロパティの名前と値を保持した Object インスタンスです。</p>
		 * <p></p>
		 * @param easing
		 * <p>使用するイージング関数の名前です。</p>
		 * <p></p>
		 * @param duration
		 * <p>モーションの継続時間です。負の数、または省略されている場合、infinity に設定されます。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function DoTween( target:Object, parameters:Object, easing:Function, duration:Number, initObject:Object = null ) {
			// 引数を設定する
			_target = target;
			_parameters = parameters || {};
			_easing = easing;
			_duration = duration;
			
			// 親クラスを初期化する
			super( _executeFunction, _interruptFunction, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _executeFunction():void {
			// 初期化する
			_tweens = [];
			
			// EventAggregater を作成する
			_aggregater = new EventAggregater();
			_aggregater.addEventListener( Event.COMPLETE, _complete );
			
			
			// Tween を作成する
			for ( var p:String in _parameters ) {
				if ( p in _target ) {
					// Tween を作成する
					var tween:Tween = new Tween( _target, p, _easing, _target[p], _parameters[p], _duration, true );
					_aggregater.addEventDispatcher( tween, TweenEvent.MOTION_FINISH );
					_tweens.push( tween );
				}
			}
			
			if ( _tweens.length ) {
				// Tween を実行する
				for ( var i:int = 0, l:int = _tweens.length; i < l; i++ ) {
					Tween( _tweens[i] ).start();
				}
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
			// Tween を停止する
			for ( var i:int = 0, l:int = _tweens.length; i < l; i++ ) {
				var tween:Tween = Tween( _tweens[i] );
				
				// その場で停止する
				tween.stop();
				
				// 中断方法によって処理を振り分ける
				switch ( interruptType ) {
					case 0	: { _target[tween.prop] = tween.begin; break; }
					case 2	: { _target[tween.prop] = tween.finish; break; }
				}
			}
			
			// 破棄する
			_destroy();
		}
		
		/**
		 * 破棄します。
		 */
		private function _destroy():void {
			if ( _aggregater ) {
				// イベントリスナーを解除する
				_aggregater.removeEventListener( Event.COMPLETE, _complete );
				
				// 全ての登録を解除する
				for ( var i:int = 0, l:int = _tweens.length; i < l; i++ ) {
					_aggregater.removeEventDispatcher( _tweens[i], TweenEvent.MOTION_FINISH );
				}
				
				// EventAggregater を破棄する
				_aggregater = null;
			}
		}
		
		/**
		 * <p>DoTween インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an DoTween subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい DoTween インスタンスです。</p>
		 * <p>A new DoTween object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new DoTween( _target, _parameters, _easing, _duration, this );
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
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null, "target" );
		}
		
		
		
		
		
		/**
		 * 登録された全てのイベントが発生した際に送出されます。
		 */
		private function _complete( e:Event ):void {
			// 処理を終了する
			super.executeComplete();
			
			// 破棄する
			_destroy();
		}
	}
}
