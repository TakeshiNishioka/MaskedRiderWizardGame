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
	import jp.progression.executors.ResumeExecutor;
	import jp.progression.ui.ContextMenuBuilder;
	
	/**
	 * <p>LWAppConfig クラスは、軽量アプリケーションの開発に特化したモードで動作させるための環境設定クラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // LWAppConfig を作成する
	 * var config:LWAppConfig = new LWAppConfig();
	 * 
	 * // Progression を初期化する
	 * Progression.initialize( config );
	 * 
	 * // Progression インスタンスを作成する
	 * var manager:Progression = new Progression( "index", stage );
	 * </listing>
	 */
	public class LWAppConfig extends Configuration {
		
		/**
		 * <p>新しい LWAppConfig インスタンスを作成します。</p>
		 * <p>Creates a new LWAppConfig object.</p>
		 */
		public function LWAppConfig() {
			// 親クラスを初期化する
			super( null, null, ResumeExecutor, null, ContextMenuBuilder, null, null );
		}
	}
}
