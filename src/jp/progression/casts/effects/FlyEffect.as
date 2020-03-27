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
	import fl.transitions.Fly;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.core.casts.EffectBase;
	
	/**
	 * <p>FlyEffect クラスは、指定した方向からムービークリップオブジェクトをスライドインします。
	 * このクラスを使用するためには、CommandExecutor が実装される環境設定（BasicAppConfig、WebConfig、等）を使用する必要があります。</p>
	 * <p>The FlyEffect class slides the movie clip object in from a specified direction.</p>
	 * 
	 * @example <listing version="3.0" >
	 * // FlyEffect インスタンスを作成する
	 * var cast:FlyEffect = new FlyEffect();
	 * </listing>
	 */
	public class FlyEffect extends EffectBase {
		
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
		 * <p>新しい FlyEffect インスタンスを作成します。</p>
		 * <p>Creates a new FlyEffect object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function FlyEffect( initObject:Object = null ) {
			// 親クラスを初期化する
			super( Fly, initObject );
			
			// 初期化する
			super.parameters.startPoint = 5;
		}
	}
}
