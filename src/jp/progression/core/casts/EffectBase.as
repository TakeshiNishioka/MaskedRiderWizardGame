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
package jp.progression.core.casts {
	import fl.transitions.easing.None;
	import flash.display.MovieClip;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.casts.CastMovieClip;
	import jp.progression.commands.tweens.DoTransition;
	import jp.progression.core.components.effects.IEffectComp;
	import jp.progression.events.CastEvent;
	
	/**
	 * @private
	 */
	public class EffectBase extends CastMovieClip {
		
		/**
		 * <p>コンポーネントの実装として使用される場合の対象コンポーネントを取得します。</p>
		 * <p></p>
		 */
		public function get component():IEffectComp { return _component; }
		private var _component:IEffectComp;
		
		/**
		 * <p>対象に適用するトランジション効果のクラスを取得します。</p>
		 * <p></p>
		 * 
		 * @see fl.transitions
		 */
		protected function get type():Class { return _type; }
		private var _type:Class;
		
		/**
		 * <p>イージングの適用方向を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.casts.effects.EffectDirectionType
		 */
		public function get direction():String { return _direction; }
		public function set direction( value:String ):void {
			switch ( value ) {
				case "in"		:
				case "inOut"	:
				case "out"		: { _direction = value; break; }
				default			: { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_003 ).toString( "direction" ) ); }
			}
		}
		private var _direction:String = "inOut";
		
		/**
		 * <p>アニメーションの継続時間を取得または設定します。</p>
		 * <p></p>
		 */
		public function get duration():Number { return _duration; }
		public function set duration( value:Number ):void { _duration = value; }
		private var _duration:Number = 1.0;
		
		/**
		 * <p>アニメーションのトゥイーン効果を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see fl.motion.easing
		 * @see fl.transitions.easing
		 */
		public function get easing():Function { return _easing; }
		public function set easing( value:Function ):void { _easing = value; }
		private var _easing:Function;
		
		/**
		 * <p>カスタムトゥイーンパラメータを取得または設定します。</p>
		 * <p></p>
		 */
		public function get parameters():Object { return _parameters; }
		public function set parameters( value:Object ):void { _parameters = value; }
		private var _parameters:Object;
		
		
		
		
		
		/**
		 * <p>新しい EffectBase インスタンスを作成します。</p>
		 * <p>Creates a new EffectBase object.</p>
		 * 
		 * @param type
		 * <p>適用するトランジション効果のクラスです。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function EffectBase( type:Class, initObject:Object = null ) {
			// 引数を設定する
			_type = type;
			_component = initObject as IEffectComp;
			
			// 初期化する
			_parameters = { };
			
			// 親クラスを初期化する
			super( initObject );
			
			// 継承せずにインスタンスを生成しようとしたら例外をスローする
			if ( Object( this ).constructor == EffectBase ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( super.className ) ); }
			
			// イベントリスナーを登録する
			super.addEventListener( CastEvent.CAST_ADDED, _castAdded, false, 0, true );
			super.addEventListener( CastEvent.CAST_REMOVED, _castRemoved, false, 0, true );
		}
		
		
		
		
		
		/**
		 * IExecutable オブジェクトが AddChild コマンド、または AddChildAt コマンド経由で表示リストに追加された場合に送出されます。
		 */
		private function _castAdded( e:CastEvent ):void {
			// 対象を取得する
			var target:MovieClip = _component ? _component.target || this : this;
			
			switch ( _direction ) {
				case "in"		:
				case "inOut"	: {
					super.addCommand(
						new DoTransition( target, _type, 0, _duration, _easing || None.easeNone, _parameters )
					);
					break;
				}
				case "out"		: { break; }
			}
		}
		
		/**
		 * IExecutable オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由で表示リストから削除された場合に送出されます。
		 */
		private function _castRemoved( e:CastEvent ):void {
			// 対象を取得する
			var target:MovieClip = _component ? _component.target || this : this;
			
			switch ( _direction ) {
				case "in"		: { break; }
				case "inOut"	:
				case "out"		: {
					super.addCommand(
						new DoTransition( target, _type, 1, _duration, _easing || None.easeNone, _parameters )
					);
					break;
				}
			}
		}
	}
}
