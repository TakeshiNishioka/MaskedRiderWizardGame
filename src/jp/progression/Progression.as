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
package jp.progression {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import jp.nium.collections.IdGroupCollection;
	import jp.nium.collections.IIdGroup;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ObjectUtil;
	import jp.nium.utils.StageUtil;
	import jp.nium.utils.StringUtil;
	import jp.progression.core.config.Configuration;
	import jp.progression.core.impls.ICastObject;
	import jp.progression.core.impls.ICastPreloader;
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.core.managers.HistoryManager;
	import jp.progression.core.managers.IInitializer;
	import jp.progression.core.managers.ISynchronizer;
	import jp.progression.core.managers.SceneManager;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.events.ManagerEvent;
	import jp.progression.events.ProcessEvent;
	import jp.progression.events.SceneEvent;
	import jp.progression.scenes.SceneId;
	import jp.progression.scenes.SceneLoader;
	import jp.progression.scenes.SceneObject;
	import jp.progression.ui.IKeyboardMapper;
	
	/**
	 * <p>シーン移動処理が実行可能になった瞬間に送出されます。
	 * このイベントが送出される以前に実行された移動命令は、実行可能になるまでスタックされます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ManagerEvent.MANAGER_READY
	 */
	[Event( name="managerReady", type="jp.progression.events.ManagerEvent" )]
	
	/**
	 * <p>オブジェクトの lock プロパティの値が変更されたときに送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ManagerEvent.MANAGER_LOCK_CHANGE
	 */
	[Event( name="managerLockChange", type="jp.progression.events.ManagerEvent" )]
	
	/**
	 * <p>管理下にあるシーンの移動処理が開始された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ProcessEvent.PROCESS_START
	 */
	[Event( name="processStart", type="jp.progression.events.ProcessEvent" )]
	
	/**
	 * <p>管理下にあるシーンの移動処理中に対象シーンが変更された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ProcessEvent.PROCESS_SCENE
	 */
	[Event( name="processScene", type="jp.progression.events.ProcessEvent" )]
	
	/**
	 * <p>管理下にあるシーンの移動処理中に対象シーンでイベントが発生した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ProcessEvent.PROCESS_EVENT
	 */
	[Event( name="processEvent", type="jp.progression.events.ProcessEvent" )]
	
	/**
	 * <p>管理下にあるシーンの移動処理中に移動先が変更された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ProcessEvent.PROCESS_CHANGE
	 */
	[Event( name="processChange", type="jp.progression.events.ProcessEvent" )]
	
	/**
	 * <p>管理下にあるシーンの移動処理が完了した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ProcessEvent.PROCESS_COMPLETE
	 */
	[Event( name="processComplete", type="jp.progression.events.ProcessEvent" )]
	
	/**
	 * <p>管理下にあるシーンの移動処理が停止された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ProcessEvent.PROCESS_STOP
	 */
	[Event( name="processStop", type="jp.progression.events.ProcessEvent" )]
	
	/**
	 * <p>シーン移動中にエラーが発生した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ProcessEvent.PROCESS_ERROR
	 */
	[Event( name="processError", type="jp.progression.events.ProcessEvent" )]
	
	/**
	 * <p>Progression クラスは、Progression を使用するための基本クラスです。
	 * シーン作成やシーン移動の処理は、全て Progression インスタンスを通じて行います。</p>
	 * <p></p>
	 * 
	 * @see jp.progression#getManagerById()
	 * @see jp.progression#getManagersByGroup()
	 * @see jp.progression.casts.CastDocument
	 * @see jp.progression.events.ProcessEvent
	 * @see jp.progression.scenes.SceneId;
	 * @see jp.progression.scenes.SceneObject;
	 * @see jp.progression.config
	 * 
	 * @example <listing version="3.0" >
	 * // Progression インスタンスを作成する
	 * var manager:Progression = new Progression( "index", stage );
	 * 
	 * // シーン構造を作成する
	 * manager.root.addScene( new SceneObject( "about" ) );
	 * manager.root.addScene( new SceneObject( "gallery" ) );
	 * manager.root.addScene( new SceneObject( "contact" ) );
	 * 
	 * // シーンを移動する
	 * manager.goto( new SceneId( "/index/about" ) );
	 * </listing>
	 */
	public class Progression extends EventDispatcher implements IIdGroup {
		
		/**
		 * <p>パッケージの名前を取得します。</p>
		 * <p></p>
		 */
		public static const NAME:String = "Progression";
		
		/**
		 * <p>パッケージのバージョン情報を取得します。</p>
		 * <p></p>
		 */
		public static const VERSION:String = "4.0.1 Public Beta 1.2";
		
		/**
		 * <p>パッケージの制作者を取得します。</p>
		 * <p></p>
		 */
		public static const AUTHOR:String = "Copyright (C) 2007-2009 taka:nium.jp, All Rights Reserved.";
		
		/**
		 * <p>パッケージの URL を取得します。</p>
		 * <p></p>
		 */
		public static const URL:String = "http://progression.jp/";
		
		/**
		 * @private
		 */
		progression_internal static function get $URL_BUILT_ON():String {
			var url:String = Progression.URL + "built_on/";
			var info:Object = {};
			var cls:Class;
			
			info.ver = Progression.VERSION;
			
			try { info.twn = int( !!getDefinitionByName( "caurina.transitions.Tweener" ) ); } catch ( e:Error ) { info.twn = 0; }
			try { info.sad = int( !!getDefinitionByName( "com.asual.swfaddress.SWFAddress" ) ); } catch ( e:Error ) { info.sad = 0; }
			try { info.ssz = int( !!getDefinitionByName( "org.libspark.ui.SWFSize" ) ); } catch ( e:Error ) { info.ssz = 0; }
			try { info.swh = int( !!getDefinitionByName( "org.libspark.ui.SWFWheel" ) ); } catch ( e:Error ) { info.swh = 0; }
			
			url += "?" + ObjectUtil.toQueryString( info );
			
			return encodeURI( url );
		}
		
		/**
		 * <p>初期化時に指定された Configuration を取得します。 </p>
		 * <p></p>
		 * 
		 * @see #initialize()
		 */
		public static function get config():Configuration { return _config; }
		private static var _config:Configuration;
		
		/**
		 * <p>現在同期中の Progression インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see #sync
		 */
		public static function get syncedManager():Progression { return _syncedManager; }
		private static var _syncedManager:Progression;
		
		/**
		 * @private
		 */
		progression_internal static var $collections:IdGroupCollection = new IdGroupCollection();
		
		/**
		 * @private
		 */
		progression_internal static var $container:Sprite;
		
		/**
		 * @private
		 */
		progression_internal static var $loader:SceneLoader;
		
		/**
		 * @private
		 */
		progression_internal static var $currentManager:Progression;
		
		/**
		 * Stage インスタンスを取得します。 
		 */
		private static var _stage:Stage;
		
		
		
		
		
		/**
		 * <p>インスタンスの識別子を取得します。</p>
		 * <p>Indicates the instance id of the Progression.</p>
		 * 
		 * @see jp.progression#getManagerById()
		 */
		public function get id():String { return _id; }
		public function set id( value:String ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_013 ).toString( "id" ) ); }
		private var _id:String;
		
		/**
		 * <p>インスタンスのグループ名を取得または設定します。</p>
		 * <p>Indicates the instance group of the Progression.</p>
		 * 
		 * @see jp.progression#getManagersByGroup()
		 */
		public function get group():String { return _group; }
		public function set group( value:String ):void { _group = Progression.progression_internal::$collections.registerGroup( this, value ) ? value : null;  }
		private var _group:String;
		
		/**
		 * <p>関連付けられている Stage インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get stage():Stage { return _stage; }
		
		/**
		 * <p>シーンツリーの最上位に位置する SceneObject インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get root():SceneObject { return _root; }
		private var _root:SceneObject;
		
		/**
		 * <p>現在位置となる SceneObject インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get current():SceneObject {
			var sceneId:SceneId = currentSceneId;
			
			// 存在しなければ終了する
			if ( !sceneId || SceneId.isNaS( sceneId ) ) { return null; }
			
			// ルートシーンを取得する
			var current:SceneObject = _root;
			
			// シーンを検索する
			for ( var i:int = 1, l:int = sceneId.length; i < l; i++ ) {
				// シーン名を取得する
				var name:String = sceneId.getNameByIndex( i );
				
				// 子シーンを取得する
				var loader:SceneLoader = current as SceneLoader;
				if ( loader ) {
					current = loader.content;
				}
				else {
					current = current.getSceneByName( name );
				}
				
				// 対象シーンが存在しなければ終了する
				if ( !current ) { return null; }
			}
			
			return current;
		}
		
		/**
		 * <p>現在位置を示すシーン識別子を取得します。</p>
		 * <p></p>
		 * 
		 * @see #departedSceneId
		 * @see #destinedSceneId
		 * @see #syncedSceneId
		 */
		public function get currentSceneId():SceneId {
			// SceneManager が存在しなければ
			if ( !_sceneManager ) { return SceneId.NaS; }
			
			// 読み込まれていれば
			if ( _loader ) {
				return _loader.globalToLocal( _loader.manager.currentSceneId );
			}
			
			return _sceneManager.currentSceneId;
		}
		
		/**
		 * <p>出発位置を示すシーン識別子を取得します。</p>
		 * <p></p>
		 * 
		 * @see #currentSceneId
		 * @see #destinedSceneId
		 * @see #syncedSceneId
		 */
		public function get departedSceneId():SceneId {
			// SceneManager が存在しなければ
			if ( !_sceneManager ) { return SceneId.NaS; }
			
			// 読み込まれていれば
			if ( _loader ) {
				return _loader.globalToLocal( _loader.manager.departedSceneId );
			}
			
			return _sceneManager.departedSceneId;
		}
		
		/**
		 * <p>目的位置を示すシーン識別子を取得します。</p>
		 * <p></p>
		 * 
		 * @see #currentSceneId
		 * @see #departedSceneId
		 * @see #syncedSceneId
		 */
		public function get destinedSceneId():SceneId {
			// SceneManager が存在しなければ
			if ( !_sceneManager ) { return SceneId.NaS; }
			
			// 読み込まれていれば
			if ( _loader ) {
				return _loader.globalToLocal( _loader.manager.destinedSceneId );
			}
			
			return _sceneManager.destinedSceneId;
		}
		
		/**
		 * <p>同期機能が有効化された状態でのシーン識別子を取得します。</p>
		 * <p></p>
		 * 
		 * @see #currentSceneId
		 * @see #departedSceneId
		 * @see #destinedSceneId
		 */
		public function get syncedSceneId():SceneId {
			if ( !_synchronizer ) { return _root.sceneId; }
			
			return _synchronizer.sceneId;
		}
		
		/**
		 * <p>現在のイベントタイプを取得します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.events.SceneEvent
		 * @see #goto()
		 */
		public function get eventType():String { return _sceneManager.eventType; }
		
		/**
		 * <p>現在の処理状態を取得します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.executors.ExecutorObjectState
		 * @see #goto()
		 */
		public function get state():int { return _sceneManager ? _sceneManager.state : -1; }
		
		/**
		 * <p>現在の移動プロセスとなる経路を示すシーン識別子のリストを取得します。</p>
		 * <p></p>
		 * 
		 * @see #goto()
		 * @see #jumpto()
		 */
		public function get processes():Array { return _sceneManager ? _sceneManager.processes : []; }
		
		/**
		 * <p>この Progression インスタンスに関する履歴を管理している HistoryManager インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see #goto()
		 * @see #jumpto()
		 */
		public function get history():HistoryManager { return _history; }
		private var _history:HistoryManager;
		
		/**
		 * <p>この Progression インスタンスを同期対象として設定するかどうかを取得または設定します。
		 * 同期対象として有効化するためには、Progression を初期化する際にシンクロ機能に対応している Configuration を設定しておく必要があります。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.config
		 */
		public function get sync():Boolean { return _synchronizer ? _synchronizer.enabled : false; }
		public function set sync( value:Boolean ):void {
			if ( _loader ) { return; }
			if ( !_synchronizer ) { throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_003 ).toString() ); }
			
			_synchronizer.enabled = value;
			_syncedManager = _synchronizer.syncedTarget;
		}
		
		/**
		 * <p>シーン移動処理の実行中に、新しい移動シーケンスの開始を無効化するかどうかを取得または設定します。
		 * このプロパティを設定すると autoLock プロパティが強制的に false に設定されます。</p>
		 * <p></p>
		 * 
		 * @see #autoLock
		 * @see #goto()
		 * @see #jumpto()
		 */
		public function get lock():Boolean { return _sceneManager ? _sceneManager.lock : false; }
		public function set lock( value:Boolean ):void { _sceneManager.lock = value; }
		
		/**
		 * <p>シーンの移動シーケンスが開始された場合に、自動的に lock プロパティを true にするかどうかを取得または設定します。
		 * 移動シーケンスが完了後には、lock プロパティは自動的に false に設定されます。</p>
		 * <p></p>
		 * 
		 * @see #lock
		 * @see #goto()
		 * @see #jumpto()
		 */
		public function get autoLock():Boolean { return _sceneManager ? _sceneManager.autoLock : false; }
		public function set autoLock( value:Boolean ):void { _sceneManager.autoLock = value; }
		
		/**
		 * SceneLoader インスタンスを取得します。
		 */
		private var _loader:SceneLoader;
		
		/**
		 * IInitializer インスタンスを取得します。 
		 */
		private var _initializer:IInitializer;
		
		/**
		 * ISynchronizer インスタンスを取得します。 
		 */
		private var _synchronizer:ISynchronizer;
		
		/**
		 * SceneManager インスタンスを取得します。 
		 */
		private var _sceneManager:SceneManager;
		
		/**
		 * IKeyboardMapper インスタンスを取得します。 
		 */
		private var _keyboardMapper:IKeyboardMapper;
		
		
		
		
		
		/**
		 * <p>新しい Progression インスタンスを作成します。</p>
		 * <p>Creates a new Progression object.</p>
		 * 
		 * @see jp.progression.config
		 * 
		 * @param id
		 * <p>インスタンスの識別子です。</p>
		 * <p></p>
		 * @param stage
		 * <p>関連付けたい Stage インスタンスです。</p>
		 * <p></p>
		 * @param rootClass
		 * <p>ルートシーンに関連付けたいクラスの参照です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function Progression( id:String, stage:Stage, rootClass:Class = null, initObject:Object = null ) {
			// すでに登録されていれば例外をスローする
			if ( !id ) { throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_007 ).toString() ); }
			
			// すでに登録されていれば例外をスローする
			if ( Progression.progression_internal::$collections.getInstanceById( id ) ) { throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_005 ).toString( "Progression", id ) ); }
			
			// 引数を設定する
			_id = id;
			_stage = stage;
			
			// コレクションに登録する
			Progression.progression_internal::$collections.addInstance( this );
			if ( !Progression.progression_internal::$collections.registerId( this, id ) ) {
				_id = null;
			}
			
			// Configuration が存在しなければ作成する
			_config ||= new Configuration();
			
			// SceneLoader を取得する
			_loader = Progression.progression_internal::$loader;
			
			// SceneLoader で読み込まれていなければ
			if ( !_loader ) {
				// IInitializer を作成する
				var cls:Class = _config.initializer as Class;
				if ( cls ) {
					_initializer = new cls( this );
				}
			}
			
			// SceneManager を作成する
			_sceneManager = new SceneManager( this );
			
			// HistoryManager を作成する
			_history = new HistoryManager( this );
			
			// SceneLoader で読み込まれていなければ
			if ( !_loader ) {
				// ISynchronizer を作成する
				cls = _config.synchronizer as Class;
				if ( cls ) {
					_synchronizer = new cls( this );
					_synchronizer.addEventListener( Event.COMPLETE, _complete );
				}
				
				// IKeyboardMapper を作成する
				cls = _config.keyboardMapper as Class;
				if ( cls ) {
					_keyboardMapper = new cls( this );
				}
			}
			
			// コンテナを取得する
			var container:Sprite = Progression.progression_internal::$container;
			
			// CastPreloader を取得する
			try {
				// CastPreloader を取得する
				var preloaderClass:Class = getDefinitionByName( "jp.progression.casts.CastPreloader" ) as Class;
				
				// 読み込まれた対象を取得する
				container ||= preloaderClass.progression_internal::$instance.loader.content;
			}
			catch ( e:Error ) {}
			
			// stage 直下のルートを取得する
			container ||= StageUtil.getDocument( _stage );
			
			// コンテナが ICastPreloader を実装していれば
			var preloader:ICastPreloader = container as ICastPreloader;
			if ( preloader ) {
				// 対象を変更する
				container = preloader.content as Sprite || preloader.background;
			}
			
			// コンテナが ICastObject を実装していれば
			var cast:ICastObject = container as ICastObject;
			if ( cast ) {
				// 自身を対象の Progression として設定する
				progression_internal::$currentManager = this;
				
				// Progression との関連付けを行う
				cast.updateManager();
			}
			
			// rootClass を作成する
			SceneObject.progression_internal::$manager = this;
			SceneObject.progression_internal::$container = container;
			SceneObject.progression_internal::$loader = _loader;
			_root = new ( rootClass || SceneObject )();
			
			// イベントを送出する
			_root.dispatchEvent( new SceneEvent( SceneEvent.SCENE_ADDED, true ) );
			if ( !_loader || _loader.root ) {
				_root.dispatchEvent( new SceneEvent( SceneEvent.SCENE_ADDED_TO_ROOT, true ) );
			}
			
			// イベントリスナーを登録する
			if ( _loader ) {
				_loader.manager.addEventListener( ManagerEvent.MANAGER_LOCK_CHANGE, super.dispatchEvent );
				_loader.manager.addEventListener( ProcessEvent.PROCESS_START, super.dispatchEvent );
				_loader.manager.addEventListener( ProcessEvent.PROCESS_SCENE, super.dispatchEvent );
				_loader.manager.addEventListener( ProcessEvent.PROCESS_EVENT, super.dispatchEvent );
				_loader.manager.addEventListener( ProcessEvent.PROCESS_CHANGE, super.dispatchEvent );
				_loader.manager.addEventListener( ProcessEvent.PROCESS_COMPLETE, super.dispatchEvent );
				_loader.manager.addEventListener( ProcessEvent.PROCESS_STOP, super.dispatchEvent );
			}
			
			// 初期化する
			ObjectUtil.setProperties( this, initObject );
			
			// 破棄する
			Progression.progression_internal::$container = null;
			Progression.progression_internal::$loader = null;
			
			// SceneLoader で読み込まれておらず、ISynchronizer が存在すれば
			if ( !_loader && _synchronizer ) {
				// 同期を開始する
				_synchronizer.start();
			}
			else {
				// イベントを送出する
				super.dispatchEvent( new ManagerEvent( ManagerEvent.MANAGER_READY ) );
			}
		}
		
		
		
		
		
		/**
		 * <p>Progression を初期化します。
		 * この処理は Progression インスタンスを作成する前の状態で 1 回のみ行うことができます。</p>
		 * <p></p>
		 * 
		 * @see #config
		 * @see jp.progression.config
		 * 
		 * @param config
		 * <p>初期化情報として使用したい Configuration インスタンスです。</p>
		 * <p></p>
		 * @return
		 * <p>初期化に成功した場合には true を、失敗した場合には false を返します。</p>
		 * <p></p>
		 */
		public static function initialize( config:Configuration ):Boolean {
			if ( _config ) { return false; }
			
			_config = config;
			
			return true;
		}
		
		/**
		 * <p>XML データから Progression インスタンスを生成します。</p>
		 * <p></p>
		 * 
		 * @param stage
		 * <p>関連付けたい Stage インスタンスです。</p>
		 * <p></p>
		 * @param xml
		 * <p>生成時に使用する設定情報を含んだ XML オブジェクトです。</p>
		 * <p></p>
		 * @return
		 * <p>生成された Progression インスタンスです。</p>
		 * <p></p>
		 */
		public static function createFromXML( stage:Stage, xml:XML ):Progression {
			// XML の構文が間違っていれば例外をスローする
			if ( !SceneObject.validate( xml ) ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_016 ).toString( "XML" ) ); }
			
			// ルートシーンの情報を取得する
			var root:XML = xml.scene[0] as XML;
			var cls:String = String( root.attribute( "cls" ) );
			var managerId:String = String( root.attribute( "name" ) );
			var rootClass:Class = cls ? getDefinitionByName( cls ) as Class : SceneObject;
			
			// ルートのみ削除した PRML データを作成する
			xml.scene = xml.scene[0].scene;
			
			// Progression を作成する
			var manager:Progression = new Progression( managerId, stage, rootClass );
			
			// ルートシーンを初期化する
			for each ( var attribute:XML in root.attributes() ) {
				var attrName:String = String( attribute.name() );
				
				if ( attrName == "name" ) { continue; }
				if ( !( attrName in manager.root ) ) { continue; }
				
				manager.root[attrName] = StringUtil.toProperType( attribute );
			}
			
			// DataHolder を更新する
			SceneObject.progression_internal::$providingData = root.*.( name() != "scene" );
			manager.root.dataHolder.update();
			
			// ルートシーン以下に子シーンを作成する
			if ( xml.scene.length() > 0 ) {
				manager.root.addSceneFromXML( xml );
			}
			
			return manager;
		}
		
		
		
		
		
		/**
		 * <p>インスタンスに対して、複数のプロパティを一括設定します。</p>
		 * <p></p>
		 * 
		 * @param paramerters
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function setProperties( paramerters:Object ):void {
			ObjectUtil.setProperties( this, paramerters );
		}
		
		/**
		 * <p>シーンを移動します。</p>
		 * <p></p>
		 * 
		 * @see #jumpto()
		 * @see #stop()
		 * 
		 * @param sceneId
		 * <p>移動先を示すシーン識別子です。</p>
		 * <p></p>
		 * @param extra
		 * <p>実行時にコマンドフローをリレーするオブジェクトです。</p>
		 * <p></p>
		 * @return
		 * <p>移動処理が正常に実行された場合は true を、それ以外は false を返します。</p>
		 * <p></p>
		 */
		public function goto( sceneId:SceneId, extra:Object = null ):Boolean {
			// 読み込まれた Progression インスタンスであれば
			if ( _loader ) { return _loader.manager.goto( _root.localToGlobal( sceneId ), extra ); }
			
			return _sceneManager.goto( sceneId, extra );
		}
		
		/**
		 * <p>シーン移動に関係した処理を全て無視して、すぐに移動します。</p>
		 * <p></p>
		 * 
		 * @see #goto()
		 * @see #stop()
		 * 
		 * @param sceneId
		 * <p>移動先を示すシーン識別子です。</p>
		 * <p></p>
		 * @param extra
		 * <p>実行時にコマンドフローをリレーするオブジェクトです。</p>
		 * <p></p>
		 * @return
		 * <p>移動処理が正常に実行された場合は true を、それ以外は false を返します。</p>
		 * <p></p>
		 */
		public function jumpto( sceneId:SceneId, extra:Object = null ):Boolean {
			// 読み込まれた Progression インスタンスであれば
			if ( _loader ) { return _loader.manager.jumpto( _root.localToGlobal( sceneId ), extra ); }
			
			return _sceneManager.jumpto( sceneId, extra );
		}
		
		/**
		 * <p>シーン移動処理を中断します。</p>
		 * <p></p>
		 * 
		 * @see #goto()
		 * @see #jumpto()
		 */
		public function stop():void {
			// 読み込まれた Progression インスタンスであれば
			if ( _loader ) {
				_loader.manager.stop();
			}
			else {
				_sceneManager.stop();
			}
		}
		
		/**
		 * @private
		 */
		progression_internal function $dispose():void {
			// イベントリスナーを解除する
			if ( _loader ) {
				_loader.manager.removeEventListener( ProcessEvent.PROCESS_START, super.dispatchEvent );
				_loader.manager.removeEventListener( ProcessEvent.PROCESS_SCENE, super.dispatchEvent );
				_loader.manager.removeEventListener( ProcessEvent.PROCESS_EVENT, super.dispatchEvent );
				_loader.manager.removeEventListener( ProcessEvent.PROCESS_CHANGE, super.dispatchEvent );
				_loader.manager.removeEventListener( ProcessEvent.PROCESS_COMPLETE, super.dispatchEvent );
				_loader.manager.removeEventListener( ProcessEvent.PROCESS_STOP, super.dispatchEvent );
				_loader.manager.removeEventListener( ManagerEvent.MANAGER_LOCK_CHANGE, super.dispatchEvent );
				_loader = null;
			}
			
			// 登録を破棄する
			Progression.progression_internal::$collections.registerId( this, null );
			_id = null;
			
			// ルートシーンを破棄する
			_root.progression_internal::$dispose();
			_root = null;
			
			// SceneManager を破棄する
			_sceneManager.progression_internal::$dispose();
			_sceneManager = null;
			
			// HistoryManager を破棄する
			_history.progression_internal::$dispose();
			_history = null;
			
			// IInitializer を破棄する
			if ( _initializer ) {
				_initializer.dispose();
			}
			
			// ISynchronizer を破棄する
			if ( _synchronizer ) {
				_synchronizer.dispose();
			}
			
			// 破棄する
			_keyboardMapper = null;
		}
		
		/**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @return
		 * <p>オブジェクトのストリング表現です。</p>
		 * <p>A string representation of the object.</p>
		 */
		public override function toString():String {
			return ObjectUtil.formatToString( this, "Progression", "id" );
		}
		
		
		
		
		
		/**
		 * 
		 */
		private function _complete( e:Event ):void {
			// イベントリスナーを解除する
			_synchronizer.removeEventListener( Event.COMPLETE, _complete );
			
			// イベントを送出する
			super.dispatchEvent( new ManagerEvent( ManagerEvent.MANAGER_READY ) );
		}
	}
}
