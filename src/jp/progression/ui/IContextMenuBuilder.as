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
package jp.progression.ui {
	import flash.display.InteractiveObject;
	
	/**
	 * <p>IContextMenuBuilder インターフェイスは、対象にコンテクストメニュー機能を実装します。</p>
	 * <p></p>
	 */
	public interface IContextMenuBuilder {
		
		/**
		 * <p>関連付けられている InteractiveObject インスタンスを取得します。</p>
		 * <p></p>
		 */
		function get target():InteractiveObject;
		
		/**
		 * <p>保持しているデータを解放します。
		 * dispose() メソッドが呼び出されると、それ以降はこのインスタンスのメソッドまたはプロパティを呼び出すと失敗し、例外がスローされます。</p>
		 * <p></p>
		 */
		function dispose():void;
	}
}
