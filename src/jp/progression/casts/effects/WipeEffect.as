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
	import fl.transitions.Wipe;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.core.casts.EffectBase;
	
	/**
	 * <p>WipeEffect クラスは、水平方向に移動するシェイプのアニメーション化されたマスクを使用して、ムービークリップオブジェクトの表示と非表示を切り替えます。
	 * このクラスを使用するためには、CommandExecutor が実装される環境設定（BasicAppConfig、WebConfig、等）を使用する必要があります。</p>
	 * <p>The WipeEffect class reveals or hides the movie clip object by using an animated mask of a shape that moves horizontally.</p>
	 * 
	 * @example <listing version="3.0" >
	 * // WipeEffect インスタンスを作成する
	 * var cast:WipeEffect = new WipeEffect();
	 * </listing>
	 */
	public class WipeEffect extends EffectBase {
		
		/**
		 * <p>エフェクトの開始位置を取得または設定します。</p>
		 * <p></p>
		 */
		public function get startPoint():int { return super.parameters.startPoint; }
		public function set startPoint( value:int ):void { super.parameters.startPoint = value; }
		
		/**
		 * @private
		 */
		public override function get parameters():Object { return {}; }
		public override function set parameters( value:Object ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "parameters" ) ); }
		
		
		
		
		
		/**
		 * <p>新しい WipeEffect インスタンスを作成します。</p>
		 * <p>Creates a new WipeEffect object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function WipeEffect( initObject:Object = null ) {
			// 親クラスを初期化する
			super( Wipe, initObject );
			
			// 初期化する
			super.parameters.startPoint = 5;
		}
	}
}
