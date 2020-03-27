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
package jp.progression.scenes {
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.system.ApplicationDomain;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.net.Query;
	import jp.progression.casts.CastDocument;
	import jp.progression.core.components.ComponentProperties;
	import jp.progression.core.components.loader.ILoaderComp;
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.events.ManagerEvent;
	import jp.progression.events.SceneEvent;
	
	/**
	 * <p>query プロパティの値が更新された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_QUERY_CHANGE
	 */
	[Event( name="sceneQueryChange", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <p>読み込み操作が開始したときに送出されます。</p>
	 * <p>Dispatched when a load operation starts.</p>
	 * 
	 * @eventType flash.events.Event.OPEN
	 */
	[Event( name="open", type="flash.events.Event" )]
	
	/**
	 * <p>ロードされた SWF ファイルのプロパティおよびメソッドがアクセス可能で使用できる状態の場合に送出されます。</p>
	 * <p>Dispatched when the properties and methods of a loaded SWF file are accessible and ready for use.</p>
	 * 
	 * @eventType flash.events.Event.INIT
	 */
	[Event( name="init", type="flash.events.Event" )]
	
	/**
	 * <p>データが正常にロードされたときに送出されます。</p>
	 * <p>Dispatched when data has loaded successfully.</p>
	 * 
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event( name="complete", type="flash.events.Event" )]
	
	/**
	 * <p>読み込まれたオブジェクトが SceneLoader オブジェクトの unload() メソッドを使用して削除されるたびに、SceneInfo オブジェクトによって送出されます。または 2 番目の読み込みが同じ SceneLoader オブジェクトによって実行され、読み込み開始前に元のコンテンツが削除された場合に、LSceneInfo オブジェクトによって送出されます。</p>
	 * <p>Dispatched by a SceneInfo object whenever a loaded object is removed by using the unload() method of the SceneLoader object, or when a second load is performed by the same SceneLoader object and the original content is removed prior to the load beginning.</p>
	 * 
	 * @eventType flash.events.Event.UNLOAD
	 */
	[Event( name="unload", type="flash.events.Event" )]
	
	/**
	 * <p>ダウンロード処理を実行中にデータを受信したときに送出されます。</p>
	 * <p>Dispatched when data is received as the download operation progresses.</p>
	 * 
	 * @eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event( name="progress", type="flash.events.ProgressEvent" )]
	
	/**
	 * <p>ネットワーク要求が HTTP を介して行われ、HTTP ステータスコードを検出できる場合に送出されます。</p>
	 * <p>Dispatched when a network request is made over HTTP and an HTTP status code can be detected.</p>
	 * 
	 * @eventType flash.events.HTTPStatusEvent.HTTP_STATUS
	 */
	[Event( name="httpStatus", type="flash.events.HTTPStatusEvent" )]
	
	/**
	 * <p>入出力エラーが発生して読み込み処理が失敗したときに送出されます。</p>
	 * <p>Dispatched when an input or output error occurs that causes a load operation to fail.</p>
	 * 
	 * @eventType flash.events.IOErrorEvent.IO_ERROR
	 */
	[Event( name="ioError", type="flash.events.IOErrorEvent" )]
	
	
	/**
	 * <p>SceneInfo クラスは、SceneObject インスタンスに関する情報を提供します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class SceneInfo extends EventDispatcher {
		
		/**
		 * パッケージ内からの呼び出しかどうかを取得します。
		 */
		private static var _internallyCalled:Boolean = false;
		
		
		
		
		
		/**
		 * <p>この SceneInfo オブジェクトに関係した読み込まれたオブジェクトです。</p>
		 * <p>The loaded object associated with this SceneInfo object.</p>
		 */
		public function get content():SceneObject { return _content; }
		private var _content:SceneObject;
		
		/**
		 * <p>この SceneInfo オブジェクトに関係した SceneLoader オブジェクトです。</p>
		 * <p>The SceneLoader object associated with this SceneInfo object.</p>
		 */
		public function get loader():SceneLoader { return _loader; }
		private var _loader:SceneLoader;
		
		/**
		 * <p>シーン移動時に渡させるクエリオブジェクトを取得します。</p>
		 * <p></p>
		 */
		public function get query():Query { return _query; }
		private var _query:Query;
		
		/**
		 * @private
		 */
		progression_internal function get $query():Query { return _query; }
		progression_internal function set $query( value:Query ):void {
			_query = value;
			
			// イベントを送出する
			super.dispatchEvent( new SceneEvent( SceneEvent.SCENE_QUERY_CHANGE ) );
		}
		
		/**
		 * <p>読み込み済みの SWF ファイルの ActionScript バージョンです。</p>
		 * <p>The ActionScript version of the loaded SWF file.</p>
		 */
		public function get actionScriptVersion():int { return _loaderInfo.actionScriptVersion; }
		
		/**
		 * <p>外部 SWF ファイルが読み込まれると、読み込まれたクラスに含まれているすべての ActionScript 3.0 定義は applicationDomain プロパティに保持されます。</p>
		 * <p>When an external SWF file is loaded, all ActionScript 3.0 definitions contained in the loaded class are stored in the applicationDomain property.</p>
		 */
		public function get applicationDomain():ApplicationDomain { return _loaderInfo.applicationDomain; }
		
		/**
		 * <p>そのメディアの読み込み済みのバイト数です。</p>
		 * <p>The number of bytes that are loaded for the media.</p>
		 */
		public function get bytesLoaded():int { return _loaderInfo.bytesLoaded; }
		
		/**
		 * <p>メディアファイル全体の圧縮後のバイト数です。</p>
		 * <p>The number of compressed bytes in the entire media file.</p>
		 */
		public function get bytesTotal():int { return _loaderInfo.bytesTotal; }
		
		/**
		 * <p>コンテンツ（子）から読み込む側（親）への信頼関係を表します。</p>
		 * <p>Expresses the trust relationship from content (child) to the Loader (parent).</p>
		 */
		public function get childAllowsParent():Boolean { return _loaderInfo.childAllowsParent; }
		
		/**
		 * <p>読み込まれたファイルの MIME タイプです。</p>
		 * <p>The MIME type of the loaded file.</p>
		 */
		public function get contentType():String { return _loaderInfo.contentType; }
		
		/**
		 * <p>読み込み済みの SWF ファイルに関する 1 秒ごとのフレーム数を表す公称のフレームレートです。</p>
		 * <p>The nominal frame rate, in frames per second, of the loaded SWF file.</p>
		 */
		public function get frameRate():Number { return _loaderInfo.frameRate; }
		
		/**
		 * <p>この SceneInfo オブジェクトによって記述されるメディアの読み込みを開始した SWF ファイルの URL です。</p>
		 * <p>The URL of the SWF file that initiated the loading of the media described by this SceneInfo object.</p>
		 */
		public function get loaderURL():String { return _loaderInfo.loaderURL; }
		
		/**
		 * <p>読み込む側（親）からコンテンツ（子）への信頼関係を表します。</p>
		 * <p>Expresses the trust relationship from Loader (parent) to the content (child).</p>
		 */
		public function get parentAllowsChild():Boolean { return _loaderInfo.parentAllowsChild; }
		
		/**
		 * <p>ロード済みの SWF ファイルに提供されるパラメータを表す、名前と値の組を含んだオブジェクトです。</p>
		 * <p>An object that contains name-value pairs that represent the parameters provided to the loaded SWF file.</p>
		 */
		public function get parameters():Object { return _loaderInfo.parameters; }
		
		/**
		 * <p>ロードする側とそのコンテンツの間のドメインの関係を次のように表します。ドメインが同じ場合は true、異なる場合は false です。</p>
		 * <p>Expresses the domain relationship between the loader and the content: true if they have the same origin domain; false otherwise.</p>
		 */
		public function get sameDomain():Boolean { return _loaderInfo.sameDomain; }
		
		/**
		 * <p>読み込み済みの SWF ファイルのファイル形式のバージョンです。</p>
		 * <p>The file format version of the loaded SWF file.</p>
		 */
		public function get swfVersion():int { return _loaderInfo.swfVersion; }
		
		/**
		 * <p>読み込まれるメディアの URL です。</p>
		 * <p>The URL of the media being loaded.</p>
		 */
		public function get url():String { return _loaderInfo.url; }
		
		/**
		 * LoaderInfo インスタンスを取得します。
		 */
		private var _loaderInfo:LoaderInfo;
		
		/**
		 * CastDocument インスタンスを取得します。
		 */
		private var _document:CastDocument;
		
		/**
		 * ILoaderComp インスタンスを取得します。
		 */
		private var _loaderComp:ILoaderComp;
		
		
		
		
		
		/**
		 * <p>新しい SceneInfo インスタンスを作成します。</p>
		 * <p>Creates a new SceneInfo object.</p>
		 */
		public function SceneInfo() {
			// パッケージ外から呼び出されたら例外をスローする
			if ( !_internallyCalled ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_008 ).toString( "SceneInfo" ) ); };
			
			// Query を作成する
			_query = new Query( null, true );
			
			// 初期化する
			_internallyCalled = false;
		}
		
		
		
		
		
		/**
		 * @private
		 */
		progression_internal static function $createInstance( content:SceneObject, loader:SceneLoader, loaderInfo:LoaderInfo ):SceneInfo {
			_internallyCalled = true;
			
			// SceneInfo を作成する
			var sceneInfo:SceneInfo = new SceneInfo();
			sceneInfo._content = content;
			sceneInfo._loader = loader;
			sceneInfo._loaderInfo = loaderInfo;
			
			// イベントリスナーを登録する
			loaderInfo.addEventListener( Event.OPEN, sceneInfo._open );
			loaderInfo.addEventListener( Event.INIT, sceneInfo._init );
			loaderInfo.addEventListener( Event.COMPLETE, sceneInfo._complete );
			loaderInfo.addEventListener( Event.UNLOAD, sceneInfo._unload );
			loaderInfo.addEventListener( ProgressEvent.PROGRESS, sceneInfo._progress );
			loaderInfo.addEventListener( HTTPStatusEvent.HTTP_STATUS, sceneInfo._httpStatus );
			loaderInfo.addEventListener( IOErrorEvent.IO_ERROR, sceneInfo._ioError );
			
			return sceneInfo;
		}
		
		
		
		
		
		/**
		 * @private
		 */
		progression_internal function $dispose():void {
			// イベントリスナーを解除する
			_loaderInfo.removeEventListener( Event.OPEN, _open );
			_loaderInfo.removeEventListener( Event.INIT, _init );
			_loaderInfo.removeEventListener( Event.COMPLETE, _complete );
			_loaderInfo.removeEventListener( Event.UNLOAD, _unload );
			_loaderInfo.removeEventListener( ProgressEvent.PROGRESS, _progress );
			_loaderInfo.removeEventListener( HTTPStatusEvent.HTTP_STATUS, _httpStatus );
			_loaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			
			// 破棄する
			_content = null;
			_loader = null;
			_loaderInfo = null;
			_query = null;
		}
		
		/**
		 * @private
		 */
		public override function dispatchEvent( event:Event ):Boolean {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "dispatchEvent" ) );
		}
		
		
		
		
		
		/**
		 * 読み込み操作が開始したときに送出されます。
		 */
		private function _open( e:Event ):void {
			// イベントを送出する
			super.dispatchEvent( e );
		}
		
		/**
		 * ロードされた SWF ファイルのプロパティおよびメソッドがアクセス可能で使用できる状態の場合に送出されます。
		 */
		private function _init( e:Event ):void {
			// イベントを送出する
			super.dispatchEvent( e );
		}
		
		/**
		 * データが正常にロードされたときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// CastDocument を取得する
			_document = _loaderInfo.content as CastDocument;
			
			// ILoaderComp を取得する
			if ( _loaderInfo.content && ComponentProperties.CURRENT_LOADER in _loaderInfo.content ) {
				_loaderComp = _loaderInfo.content[ComponentProperties.CURRENT_LOADER];
			}
			
			switch ( true ) {
				case !!_document	: {
					// プロパティを初期化する
					_content = _document.manager.root.sceneInfo.content;
					_loader = _document.manager.root.sceneInfo.loader;
					
					// イベントを送出する
					super.dispatchEvent( new Event( Event.COMPLETE ) );
					return;
				}
				case !!_loaderComp	: {
					// イベントリスナーを登録する
					_loaderComp.addEventListener( ManagerEvent.MANAGER_ACTIVATE, _managerActivate );
					return;
				}
			}
			
			// イベントを送出する
			super.dispatchEvent( new IOErrorEvent( IOErrorEvent.IO_ERROR, false, false, Logger.getLog( L10NProgressionMsg.ERROR_016 ).toString() ) );
		}
		
		/**
		 * キャストオブジェクトと Progression インスタンスの関連付けがアクティブになったときに送出されます。
		 */
		private function _managerActivate( e:ManagerEvent ):void {
			// イベントリスナーを破棄する
			_loaderComp.removeEventListener( ManagerEvent.MANAGER_ACTIVATE, _managerActivate );
			
			// プロパティを初期化する
			_content = _loaderComp.manager.root.sceneInfo.content;
			_loader = _loaderComp.manager.root.sceneInfo.loader;
			
			// イベントを送出する
			super.dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		/**
		 * 読み込まれたオブジェクトが SceneLoader オブジェクトの unload() メソッドを使用して削除されるたびに、SceneInfo オブジェクトによって送出されます。または 2 番目の読み込みが同じ SceneLoader オブジェクトによって実行され、読み込み開始前に元のコンテンツが削除された場合に、LSceneInfo オブジェクトによって送出されます。<
		 */
		private function _unload( e:Event ):void {
			// 破棄する
			_document = null;
			_content = null;
			_loader = null;
			
			// イベントを送出する
			super.dispatchEvent( e );
		}
		
		/**
		 * ダウンロード処理を実行中にデータを受信したときに送出されます。
		 */
		private function _progress( e:ProgressEvent ):void {
			// イベントを送出する
			super.dispatchEvent( e );
		}
		
		/**
		 * ネットワーク要求が HTTP を介して行われ、HTTP ステータスコードを検出できる場合に送出されます。
		 */
		private function _httpStatus( e:HTTPStatusEvent ):void {
			// イベントを送出する
			super.dispatchEvent( e );
		}
		
		/**
		 * 入出力エラーが発生して読み込み処理が失敗したときに送出されます。
		 */
		private function _ioError( e:IOErrorEvent ):void {
			// イベントを送出する
			super.dispatchEvent( e );
		}
	}
}
