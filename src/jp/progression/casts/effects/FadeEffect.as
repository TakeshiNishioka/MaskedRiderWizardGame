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
	import fl.transitions.Fade;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.core.casts.EffectBase;
	
	/**
	 * <p>FadeEffect クラスは、ムービークリップオブジェクトをフェードインまたはフェードアウトします。
	 * このクラスを使用するためには、CommandExecutor が実装される環境設定（BasicAppConfig、WebConfig、等）を使用する必要があります。</p>
	 * <p>The FadeEffect class fades the movie clip object in or out.</p>
	 * 
	 * @example <listing version="3.0" >
	 * // FadeEffect インスタンスを作成する
	 * var cast:FadeEffect = new FadeEffect();
	 * </listing>
	 */
	public class FadeEffect extends EffectBase {
		
		/**
		 * @private
		 */
		public override function get parameters():Object { return {}; }
		public override function set parameters( value:Object ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "parameters" ) ); }
		
		
		
		
		
		/**
		 * <p>新しい FadeEffect インスタンスを作成します。</p>
		 * <p>Creates a new FadeEffect object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function FadeEffect( initObject:Object = null ) {
			// 親クラスを初期化する
			super( Fade, initObject );
		}
	}
}
