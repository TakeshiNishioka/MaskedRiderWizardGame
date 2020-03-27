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
	import fl.transitions.Zoom;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.core.casts.EffectBase;
	
	/**
	 * <p>ZoomEffect クラスは、縦横比を維持しながら拡大 / 縮小することで、ムービークリップオブジェクトをズームインまたはズームアウトします。
	 * このクラスを使用するためには、CommandExecutor が実装される環境設定（BasicAppConfig、WebConfig、等）を使用する必要があります。</p>
	 * <p>The ZoomEffect class zooms the movie clip object in or out by scaling it in proportion.</p>
	 * 
	 * @example <listing version="3.0" >
	 * // ZoomEffect インスタンスを作成する
	 * var cast:ZoomEffect = new ZoomEffect();
	 * </listing>
	 */
	public class ZoomEffect extends EffectBase {
		
		/**
		 * @private
		 */
		public override function get parameters():Object { return {}; }
		public override function set parameters( value:Object ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "parameters" ) ); }
		
		
		
		
		/**
		 * <p>新しい ZoomEffect インスタンスを作成します。</p>
		 * <p>Creates a new ZoomEffect object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function ZoomEffect( initObject:Object = null ) {
			// 親クラスを初期化する
			super( Zoom, initObject );
		}
	}
}
