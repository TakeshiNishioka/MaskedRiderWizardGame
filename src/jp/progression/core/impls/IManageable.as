﻿/**
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
package jp.progression.core.impls {
	import flash.events.IEventDispatcher;
	import jp.progression.Progression;
	
	/**
	 * @private
	 */
	public interface IManageable extends IEventDispatcher {
		
		/**
		 * <p>関連付けられている Progression インスタンスを取得します。</p>
		 * <p></p>
		 */
		function get manager():Progression;
	}
}