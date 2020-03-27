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
	import fl.transitions.Photo;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.core.casts.EffectBase;
	
	/**
	 * <p>写真のフラッシュのようにムービークリップオブジェクトの表示 / 非表示を切り替えます。
	 * このクラスを使用するためには、CommandExecutor が実装される環境設定（BasicAppConfig、WebConfig、等）を使用する必要があります。</p>
	 * <p>Makes the movie clip object appear or disappear like a photographic flash.</p>
	 * 
	 * @example <listing version="3.0" >
	 * // PhotoEffect インスタンスを作成する
	 * var cast:PhotoEffect = new PhotoEffect();
	 * </listing>
	 */
	public class PhotoEffect extends EffectBase {
		
		/**
		 * @private
		 */
		public override function get parameters():Object { return {}; }
		public override function set parameters( value:Object ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "parameters" ) ); }
		
		
		
		
		/**
		 * <p>新しい PhotoEffect インスタンスを作成します。</p>
		 * <p>Creates a new PhotoEffect object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function PhotoEffect( initObject:Object = null ) {
			// 親クラスを初期化する
			super( Photo, initObject );
		}
	}
}
