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
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.utils.Dictionary;
	import jp.nium.core.debug.Logger;
	import jp.nium.external.JavaScript;
	import jp.nium.utils.ClassUtil;
	import jp.progression.config.WebConfig;
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.data.WebDataHolder;
	import jp.progression.events.ProcessEvent;
	import jp.progression.events.SceneEvent;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneId;
	import jp.progression.scenes.SceneObject;
	
	/**
	 * <p>WebSynchronizer クラスは、WebConfig 実装時に SWFAddress ライブラリを使用したディープリンク機能などを実装するクラスです。</p>
	 * <p></p>
	 * 
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event( name="complete", type="flash.events.Event" )]
	
	/**
	 * @private
	 */
	public class WebSynchronizer extends EventDispatcher implements ISynchronizer {
		
		/**
		 * 同期対象となっている Progression インスタンスを取得します。
		 */
		private static var _syncedTarget:Progression;
		
		/**
		 * 全てのインスタンスを保存した Dictionary インスタンスを取得します。
		 */
		private static var _instances:Dictionary = new Dictionary( true );
		
		/**
		 * 登録されたインスタンス数を取得します。
		 */
		private static var _numInstances:uint = 0;
		
		
		
		
		
		/**
		 * <p>関連付けられている Progression インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get target():Progression { return _target; }
		private var _target:Progression;
		
		/**
		 * <p>現在同期中の Progression インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get syncedTarget():Progression { return _syncedTarget; }
		
		/**
		 * <p>起点となるシーン識別子を取得します。</p>
		 * <p></p>
		 */
		public function get sceneId():SceneId { return _sceneId; }
		private var _sceneId:SceneId;
		
		/**
		 * <p>同期機能が有効化されているかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		public function get enabled():Boolean { return _enabled; }
		public function set enabled( value:Boolean ):void {
			if ( _enabled = value ) {
				// 他のシンクロナイザを停止する
				for ( var otherSynchronizer:* in _instances ) {
					if ( otherSynchronizer == this ) { continue; }
					otherSynchronizer.enabled = false;
				}
				
				// プレイヤーを判別する
				switch ( Capabilities.playerType ) {
					case "ActiveX"		: { break; }
					case "External"		: { _enabled = false; break; }
					case "PlugIn"		: { break; }
					case "StandAlone"	:
					case "Desktop"		: { _enabled = false; break; }
				}
				
				// 同期対象として設定する
				_syncedTarget = _target;
				
				// 情報を表示する
				Logger.info( Logger.getLog( L10NProgressionMsg.INFO_000 ).toString( "SWFAddress" ) );
				
				// イベントリスナーを登録する
				SWFAddress.addEventListener( SWFAddressEvent.CHANGE, _change );
				_target.addEventListener( ProcessEvent.PROCESS_COMPLETE, _processCompleteAndSceneQueryChange );
				_target.root.sceneInfo.addEventListener( SceneEvent.SCENE_QUERY_CHANGE, _processCompleteAndSceneQueryChange );
			}
			else {
				// 有効化されているシンクロナイザが存在するかどうかを確認する
				var exists:Boolean = false;
				for ( var targetSynchronizer:* in _instances ) {
					if ( !targetSynchronizer.enabled ) { continue; }
					exists = true;
				}
				
				// 存在しなければ同期対象を null にする
				if ( !exists ) {
					_syncedTarget = null;
				}
				
				// イベントリスナーを解除する
				SWFAddress.removeEventListener( SWFAddressEvent.CHANGE, _change );
				_target.removeEventListener( ProcessEvent.PROCESS_COMPLETE, _processCompleteAndSceneQueryChange );
				_target.root.sceneInfo.removeEventListener( SceneEvent.SCENE_QUERY_CHANGE, _processCompleteAndSceneQueryChange );
				
				// 対象シーンが存在すれば
				if ( _scene ) {
					// イベントリスナーを解除する
					_scene.removeEventListener( SceneEvent.SCENE_TITLE_CHANGE, _sceneTitleChange );
					
					// 破棄する
					_scene = null;
				}
			}
		}
		private var _enabled:Boolean = false;
		
		/**
		 * すでに開始されているかどうかを取得します。
		 */
		private var _started:Boolean = false;
		
		/**
		 * SceneObject インスタンスを取得します。
		 */
		private var _scene:SceneObject;
		
		/**
		 * URLLoader インスタンスを取得します。
		 */
		private var _loader:URLLoader;
		
		
		
		
		
		/**
		 * <p>新しい WebSynchronizer インスタンスを作成します。</p>
		 * <p>Creates a new WebSynchronizer object.</p>
		 * 
		 * @param target
		 * <p>関連付けたい Progression インスタンスです。</p>
		 * <p></p>
		 */
		public function WebSynchronizer( target:Progression ) {
			// 引数を設定する
			_target = target;
			
			// ルートシーン識別子を取得する
			var scenePath:String = "/" + target.id;
			var fragmentPath:String = JavaScript.locationHref.split( "#" )[1] || "";
			
			// シーンパスの書式が正しければ
			if ( SceneId.validatePath( scenePath + fragmentPath ) ) {
				scenePath += fragmentPath;
			}
			
			// 初期シーン識別子を設定する
			_sceneId = new SceneId( scenePath );
			
			// 登録する
			_instances[this] = _numInstances++;
		}
		
		
		
		
		
		/**
		 * <p>同期を開始します。</p>
		 * <p></p>
		 */
		public function start():void {
			// すでに開始されていれば例外をスローする
			if ( _started ) { throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_020 ).toString( ClassUtil.getClassName( this ) ) ); }
			
			// 同期を開始する
			_started = true;
			
			// 現在の環境設定を取得します。
			var config:WebConfig = Progression.config as WebConfig;
			
			// 環境設定が WebConfig ではない、または HTMLInjection を使用しないのであれば終了する
			if ( !config || !config.useHTMLInjection ) {
				// イベントを送出する
				super.dispatchEvent( new Event( Event.COMPLETE ) );
				return;
			}
			
			// 同期候補の HTML ファイルの URL を取得する
			var url:String;
			if ( JavaScript.enabled ) {
				url = JavaScript.locationHref;
			}
			else {
				url = _target.root.container.loaderInfo.url.replace( new RegExp( ".swf$" ), ".html" );
				
				// 警告を表示する
				Logger.warn( Logger.getLog( L10NProgressionMsg.WARN_000 ).toString() );
			}
			
			// URLLoader を作成する
			_loader = new URLLoader();
			
			// イベントリスナーを設定する
			_loader.addEventListener( Event.COMPLETE, _complete );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, _ioAndSecurityError );
			_loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, _ioAndSecurityError );
			
			// データを読み込む
			_loader.load( new URLRequest( url ) );
		}
		
		/**
		 * <p>破棄します。</p>
		 * <p></p>
		 */
		public function dispose():void {
			// 無効化する
			enabled = false;
			
			// 破棄する
			_target = null;
		}
		
		
		
		
		
		/**
		 * 
		 */
		private function _complete( e:Event ):void {
			// イベントリスナーを解除する
			_loader.removeEventListener( Event.COMPLETE, _complete );
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, _ioAndSecurityError );
			_loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, _ioAndSecurityError );
			
			try {
				// データを取得する
				var data:String = String( _loader.data );
				
				// ネームスペースを破棄する
				data = data.replace( new RegExp( 'xmlns=".*"', "g" ), "" );
				
				// データを登録する
				WebDataHolder.progression_internal::$html = new XML( data );
			}
			catch ( e:Error ) {
				// データを登録する
				WebDataHolder.progression_internal::$html = null;
			}
			
			// 情報を表示する
			Logger.info( Logger.getLog( L10NProgressionMsg.INFO_002 ).toString() );
			
			// 破棄する
			_loader = null;
			
			// イベントを送出する
			super.dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		/**
		 * 
		 */
		private function _ioAndSecurityError( e:Event ):void {
			// イベントリスナーを解除する
			_loader.removeEventListener( Event.COMPLETE, _complete );
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, _ioAndSecurityError );
			_loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, _ioAndSecurityError );
			
			// 破棄する
			_loader = null;
			
			// 情報を表示する
			Logger.warn( Logger.getLog( L10NProgressionMsg.WARN_001 ).toString() );
			
			// イベントを送出する
			super.dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		/**
		 * 
		 */
		private function _change( e:SWFAddressEvent ):void {
			// 現在地が NaS であれば終了する
			if ( SceneId.isNaS( _target.currentSceneId ) ) { return; }
			
			// 発行されるパスを取得する
			var path:String = SWFAddress.getValue();
			
			// path が / であればルートシーンに移動する
			if ( path == "/" ) {
				_target.goto( _target.root.sceneId );
				return;
			}
			
			// 書式が正しくなければ終了する
			if ( !SceneId.validatePath( path ) ) { return; }
			
			// 移動する
			_target.goto( new SceneId( "/" + _target.id + path ) );
		}
		
		/**
		 * 
		 */
		private function _processCompleteAndSceneQueryChange( e:Event ):void {
			if ( _scene ) {
				// イベントリスナーを解除する
				_scene.removeEventListener( SceneEvent.SCENE_TITLE_CHANGE, _sceneTitleChange );
			}
			
			// 現在のシーンを設定する
			_scene = _target.current;
			
			if ( _scene ) {
				// 発行するパスを取得する
				var sceneId:SceneId = _target.destinedSceneId || _target.root.sceneId;
				var path:String = sceneId.toShortPath();
				
				// URL を発行する
				if ( SWFAddress.getValue() != path ) {
					SWFAddress.setValue( sceneId.toShortPath() );
				}
				
				// タイトルを設定する
				if ( _scene.title ) {
					SWFAddress.setTitle( _scene.title );
				}
				
				// イベントリスナーを登録する
				_scene.addEventListener( SceneEvent.SCENE_TITLE_CHANGE, _sceneTitleChange, false, 0, true );
			}
		}
		
		/**
		 * シーンオブジェクトの title プロパティが変更された場合に送出されます。
		 */
		private function _sceneTitleChange( e:SceneEvent ):void {
			// タイトルを設定する
			if ( e.target.title ) {
				SWFAddress.setTitle( e.target.title );
			}
		}
	}
}
