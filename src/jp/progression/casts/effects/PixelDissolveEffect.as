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
	import fl.transitions.PixelDissolve;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.core.casts.EffectBase;
	
	/**
	 * <p>PixelDissolveEffect クラスは、チェッカーボードのパターンでランダムに表示される矩形または消える矩形を使用して、ムービークリップオブジェクトを表示します。
	 * このクラスを使用するためには、CommandExecutor が実装される環境設定（BasicAppConfig、WebConfig、等）を使用する必要があります。</p>
	 * <p>The PixelDissolveEffect class reveals reveals the movie clip object by using randomly appearing or disappearing rectangles in a checkerboard pattern.</p>
	 * 
	 * @example <listing version="3.0" >
	 * // PixelDissolveEffect インスタンスを作成する
	 * var cast:PixelDissolveEffect = new PixelDissolveEffect();
	 * </listing>
	 */
	public class PixelDissolveEffect extends EffectBase {
		
		/**
		 * <p>水平軸に沿ったマスク矩形セクションの数を取得または設定します。</p>
		 * <p></p>
		 */
		public function get xSections():int { return super.parameters.xSections; }
		public function set xSections( value:int ):void { super.parameters.xSections = value; }
		
		/**
		 * <p>垂直軸に沿ったマスク矩形セクションの数を取得または設定します。</p>
		 * <p></p>
		 */
		public function get ySections():int { return super.parameters.ySections; }
		public function set ySections( value:int ):void { super.parameters.ySections = value; }
		
		/**
		 * @private
		 */
		public override function get parameters():Object { return {}; }
		public override function set parameters( value:Object ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "parameters" ) ); }
		
		
		
		
		
		/**
		 * <p>新しい PixelDissolveEffect インスタンスを作成します。</p>
		 * <p>Creates a new PixelDissolveEffect object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function PixelDissolveEffect( initObject:Object = null ) {
			// 親クラスを初期化する
			super( PixelDissolve, initObject );
			
			// 初期化する
			super.parameters.xSections = 10;
			super.parameters.ySections = 10;
		}
	}
}
