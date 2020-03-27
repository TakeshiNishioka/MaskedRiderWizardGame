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
package jp.progression.core.managers {
	import flash.events.IEventDispatcher;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneId;
	
	/**
	 * @private
	 */
	public interface ISynchronizer extends IEventDispatcher {
		
		/**
		 * <p>関連付けられている Progression インスタンスを取得します。</p>
		 * <p></p>
		 */
		function get target():Progression;
		
		/**
		 * <p>現在同期中の Progression インスタンスを取得します。</p>
		 * <p></p>
		 */
		function get syncedTarget():Progression;
		
		/**
		 * <p>起点となるシーン識別子を取得します。</p>
		 * <p></p>
		 */
		function get sceneId():SceneId;
		
		/**
		 * <p>同期機能が有効化されているかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		function get enabled():Boolean;
		function set enabled( value:Boolean ):void;
		
		
		
		
		
		/**
		 * <p>同期を開始します。</p>
		 * <p></p>
		 */
		function start():void;
		
		/**
		 * <p>破棄します。</p>
		 * <p></p>
		 */
		function dispose():void;
	}
}
