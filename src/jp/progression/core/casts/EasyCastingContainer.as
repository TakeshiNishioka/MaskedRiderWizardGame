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
package jp.progression.core.casts {
	import jp.progression.casts.CastSprite;
	import jp.progression.Progression;
	import jp.progression.scenes.EasyCastingScene;
	
	/**
	 * @private
	 * </listing>
	 */
	public class EasyCastingContainer extends CastSprite {
		
		/**
		 * <p>関連付けられている Progression インスタンスを取得します。</p>
		 * <p></p>
		 */
		public override function get manager():Progression { return _scene.manager; }
		
		/**
		 * EasyCastingScene インスタンスを取得します。
		 */
		private var _scene:EasyCastingScene;
		
		
		
		
		
		/**
		 * <p>新しい EasyCastingContainer インスタンスを作成します。</p>
		 * <p>Creates a new EasyCastingContainer object.</p>
		 * 
		 * @param scene
		 * <p>関連付けたい EasyCastingScene インスタンスです。</p>
		 * <p></p>
		 */
		public function EasyCastingContainer( scene:EasyCastingScene ) {
			// 引数を設定する
			_scene = scene;
		}
	}
}
