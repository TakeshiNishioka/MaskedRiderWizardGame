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
package jp.progression.casts.effects {
	import fl.transitions.Rotate;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.core.casts.EffectBase;
	
	/**
	 * <p>RotateEffect クラスは、ムービークリップオブジェクトを回転させます。
	 * このクラスを使用するためには、CommandExecutor が実装される環境設定（BasicAppConfig、WebConfig、等）を使用する必要があります。</p>
	 * <p>The RotateEffect class rotates the movie clip object.</p>
	 * 
	 * @example <listing version="3.0" >
	 * // RotateEffect インスタンスを作成する
	 * var cast:RotateEffect = new RotateEffect();
	 * </listing>
	 */
	public class RotateEffect extends EffectBase {
		
		/**
		 * <p>対象を反時計回りに回転させるかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		public function get ccw():Boolean { return super.parameters.ccw; }
		public function set ccw( value:Boolean ):void { super.parameters.ccw = value; }
		
		/**
		 * <p>オブジェクトを回転する角度を取得または設定します。</p>
		 * <p></p>
		 */
		public function get degrees():Number { return super.parameters.degrees; }
		public function set degrees( value:Number ):void { super.parameters.degrees = value; }
		
		/**
		 * @private
		 */
		public override function get parameters():Object { return {}; }
		public override function set parameters( value:Object ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "parameters" ) ); }
		
		
		
		
		
		/**
		 * <p>新しい RotateEffect インスタンスを作成します。</p>
		 * <p>Creates a new RotateEffect object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function RotateEffect( initObject:Object = null ) {
			// 親クラスを初期化する
			super( Rotate, initObject );
			
			// 初期化する
			super.parameters.ccw = false;
			super.parameters.degrees = 360;
		}
	}
}
