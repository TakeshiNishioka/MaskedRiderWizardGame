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
	import fl.transitions.Blinds;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.core.casts.EffectBase;
	
	/**
	 * <p>BlindsEffect クラスは、次第に表示される矩形または消えていく矩形を使用して、イベントフローとの連携機能を実装しながらムービークリップオブジェクトを表示します。
	 * このクラスを使用するためには、CommandExecutor が実装される環境設定（BasicAppConfig、WebConfig、等）を使用する必要があります。</p>
	 * <p>The BlindsEffect class reveals the movie clip object by using appearing or disappearing rectangles.</p>
	 * 
	 * @example <listing version="3.0" >
	 * // BlindsEffect インスタンスを作成する
	 * var cast:BlindsEffect = new BlindsEffect();
	 * </listing>
	 */
	public class BlindsEffect extends EffectBase {
		
		/**
		 * <p>Blinds 効果内のマスクストリップの数を取得または設定します。</p>
		 * <p></p>
		 */
		public function get numStrips():int { return super.parameters.numStrips; }
		public function set numStrips( value:int ):void { super.parameters.numStrips = Math.max( 1, value ); }
		
		/**
		 * <p>マスクストリップが垂直か水平かを取得または設定します。</p>
		 * <p></p>
		 */
		public function get dimension():int { return super.parameters.dimension; }
		public function set dimension( value:int ):void { super.parameters.dimension = value; }
		
		/**
		 * @private
		 */
		public override function get parameters():Object { return {}; }
		public override function set parameters( value:Object ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "parameters" ) ); }
		
		
		
		
		/**
		 * <p>新しい BlindsEffect インスタンスを作成します。</p>
		 * <p>Creates a new BlindsEffect object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function BlindsEffect( initObject:Object = null ) {
			// 親クラスを初期化する
			super( Blinds, initObject );
			
			// 初期化する
			super.parameters.numStrips = 10;
			super.parameters.dimension = 0;
		}
	}
}
