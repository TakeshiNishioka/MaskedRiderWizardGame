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
package jp.progression.casts {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import jp.nium.core.debug.Logger;
	import jp.nium.display.ExDocument;
	import jp.nium.events.ExEvent;
	import jp.nium.utils.URLUtil;
	import jp.progression.core.config.Configuration;
	import jp.progression.core.impls.ICastDocument;
	import jp.progression.core.impls.ICastObject;
	import jp.progression.core.impls.IManageable;
	import jp.progression.core.L10N.L10NExecuteMsg;
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.events.ManagerEvent;
	import jp.progression.events.SceneEvent;
	import jp.progression.executors.ExecutorObject;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneLoader;
	import jp.progression.ui.IContextMenuBuilder;
	
	/**
	 * <p>Progression インスタンスとの関連付けがアクティブになったときに送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ManagerEvent.MANAGER_ACTIVATE
	 */
	[Event( name="managerActivate", type="jp.progression.events.ManagerEvent" )]
	
	/**
	 * <p>Progression インスタンスとの関連付けが非アクティブになったときに送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ManagerEvent.MANAGER_DEACTIVATE
	 */
	[Event( name="managerDeactivate", type="jp.progression.events.ManagerEvent" )]
	
	/**
	 * <p>CastDocument クラスは、ExDocument クラスの基本機能を拡張し、イベントフローとの連携機能を実装した jp.progression パッケージで使用される基本的な表示オブジェクトクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastDocument extends ExDocument implements ICastObject, ICastDocument, IManageable {
		include "_inc/CastObject.contextMenu.inc"
		
		/**
		 * <p>ロードされた SWF ファイル内の表示オブジェクトの場合、root プロパティはその SWF ファイルが表す表示リストのツリー構造部分の一番上にある表示オブジェクトとなります。</p>
		 * <p>For a display object in a loaded SWF file, the root property is the top-most display object in the portion of the display list's tree structure represented by that SWF file.</p>
		 */
		public static function get root():CastDocument { return CastDocument( ExDocument.root ); }
		
		/**
		 * <p>表示オブジェクトのステージです。</p>
		 * <p>The Stage of the display object.</p>
		 */
		public static function get stage():Stage { return ExDocument.stage; }
		
		/**
		 * <p>ステージ左の X 座標を取得します。</p>
		 * <p>Get the left X coordinate of the stage.</p>
		 * 
		 * @see #right
		 * @see #top
		 * @see #bottom
		 */
		public static function get left():Number { return ExDocument.left; }
		
		/**
		 * <p>ステージ中央の X 座標を取得します。</p>
		 * <p>Get the center X coordinate of the stage.</p>
		 * 
		 * @see #center
		 */
		public static function get center():Number { return ExDocument.center; }
		
		/**
		 * <p>ステージ右の X 座標を取得します。</p>
		 * <p>Get the right X coordinate of the stage.</p>
		 * 
		 * @see #left
		 * @see #top
		 * @see #bottom
		 */
		public static function get right():Number { return ExDocument.right; }
		
		/**
		 * <p>ステージ上の Y 座標を取得します。</p>
		 * <p>Get the top Y coordinate of the stage.</p>
		 * 
		 * @see #left
		 * @see #right
		 * @see #bottom
		 */
		public static function get top():Number { return ExDocument.top; }
		
		/**
		 * <p>ステージ中央の Y 座標を取得します。</p>
		 * <p>Get the center Y coordinate of the stage.</p>
		 * 
		 * @see #centerX
		 */
		public static function get middle():Number { return ExDocument.middle; }
		
		/**
		 * <p>ステージ下の Y 座標を取得します。</p>
		 * <p>Get the bottom Y coordinate of the stage.</p>
		 * 
		 * @see #left
		 * @see #right
		 * @see #top
		 */
		public static function get bottom():Number { return ExDocument.bottom; }
		
		/**
		 * クラス内からの呼び出しかどうかを取得します。
		 */
		private static var _internallyCalled:Boolean = false;
		
		
		
		
		
		/**
		 * <p>自身の参照を取得します。</p>
		 * <p></p>
		 */
		public function get self():CastDocument { return CastDocument( this ); }
		
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
		 * <p>関連付けられている ExecutorObject インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see #onCastAdded;
		 * @see #onCastRemoved;
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 */
		public function get executor():ExecutorObject { return _executor; }
		private var _executor:ExecutorObject;
		
		/**
		 * <p>このオブジェクトの子の数を返します。
		 * このインスタンスが SceneLoader によって読み込まれている場合には、関連付けられている DisplayObjectContainer の子の数を返します。</p>
		 * <p></p>
		 */
		public override function get numChildren():int { return _getProperty( "numChildren" ) as int; }
		
		/**
		 * <p>この表示オブジェクトを含む DisplayObjectContainer オブジェクトを示します。
		 * このインスタンスが SceneLoader によって読み込まれている場合には、関連付けられている DisplayObjectContainer を示します。</p>
		 * <p></p>
		 */
		public override function get parent():DisplayObjectContainer { return _getProperty( "parent" ) as DisplayObjectContainer; }
		
		/**
		 * <p>読み込まれた SWF ファイル内の表示オブジェクトの場合、root プロパティはその SWF ファイルが表す表示リストのツリー構造部分の一番上にある表示オブジェクトとなります。
		 * このインスタンスが SceneLoader によって読み込まれている場合には、関連付けられている DisplayObject を示します。</p>
		 * <p></p>
		 */
		public override function get root():DisplayObject { return _getProperty( "root" ) as DisplayObject; }
		
		/**
		 * <p>表示オブジェクトのステージです。
		 * このインスタンスが SceneLoader によって読み込まれている場合には、関連付けられている Stage を示します。</p>
		 * <p></p>
		 */
		public override function get stage():Stage { return _getProperty( "stage" ) as Stage; }
		
		/**
		 * Progression 識別子を取得します。
		 */
		private var _managerId:String;
		
		/**
		 * ルートクラスの参照を取得します。
		 */
		private var _rootClass:Class;
		
		/**
		 * IContextMenuBuilder インスタンスを取得します。
		 */
		private var _contextMenuBuilder:IContextMenuBuilder;
		
		/**
		 * コンテクストメニューの設定を許可するかどうかを取得します。
		 */
		private var _allowBuildContextMenu:Boolean = false;
		
		/**
		 * 現在の対象コンテナを取得します。
		 */
		private var _container:DisplayObjectContainer;
		
		/**
		 * <p>SWF ファイルの読み込みが完了し、stage 及び loaderInfo にアクセス可能になった場合に呼び出されるイベントハンドラメソッドを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see jp.nium.events.ExEvent#READY
		 */
		public function get onReady():Function { return _onReady; }
		public function set onReady( value:Function ):void { _onReady = value; }
		private var _onReady:Function;
		
		/**
		 * <p>SWF ファイルの読み込みが完了し、stage 及び loaderInfo にアクセス可能になった場合に呼び出されるオーバーライド・イベントハンドラメソッドです。</p>
		 * <p></p>
		 */
		protected function atReady():void {}
		
		
		
		
		
		/**
		 * <p>新しい CastDocument インスタンスを作成します。</p>
		 * <p>Creates a new CastDocument object.</p>
		 * 
		 * @param managerId
		 * <p>自動的に生成される Progression インスタンスの識別子です。
		 * 省略した場合には SWF ファイル名が自動的に割り当てられます。</p>
		 * <p></p>
		 * @param rootClass
		 * <p>自動的に生成される Progression インスタンスのルートシーンに関連付けたいクラスの参照です。</p>
		 * <p></p>
		 * @param config
		 * <p>自動的に生成される Progression インスタンスの初期化情報として使用したい Configuration インスタンスです。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function CastDocument( managerId:String = null, rootClass:Class = null, config:Configuration = null, initObject:Object = null ) {
			// 環境設定を適用する
			if ( config ) {
				Progression.initialize( config );
			}
			
			// 初期化する
			_container = this;
			
			// 引数を設定する
			_managerId = managerId;
			_rootClass = rootClass;
			
			// 親クラスを初期化する
			super( initObject );
			
			// イベントリスナーを登録する
			super.addEventListener( ExEvent.EX_READY, _ready, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		progression_internal function $initialize( xml:XML = null, loader:SceneLoader = null, container:Sprite = null ):void {
			// すでに存在していれば
			if ( _manager ) { throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_002 ).toString( super.className ) ); }
			
			// stage の参照を取得する
			var target:Stage = super.stage || loader.stage;
			
			// 識別子が設定されていなければ、ファイル名から自動的に指定する
			_managerId ||= URLUtil.getFileName( super.loaderInfo.url ) + ".swf";
			
			// Progression の初期設定を行う
			Progression.progression_internal::$container = container || this;
			Progression.progression_internal::$loader = loader;
			
			// Progression を作成する
			_manager = xml ? Progression.createFromXML( target, xml ) : new Progression( _managerId, target, _rootClass );
			
			// コンテナを設定する
			_container = _manager.root.container;
			
			// イベントを送出する
			super.dispatchEvent( new ManagerEvent( ManagerEvent.MANAGER_ACTIVATE ) );
			
			// ExecutorObject を作成する
			_executor = new ( Progression.config.executor as Class )( this );
			
			// コンテクストメニューを初期化する
			var cls:Class = Progression.config.contextMenuBuilder;
			if ( cls ) {
				_allowBuildContextMenu = true;
				_contextMenuBuilder = new cls( this );
				_allowBuildContextMenu = false;
			}
			
			if ( loader ) {
				// イベントを送出する
				_manager.root.dispatchEvent( new SceneEvent( SceneEvent.SCENE_ADDED, true, false ) );
				_manager.root.dispatchEvent( new SceneEvent( SceneEvent.SCENE_ADDED_TO_ROOT, true, false ) );
			}
			
			// 破棄する
			_managerId = null;
			_rootClass = null;
		}
		
		/**
		 * @private
		 */
		progression_internal function $dispose():void {
			// Progression を破棄する
			_manager.progression_internal::$dispose();
			_manager = null;
			
			// コンテナを破棄する
			_container = this;
			
			// イベントを送出する
			super.dispatchEvent( new ManagerEvent( ManagerEvent.MANAGER_DEACTIVATE ) );
		}
		
		/**
		 * 対象のプロパティ値を取得します。
		 */
		private function _getProperty( name:String ):* {
			if ( _internallyCalled ) {
				return super[ name ];
			}
			else {
				_internallyCalled = true;
				var result:* = _container[ name ];
				_internallyCalled = false;
			}
			
			return result;
		}
		
		/**
		 * 対象のメソッドを実行します。
		 */
		private function _applyFunction( name:String, ... args:Array ):* {
			var result:*;
			
			if ( _internallyCalled ) {
				return super[ name ].apply( this, args );
			}
			else {
				_internallyCalled = true;
				if ( _container && name in _container ) {
					result = _container[ name ].apply( null, args );
				}
				else {
					result = super[ name ].apply( null, args );
				}
				_internallyCalled = false;
			}
			
			return result;
		}
		
		/**
		 * <p>マネージャオブジェクトとの関連付けを更新します。</p>
		 * <p></p>
		 * 
		 * @return
		 * <p>関連付けが成功したら true を、それ以外は false を返します。</p>
		 * <p></p>
		 */
		public function updateManager():Boolean {
			return true;
		}
		
		/**
		 * <p>特定のイベントが送出された際に、自動実行させたい Command インスタンスをリストの最後尾に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に初期化されます。
		 * このメソッドを使用するためには executor プロパティに CommandExecutor が実装されている必要があります。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #onCastAdded;
		 * @see #onCastRemoved;
		 * @see #insertCommand();
		 * @see #clearCommand();
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
		 * @see #onCastAdded;
		 * @see #onCastRemoved;
		 * @see #addCommand();
		 * @see #clearCommand();
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
		 * @see #onCastAdded;
		 * @see #onCastRemoved;
		 * @see #addCommand();
		 * @see #insertCommand();
		 * 
		 * @param completely
		 * <p>true が設定されている場合は登録されている全てのコマンド登録を解除し、false の場合には現在処理中のコマンド以降の登録を解除します。</p>
		 * <p></p>
		 */
		public function clearCommand( completely:Boolean = false ):void {
			if ( !_executor ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_009 ).toString( "clearCommand" ) ); }
			if ( !( "clearCommand" in _executor ) ) { throw new Error( Logger.getLog( L10NExecuteMsg.ERROR_001 ).toString( "clearCommand", "CommandExecutor" ) ); }
			
			Object( _executor ).clearCommand( completely );
		}
		
		/**
		 * <p>この DisplayObjectContainer インスタンスに子 DisplayObject インスタンスを追加します。</p>
		 * <p>Adds a child DisplayObject instance to this DisplayObjectContainer instance.</p>
		 * 
		 * @param child
		 * <p>対象の DisplayObjectContainer インスタンスの子として追加する DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance to add as a child of this DisplayObjectContainer instance.</p>
		 * @return
		 * <p>child パラメータで渡す DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance that you pass in the child parameter.</p>
		 */
		public override function addChild( child:DisplayObject ):DisplayObject {
			return _applyFunction( "addChild", child ) as DisplayObject;
		}
		
		/**
		 * <p>この DisplayObjectContainer インスタンスの指定されたインデックス位置に子 DisplayObject インスタンスを追加します。</p>
		 * <p>Adds a child DisplayObject instance to this DisplayObjectContainer instance.</p>
		 * 
		 * @param child
		 * <p>対象の DisplayObjectContainer インスタンスの子として追加する DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance to add as a child of this DisplayObjectContainer instance.</p>
		 * @param index
		 * <p>子を追加するインデックス位置です。</p>
		 * <p>The index position to which the child is added. If you specify a currently occupied index position, the child object that exists at that position and all higher positions are moved up one position in the child list.</p>
		 * @return
		 * <p>child パラメータで渡す DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance that you pass in the child parameter.</p>
		 */
		public override function addChildAt( child:DisplayObject, index:int ):DisplayObject {
			return _applyFunction( "addChildAt", child, index ) as DisplayObject;
		}
		
		/**
		 * <p>この DisplayObjectContainer インスタンスの指定されたインデックス位置に子 DisplayObject インスタンスを追加します。</p>
		 * <p>Adds a child DisplayObject instance to this DisplayObjectContainer instance.</p>
		 * 
		 * @param child
		 * <p>対象の DisplayObjectContainer インスタンスの子として追加する DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance to add as a child of this DisplayObjectContainer instance.</p>
		 * @param index
		 * <p>子を追加するインデックス位置です。</p>
		 * <p>The index position to which the child is added. If you specify a currently occupied index position, the child object that exists at that position and all higher positions are moved up one position in the child list.</p>
		 * @return
		 * <p>child パラメータで渡す DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance that you pass in the child parameter.</p>
		 */
		public override function addChildAtAbove( child:DisplayObject, index:int ):DisplayObject {
			return _applyFunction( "addChildAtAbove", child, index ) as DisplayObject;
		}
		
		/**
		 * <p>DisplayObjectContainer インスタンスの子リストから指定の DisplayObject インスタンスを削除します。</p>
		 * <p>Removes the specified child DisplayObject instance from the child list of the DisplayObjectContainer instance.</p>
		 * 
		 * @param child
		 * <p>対象の DisplayObjectContainer インスタンスの子から削除する DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance to remove.</p>
		 * @return
		 * <p>child パラメータで渡す DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance that you pass in the child parameter.</p>
		 */
		public override function removeChild( child:DisplayObject ):DisplayObject {
			return _applyFunction( "removeChild", child ) as DisplayObject;
		}
		
		/**
		 * <p>DisplayObjectContainer の子リストの指定されたインデックス位置から子 DisplayObject インスタンスを削除します。</p>
		 * <p>Removes a child DisplayObject from the specified index position in the child list of the DisplayObjectContainer.</p>
		 * 
		 * @param index
		 * <p>削除する DisplayObject の子インデックスです。</p>
		 * <p>The child index of the DisplayObject to remove.</p>
		 * @return
		 * <p>削除された DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance that was removed.</p>
		 */
		public override function removeChildAt( index:int ):DisplayObject {
			return _applyFunction( "removeChildAt", index ) as DisplayObject;
		}
		
		/**
		 * <p>DisplayObjectContainer に追加されている全ての子 DisplayObject インスタンスを削除します。</p>
		 * <p>Remove the whole child DisplayObject instance which added to the DisplayObjectContainer.</p>
		 */
		public override function removeAllChildren():void {
			_applyFunction( "removeAllChildren" );
		}
		
		/**
		 * <p>指定された表示オブジェクトが DisplayObjectContainer インスタンスの子であるか、オブジェクト自体であるかを指定します。</p>
		 * <p>Determines whether the specified display object is a child of the DisplayObjectContainer instance or the instance itself.</p>
		 * 
		 * @param child
		 * <p>テストする子 DisplayObject インスタンスです。</p>
		 * <p>The child object to test.</p>
		 * @return
		 * <p>child インスタンスが DisplayObjectContainer の子であるか、コンテナ自体である場合は true となります。そうでない場合は false となります。</p>
		 * <p>true if the child object is a child of the DisplayObjectContainer or the _container itself; otherwise false.</p>
		 */
		public override function contains( child:DisplayObject ):Boolean {
			return _applyFunction( "contains", child ) as Boolean;
		}
		
		/**
		 * <p>指定のインデックス位置にある子表示オブジェクトオブジェクトを返します。</p>
		 * <p>Returns the child display object instance that exists at the specified index.</p>
		 * 
		 * @param index
		 * <p>子 DisplayObject インスタンスのインデックス位置です。</p>
		 * <p>The index position of the child object.</p>
		 * @return
		 * <p>指定されたインデックス位置にある子 DisplayObject インスタンスです。</p>
		 * <p>The child display object at the specified index position.</p>
		 */
		public override function getChildAt( index:int ):DisplayObject {
			return _applyFunction( "getChildAt", index ) as DisplayObject;
		}
		
		/**
		 * <p>指定された名前に一致する子表示オブジェクトを返します。</p>
		 * <p>Returns the child display object that exists with the specified name.</p>
		 * 
		 * @param name
		 * <p>返される子 DisplayObject インスタンスの名前です。</p>
		 * <p>The name of the child to return.</p>
		 * @return
		 * <p>指定された名前を持つ子 DisplayObject インスタンスです。</p>
		 * <p>The child display object with the specified name.</p>
		 */
		public override function getChildByName( name:String ):DisplayObject {
			return _applyFunction( "getChildByName", name ) as DisplayObject;
		}
		
		/**
		 * <p>子 DisplayObject インスタンスのインデックス位置を返します。</p>
		 * <p>Returns the index position of a child DisplayObject instance.</p>
		 * 
		 * @param child
		 * <p>特定する子 DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance to identify.</p>
		 * @return
		 * <p>特定する子 DisplayObject インスタンスのインデックス位置です。</p>
		 * <p>The index position of the child display object to identify.</p>
		 */
		public override function getChildIndex( child:DisplayObject ):int {
			return _applyFunction( "getChildIndex", child ) as int;
		}
		
		/**
		 * <p>表示オブジェクトコンテナの既存の子の位置を変更します。</p>
		 * <p>Changes the position of an existing child in the display object container.</p>
		 * 
		 * @param child
		 * <p>インデックス番号を変更する子 DisplayObject インスタンスです。</p>
		 * <p>The child DisplayObject instance for which you want to change the index number.</p>
		 * @param index
		 * <p>child インスタンスの結果のインデックス番号です。</p>
		 * <p>The resulting index number for the child display object.</p>
		 */
		public override function setChildIndex( child:DisplayObject, index:int ):void {
			_applyFunction( "setChildIndex", child, index );
		}
		
		/**
		 * <p>表示オブジェクトコンテナの既存の子の位置を変更します。</p>
		 * <p>Changes the position of an existing child in the display object container.</p>
		 * 
		 * @param child
		 * <p>インデックス番号を変更する子 DisplayObject インスタンスです。</p>
		 * <p>The child DisplayObject instance for which you want to change the index number.</p>
		 * @param index
		 * <p>child インスタンスの結果のインデックス番号です。</p>
		 * <p>The resulting index number for the child display object.</p>
		 */
		public override function setChildIndexAbove( child:DisplayObject, index:int ):void {
			_applyFunction( "setChildIndexAbove", child, index );
		}
		
		/**
		 * <p>指定された 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</p>
		 * <p>Swaps the z-order (front-to-back order) of the two specified child objects.</p>
		 * 
		 * @param child1
		 * <p>先頭の子 DisplayObject インスタンスです。</p>
		 * <p>The first child object.</p>
		 * @param child2
		 * <p>2 番目の子 DisplayObject インスタンスです。</p>
		 * <p>The second child object.</p>
		 */
		public override function swapChildren( child1:DisplayObject, child2:DisplayObject ):void {
			_applyFunction( "swapChildren", child1, child2 );
		}
		
		/**
		 * <p>子リスト内の指定されたインデックス位置に該当する 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</p>
		 * <p>Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list.</p>
		 * 
		 * @param index1
		 * <p>最初の子 DisplayObject インスタンスのインデックス位置です。</p>
		 * <p>The index position of the first child object.</p>
		 * @param index2
		 * <p>2 番目の子 DisplayObject インスタンスのインデックス位置です。</p>
		 * <p>The index position of the second child object.</p>
		 */
		public override function swapChildrenAt( index1:int, index2:int ):void {
			_applyFunction( "swapChildrenAt", index1, index2 );
		}
		
		
		
		
		
		/**
		 * SWF ファイルの読み込みが完了し、stage 及び loaderInfo にアクセス可能になった場合に送出されます。
		 */
		private function _ready( e:ExEvent ):void {
			// イベントリスナーを解除する
			super.removeEventListener( ExEvent.EX_READY, _ready );
			
			// Progression が存在しなければ
			if ( !_manager ) {
				progression_internal::$initialize();
			}
			
			// イベントハンドラメソッドを実行する
			atReady();
			if ( _onReady != null ) {
				_onReady.apply( this );
			}
		}
	}
}
