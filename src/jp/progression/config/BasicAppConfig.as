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
package jp.progression.config {
	import jp.progression.core.config.Configuration;
	import jp.progression.executors.CommandExecutor;
	import jp.progression.ui.ContextMenuBuilder;
	import jp.progression.ui.ToolTip;
	
	/**
	 * <p>BasicAppConfig クラスは、Progression の非同期処理をコマンドを使用して動作させるための環境設定クラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // BasicAppConfig を作成する
	 * var config:BasicAppConfig = new BasicAppConfig();
	 * 
	 * // Progression を初期化する
	 * Progression.initialize( config );
	 * 
	 * // Progression インスタンスを作成する
	 * var manager:Progression = new Progression( "index", stage );
	 * </listing>
	 */
	public class BasicAppConfig extends Configuration {
		
		/**
		 * <p>新しい BasicAppConfig インスタンスを作成します。</p>
		 * <p>Creates a new BasicAppConfig object.</p>
		 */
		public function BasicAppConfig() {
			// 親クラスを初期化する
			super( null, null, CommandExecutor, null, ContextMenuBuilder, ToolTip, null );
		}
	}
}
