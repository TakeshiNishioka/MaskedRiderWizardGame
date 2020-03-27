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
	import flash.display.Sprite;
	import flash.events.Event;
	import jp.nium.core.debug.Logger;
	import jp.nium.utils.StageUtil;
	import jp.progression.config.WebConfig;
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.Progression;
	import org.libspark.ui.SWFSize;
	import org.libspark.ui.SWFWheel;
	
	/**
	 * @private
	 */
	public class WebInitializer implements IInitializer {
		
		/**
		 * <p>関連付けられている Progression インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get target():Progression { return _target; }
		private var _target:Progression;
		
		
		
		
		
		/**
		 * <p>新しい WebInitializer インスタンスを作成します。</p>
		 * <p>Creates a new WebInitializer object.</p>
		 * 
		 * @param target
		 * <p>関連付けたい Progression インスタンスです。</p>
		 * <p></p>
		 */
		public function WebInitializer( target:Progression ) {
			// 引数を設定する
			_target = target;
			
			// 現在の環境設定を取得します。
			var config:WebConfig = Progression.config as WebConfig;
			
			// 環境設定が WebConfig であり、SWFWheel を使用するのであれば
			if ( config && config.useSWFWheel ) {
				// SWFWheel を初期化する
				SWFWheel.initialize( _target.stage );
				
				// 情報を表示する
				Logger.info( Logger.getLog( L10NProgressionMsg.INFO_000 ).toString( "SWFWheel" ) );
			}
			
			// 環境設定が WebConfig ではない、または SWFSize を使用しないのであれば
			if ( !config || !config.useSWFSize ) { return; }
			
			// 既に読み込まれていれば
			if ( _target.stage.loaderInfo.bytesTotal > 0 && _target.stage.loaderInfo.bytesLoaded >= _target.stage.loaderInfo.bytesTotal ) {
				_complete( null );
			}
			else {
				_target.stage.loaderInfo.addEventListener( Event.COMPLETE, _complete );
			}
		}
		
		/**
		 * <p>破棄します。</p>
		 * <p></p>
		 */
		public function dispose():void {
			// 破棄する
			_target = null;
		}
		
		
		
		
		
		/**
		 * データが正常にロードされたときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// イベントリスナーを解除する
			_target.stage.loaderInfo.removeEventListener( Event.COMPLETE, _complete );
			
			// ルートを取得する
			var root:Sprite = StageUtil.getDocument( _target.stage );
			
			// SWFSize を初期化する
			SWFSize.initialize( root.loaderInfo.width, root.loaderInfo.height );
			
			// 情報を表示する
			Logger.info( Logger.getLog( L10NProgressionMsg.INFO_000 ).toString( "SWFSize" ) );
		}
	}
}
