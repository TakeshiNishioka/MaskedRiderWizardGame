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
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.casts.CastDocument;
	import jp.progression.core.components.ComponentProperties;
	import jp.progression.core.components.loader.ILoaderComp;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.events.ManagerEvent;
	import jp.progression.events.SceneEvent;
	
	/**
	 * <p>シーン移動時に目的地がシーンオブジェクト自身もしくは子階層であり、かつ自身が SWF ファイルを読み込んでいない状態で、SceneEvent.SCENE_LOAD イベントが発生する直前に送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_PRE_LOAD
	 */
	[Event( name="scenePreLoad", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <p>シーン移動時に目的地がシーンオブジェクト自身もしくは親階層であり、かつ自身がすでに SWF ファイルを読み込んでいる状態で、SceneEvent.SCENE_UNLOAD イベントが発生した直後に送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_POST_UNLOAD
	 */
	[Event( name="scenePostUnload", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <p>SceneLoader クラスは、自身以下のシーンリストを読み込んだ外部 SWF ファイルを使用して設計可能にするローダークラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // SceneLoader インスタンスを作成する
	 * var scene:SceneLoader = new SceneLoader();
	 * </listing>
	 */
	public class SceneLoader extends SceneObject {
		
		/**
		 * <p>読み込まれた SWF ファイル内に作成される SceneObject インスタンスの container プロパティの値を取得します。</p>
		 * <p></p>
		 */
		public function get loaderContainer():Sprite { return _loaderContainer; }
		private var _loaderContainer:Sprite;
		
		/**
		 * <p>読み込まれた SWF ファイルの CastDocument インスタンスに関連付けられているルートシーンを取得します。</p>
		 * <p></p>
		 */
		public function get content():SceneObject { return _content; }
		private var _content:SceneObject;
		
		/**
		 * <p>読み込まれた SWF ファイルに関連付けられている SceneInfo インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get contentSceneInfo():SceneInfo { return _contentSceneInfo; }
		private var _contentSceneInfo:SceneInfo;
		
		/**
		 * @private
		 */
		public override function get scenes():Array { return []; }
		
		/**
		 * @private
		 */
		public override function get numScenes():int { return 0; }
		
		/**
		 * Loader インスタンスを取得します。
		 */
		private var _loader:Loader;
		
		/**
		 * CastDocument インスタンスを取得します。
		 */
		private var _document:CastDocument;
		
		/**
		 * ILoaderComp インスタンスを取得します。
		 */
		private var _loaderComp:ILoaderComp;
		
		/**
		 * @private
		 */
		public override function get onSceneLoad():Function { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "onSceneLoad" ) ); }
		public override function set onSceneLoad( value:Function ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "onSceneLoad" ) ); }
		
		/**
		 * @private
		 */
		public override function get onSceneUnload():Function { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "onSceneUnload" ) ); }
		public override function set onSceneUnload( value:Function ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "onSceneUnload" ) ); }
		
		/**
		 * @private
		 */
		public override function get onSceneInit():Function { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "onSceneInit" ) ); }
		public override function set onSceneInit( value:Function ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "onSceneInit" ) ); }
		
		/**
		 * @private
		 */
		public override function get onSceneGoto():Function { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "onSceneGoto" ) ); }
		public override function set onSceneGoto( value:Function ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "onSceneGoto" ) ); }
		
		/**
		 * @private
		 */
		public override function get onSceneDescend():Function { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "onSceneDescend" ) ); }
		public override function set onSceneDescend( value:Function ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "onSceneDescend" ) ); }
		
		/**
		 * @private
		 */
		public override function get onSceneAscend():Function { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "onSceneAscend" ) ); }
		public override function set onSceneAscend( value:Function ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "onSceneAscend" ) ); }
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_PRE_LOAD イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#PRE_LOAD
		 */
		public function get onScenePreLoad():Function { return _onScenePreLoad; }
		public function set onScenePreLoad( value:Function ):void { _onScenePreLoad = value; }
		private var _onScenePreLoad:Function;
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_PRE_LOAD イベントを受け取った場合に呼び出されるオーバーライド・イベントハンドラメソッドです。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#PRE_LOAD
		 */
		protected function atScenePreLoad():void {}
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_POST_UNLOAD イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#POST_UNLOAD
		 */
		public function get onScenePostUnload():Function { return _onScenePostUnload; }
		public function set onScenePostUnload( value:Function ):void { _onScenePostUnload = value; }
		private var _onScenePostUnload:Function;
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_POST_UNLOAD イベントを受け取った場合に呼び出されるオーバーライド・イベントハンドラメソッドです。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#POST_UNLOAD
		 */
		protected function atScenePostUnload():void {}
		
		
		
		
		
		/**
		 * <p>新しい SceneLoader インスタンスを作成します。</p>
		 * <p>Creates a new SceneLoader object.</p>
		 * 
		 * @param name
		 * <p>シーンの名前です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function SceneLoader( name:String = null, initObject:Object = null ) {
			// 親クラスを初期化する
			super( name, initObject );
			
			// Loader を作成する
			_loader = new Loader();
			
			// SceneInfo を作成する
			_contentSceneInfo = SceneInfo.progression_internal::$createInstance( null, this, _loader.contentLoaderInfo );
			
			// イベントリスナーを登録する
			super.addEventListener( SceneEvent.SCENE_PRE_LOAD, _scenePreLoad, false, 0, true );
			super.addEventListener( SceneEvent.SCENE_POST_UNLOAD, _scenePostUnload, false, 0, true );
		}
		
		
		
		
		
		/**
		 * <p>SWF ファイルを、この SceneLoader オブジェクトの子であるオブジェクトにロードします。
		 * 読み込まれる SWF ファイルはドキュメントクラスに CastDocument クラスを継承している必要があります。</p>
		 * <p></p>
		 * 
		 * @param request
		 * <p>読み込む SWF ファイルの絶対 URL または相対 URL です。相対パスの場合は、メイン SWF ファイルを基準にする必要があります。絶対 URL の場合は、http:// や file:/// などのプロトコル参照も含める必要があります。ファイル名には、ドライブ指定を含めることはできません。</p>
		 * <p>The absolute or relative URL of the SWF file to be loaded. A relative path must be relative to the main SWF file. Absolute URLs must include the protocol reference, such as http:// or file:///. Filenames cannot include disk drive specifications.</p>
		 * @param loaderContainer
		 * <p>読み込まれた SWF ファイルの表示オブジェクトの基準となる Sprite です。</p>
		 * <p></p>
		 * @param checkPolicyFile
		 * <p>オブジェクトをロードする前に、URL ポリシーファイルの存在を確認するかどうかを指定します。</p>
		 * <p>Specifies whether a check should be made for the existence of a URL policy file before loading the object. </p>
		 * @param securityDomain
		 * <p>SceneLoader オブジェクトで使用する SecurityDomain オブジェクトを指定します。 </p>
		 * <p>Specifies the SecurityDomain object to use for a SceneLoader object. </p>
		 */
		public function load( request:URLRequest, loaderContainer:Sprite = null, checkPolicyFile:Boolean = false, securityDomain:SecurityDomain = null ):void {
			// 引数を設定する
			_loaderContainer = loaderContainer || container;
			
			// イベントリスナーを登録する
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, _complete, false, int.MAX_VALUE );
			_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, _ioError, false, int.MAX_VALUE );
			
			// 読み込む
			_loader.load( request, new LoaderContext( checkPolicyFile, ApplicationDomain.currentDomain, securityDomain ) );
		}
		
		/**
		 * <p>load() メソッドを使用して読み込まれた、この SceneLoader オブジェクトの子を削除します。</p>
		 * <p>Removes a child of this SceneLoader object that was loaded by using the load() method.</p>
		 */
		public function unload():void {
			// イベントリスナーを解除する
			_removeLoaderListeners();
			
			// CastDocument を破棄する
			if ( _document ) {
				_document.progression_internal::$dispose();
				_document = null;
			}
			
			// ILoaderComp を破棄する
			if ( _loaderComp ) {
				_loaderComp.progression_internal::$dispose();
				_loaderComp = null;
			}
			
			// Loader を破棄する
			_loader.unload();
			
			// 破棄する
			_loaderContainer = null;
			_content = null;
		}
		
		/**
		 * <p>SceneLoader インスタンスに対して現在進行中の load() メソッドの処理をキャンセルします。</p>
		 * <p>Cancels a load() method operation that is currently in progress for the SceneLoader instance.</p>
		 */
		public function close():void {
			if ( _loader ) {
				_loader.close();
			}
		}
		
		/**
		 * @private
		 */
		public override function addScene( scene:SceneObject ):SceneObject {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "addScene" ) );
		}
		
		/**
		 * @private
		 */
		public override function addSceneAt( scene:SceneObject, index:int ):SceneObject {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "addSceneAt" ) );
		}
		
		/**
		 * @private
		 */
		public override function addSceneAtAbove( scene:SceneObject, index:int ):SceneObject {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "addSceneAtAbove" ) );
		}
		
		/**
		 * @private
		 */
		public override function addSceneFromXML( prml:XML ):void {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "addSceneFromXML" ) );
		}
		
		/**
		 * @private
		 */
		public override function removeScene( scene:SceneObject ):SceneObject {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "removeScene" ) );
		}
		
		/**
		 * @private
		 */
		public override function removeSceneAt( index:int ):SceneObject {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "removeSceneAt" ) );
		}
		
		/**
		 * @private
		 */
		public override function removeAllScenes():void {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "removeAllScenes" ) );
		}
		
		/**
		 * @private
		 */
		public override function contains( scene:SceneObject ):Boolean {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "contains" ) );
		}
		
		/**
		 * @private
		 */
		public override function getSceneAt( index:int ):SceneObject {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "getSceneAt" ) );
		}
		
		/**
		 * @private
		 */
		public override function getSceneByName( name:String ):SceneObject {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "getSceneByName" ) );
		}
		
		/**
		 * @private
		 */
		public override function getSceneIndex( scene:SceneObject ):int {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "getSceneIndex" ) );
		}
		
		/**
		 * @private
		 */
		public override function setSceneIndex( scene:SceneObject, index:int ):void {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "setSceneIndex" ) );
		}
		
		/**
		 * @private
		 */
		public override function setSceneIndexAbove( scene:SceneObject, index:int ):void {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "setSceneIndexAbove" ) );
		}
		
		/**
		 * @private
		 */
		public override function swapScenes( scene1:SceneObject, scene2:SceneObject ):void {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "swapScenes" ) );
		}
		
		/**
		 * @private
		 */
		public override function swapScenesAt( index1:int, index2:int ):void {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "swapScenesAt" ) );
		}
		
		/**
		 * Loader のイベントリスナーを解除します。
		 */
		private function _removeLoaderListeners():void {
			// 対象が存在すれば
			if ( _loader ) {
				// イベントリスナーを解除する
				_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, _complete );
				_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			}
		}
		
		/**
		 * <p>指定されたオブジェクトの XML ストリング表現を返します。</p>
		 * <p>Returns a XML string representation of the XML object.</p>
		 * 
		 * @return
		 * <p>オブジェクトの XML ストリング表現です。</p>
		 * <p>The XML string representation of the XML object. </p>
		 */
		public override function toXMLString():String {
			var xml:XML = new XML( super.toXMLString() );
			
			// 読み込みが完了していれば
			if ( _document ) {
				// 子シーンノードを作成する
				var scenes:Array = super.root.scenes;
				for ( var i:int = 0, l:int = scenes.length; i < l; i++ ) {
					xml.appendChild( new XML( scenes[i].toXMLString() ) );
				}
			}
			
			return xml.toXMLString();
		}
		
		
		
		
		
		/**
		 * 受信したすべてのデータがデコードされて Loader インスタンスの data プロパティへの保存が完了したときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// イベントリスナーを解除する
			_removeLoaderListeners();
			
			// CastDocument を取得する
			_document = _loader.content as CastDocument;
			
			// ILoaderComp を取得する
			if ( ComponentProperties.CURRENT_LOADER in _loader.content ) {
				_loaderComp = _loader.content[ComponentProperties.CURRENT_LOADER];
			}
			
			switch ( true ) {
				case !!_document	: {
					// CastDocument を初期化する
					_document.progression_internal::$initialize( null, this, _loaderContainer );
					
					// 対象のルートシーンを設定する
					_content = _document.manager.root;
					return;
				}
				case !!_loaderComp	: {
					// イベントリスナーを登録する
					_loaderComp.addEventListener( ManagerEvent.MANAGER_ACTIVATE, _managerActivate );
					
					// ILoaderComp を初期化する
					_loaderComp.progression_internal::$load( this, _loaderContainer );
					return;
				}
			}
			
			// 破棄する
			_loader.unload();
		}
		
		/**
		 * キャストオブジェクトと Progression インスタンスの関連付けがアクティブになったときに送出されます。
		 */
		private function _managerActivate( e:ManagerEvent ):void {
			// イベントリスナーを破棄する
			_loaderComp.removeEventListener( ManagerEvent.MANAGER_ACTIVATE, _managerActivate );
			
			// 対象のルートシーンを設定する
			_content = _loaderComp.manager.root;
		}
		
		/**
		 * 入出力エラーが発生してロード処理が失敗したときに送出されます。
		 */
		private function _ioError( e:IOErrorEvent ):void {
			// イベントリスナーを解除する
			_removeLoaderListeners();
		}
		
		/**
		 * シーン移動時に目的地がシーンオブジェクト自身もしくは子階層であり、かつ自身が SWF ファイルを読み込んでいない状態で、SceneEvent.SCENE_LOAD イベントが発生する直前に送出されます。
		 */
		private function _scenePreLoad( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			atScenePreLoad();
			if ( _onScenePreLoad != null ) {
				_onScenePreLoad.apply( this );
			}
		}
		
		/**
		 * シーン移動時に目的地がシーンオブジェクト自身もしくは親階層であり、かつ自身がすでに SWF ファイルを読み込んでいる状態で、SceneEvent.SCENE_UNLOAD イベントが発生した直後に送出されます。
		 */
		private function _scenePostUnload( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			atScenePostUnload();
			if ( _onScenePostUnload != null ) {
				_onScenePostUnload.apply( this );
			}
		}
	}
}
