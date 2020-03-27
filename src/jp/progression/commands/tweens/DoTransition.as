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
	import fl.transitions.Transition;
	import fl.transitions.TransitionManager;
	import flash.display.MovieClip;
	import flash.events.Event;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.commands.Command;
	
	/**
	 * <p>DoTransition クラスは、fl.transitions パッケージのトランジション機能を実行するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // DoTransition インスタンスを作成する
	 * var com:DoTransition = new DoTransition();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class DoTransition extends Command {
		
		/**
		 * <p>トランジション効果を適用する対象の MovieClip オブジェクトを取得します。</p>
		 * <p></p>
		 */
		public function get target():MovieClip { return _target; }
		private var _target:MovieClip;
		
		/**
		 * <p>Tween インスタンスに適用する Transition を取得します。</p>
		 * <p></p>
		 */
		public function get type():Class { return _type; }
		private var _type:Class;
		
		/**
		 * <p>Tween インスタンスのイージングの方向を取得します。</p>
		 * <p></p>
		 */
		public function get direction():int { return _direction; }
		private var _direction:int = Transition.IN;
		
		/**
		 * <p>Tween インスタンスの継続時間を取得します。</p>
		 * <p></p>
		 */
		public function get duration():Number { return _duration; }
		private var _duration:Number = 0.0;
		
		/**
		 * <p>アニメーションのトゥイーン効果を取得します。</p>
		 * <p></p>
		 */
		public function get easing():Function { return _easing; }
		private var _easing:Function;
		
		/**
		 * <p>カスタムトゥイーンパラメータを取得します。</p>
		 * <p></p>
		 */
		public function get parameters():Object { return _parameters; }
		private var _parameters:Object;
		
		/**
		 * TransitionManager インスタンスを取得します。
		 */
		private var _manager:TransitionManager;
		
		/**
		 * Transition インスタンスを取得します。
		 */
		private var _transition:Transition;
		
		
		
		
		
		/**
		 * <p>新しい DoTransition インスタンスを作成します。</p>
		 * <p>Creates a new DoTransition object.</p>
		 * 
		 * @param target
		 * <p>トランジション効果を適用する対象の MovieClip オブジェクトです。</p>
		 * <p></p>
		 * @param type
		 * <p>Tween インスタンスに適用する Transition です。</p>
		 * <p></p>
		 * @param direction
		 * <p>Tween インスタンスのイージングの方向です。</p>
		 * <p></p>
		 * @param duration
		 * <p>Tween インスタンスの継続時間です。</p>
		 * <p></p>
		 * @param easing
		 * <p>アニメーションのトゥイーン効果です。</p>
		 * <p></p>
		 * @param parameters
		 * <p>カスタムトゥイーンパラメータです。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function DoTransition( target:MovieClip, type:Class, direction:int, duration:Number, easing:Function, parameters:Object = null, initObject:Object = null ) {
			// 引数を設定する
			_target = target;
			_type = type;
			_direction = direction;
			_duration = duration;
			_easing = easing;
			_parameters = parameters;
			
			// 親クラスを初期化する
			super( _executeFunction, _interruptFunction, initObject );
			
			switch ( _direction ) {
				case Transition.IN		:
				case Transition.OUT		: { break; }
				default					: { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_003 ).toString( "direction" ) ); }
			}
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _executeFunction():void {
			// パラメータを設定する
			var o:Object = { type:_type, direction:_direction, duration:_duration, easing:_easing };
			for ( var p:String in _parameters ) {
				o[p] ||= _parameters[p];
			}
			
			// TransitionManager を作成する
			_manager = new TransitionManager( _target );
			_manager.addEventListener( "allTransitionsInDone", _transitionDone );
			_manager.addEventListener( "allTransitionsOutDone", _transitionDone );
			
			// TransitionManager を実行する
			_transition = _manager.startTransition( o );
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
			if ( _transition && _manager ) {
				// Transition を破棄する
				_manager.removeTransition( _transition );
				_transition = null;
				
				// イベントリスナーを解除する
				_manager.removeEventListener( "allTransitionsInDone", _transitionDone );
				_manager.removeEventListener( "allTransitionsOutDone", _transitionDone );
				
				// TransitionManager を破棄する
				_manager = null;
			}
		}
		
		/**
		 * <p>DoTransition インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an DoTransition subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい DoTransition インスタンスです。</p>
		 * <p>A new DoTransition object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new DoTransition( _target, _type, _direction, _duration, _easing, _parameters, this );
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
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null, "target", "type", "direction", "duration" );
		}
		
		
		
		
		
		/**
		 * 
		 */
		private function _transitionDone( e:Event ):void {
			// 処理を終了する
			super.executeComplete();
			
			// 破棄する
			_destroy();
		}
	}
}
