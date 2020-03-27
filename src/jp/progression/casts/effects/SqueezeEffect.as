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
	import fl.transitions.Squeeze;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.core.casts.EffectBase;
	
	/**
	 * <p>SqueezeEffect クラスは、ムービークリップオブジェクトを水平または垂直に拡大 / 縮小します。
	 * このクラスを使用するためには、CommandExecutor が実装される環境設定（BasicAppConfig、WebConfig、等）を使用する必要があります。</p>
	 * <p>The SqueezeEffect class scales the movie clip object horizontally or vertically.</p>
	 * 
	 * @example <listing version="3.0" >
	 * // SqueezeEffect インスタンスを作成する
	 * var cast:SqueezeEffect = new SqueezeEffect();
	 * </listing>
	 */
	public class SqueezeEffect extends EffectBase {
		
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
		 * <p>新しい SqueezeEffect インスタンスを作成します。</p>
		 * <p>Creates a new SqueezeEffect object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function SqueezeEffect( initObject:Object = null ) {
			// 親クラスを初期化する
			super( Squeeze, initObject );
			
			// 初期化する
			super.parameters.dimension = 1;
		}
	}
}
