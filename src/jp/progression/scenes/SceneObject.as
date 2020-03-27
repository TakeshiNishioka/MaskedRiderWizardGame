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
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.EventPhase;
	import flash.utils.getDefinitionByName;
	import jp.nium.collections.UniqueList;
	import jp.nium.collections.IdGroupCollection;
	import jp.nium.collections.IIdGroup;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.core.ns.nium_internal;
	import jp.nium.core.primitives.StringObject;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.ObjectUtil;
	import jp.nium.utils.StringUtil;
	import jp.progression.core.impls.IExecutable;
	import jp.progression.core.impls.IManageable;
	import jp.progression.core.L10N.L10NExecuteMsg;
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.data.DataHolder;
	import jp.progression.events.SceneEvent;
	import jp.progression.executors.ExecutorObject;
	import jp.progression.Progression;
	
	/**
	 * <p>シーン移動時に目的地がシーンオブジェクト自身もしくは子階層だった場合に、階層が変更された直後に送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_LOAD
	 */
	[Event( name="sceneLoad", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <p>シーン移動時に目的地がシーンオブジェクト自身もしくは親階層だった場合に、階層が変更される直前に送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_UNLOAD
	 */
	[Event( name="sceneUnload", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <p>シーンオブジェクト自身が目的地だった場合に、到達した瞬間に送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_INIT
	 */
	[Event( name="sceneInit", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <p>シーンオブジェクト自身が出発地だった場合に、移動を開始した瞬間に送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_GOTO
	 */
	[Event( name="sceneGoto", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <p>シーン移動時に目的地がシーンオブジェクトの子階層であり、かつ出発地ではない場合に、自身が移動を中継した瞬間に送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_DESCEND
	 */
	[Event( name="sceneDescend", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <p>シーン移動時に目的地がシーンオブジェクトの親階層であり、かつ出発地ではない場合に、自身が移動を中継した瞬間に送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_ASCEND
	 */
	[Event( name="sceneAscend", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <p>シーンオブジェクトがシーンリストに追加された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_ADDED
	 */
	[Event( name="sceneAdded", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <p>シーンオブジェクトが直接、またはシーンオブジェクトを含むサブツリーの追加により、ルートシーン上のシーンリストに追加されたときに送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_ADDED_TO_ROOT
	 */
	[Event( name="sceneAddedToRoot", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <p>シーンオブジェクトがシーンリストから削除された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_REMOVED
	 */
	[Event( name="sceneRemoved", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <p>シーンオブジェクトが直接、またはシーンオブジェクトを含むサブツリーの削除により、ルートシーン上のシーンリストから削除されようとしているときに送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_REMOVED_FROM_ROOT
	 */
	[Event( name="sceneRemovedFromRoot", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <p>シーンオブジェクトの title プロパティが変更された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.SceneEvent.SCENE_TITLE_CHANGE
	 */
	[Event( name="sceneTitleChange", type="jp.progression.events.SceneEvent" )]
	
	/**
	 * <p>非同期処理中にエラーが発生した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ExecuteErrorEvent.EXECUTE_ERROR
	 */
	[Event( name="executeError", type="jp.progression.events.ExecuteErrorEvent" )]
	
	/**
	 * <p>SceneObject クラスは、シーンコンテナとして機能する全てのオブジェクトの基本クラスです。
	 * 
	 * "DisplayObject like SceneObject Event Flow" is created by seyself (http://seyself.com/)</p>
	 * <p></p>
	 * 
	 * @see jp.progression.Progression
	 * 
	 * @example <listing version="3.0" >
	 * // SceneObject インスタンスを作成する
	 * var scene:SceneObject = new SceneObject( "about" );
	 * 
	 * // シーンイベントを設定する
	 * scene.onSceneInit = function():void {
	 * 	trace( scene, "に到着しました。"
	 * };
	 * scene.onSceneGoto = function():void {
	 * 	trace( scene, "から出発しました。"
	 * };
	 * 
	 * // Progression インスタンスを作成する
	 * var manager:Progression = new Progression( "index", stage );
	 * 
	 * // シーン構造を作成する
	 * manager.root.addScene( scene );
	 * 
	 * // シーンを移動する
	 * manager.goto( new SceneId( "/index/about" ) );
	 * </listing>
	 */
	public class SceneObject extends EventDispatcher implements IIdGroup, IManageable, IExecutable {
		
		/**
		 * @private
		 */
		progression_internal static var $collections:IdGroupCollection = new IdGroupCollection();
		
		/**
		 * @private
		 */
		progression_internal static var $manager:Progression;
		
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
		progression_internal static var $providingData:*;
		
		/**
		 * インスタンス名の接頭辞を取得します。
		 */
		private static var _prefix:String = "scene";
		
		
		
		
		
		/**
		 * <p>インスタンスのクラス名を取得します。</p>
		 * <p>Indicates the instance className of the SceneObject.</p>
		 */
		public function get className():String { return _classNameObj ? _classNameObj.toString() : ClassUtil.nium_internal::$DEFAULT_CLASS_NAME; }
		private var _classNameObj:StringObject;
		
		/**
		 * <p>インスタンスを表すユニークな識別子を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.scenes#getSceneById()
		 */
		public function get id():String { return _id; }
		public function set id( value:String ):void {
			// 既存の登録を取得する
			var instance:IIdGroup = SceneObject.progression_internal::$collections.getInstanceById( value );
			
			// すでに存在していれば例外をスローする
			if ( instance ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_022 ).toString( value ) ); }
			
			// 登録する
			_id = SceneObject.progression_internal::$collections.registerId( this, value ) ? value : null;
		}
		private var _id:String;
		
		/**
		 * <p>インスタンスのグループ名を取得または設定します。</p>
		 * <p>Indicates the instance group of the SceneObject.</p>
		 * 
		 * @see jp.progression.scenes#getScenesByGroup()
		 */
		public function get group():String { return _group; }
		public function set group( value:String ):void { _group = SceneObject.progression_internal::$collections.registerGroup( this, value ) ? value : null; }
		private var _group:String;
		
		/**
		 * <p>インスタンスの名前を取得または設定します。</p>
		 * <p>Indicates the instance name of the SceneObject.</p>
		 * 
		 * @see #sceneId
		 * @see #getSceneByName()
		 */
		public function get name():String { return _name || ( _prefix + _uniqueNum ); }
		public function set name( value:String ):void {
			if ( _root ) { throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_004 ).toString( "name" ) ); }
			if ( !SceneId.validateName( value ) ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_005 ).toString( "name" ) ); }
			
			_name = value;
		}
		private var _name:String;
		private var _uniqueNum:uint;
		
		/**
		 * <p>シーン識別子を取得します。</p>
		 * <p></p>
		 * 
		 * @see #name
		 */
		public function get sceneId():SceneId { return _sceneId; }
		private var _sceneId:SceneId;
		
		/**
		 * <p>シーンのタイトルを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.events.SceneEvent#SCENE_TITLE_CHANGE
		 */
		public function get title():String { return _title; }
		public function set title( value:String ):void {
			_title = value;
			
			// イベントを送出する
			_dispatchEvent( new SceneEvent( SceneEvent.SCENE_TITLE_CHANGE ) );
		}
		private var _title:String;
		
		/**
		 * <p>関連付けられている Progression インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.events.ManagerEvent#MANAGER_ACTIVATE
		 * @see jp.progression.events.ManagerEvent#MANAGER_DEACTIVATE
		 */
		public function get manager():Progression { return _manager; }
		private var _manager:Progression;
		
		/**
		 * <p>関連付けられている Stage インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get stage():Stage { return _stage; }
		private var _stage:Stage;
		
		/**
		 * <p>関連付けられている Sprite インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get container():Sprite {
			if ( _sceneInfo && _sceneInfo.loader ) { return _sceneInfo.loader.loaderContainer; }
			if ( __root ) { return __root._container; }
			return null;
		}
		private var _container:Sprite;
		
		/**
		 * <p>自身の参照を取得します。</p>
		 * <p></p>
		 */
		public function get self():SceneObject { return this; }
		
		/**
		 * <p>この SceneObject オブジェクトを含む SceneObject オブジェクトを示します。</p>
		 * <p>Indicates the SceneObject object that contains this SceneObject object.</p>
		 * 
		 * @see #root
		 * @see #next
		 * @see #previous
		 */
		public function get parent():SceneObject { return __parent; }
		private function set _parent( value:SceneObject ):void {
			if ( Boolean( __parent = value ) ) {
				// イベントを送出する
				_dispatchEvent( new SceneEvent( SceneEvent.SCENE_ADDED, true ) );
			}
			else {
				// イベントを送出する
				_dispatchEvent( new SceneEvent( SceneEvent.SCENE_REMOVED, true ) );
			}
		}
		private var __parent:SceneObject;
		
		/**
		 * イベントフロー上で親となる SceneObject インスタンスを取得します。
		 */
		private var _eventParent:SceneObject;
		
		/**
		 * <p>シーンツリー構造の一番上に位置する SceneObject インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see #parent
		 * @see #next
		 * @see #previous
		 */
		public function get root():SceneObject { return __root; }
		private function get _root():SceneObject { return __root; }
		private function set _root( value:SceneObject ):void {
			// 現在のルートシーンを取得する
			var oldRoot:SceneObject = __root;
			
			// ルートシーンを更新する
			__root = value;
			
			// ルートシーンが変更されていれば
			if ( oldRoot != value ) {
				if ( value ) {
					// イベントを送出する
					_dispatchEvent( new SceneEvent( SceneEvent.SCENE_ADDED_TO_ROOT ) );
				}
				else {
					// イベントを送出する
					_dispatchEvent( new SceneEvent( SceneEvent.SCENE_REMOVED_FROM_ROOT ) );
				}
			}
			
			// 子シーンが存在しなければ終了する
			if ( !_scenes ) { return; }
			
			// 子シーンのルートシーンを更新する
			for ( var i:int = 0, l:int = numScenes; i < l; i++ ) {
				SceneObject( _scenes.getItemAt( i ) )._root = value;
			}
		}
		private var __root:SceneObject;
		
		/**
		 * <p>このシーンが関連付けられている親の SceneObject インスタンス内で、次に位置する SceneObject インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see #parent
		 * @see #root
		 * @see #previous
		 */
		public function get next():SceneObject {
			if ( !__parent ) { return null; }
			
			var scenes:UniqueList = __parent._scenes;
			var index:int = scenes.getItemIndex( this ) + 1;
			
			if ( index < 0 || scenes.numItems < index ) { return null; }
			
			return scenes.getItemAt( index );
		}
		
		/**
		 * <p>このシーンが関連付けられている親の SceneObject インスタンス内で、一つ前に位置する SceneObject インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see #parent
		 * @see #root
		 * @see #next
		 */
		public function get previous():SceneObject {
			if ( !__parent ) { return null; }
			
			var scenes:UniqueList = __parent._scenes;
			var index:int = scenes.getItemIndex( this ) - 1;
			
			if ( index < 0 || scenes.numItems < index ) { return null; }
			
			return scenes.getItemAt( index );
		}
		
		/**
		 * <p>子シーンインスタンスが保存されている配列です。
		 * この配列を操作することで元の配列を変更することはできません。</p>
		 * <p></p>
		 */
		public function get scenes():Array { return _scenes ? _scenes.toArray() : []; }
		private var _scenes:UniqueList;
		
		/**
		 * <p>子として登録されているシーン数を取得します。</p>
		 * <p>Returns the number of children of this SceneObject.</p>
		 */
		public function get numScenes():int { return _scenes ? _scenes.numItems : 0; }
		
		/**
		 * <p>シーンツリー構造上での自身の深度を取得します。</p>
		 * <p></p>
		 */
		public function get depth():int { return _depth; }
		private var _depth:int = 0;
		
		/**
		 * <p>関連付けられている ExecutorObject インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get executor():ExecutorObject { return _executor; }
		private var _executor:ExecutorObject;
		
		/**
		 * <p>関連付けられている SceneInfo インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.scenes.SceneLoader
		 */
		public function get sceneInfo():SceneInfo { return _sceneInfo; }
		private var _sceneInfo:SceneInfo;
		
		/**
		 * <p>関連付けられている DataHolder インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.data
		 */
		public function get dataHolder():DataHolder { return _dataHolder; }
		private var _dataHolder:DataHolder;
		
		/**
		 * キャプチャフェイズ用の EventDispatcher インスタンスを取得します。
		 */
		private var _captureDispatcher:EventDispatcher;
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_LOAD イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#LOAD
		 */
		public function get onSceneLoad():Function { return _onSceneLoad; }
		public function set onSceneLoad( value:Function ):void { _onSceneLoad = value; }
		private var _onSceneLoad:Function;
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_LOAD イベントを受け取った場合に呼び出されるオーバーライド・イベントハンドラメソッドです。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#LOAD
		 */
		protected function atSceneLoad():void {}
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_UNLOAD イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#UNLOAD
		 */
		public function get onSceneUnload():Function { return _onSceneUnload; }
		public function set onSceneUnload( value:Function ):void { _onSceneUnload = value; }
		private var _onSceneUnload:Function;
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_UNLOAD イベントを受け取った場合に呼び出されるオーバーライド・イベントハンドラメソッドです。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#UNLOAD
		 */
		protected function atSceneUnload():void {}
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_INIT イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#INIT
		 */
		public function get onSceneInit():Function { return _onSceneInit; }
		public function set onSceneInit( value:Function ):void { _onSceneInit = value; }
		private var _onSceneInit:Function;
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_INIT イベントを受け取った場合に呼び出されるオーバーライド・イベントハンドラメソッドです。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#INIT
		 */
		protected function atSceneInit():void {}
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_GOTO イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#GOTO
		 */
		public function get onSceneGoto():Function { return _onSceneGoto; }
		public function set onSceneGoto( value:Function ):void { _onSceneGoto = value; }
		private var _onSceneGoto:Function;
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_GOTO イベントを受け取った場合に呼び出されるオーバーライド・イベントハンドラメソッドです。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#GOTO
		 */
		protected function atSceneGoto():void {}
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_DESCEND イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#DESCEND
		 */
		public function get onSceneDescend():Function { return _onSceneDescend; }
		public function set onSceneDescend( value:Function ):void { _onSceneDescend = value; }
		private var _onSceneDescend:Function;
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_DESCEND イベントを受け取った場合に呼び出されるオーバーライド・イベントハンドラメソッドです。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#DESCEND
		 */
		protected function atSceneDescend():void {}
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_ASCEND イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#ASCEND
		 */
		public function get onSceneAscend():Function { return _onSceneAscend; }
		public function set onSceneAscend( value:Function ):void { _onSceneAscend = value; }
		private var _onSceneAscend:Function;
		
		/**
		 * <p>シーンオブジェクトが SceneEvent.SCENE_ASCEND イベントを受け取った場合に呼び出されるオーバーライド・イベントハンドラメソッドです。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.SceneEvent#ASCEND
		 */
		protected function atSceneAscend():void {}
		
		
		
		
		
		/**
		 * <p>新しい SceneObject インスタンスを作成します。</p>
		 * <p>Creates a new SceneObject object.</p>
		 * 
		 * @see jp.progression.scenes.getSceneById
		 * @see jp.progression.scenes.getScenesByGroup
		 * 
		 * @param name
		 * <p>シーンの名前です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function SceneObject( name:String = null, initObject:Object = null ) {
			// クラス名を取得する
			_classNameObj = ClassUtil.nium_internal::$getClassString( this );
			
			// 親クラスを初期化する
			super();
			
			// コレクションに登録する
			_uniqueNum = SceneObject.progression_internal::$collections.addInstance( this );
			
			// EventDispatcher を作成する
			_captureDispatcher = new EventDispatcher( this );
			
			// 引数を設定する
			_name = name;
			
			// 初期化する
			_sceneId = SceneId.NaS;
			
			// Progression が存在すればルートとして設定する
			if ( SceneObject.progression_internal::$manager ) {
				if ( !SceneId.validateName( SceneObject.progression_internal::$manager.id ) ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_005 ).toString( "name" ) ); }
				
				// 特定のプロパティを初期化する
				_name = SceneObject.progression_internal::$manager.id;
				_sceneId = new SceneId( "/" + _name );
				_manager = SceneObject.progression_internal::$manager;
				_stage = SceneObject.progression_internal::$manager.stage;
				_container = SceneObject.progression_internal::$container;
				_root = this;
				_executor = new ( Progression.config.executor as Class )( this );
				_sceneInfo = SceneInfo.progression_internal::$createInstance( this, SceneObject.progression_internal::$loader, _stage.loaderInfo );
				_dataHolder = new ( Progression.config.dataHolder as Class )( this );
				_dataHolder.update();
				
				// 破棄する
				SceneObject.progression_internal::$manager = null;
				SceneObject.progression_internal::$container = null;
				SceneObject.progression_internal::$loader = null;
			}
			
			// 初期化する
			ObjectUtil.setProperties( this, initObject );
			
			// イベントリスナーを登録する
			super.addEventListener( SceneEvent.SCENE_LOAD, _sceneLoad, false, 0, true );
			super.addEventListener( SceneEvent.SCENE_UNLOAD, _sceneUnload, false, 0, true );
			super.addEventListener( SceneEvent.SCENE_INIT, _sceneInit, false, 0, true );
			super.addEventListener( SceneEvent.SCENE_GOTO, _sceneGoto, false, 0, true );
			super.addEventListener( SceneEvent.SCENE_DESCEND, _sceneDescend, false, 0, true );
			super.addEventListener( SceneEvent.SCENE_ASCEND, _sceneAscend, false, 0, true );
			
			// 自身がルートであれば終了する
			if ( _root ) { return; }
			
			// イベントリスナーを登録する
			super.addEventListener( SceneEvent.SCENE_ADDED, _sceneAdded, false, int.MAX_VALUE, true );
			super.addEventListener( SceneEvent.SCENE_ADDED_TO_ROOT, _sceneAddedToRoot, false, int.MAX_VALUE, true );
			super.addEventListener( SceneEvent.SCENE_REMOVED, _sceneRemoved, false, int.MAX_VALUE, true );
			super.addEventListener( SceneEvent.SCENE_REMOVED_FROM_ROOT, _sceneRemovedFromRoot, false, int.MAX_VALUE, true );
		}
		
		
		
		
		/**
		 * <p>XML データが PRML フォーマットに準拠しているかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @param prml
		 * <p>フォーマットを検査したい XML データです。</p>
		 * <p></p>
		 * @return
		 * <p>フォーマットが合致すれば true を、合致しなければ false となります。</p>
		 * <p></p>
		 */
		public static function validate( prml:XML ):Boolean {
			prml = new XML( prml.toXMLString() );
			
			// <prml> タグが存在しなければ
			if ( String( prml.name() ) != "prml" ) { return false; }
			
			// バージョンが正しくなければ
			switch ( String( prml.attribute( "version" ) ) ) {
				case "2.0.0"	: { break; }
				default			: { return false; }
			}
			
			// コンテンツタイプを確認する
			var type:String = String( prml.attribute( "type" ) );
			switch ( type ) {
				case "text/easycasting"		:
				case "text/prml"			:
				case "text/prml.plain"		:
				default						: {
					if ( new RegExp( "^text/prml(\\..+)?$" ).test( type ) ) { break; }
					return false;
				}
			}
			
			// ルートにシーンが 1 つ以上存在しなければ
			if ( prml.scene.length() < 1 ) { return false; }
			
			// 必須プロパティを精査する
			for each ( var scene:XML in prml..scene ) {
				if ( !( SceneId.validateName( String( scene.attribute( "name" ) ) ) ) ) { return false; }
				if ( !String( scene.attribute( "cls" ) ) ) { return false; }
			}
			
			return true;
		}
		
		
		
		
		
		/**
		 * <p>インスタンスに対して、複数のプロパティを一括設定します。</p>
		 * <p></p>
		 * 
		 * @param parameters
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function setProperties( parameters:Object ):void {
			ObjectUtil.setProperties( this, parameters );
		}
		
		/**
		 * <p>シーン識別子をルートシーン（グローバル）パスからローダーシーンの（ローカル）パスに変換します。</p>
		 * <p></p>
		 * 
		 * @param sceneId
		 * <p>変換したいシーン識別子オブジェクトです。</p>
		 * <p></p>
		 * @return
		 * <p>ローカルパスに変換されたシーン識別子オブジェクトです。</p>
		 * <p></p>
		 */
		public function globalToLocal( sceneId:SceneId ):SceneId {
			// 読み込まれた Progression インスタンスであれば
			if ( _sceneInfo && _sceneInfo.loader ) {
				// 親のパスとの差分を取得する
				if ( sceneId.length > 1 ) {
					sceneId = _sceneInfo.loader.globalToLocal( new SceneId( "/" + root.name + sceneId.slice( 1 ) ) );
				}
				else {
					sceneId = _sceneInfo.loader.globalToLocal( new SceneId( "/" + root.name ) );
				}
			}
			
			return sceneId;
		}
		
		/**
		 * <p>シーン識別子をローダーシーンの（ローカル）パスからルートシーン（グローバル）パスに変換します。</p>
		 * <p></p>
		 * 
		 * @param sceneId
		 * <p>変換したいシーン識別子オブジェクトです。</p>
		 * <p></p>
		 * @return
		 * <p>グローバルパスに変換されたシーン識別子オブジェクトです。</p>
		 * <p></p>
		 */
		public function localToGlobal( sceneId:SceneId ):SceneId {
			// 読み込まれた Progression インスタンスであれば
			if ( _sceneInfo && _sceneInfo.loader ) {
				// 移動先が管理下に存在しなければ
				if ( !root.sceneId.contains( sceneId ) ) { throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_013 ).toString( sceneId ) ); }
				
				// 親のパスと結合する
				if ( sceneId.length > 1 ) {
					return _sceneInfo.loader.localToGlobal( _sceneInfo.loader.sceneId.transfer( "." + sceneId.slice( 1 ) ) );
				}
				else {
					return _sceneInfo.loader.localToGlobal( _sceneInfo.loader.sceneId );
				}
			}
			
			return sceneId;
		}
		
		/**
		 * <p>特定のイベントが送出された際に、自動実行させたい Command インスタンスをリストの最後尾に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に初期化されます。
		 * このメソッドを使用するためには executor プロパティに CommandExecutor が実装されている必要があります。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #insertCommand()
		 * @see #clearCommand()
		 * 
		 * @param commands
		 * <p>登録したいコマンドを含む配列です。</p>
		 * <p></p>
		 */
		public function addCommand( ... commands:Array ):void {
			if ( !_executor ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_009 ).toString( "addCommand" ) ); }
			if ( !( "addCommand" in _executor ) ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_001 ).toString( "addCommand", "CommandExecutor" ) ); }
			
			Object( _executor ).addCommand.apply( null, commands );
		}
		
		/**
		 * <p>特定のイベントが送出された際に、自動実行させたい Command インスタンスをすでにリストに登録され、実行中の Command インスタンスの次の位置に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に初期化されます。
		 * このメソッドを使用するためには executor プロパティに CommandExecutor が実装されている必要があります。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand()
		 * @see #clearCommand()
		 * 
		 * @param commands
		 * <p>登録したいコマンドを含む配列です。</p>
		 * <p></p>
		 */
		public function insertCommand( ... commands:Array ):void {
			if ( !_executor ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_009 ).toString( "insertCommand" ) ); }
			if ( !( "insertCommand" in _executor ) ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_001 ).toString( "insertCommand", "CommandExecutor" ) ); }
			
			Object( _executor ).insertCommand.apply( null, commands );
		}
		
		/**
		 * <p>登録されている Command インスタンスを削除します。
		 * このメソッドを使用するためには executor プロパティに CommandExecutor が実装されている必要があります。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand()
		 * @see #insertCommand()
		 * 
		 * @param completely
		 * <p>登録されている全てのコマンド登録を解除したい場合には true を、現在処理中のコマンド以降の登録を解除したい場合には false です。</p>
		 * <p></p>
		 */
		public function clearCommand( completely:Boolean = false ):void {
			if ( !_executor ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_009 ).toString( "clearCommand" ) ); }
			if ( !( "clearCommand" in _executor ) ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_001 ).toString( "clearCommand", "CommandExecutor" ) ); }
			
			Object( _executor ).clearCommand( completely );
		}
		
		/**
		 * <p>この SceneObject インスタンスに子 SceneObject インスタンスを追加します。</p>
		 * <p>Adds a child SceneObject instance to this SceneObject instance.</p>
		 * 
		 * @see #addSceneAt()
		 * @see #addSceneAtAbove()
		 * @see #addSceneFromXML()
		 * 
		 * @param scene
		 * <p>対象の SceneObject インスタンスの子として追加する SceneObject インスタンスです。</p>
		 * <p>The SceneObject instance to add as a scene of this SceneObject instance.</p>
		 * @return
		 * <p>scene パラメータで渡す SceneObject インスタンスです。</p>
		 * <p>The SceneObject instance that you pass in the scene parameter.</p>
		 */
		public function addScene( scene:SceneObject ):SceneObject {
			return _addSceneAt( scene, numScenes );
		}
		
		/**
		 * <p>この SceneObject インスタンスの指定されたインデックス位置に子 SceneObject インスタンスを追加します。</p>
		 * <p>Adds a child SceneObject instance to this SceneObject instance.</p>
		 * 
		 * @see #addScene()
		 * @see #addSceneAtAbove()
		 * @see #addSceneFromXML()
		 * 
		 * @param scene
		 * <p>対象の SceneObject インスタンスの子として追加する SceneObject インスタンスです。</p>
		 * <p>The SceneObject instance to add as a scene of this SceneObject instance.</p>
		 * @param index
		 * <p>子を追加するインデックス位置です。</p>
		 * <p>The index position to which the scene is added. If you specify a currently occupied index position, the scene object that exists at that position and all higher positions are moved up one position in the scene list.</p>
		 * @return
		 * <p>scene パラメータで渡す SceneObject インスタンスです。</p>
		 * <p>The SceneObject instance that you pass in the scene parameter.</p>
		 */
		public function addSceneAt( scene:SceneObject, index:int ):SceneObject {
			return _addSceneAt( scene, index );
		}
		
		/**
		 * 
		 */
		private function _addSceneAt( scene:SceneObject, index:int ):SceneObject {
			
			// インデックスの範囲を超えていれば例外をスローする
			if ( index < 0 || numScenes < index ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_004 ).toString() ); }
			
			// すでに親が存在していれば解除する
			var parent:SceneObject = scene.parent;
			if ( parent ) {
				parent.removeScene( scene );
				index = Math.min( index, parent.numScenes );
			}
			
			// イベントフロー時の参照先を登録する
			scene._eventParent = this;
			
			// 存在しなければ作成する
			_scenes ||= new UniqueList();
			
			// 登録する
			_scenes.addItemAt( scene, index );
			scene._parent = this;
			scene._root = _root;
			
			return scene;
		}
		
		/**
		 * <p>この SceneObject インスタンスの指定されたインデックス位置に子 SceneObject インスタンスを追加します。</p>
		 * <p>Adds a child SceneObject instance to this SceneObject instance.</p>
		 * 
		 * @see #addScene()
		 * @see #addSceneAt()
		 * @see #addSceneFromXML()
		 * 
		 * @param scene
		 * <p>対象の SceneObject インスタンスの子として追加する SceneObject インスタンスです。</p>
		 * <p>The SceneObject instance to add as a scene of this SceneObject instance.</p>
		 * @param index
		 * <p>子を追加するインデックス位置です。</p>
		 * <p>The index position to which the scene is added. If you specify a currently occupied index position, the scene object that exists at that position and all higher positions are moved up one position in the scene list.</p>
		 * @return
		 * <p>scene パラメータで渡す SceneObject インスタンスです。</p>
		 * <p>The SceneObject instance that you pass in the scene parameter.</p>
		 */
		public function addSceneAtAbove( scene:SceneObject, index:int ):SceneObject {
			if ( _scenes ) { return _addSceneAt( scene, _scenes.getItemAt( index ) ? index + 1 : index ); }
			return _addSceneAt( scene, index );
		}
		
		/**
		 * <p>この SceneObject インスタンスの子を PRML 形式の XML データから追加します。</p>
		 * <p></p>
		 * 
		 * @see #addScene()
		 * @see #addSceneAt()
		 * @see #addSceneAtAbove()
		 * 
		 * @param prml
		 * <p>PRML 形式の XML データです。</p>
		 * <p></p>
		 */
		public function addSceneFromXML( prml:XML ):void {
			// PRML のフォーマットが正しくなければ例外をスローする
			if ( !validate( prml ) ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_005 ).toString( "PRML" ) ); }
			
			// <scene> から SceneObject を作成する
			for each ( var scene:XML in prml.scene ) {
				// クラスの参照を作成する
				var cls:String = String( scene.@cls ) || "jp.progression.scenes.SceneObject";
				var classRef:Class = getDefinitionByName( cls ) as Class;
				
				// 存在しなければ例外をスローする
				if ( !classRef ) { throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_011 ).toString( cls ) ); }
				
				// SceneObject を作成する
				var child:SceneObject = new classRef() as SceneObject;
				
				// 存在しなければ例外をスローする
				if ( !child ) { throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_011 ).toString( "cls", cls, "SceneObject" ) ); }
				
				// プロパティを初期化する
				for each ( var attribute:XML in scene.attributes() ) {
					var attrName:String = String( attribute.name() );
					
					if ( !( attrName in child ) ) { continue; }
					
					child[attrName] = StringUtil.toProperType( attribute );
				}
				
				// 子シーンに追加する
				_addSceneAt( child, numScenes );
				
				// 孫シーンを追加する
				if ( scene.scene.length() > 0 ) {
					child.addSceneFromXML( <prml version={ prml.@version } type={ prml.@type }>{ scene.scene }</prml> );
				}
				
				// DataHolder を更新する
				progression_internal::$providingData = scene.*.( name() != "scene" );
				child.dataHolder.update();
			}
		}
		
		/**
		 * <p>SceneObject インスタンスの子リストから指定の SceneObject インスタンスを削除します。</p>
		 * <p>Removes the specified child SceneObject instance from the scene list of the SceneObject instance.</p>
		 * 
		 * @see #removeSceneAt()
		 * @see #removeAllScenes()
		 * 
		 * @param scene
		 * <p>対象の SceneObject インスタンスの子から削除する SceneObject インスタンスです。</p>
		 * <p>The SceneObject instance to remove.</p>
		 * @return
		 * <p>scene パラメータで渡す SceneObject インスタンスです。</p>
		 * <p>The SceneObject instance that you pass in the scene parameter.</p>
		 */
		public function removeScene( scene:SceneObject ):SceneObject {
			if ( !_scenes ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_011 ).toString( scene ) ); }
			return _removeSceneAt( _scenes.getItemIndex( scene ) );
		}
		
		/**
		 * <p>SceneObject の子リストの指定されたインデックス位置から子 SceneObject インスタンスを削除します。</p>
		 * <p>Removes a child SceneObject from the specified index position in the child list of the SceneObject.</p>
		 * 
		 * @see #removeScene()
		 * @see #removeAllScenes()
		 * 
		 * @param index
		 * <p>削除する SceneObject の子インデックスです。</p>
		 * <p>The child index of the SceneObject to remove.</p>
		 * @return
		 * <p>削除された SceneObject インスタンスです。</p>
		 * <p>The SceneObject instance that was removed.</p>
		 */
		public function removeSceneAt( index:int ):SceneObject {
			return _removeSceneAt( index );
		}
		
		/**
		 * 
		 */
		private function _removeSceneAt( index:int ):SceneObject {
			if ( !_scenes ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_011 ).toString( "DisplayObject" ) ); }
			
			// シーンを取得する
			var scene:SceneObject = _scenes.getItemAt( index );
			
			// 登録を解除する
			_scenes.removeItemAt( index );
			scene._parent = null;
			scene._root = null;
			
			// 登録情報が存在しなければ
			if ( _scenes.numItems < 1 ) {
				_scenes.dispose();
				_scenes = null;
			}
			
			// イベントフロー時の参照先の登録を解除する
			scene._eventParent = null;
			
			return scene;
		}
		
		/**
		 * <p>SceneObject に追加されている全ての子 SceneObject インスタンスを削除します。</p>
		 * <p></p>
		 * 
		 * @see #removeScene()
		 * @see #removeSceneAt()
		 */
		public function removeAllScenes():void {
			while ( _scenes && _scenes.numItems > 0 ) {
				_removeSceneAt( 0 );
			}
		}
		
		/**
		 * <p>指定されたシーンオブジェクトが SceneObject インスタンスの子であるか、オブジェクト自体であるかを指定します。</p>
		 * <p>Determines whether the specified SceneObject is a scene of the SceneObject instance or the instance itself.</p>
		 * 
		 * @param scene
		 * <p>テストする子 SceneObject インスタンスです。</p>
		 * <p>The scene object to test.</p>
		 * @return
		 * <p>scene インスタンスが SceneObject の子であるか、コンテナ自体である場合は true となります。そうでない場合は false となります。</p>
		 * <p>true if the scene object is a scene of the SceneObject or the container itself; otherwise false.</p>
		 */
		public function contains( scene:SceneObject ):Boolean {
			// 自身であれば true を返す
			if ( scene == this ) { return true; }
			
			// 子または孫に存在すれば true を返す
			for ( var i:int = 0, l:int = numScenes; i < l; i++ ) {
				if ( _scenes.contains( scene ) ) { return true; }
				if ( SceneObject( _scenes.getItemAt( i ) ).contains( scene ) ) { return true; }
			}
			
			return false;
		}
		
		/**
		 * <p>指定のインデックス位置にある子シーンオブジェクトオブジェクトを返します。</p>
		 * <p>Returns the child SceneObject instance that exists at the specified index.</p>
		 * 
		 * @param index
		 * <p>子 SceneObject インスタンスのインデックス位置です。</p>
		 * <p>The index position of the scene object.</p>
		 * @return
		 * <p>指定されたインデックス位置にある子 SceneObject インスタンスです。</p>
		 * <p>The child SceneObject at the specified index position.</p>
		 */
		public function getSceneAt( index:int ):SceneObject {
			if ( _scenes ) { return _scenes.getItemAt( index ); }
			return null;
		}
		
		/**
		 * <p>指定された名前に一致する子シーンオブジェクトを返します。</p>
		 * <p>Returns the child SceneObject that exists with the specified name.</p>
		 * 
		 * @param name
		 * <p>返される子 SceneObject インスタンスの名前です。</p>
		 * <p>The name of the scene to return.</p>
		 * @return
		 * <p>指定された名前を持つ子 SceneObject インスタンスです。</p>
		 * <p>The child SceneObject with the specified name.</p>
		 */
		public function getSceneByName( name:String ):SceneObject {
			if ( !_scenes ) { return null; }
			
			for ( var i:int = _scenes.numItems; 0 < i; i-- ) {
				var scene:SceneObject = _scenes.getItemAt( i - 1 );
				if ( scene.name == name ) { return scene; }
			}
			
			return null;
		}
		
		/**
		 * <p>子 SceneObject インスタンスのインデックス位置を返します。</p>
		 * <p>Returns the index position of a child SceneObject instance.</p>
		 * 
		 * @param child
		 * <p>特定する子 SceneObject インスタンスです。</p>
		 * <p>The SceneObject instance to identify.</p>
		 * @return
		 * <p>特定する子 SceneObject インスタンスのインデックス位置です。</p>
		 * <p>The index position of the child SceneObject to identify.</p>
		 */
		public function getSceneIndex( scene:SceneObject ):int {
			if ( !_scenes ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_011 ).toString( "DisplayObject" ) ); }
			return _scenes.getItemIndex( scene );
		}
		
		/**
		 * <p>シーンオブジェクトコンテナの既存の子の位置を変更します。</p>
		 * <p>Changes the position of an existing scene in the SceneObject container.</p>
		 * 
		 * @see #setSceneIndexAbove()
		 * 
		 * @param scene
		 * <p>インデックス番号を変更する子 SceneObject インスタンスです。</p>
		 * <p>The child SceneObject instance for which you want to change the index number.</p>
		 * @param index
		 * <p>child インスタンスの結果のインデックス番号です。</p>
		 * <p>The resulting index number for the child SceneObject.</p>
		 */
		public function setSceneIndex( scene:SceneObject, index:int ):void {
			if ( !_scenes ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_011 ).toString( "DisplayObject" ) ); }
			_scenes.setItemIndex( scene, index );
		}
		
		/**
		 * <p>シーンオブジェクトコンテナの既存の子の位置を変更します。</p>
		 * <p>Changes the position of an existing scene in the SceneObject container.</p>
		 * 
		 * @see #setSceneIndex()
		 * 
		 * @param scene
		 * <p>インデックス番号を変更する子 SceneObject インスタンスです。</p>
		 * <p>The child SceneObject instance for which you want to change the index number.</p>
		 * @param index
		 * <p>child インスタンスの結果のインデックス番号です。</p>
		 * <p>The resulting index number for the child SceneObject.</p>
		 */
		public function setSceneIndexAbove( scene:SceneObject, index:int ):void {
			if ( !_scenes ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_011 ).toString( "DisplayObject" ) ); }
			_scenes.setItemIndex( scene, _scenes.getItemAt( index ) ? index + 1 : index );
		}
		
		/**
		 * <p>指定された 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</p>
		 * <p>Swaps the z-order (front-to-back order) of the two specified scene objects.</p>
		 * 
		 * @see #swapScenesAt()
		 * 
		 * @param scene1
		 * <p>先頭の子 SceneObject インスタンスです。</p>
		 * <p>The first scene object.</p>
		 * @param scene2
		 * <p>2 番目の子 SceneObject インスタンスです。</p>
		 * <p>The second scene object.</p>
		 */
		public function swapScenes( scene1:SceneObject, scene2:SceneObject ):void {
			if ( !_scenes ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_011 ).toString( "DisplayObject" ) ); }
			_scenes.swapItems( scene1, scene2 );
		}
		
		/**
		 * <p>子リスト内の指定されたインデックス位置に該当する 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</p>
		 * <p>Swaps the z-order (front-to-back order) of the scene objects at the two specified index positions in the scene list.</p>
		 * 
		 * @see #swapScenes()
		 * 
		 * @param index1
		 * <p>最初の子 SceneObject インスタンスのインデックス位置です。</p>
		 * <p>The index position of the first scene object.</p>
		 * @param index2
		 * <p>2 番目の子 SceneObject インスタンスのインデックス位置です。</p>
		 * <p>The index position of the second scene object.</p>
		 */
		public function swapScenesAt( index1:int, index2:int ):void {
			if ( !_scenes ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_011 ).toString( "DisplayObject" ) ); }
			_scenes.swapItemsAt( index1, index2 );
		}
		
		/**
		 * <p>イベントリスナーオブジェクトを EventIntegrator インスタンスに登録し、リスナーがイベントの通知を受け取るようにします。
		 * このメソッドを使用して登録されたリスナーを removeEventListener() メソッドで削除した場合には、restoreRemovedListeners() メソッドで再登録させることができます。</p>
		 * <p>Register the event listener object into the EventIntegrator instance to get the event notification.
		 * If the registered listener by this method removed by using removeEventListener() method, it can re-register using restoreRemovedListeners() method.</p>
		 * 
		 * @param type
		 * <p>イベントのタイプです。</p>
		 * <p>The type of event.</p>
		 * @param listener
		 * <p>イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</p>
		 * <p>The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing. The function can have any name.</p>
		 * @param useCapture
		 * <p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</p>
		 * <p>Determines whether the listener works in the capture phase or the target and bubbling phases. If useCapture is set to true, the listener processes the event only during the capture phase and not in the target or bubbling phase. If useCapture is false, the listener processes the event only during the target or bubbling phase. To listen for the event in all three phases, call addEventListener twice, once with useCapture set to true, then again with useCapture set to false.</p>
		 * @param priority
		 * <p>イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</p>
		 * <p>The priority level of the event listener. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.</p>
		 * @param useWeakReference
		 * <p>リスナーへの参照が強参照と弱参照のいずれであるかを判断します。デフォルトである強参照の場合は、リスナーのガベージコレクションが回避されます。弱参照では回避されません。</p>
		 * <p>Determines whether the reference to the listener is strong or weak. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.</p>
		 */
		public override function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			( useCapture ? _captureDispatcher.addEventListener : super.addEventListener )( type, listener, false, priority, useWeakReference );
		}
		
		/**
		 * <p>EventIntegrator インスタンスからリスナーを削除します。
		 * このメソッドを使用して削除されたリスナーは、restoreRemovedListeners() メソッドで再登録させることができます。</p>
		 * <p>Remove the listener from EventIntegrator instance.
		 * The listener removed by using this method can re-register by restoreRemovedListeners() method.</p>
		 * 
		 * @param type
		 * <p>イベントのタイプです。</p>
		 * <p>The type of event.</p>
		 * @param listener
		 * <p>削除するリスナーオブジェクトです。</p>
		 * <p>The listener object to remove.</p>
		 * @param useCapture
		 * <p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</p>
		 * <p>Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</p>
		 */
		public override function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			( useCapture ? _captureDispatcher.removeEventListener : super.removeEventListener )( type, listener, false );
		}
		
		/**
		 * <p>イベントをイベントフローに送出します。</p>
		 * <p>Dispatches an event into the event flow.</p>
		 * 
		 * @param event
		 * <p>イベントフローに送出されるイベントオブジェクトです。イベントが再度送出されると、イベントのクローンが自動的に作成されます。イベントが送出された後にそのイベントの target プロパティは変更できないため、再送出処理のためにはイベントの新しいコピーを作成する必要があります。</p>
		 * <p>The Event object that is dispatched into the event flow. If the event is being redispatched, a clone of the event is created automatically. After an event is dispatched, its target property cannot be changed, so you must create a new copy of the event for redispatching to work.</p>
		 * @return
		 * <p>値が true の場合、イベントは正常に送出されました。値が false の場合、イベントの送出に失敗したか、イベントで preventDefault() が呼び出されたことを示しています。</p>
		 * <p>A value of true if the event was successfully dispatched. A value of false indicates failure or that preventDefault() was called on the event.</p>
		 */
		public override function dispatchEvent( event:Event ):Boolean {
			return _dispatchEvent( event );
		}
		
		/**
		 * 
		 */
		private function _dispatchEvent( event:Event ):Boolean {
			var result:Boolean = false;
			var e:SceneEvent = event as SceneEvent;
			
			// SceneEvent であれば
			if ( e ) {
				// シーンフローイベントであれば
				switch ( e.type ) {
					case SceneEvent.SCENE_LOAD	:
					case SceneEvent.SCENE_UNLOAD	:
					case SceneEvent.SCENE_INIT	:
					case SceneEvent.SCENE_GOTO	:
					case SceneEvent.SCENE_DESCEND	:
					case SceneEvent.SCENE_ASCEND	: {
						// ターゲットが存在すれば終了する
						if ( e.target || e.currentTarget ) { return false; }
						
						// プロパティを設定する
						e.progression_internal::$eventPhase = EventPhase.AT_TARGET;
						e.progression_internal::$target = this;
						e.progression_internal::$currentTarget = this;
						
						// イベントを送出する
						return super.dispatchEvent( e );
					}
				}
				
				if ( e.eventPhase == EventPhase.AT_TARGET ) {
					e.progression_internal::$target = this;
				}
				
				e.progression_internal::$currentTarget = this;
				
				if ( _eventParent && e.eventPhase <= EventPhase.AT_TARGET ) {
					// 新規イベントオブジェクトを作成する
					var phase1:SceneEvent = SceneEvent( e.clone() );
					phase1.progression_internal::$eventPhase = EventPhase.CAPTURING_PHASE;
					phase1.progression_internal::$target = e.progression_internal::$target;
					
					// イベントを送出する
					result = _eventParent.dispatchEvent( phase1 );
				}
				
				if ( e.eventPhase == EventPhase.CAPTURING_PHASE ) {
					// イベントを送出する
					result = _captureDispatcher.dispatchEvent( e );
				}
				else {
					// イベントを送出する
					result = super.dispatchEvent( e );
				}
				
				if ( e.bubbles && _eventParent && e.eventPhase >= EventPhase.AT_TARGET ) {
					// 新規イベントオブジェクトを作成する
					var phase3:SceneEvent = SceneEvent( e.clone() );
					phase3.progression_internal::$eventPhase = EventPhase.BUBBLING_PHASE;
					phase3.progression_internal::$target = e.target;
					
					// イベントを送出する
					result = _eventParent.dispatchEvent( phase3 );
				}
				
				return result;
			}
			else {
				// イベントを送出する
				result = super.dispatchEvent( event );
			}
			
			return result;
		}
		
		/**
		 * <p>EventIntegrator インスタンスに、特定のイベントタイプに対して登録されたリスナーがあるかどうかを確認します。</p>
		 * <p>Checks whether the EventDispatcher object has any listeners registered for a specific type of event.</p>
		 * 
		 * @param event
		 * <p>イベントのタイプです。</p>
		 * <p>The type of event.</p>
		 * @return
		 * <p>指定したタイプのリスナーが登録されている場合は true に、それ以外の場合は false になります。</p>
		 * <p>A value of true if a listener of the specified type is registered; false otherwise.</p>
		 */
		public override function hasEventListener(type:String):Boolean {
			return super.hasEventListener( type ) || _captureDispatcher.hasEventListener( type );
		}
		
		/**
		 * <p>指定されたイベントタイプについて、この EventIntegrator インスタンスまたはその祖先にイベントリスナーが登録されているかどうかを確認します。</p>
		 * <p>Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.</p>
		 * 
		 * @param event
		 * <p>イベントのタイプです。</p>
		 * <p>The type of event.</p>
		 * @return
		 * <p>指定したタイプのリスナーがトリガされた場合は true に、それ以外の場合は false になります。</p>
		 * <p>A value of true if a listener of the specified type will be triggered; false otherwise.</p>
		 */
		public override function willTrigger(type:String):Boolean {
			var result:Boolean = hasEventListener( type );
			
			if ( _eventParent) {
				result ||= _eventParent.hasEventListener( type );
			}
			
			return result;
		}
		
		/**
		 * @private
		 */
		progression_internal function $dispose():void {
			// 全ての子シーンを削除する
			removeAllScenes();
			
			// ExecutorObject を破棄する
			_executor.dispose();
			_executor = null;
			
			// SceneInfo を破棄する
			_sceneInfo.progression_internal::$dispose();
			_sceneInfo = null;
			
			// 破棄する
			id = null;
			_manager = null;
			_stage = null;
			_container = null;
			_root = null;
		}
		
		/**
		 * <p>指定されたオブジェクトの XML ストリング表現を返します。</p>
		 * <p>Returns a XML string representation of the XML object.</p>
		 * 
		 * @return
		 * <p>オブジェクトの XML ストリング表現です。</p>
		 * <p>The XML string representation of the XML object. </p>
		 */
		public function toXMLString():String {
			// シーンノードを作成する
			var xml:XML = <scene name={ name } cls={ ClassUtil.getClassPath( this ) } title={ title } />;
			
			// DataHolder のデータを追加する
			if ( dataHolder && dataHolder.data ) {
				xml.appendChild( dataHolder.data );
			}
			
			// 子シーンノードを作成する
			if ( _scenes ) {
				for ( var i:int = 0, l:int = numScenes; i < l; i++ ) {
					xml.appendChild( new XML( SceneObject( _scenes.getItemAt( i ) ).toXMLString() ) );
				}
			}
			
			return xml.toXMLString();
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
			return ObjectUtil.formatToString( this, _classNameObj.toString(), SceneId.isNaS( sceneId ) ? ( id ? "id" : null ) : "sceneId" );
		}
		
		
		
		
		
		/**
		 * シーンオブジェクトがシーンリストに追加された場合に送出されます。
		 */
		private function _sceneAdded( e:SceneEvent ):void {
			// 自身で発生したイベントではなければ終了する
			if ( e.eventPhase != EventPhase.AT_TARGET ) { return; }
			
			// 親が存在すれば
			if ( __parent ) {
				_manager = __parent._manager;
				_stage = __parent._stage;
				_sceneInfo = __parent._sceneInfo;
				_depth = __parent.depth + 1;
			}
			
			// 初期化されていなければ終了する
			if ( !Progression.config ) {
				Logger.warn( Logger.getLog( L10NProgressionMsg.ERROR_017 ).toString( this, "dataHolder" ) );
				return;
			}
			
			// DataHolder を作成する
			_dataHolder = new ( Progression.config.dataHolder as Class )( this );
			_dataHolder.update();
		}
		
		/**
		 * シーンオブジェクトが直接、またはシーンオブジェクトを含むサブツリーの追加により、ルートシーン上のシーンリストに追加されたときに送出されます。
		 */
		private function _sceneAddedToRoot( e:SceneEvent ):void {
			// 親が存在すれば
			if ( __parent ) {
				_manager = __parent._manager;
				_sceneId = new SceneId( __parent._sceneId.path + "/" + _name );
				_stage = __parent._stage;
				_sceneInfo = __parent._sceneInfo;
				_depth = __parent.depth + 1;
			}
			
			// ExecutorObject を作成する
			_executor = new ( Progression.config.executor as Class )( this );
			
			// 親が IExecutable であれば
			var executable:IExecutable = parent as IExecutable;
			if ( executable && executable.executor ) {
				executable.executor.addExecutor( _executor );
			}
		}
		
		/**
		 * シーンオブジェクトがシーンリストから削除された場合に送出されます。
		 */
		private function _sceneRemoved( e:SceneEvent ):void {
			// 自身で発生したイベントではなければ終了する
			if ( e.eventPhase != EventPhase.AT_TARGET ) { return; }
			
			// 破棄する
			_manager = null;
			_stage = null;
			_sceneInfo = null;
			_depth = 0;
			
			// DataHolder を破棄する
			if ( _dataHolder ) {
				_dataHolder.dispose();
			}
		}
		
		/**
		 * シーンオブジェクトが直接、またはシーンオブジェクトを含むサブツリーの削除により、ルートシーン上のシーンリストから削除されようとしているときに送出されます。
		 */
		private function _sceneRemovedFromRoot( e:SceneEvent ):void {
			// 破棄する
			_manager = null;
			_sceneId = SceneId.NaS;
			_stage = null;
			_sceneInfo = null;
			_depth = 0;
			
			// ExecutorObject が存在すれば
			if ( _executor ) {
				// ExecutorObject に親が存在すれば
				if ( _executor.parent ) {
					_executor.parent.removeExecutor( _executor );
				}
				
				// ExecutorObject を破棄する
				_executor.dispose();
				_executor = null;
			}
		}
		
		/**
		 * シーン移動時に目的地がシーンオブジェクト自身もしくは子階層だった場合に、階層が変更された直後に送出されます。
		 */
		private function _sceneLoad( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			atSceneLoad();
			if ( _onSceneLoad != null ) {
				_onSceneLoad.apply( this );
			}
		}
		
		/**
		 * シーン移動時に目的地がシーンオブジェクト自身もしくは親階層だった場合に、階層が変更される直前に送出されます。
		 */
		private function _sceneUnload( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			atSceneUnload();
			if ( _onSceneUnload != null ) {
				_onSceneUnload.apply( this );
			}
		}
		
		/**
		 * シーンオブジェクトが目的地だった場合に、到達した瞬間に送出されます。
		 */
		private function _sceneInit( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			atSceneInit();
			if ( _onSceneInit != null ) {
				_onSceneInit.apply( this );
			}
		}
		
		/**
		 * シーンオブジェクトが出発地だった場合に、移動を開始した瞬間に送出されます。
		 */
		private function _sceneGoto( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			atSceneGoto();
			if ( _onSceneGoto != null ) {
				_onSceneGoto.apply( this );
			}
		}
		
		/**
		 * シーン移動時に目的地がシーンオブジェクトの子階層であり、かつ出発地ではない場合に、自身が移動を中継した瞬間に送出されます。
		 */
		private function _sceneDescend( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			atSceneDescend();
			if ( _onSceneDescend != null ) {
				_onSceneDescend.apply( this );
			}
		}
		
		/**
		 * シーン移動時に目的地がシーンオブジェクトの親階層であり、かつ出発地ではない場合に、自身が移動を中継した瞬間に送出されます。
		 */
		private function _sceneAscend( e:SceneEvent ):void {
			// イベントハンドラメソッドを実行する
			atSceneAscend();
			if ( _onSceneAscend != null ) {
				_onSceneAscend.apply( this );
			}
		}
	}
}
