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
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getDefinitionByName;
	import jp.nium.core.debug.Logger;
	import jp.nium.display.ExDocument;
	import jp.nium.events.ExEvent;
	import jp.progression.core.impls.ICastObject;
	import jp.progression.core.impls.ICastPreloader;
	import jp.progression.core.L10N.L10NExecuteMsg;
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.events.CastEvent;
	import jp.progression.events.ExecuteEvent;
	import jp.progression.executors.ExecutorObject;
	import jp.progression.ui.IContextMenuBuilder;
	
	/**
	 * <p>オブジェクトが読み込みを開始した瞬間に送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastEvent.CAST_LOAD_START
	 */
	[Event( name="castLoadStart", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <p>オブジェクトが読み込みを完了した瞬間に送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastEvent.CAST_LOAD_COMPLETE
	 */
	[Event( name="castLoadComplete", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <p>ダウンロード処理を実行中にデータを受信したときに送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event( name="progress", type="flash.events.ProgressEvent" )]
	
	/**
	 * <p>入出力エラーが発生して読み込み処理が失敗したときに送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType flash.events.IOErrorEvent.IO_ERROR
	 */
	[Event( name="ioError", type="flash.events.IOErrorEvent" )]
	
	/**
	 * <p>CastPreloader クラスは、ExDocument クラスの基本機能を拡張し、イベントフローとの連携機能を実装した jp.progression パッケージで使用されるプリロード処理に特化した表示オブジェクトクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastPreloader extends ExDocument implements ICastObject, ICastPreloader {
		include "_inc/CastPreloader.contextMenu.inc"
		
		/**
		 * <p>ロードされた SWF ファイル内の表示オブジェクトの場合、root プロパティはその SWF ファイルが表す表示リストのツリー構造部分の一番上にある表示オブジェクトとなります。</p>
		 * <p>For a display object in a loaded SWF file, the root property is the top-most display object in the portion of the display list's tree structure represented by that SWF file.</p>
		 */
		public static function get root():CastPreloader { return CastPreloader( ExDocument.root ); }
		
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
		 * @private
		 */
		progression_internal static function get $instance():CastPreloader { return _instance; }
		private static var _instance:CastPreloader;
		
		
		
		
		/**
		 * <p>自動的に読み込まれる SWF ファイルの URL を取得します。</p>
		 * <p></p>
		 */
		public function get request():URLRequest { return _request; }
		private var _request:URLRequest;
		
		/**
		 * <p>オブジェクトをロードする前に、Flash Player がクロスドメインポリシーファイルの存在を確認するかどうかを取得または指定します。
		 * ただし、読み込み処理が開始された以降は設定を変更することはできません。</p>
		 * <p></p>
		 */
		public function get checkPolicyFile():Boolean { return _checkPolicyFile; }
		private var _checkPolicyFile:Boolean = false;
		
		/**
		 * <p>自身の参照を取得します。</p>
		 * <p></p>
		 */
		public function get self():CastPreloader { return CastPreloader( this ); }
		
		/**
		 * <p>関連付けられている ExecutorObject インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 */
		public function get executor():ExecutorObject { return _executor; }
		private var _executor:ExecutorObject;
		
		/**
		 * IContextMenuBuilder インスタンスを取得します。
		 */
		private var _contextMenuBuilder:IContextMenuBuilder;
		
		/**
		 * コンテクストメニューの設定を許可するかどうかを取得します。
		 */
		private var _allowBuildContextMenu:Boolean = false;
		
		/**
		 * <p>読み込まれるコンテンツよりも前面に表示したい DisplayObject を管理する Sprite インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get foreground():Sprite { return _foreground; }
		private var _foreground:Sprite;
		
		/**
		 * <p>load() メソッドまたは loadBytes() メソッドを使用して読み込まれた SWF ファイルまたはイメージ（JPG、PNG、または GIF）ファイルのルート表示オブジェクトが含まれます。</p>
		 * <p>Contains the root display object of the SWF file or image (JPG, PNG, or GIF) file that was loaded by using the load() or loadBytes() methods.</p>
		 */
		public function get content():DisplayObject { return _loader.content; }
		
		/**
		 * <p>読み込まれるコンテンツよりも背面に表示したい DisplayObject を管理する Sprite インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get background():Sprite { return _background; }
		private var _background:Sprite;
		
		/**
		 * <p>読み込まれているオブジェクトに対応する LoaderInfo オブジェクトを返します。</p>
		 * <p>Returns a LoaderInfo object corresponding to the object being loaded.</p>
		 */
		public function get contentLoaderInfo():LoaderInfo { return _loader.contentLoaderInfo; }
		private var _loader:Loader;
		
		/**
		 * <p>そのメディアのロード済みのバイト数です。</p>
		 * <p>The number of bytes that are loaded for the media.</p>
		 */
		public function get bytesLoaded():uint { return _bytesLoaded; }
		private var _bytesLoaded:uint = 0;
		
		/**
		 * <p>メディアファイル全体の圧縮後のバイト数です。</p>
		 * <p>The number of compressed bytes in the entire media file.</p>
		 */
		public function get bytesTotal():uint { return _bytesTotal; }
		private var _bytesTotal:uint = 0;
		
		/**
		 * ExecutorObject クラスを取得します。
		 */
		private var _executorClass:Class;
		
		/**
		 * Progression クラスを取得します。
		 */
		private var _managerClass:Class;
		
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
		 * <p>ProgressEvent.PROGRESS イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。</p>
		 * <p></p>
		 */
		public function get onProgress():Function { return _onProgress; }
		public function set onProgress( value:Function ):void { _onProgress = value; }
		private var _onProgress:Function;
		
		/**
		 * <p>ProgressEvent.PROGRESS イベントを受け取った場合に呼び出されるオーバーライド・イベントハンドラメソッドです。</p>
		 * <p></p>
		 */
		protected function atProgress():void {}
		
		/**
		 * <p>読み込み処理が開始される直前に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 */
		public function get onCastLoadStart():Function { return _onCastLoadStart; }
		public function set onCastLoadStart( value:Function ):void { _onCastLoadStart = value; }
		private var _onCastLoadStart:Function;
		
		/**
		 * <p>読み込み処理が開始される直前に呼び出されるオーバーライド・イベントハンドラメソッドです。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 */
		protected function atCastLoadStart():void {}
		
		/**
		 * <p>読み込み処理が完了された直後に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 */
		public function get onCastLoadComplete():Function { return _onCastLoadComplete; }
		public function set onCastLoadComplete( value:Function ):void { _onCastLoadComplete = value; }
		private var _onCastLoadComplete:Function;
		
		/**
		 * <p>読み込み処理が完了された直後に呼び出されるオーバーライド・イベントハンドラメソッドです。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 */
		protected function atCastLoadComplete():void {}
		
		
		
		
		
		/**
		 * <p>新しい CastPreloader インスタンスを作成します。</p>
		 * <p>Creates a new CastPreloader object.</p>
		 * 
		 * @param request
		 * <p>読み込む SWF ファイルの絶対 URL または相対 URL です。</p>
		 * <p>The absolute or relative URL of the SWF file to be loaded.</p>
		 * @param checkPolicyFile
		 * <p>オブジェクトをロードする前に、URL ポリシーファイルの存在を確認するかどうかを指定します。</p>
		 * <p>Specifies whether a check should be made for the existence of a URL policy file before loading the object.</p>
		 * @param executorClass
		 * <p>汎用的な処理の実装として使用したいクラスです。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function CastPreloader( request:URLRequest, checkPolicyFile:Boolean = false, executorClass:Class = null, initObject:Object = null ) {
			// 引数を設定する
			_request = request;
			_checkPolicyFile = checkPolicyFile;
			_executorClass = executorClass || ExecutorObject;
			
			// インスタンスを登録する
			_instance = CastPreloader( this );
			
			// Sprite を作成する
			_foreground = new Sprite();
			_background = new Sprite();
			
			// 親クラスを初期化する
			super( initObject );
			
			// 既存の DisplayObject を取得する
			var list:Array = [];
			var l:int; l = super.children.length;
			for ( var i:int = 0; i < l; i++ ) {
				list.push( super.children[i] );
			}
			
			// 表示リストに追加する
			super.addChild( _background );
			super.addChild( _foreground );
			
			// 既存の表示オブジェクトを background に移行する
			for ( i = 0, l = list.length; i < l; i++ ) {
				_background.addChild( super.removeChild( list[i] ) );
			}
			list = null;
			
			// Loader を作成する
			_loader = new Loader();
			
			// イベントリスナーを登録する
			super.addEventListener( ExEvent.EX_READY, _ready );
			super.addEventListener( CastEvent.CAST_LOAD_START, _castLoadStart );
			super.addEventListener( CastEvent.CAST_LOAD_COMPLETE, _castLoadComplete );
			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, _progress );
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, _complete );
			_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, super.dispatchEvent );
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
			return false;
		}
		
		/**
		 * <p>特定のイベントが送出された際に、自動実行させたい Command インスタンスをリストの最後尾に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に初期化されます。
		 * このメソッドを使用するためには executor プロパティに CommandExecutor が実装されている必要があります。</p>
		 * <p></p>
		 * 
		 * @see #executor
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
		 * @private
		 */
		public override function addChild( child:DisplayObject ):DisplayObject {
			throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_015 ).toString( this ) );
		}
		
		/**
		 * @private
		 */
		public override function addChildAt( child:DisplayObject, index:int ):DisplayObject {
			throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_015 ).toString( this ) );
		}
		
		/**
		 * @private
		 */
		public override function addChildAtAbove( child:DisplayObject, index:int ):DisplayObject {
			throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_015 ).toString( this ) );
		}
		
		/**
		 * @private
		 */
		public override function removeChild( child:DisplayObject ):DisplayObject {
			throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_015 ).toString( this ) );
		}
		
		/**
		 * @private
		 */
		public override function removeChildAt( index:int ):DisplayObject {
			throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_015 ).toString( this ) );
		}
		
		/**
		 * @private
		 */
		public override function removeAllChildren():void {
			throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_015 ).toString( this ) );
		}
		
		/**
		 * @private
		 */
		public override function setChildIndex( child:DisplayObject, index:int ):void {
			throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_015 ).toString( this ) );
		}
		
		/**
		 * @private
		 */
		public override function setChildIndexAbove( child:DisplayObject, index:int ):void {
			throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_015 ).toString( this ) );
		}
		
		/**
		 * @private
		 */
		public override function swapChildren( child1:DisplayObject, child2:DisplayObject ):void {
			throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_015 ).toString( this ) );
		}
		
		/**
		 * @private
		 */
		public override function swapChildrenAt( index1:int, index2:int ):void {
			throw new Error( Logger.getLog( L10NProgressionMsg.ERROR_015 ).toString( this ) );
		}
		
		
		
		
		/**
		 * SWF ファイルの読み込みが完了し、stage 及び loaderInfo にアクセス可能になった場合に送出されます。
		 */
		private function _ready( e:ExEvent ):void {
			// 読み込み状態を取得する
			_bytesLoaded = 0;
			_bytesTotal = 0;
			
			// イベントハンドラメソッドを実行する
			atReady();
			if ( _onReady != null ) {
				_onReady.apply( this );
			}
			
			// ExecutorObject を作成する
			_executor = new _executorClass( this ) as ExecutorObject;
			
			// イベントリスナーを登録する
			_executor.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteLoadStart );
			
			// 実行する
			_executor.execute( new CastEvent( CastEvent.CAST_LOAD_START ) );
		}
		
		/**
		 * 処理が完了した場合に送出されます。
		 */
		private function _executeCompleteLoadStart( e:ExecuteEvent ):void {
			// イベントリスナーを解除する
			_executor.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteLoadStart );
			
			// ExecutorObject を破棄する
			_executor.dispose();
			_executor = null;
			
			// ファイルを読み込む
			_loader.load( _request, new LoaderContext( _checkPolicyFile, ApplicationDomain.currentDomain ) );
		}
		
		/**
		 * データが正常にロードされたときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// イベントリスナーを解除する
			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, _progress );
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, _complete );
			_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, super.dispatchEvent );
			
			// ExecutorObject を作成する
			_executor = new ( _executorClass || ExecutorObject )( this ) as ExecutorObject;
			
			// イベントリスナーを登録する
			_executor.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteLoadComplete );
			
			// 実行する
			_executor.execute( new CastEvent( CastEvent.CAST_LOAD_COMPLETE ) );
		}
		
		/**
		 * 処理が完了した場合に送出されます。
		 */
		private function _executeCompleteLoadComplete( e:ExecuteEvent ):void {
			// イベントリスナーを解除する
			_executor.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteLoadComplete );
			
			// ExecutorObject を破棄する
			_executor.dispose();
			_executor = null;
			
			// Progression の生成を検知する
			try {
				// Progression クラスを取得する
				_managerClass = getDefinitionByName( "jp.progression.Progression" ) as Class;
				
				// イベントリスナーを登録する
				_managerClass.progression_internal::$collections.addEventListener( "collectionUpdate", _collectionUpdate );
			}
			catch ( e:Error ) {}
			
			// 表示リストに追加する
			super.addChildAt( _loader, super.getChildIndex( _background ) + 1 );
		}
		
		/**
		 * 
		 */
		private function _collectionUpdate( e:Event ):void {
			// イベントリスナーを解除する
			_managerClass.progression_internal::$collections.addEventListener( "collectionUpdate", _collectionUpdate );
			
			// 環境設定が存在しなければ終了する
			if ( !_managerClass.config ) { return; }
			
			// コンテクストメニューを作成する
			var cls:Class = _managerClass.config.contextMenuBuilder;
			if ( cls ) {
				_allowBuildContextMenu = true;
				_contextMenuBuilder = new cls( this );
				_allowBuildContextMenu = false;
			}
		}
		
		/**
		 * オブジェクトが読み込みを開始した瞬間に送出されます。
		 */
		private function _castLoadStart( e:CastEvent ):void {
			// イベントハンドラメソッドを実行する
			atCastLoadStart();
			if ( _onCastLoadStart != null ) {
				_onCastLoadStart.apply( this );
			}
		}
		
		/**
		 * ダウンロード処理を実行中にデータを受信したときに送出されます。
		 */
		private function _progress( e:ProgressEvent ):void {
			// 読み込み状態を取得する
			_bytesLoaded = _loader.contentLoaderInfo.bytesLoaded;
			_bytesTotal = _loader.contentLoaderInfo.bytesTotal;
			
			// イベントを送出する
			super.dispatchEvent( e );
			
			// イベントハンドラメソッドを実行する
			atProgress();
			if ( _onProgress != null ) {
				_onProgress.apply( this );
			}
		}
		
		/**
		 * オブジェクトが読み込みを完了した瞬間に送出されます。
		 */
		private function _castLoadComplete( e:CastEvent ):void {
			// イベントハンドラメソッドを実行する
			atCastLoadComplete();
			if ( _onCastLoadComplete != null ) {
				_onCastLoadComplete.apply( this );
			}
		}
	}
}
