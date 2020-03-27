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
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.scenes.SceneId;
	
	/**
	 * <p>RollOverButton クラスは、任意のシーンに移動するボタン機能を提供するコンポーネントクラスです。
	 * このクラスを使用するためには、CommandExecutor が実装される環境設定（BasicAppConfig、WebConfig、等）を使用する必要があります。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // RollOverButton インスタンスを作成する
	 * var cast:RollOverButton = new RollOverButton();
	 * </listing>
	 */
	public class RollOverButton extends ButtonBase {
		
		/**
		 * <p>ボタンがクリックされた時の移動先を示すシーンパスを取得または設定します。</p>
		 * <p></p>
		 */
		public function get scenePath():String { return _scenePath; }
		public function set scenePath( value:String ):void {
			// 書式が正しければ
			if ( SceneId.validatePath( value ) ) {
				// sceneId を設定する
				super.sceneId = new SceneId( value );
				
				// 更新する
				_scenePath = value;
			}
			else if ( value ) {
				Logger.warn( Logger.getLog( L10NProgressionMsg.ERROR_013 ).toString( value ) );
			}
		}
		private var _scenePath:String;
		
		/**
		 * @private
		 */
		public override function get sceneId():SceneId { return super.sceneId; }
		public override function set sceneId( value:SceneId ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "sceneId" ) ); }
		
		/**
		 * @private
		 */
		public override function get href():String { return super.href; }
		public override function set href( value:String ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "href" ) ); }
		
		
		
		
		
		/**
		 * <p>新しい RollOverButton インスタンスを作成します。</p>
		 * <p>Creates a new RollOverButton object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function RollOverButton( initObject:Object = null ) {
			// 親クラスを初期化する
			super( initObject );
		}
	}
}
