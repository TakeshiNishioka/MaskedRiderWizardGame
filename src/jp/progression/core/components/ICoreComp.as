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
package jp.progression.core.components {
	import flash.display.MovieClip;
	import flash.events.IEventDispatcher;
	
	/**
	 * @private
	 */
	public interface ICoreComp extends IEventDispatcher {
		
		/**
		 * <p>コンポーネント効果を適用する対象 MovieClip インスタンスを取得します。</p>
		 * <p></p>
		 */
		function get target():MovieClip;
		
		/**
		 * <p>コンポーネントが有効化されているかどうかを取得します。</p>
		 * <p></p>
		 */
		function get enabled():Boolean;
	}
}
