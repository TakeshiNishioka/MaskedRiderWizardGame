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
	import flash.system.Capabilities;
	import jp.nium.core.debug.Logger;
	import jp.progression.core.config.Configuration;
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.core.managers.WebInitializer;
	import jp.progression.core.managers.WebSynchronizer;
	import jp.progression.data.WebDataHolder;
	import jp.progression.executors.CommandExecutor;
	import jp.progression.ui.ToolTip;
	import jp.progression.ui.WebContextMenuBuilder;
	import jp.progression.ui.WebKeyboardMapper;
	
	/**
	 * <p>WebConfig クラスは、Progression を Web サイト制作に特化したモードで動作させるための環境設定クラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // WebConfig を作成する
	 * var config:WebConfig = new WebConfig();
	 * 
	 * // Progression を初期化する
	 * Progression.initialize( config );
	 * 
	 * // Progression インスタンスを作成する
	 * var manager:Progression = new Progression( "index", stage );
	 * </listing>
	 */
	public class WebConfig extends Configuration {
		
		/**
		 * <p>SWFWheel を有効化するかどうかを取得します。</p>
		 * <p></p>
		 */
		public function get useSWFWheel():Boolean { return _useSWFWheel; }
		private var _useSWFWheel:Boolean = true;
		
		/**
		 * <p>SWFSize を有効化するかどうかを取得します。</p>
		 * <p></p>
		 */
		public function get useSWFSize():Boolean { return _useSWFSize; }
		private var _useSWFSize:Boolean = true;
		
		/**
		 * <p>HTML インジェクション機能を有効化するかどうかを取得します。</p>
		 * <p></p>
		 */
		public function get useHTMLInjection():Boolean { return _useHTMLInjection; }
		private var _useHTMLInjection:Boolean = true;
		
		
		
		
		
		/**
		 * <p>新しい WebConfig インスタンスを作成します。</p>
		 * <p>Creates a new WebConfig object.</p>
		 * 
		 * @param useSWFWheel
		 * <p>SWFWheel を有効化するかどうかです。</p>
		 * <p></p>
		 * @param SWFSize
		 * <p>SWFSize を有効化するかどうかです。</p>
		 * <p></p>
		 * @param useHTMLInjector
		 * <p>HTML インジェクション機能を有効化するかどうかです。</p>
		 * <p></p>
		 */
		public function WebConfig( useSWFWheel:Boolean = true, useSWFSize:Boolean = true, useHTMLInjector:Boolean = true ) {
			// 引数を設定する
			_useSWFWheel = useSWFWheel;
			_useSWFSize = useSWFSize;
			_useHTMLInjection = useHTMLInjector;
			
			// 親クラスを初期化する
			super( WebInitializer, WebSynchronizer, CommandExecutor, WebKeyboardMapper, WebContextMenuBuilder, ToolTip, WebDataHolder );
			
			// プレイヤーを判別する
			switch ( Capabilities.playerType ) {
				case "ActiveX"		:
				case "External"		:
				case "PlugIn"		:
				case "StandAlone"	: { break; }
				case "Desktop"		: { throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_000 ).toString( super.className ) ); }
			}
		}
	}
}
