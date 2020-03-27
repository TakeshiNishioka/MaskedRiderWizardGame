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
package jp.progression.casts.buttons {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.core.casts.ButtonBase;
	import jp.progression.scenes.SceneId;
	
	/**
	 * <p>AnchorButton クラスは、外部リンク機能を持ったボタン機能を提供するコンポーネントクラスです。
	 * このクラスを使用するためには、CommandExecutor が実装される環境設定（BasicAppConfig、WebConfig、等）を使用する必要があります。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // AnchorButton インスタンスを作成する
	 * var cast:AnchorButton = new AnchorButton();
	 * </listing>
	 */
	public class AnchorButton extends ButtonBase {
		
		/**
		 * @private
		 */
		public override function get sceneId():SceneId { return super.sceneId; }
		public override function set sceneId( value:SceneId ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "sceneId" ) ); }
		
		
		
		
		
		/**
		 * <p>新しい AnchorButton インスタンスを作成します。</p>
		 * <p>Creates a new AnchorButton object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function AnchorButton( initObject:Object = null ) {
			// 親クラスを初期化する
			super( initObject );
		}
	}
}
