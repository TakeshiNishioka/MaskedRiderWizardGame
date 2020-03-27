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
package jp.progression.debug {
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	import jp.progression.casts.CastButton;
	import jp.progression.commands.Command;
	import jp.progression.core.impls.ICastObject;
	import jp.progression.data.DataHolder;
	import jp.progression.executors.CommandExecutor;
	import jp.progression.executors.ExecutorObject;
	import jp.progression.executors.ResumeExecutor;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneObject;
	
	/**
	 * <p>Debugger クラスは、各種インスタンスのイベント発生状況を管理し、状態の変化を出力する開発者用のデバッガクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class Debugger {
		
		/**
		 * <p>デバッガを有効化するかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		public static function get enabled():Boolean { return Logger.enabled; }
		public static function set enabled( value:Boolean ):void {
			Logger.enabled = value;
			
			for each ( var watcher:Watcher in _watchers ) {
				watcher.enabled = value;
			}
		}
		
		/**
		 * <p>監視レベルを取得または設定します。</p>
		 * <p></p>
		 */
		public static function get level():int { return Logger.level; }
		public static function set level( value:int ):void { Logger.level = value; }
		
		/**
		 * 監視オブジェクトを保持した Dictionary インスタンスを取得します。
		 */
		private static var _watchers:Dictionary = new Dictionary( true );
		
		/**
		 * <p>出力されるメッセージに対して連番を付加するかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		public static function get insertSerialNums():Boolean { return Logger.insertSerialNums; }
		public static function set insertSerialNums( value:Boolean ):void { Logger.insertSerialNums = value; }
		
		/**
		 * <p>ログ出力に使用するロギング関数を取得または設定します。</p>
		 * <p></p>
		 */
		public static function get loggingFunction():Function { return Logger.loggingFunction; }
		public static function set loggingFunction( value:Function ):void { Logger.loggingFunction = value; }
		
		
		
		
		
		/**
		 * @private
		 */
		public function Debugger() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>監視対象にインスタンスを登録します。</p>
		 * <p></p>
		 * 
		 * @param target
		 * <p>登録したいインスタンスです。</p>
		 * <p></p>
		 */
		public static function addTarget( target:IEventDispatcher ):void {
			switch ( true ) {
				case target is Progression		: { _watchers[target] = new ProgressionWatcher( target as Progression ); break; }
				case target is SceneObject		: { _watchers[target] = new SceneObjectWatcher( target as SceneObject ); break; }
				case target is CastButton		: { _watchers[target] = new CastButtonWatcher( target as CastButton ); break; }
				case target is ICastObject		: { _watchers[target] = new CastObjectWatcher( target as ICastObject ); break; }
				case target is ResumeExecutor	: { _watchers[target] = new ResumeExecutorObjectWatcher( target as ResumeExecutor ); break; }
				case target is CommandExecutor	: { _watchers[target] = new CommandExecutorObjectWatcher( target as CommandExecutor ); break; }
				case target is ExecutorObject	: { _watchers[target] = new ExecutorObjectWatcher( target as ExecutorObject ); break; }
				case target is Command			: { _watchers[target] = new CommandWatcher( target as Command ); break; }
				case target is DataHolder		: { _watchers[target] = new DataHolderWatcher( target as DataHolder ); break; }
			}
		}
		
		/**
		 * <p>監視対象のインスタンスを解除します。</p>
		 * <p></p>
		 * 
		 * @param target
		 * <p>解除したいインスタンスです。</p>
		 * <p></p>
		 */
		public static function removeTarget( target:IEventDispatcher ):void {
			if ( _watchers[target] ) {
				_watchers[target].dispose();
				delete _watchers[target];
			}
		}
	}		
}





import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.EventPhase;
import flash.events.IEventDispatcher;
import flash.system.Capabilities;
import flash.utils.getDefinitionByName;
import jp.nium.core.debug.Logger;
import jp.nium.external.JavaScript;
import jp.nium.utils.StringUtil;
import jp.progression.casts.CastButton;
import jp.progression.commands.Command;
import jp.progression.commands.CommandList;
import jp.progression.core.impls.ICastObject;
import jp.progression.core.impls.IManageable;
import jp.progression.core.L10N.L10NDebugMsg;
import jp.progression.data.DataHolder;
import jp.progression.debug.Debugger;
import jp.progression.events.CastEvent;
import jp.progression.events.CastMouseEvent;
import jp.progression.events.DataProvideEvent;
import jp.progression.events.ExecuteErrorEvent;
import jp.progression.events.ExecuteEvent;
import jp.progression.events.ManagerEvent;
import jp.progression.events.ProcessEvent;
import jp.progression.events.SceneEvent;
import jp.progression.executors.CommandExecutor;
import jp.progression.executors.ExecutorObject;
import jp.progression.executors.ResumeExecutor;
import jp.progression.Progression;
import jp.progression.scenes.SceneObject;

/**
 * <p></p>
 * <p></p>
 */
class Watcher extends EventDispatcher {
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public function get target():IEventDispatcher { return _target; }
	private var _target:IEventDispatcher;
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public function get enabled():Boolean { return _enabled; }
	public function set enabled( value:Boolean ):void { _enabled = value; }
	private var _enabled:Boolean = false;
	
	
	
	
	
	/**
	 * <p>新しい Watcher インスタンスを作成します。</p>
	 * <p>Creates a new Watcher object.</p>
	 * 
	 * @param target
	 * <p></p>
	 * <p></p>
	 */
	public function Watcher( target:IEventDispatcher ) {
		// 引数を設定する
		_target = target;
		
		// 有効化する
		enabled = true;
	}
	
	
	
	
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public function dispose():void {
		// 無効化する
		enabled = false;
		
		// 破棄する
		_target = null;
	}
}





/**
 * <p></p>
 * <p></p>
 */
class ProgressionWatcher extends Watcher {
	
	/**
	 * 
	 */
	private static var _initialized:Boolean = false;
	
	
	
	
	
	/**
	 * 
	 */
	private var _target:Progression;
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function get enabled():Boolean { return super.enabled; }
	public override function set enabled( value:Boolean ):void {
		if ( super.enabled = value ) {
			_target.addEventListener( ManagerEvent.MANAGER_READY, _managerReady, false, int.MAX_VALUE );
			_target.addEventListener( ManagerEvent.MANAGER_LOCK_CHANGE, _managerLockChange, false, int.MAX_VALUE );
			_target.addEventListener( ProcessEvent.PROCESS_START, _processStart, false, int.MAX_VALUE );
			_target.addEventListener( ProcessEvent.PROCESS_SCENE, _processScene, false, int.MAX_VALUE );
			_target.addEventListener( ProcessEvent.PROCESS_EVENT, _processEvent, false, int.MAX_VALUE );
			_target.addEventListener( ProcessEvent.PROCESS_CHANGE, _processChange, false, int.MAX_VALUE );
			_target.addEventListener( ProcessEvent.PROCESS_COMPLETE, _processComplete, false, int.MAX_VALUE );
			_target.addEventListener( ProcessEvent.PROCESS_STOP, _processStop, false, int.MAX_VALUE );
			_target.addEventListener( ProcessEvent.PROCESS_ERROR, _processError, false, int.MAX_VALUE );
			_target.root.sceneInfo.addEventListener( SceneEvent.SCENE_QUERY_CHANGE, _sceneQueryChange, false, int.MAX_VALUE );
		}
		else {
			_target.removeEventListener( ManagerEvent.MANAGER_READY, _managerReady );
			_target.removeEventListener( ManagerEvent.MANAGER_LOCK_CHANGE, _managerLockChange );
			_target.removeEventListener( ProcessEvent.PROCESS_START, _processStart );
			_target.removeEventListener( ProcessEvent.PROCESS_SCENE, _processScene );
			_target.removeEventListener( ProcessEvent.PROCESS_EVENT, _processEvent );
			_target.removeEventListener( ProcessEvent.PROCESS_CHANGE, _processChange );
			_target.removeEventListener( ProcessEvent.PROCESS_COMPLETE, _processComplete );
			_target.removeEventListener( ProcessEvent.PROCESS_STOP, _processStop );
			_target.removeEventListener( ProcessEvent.PROCESS_ERROR, _processError );
			_target.root.sceneInfo.removeEventListener( SceneEvent.SCENE_QUERY_CHANGE, _sceneQueryChange );
		}
	}
	
	
	
	
	
	/**
	 * <p>新しい ProgressionWatcher インスタンスを作成します。</p>
	 * <p>Creates a new ProgressionWatcher object.</p>
	 * 
	 * @param target
	 * <p></p>
	 * <p></p>
	 */
	public function ProgressionWatcher( target:Progression ) {
		// 引数を設定する
		_target = target;
		
		super( target );
		
		if ( _initialized ) { return; }
		
		Logger.separate();
		
		// パッケージ情報を出力する
		Logger.output( "\n  " + Progression.NAME, Progression.VERSION + "\n  " + Progression.AUTHOR );
		
		Logger.br();
		
		// Progression の実装情報を出力する
		Logger.output( "  PROGRESSION ENVIRONMENTS" );
		Logger.output( "    Config :", Progression.config ? Progression.config.className : "Not initialized yet" );
		
		Logger.br();
		
		// クライアントの環境情報を出力する
		Logger.output( "  CLIENT ENVIRONMENTS" );
		Logger.output( "    OS :", Capabilities.os );
		Logger.output( "    Language :", Capabilities.language );
		Logger.output( "    Display :", Capabilities.screenResolutionX, "x", Capabilities.screenResolutionY, "(", Capabilities.screenDPI, "dpi )" );
		Logger.output( "    FlashPlayer :", Capabilities.version, "(", Capabilities.playerType, ")" );
		Logger.output( "    DebugPlayer :", Capabilities.isDebugger );
		
		// ブラウザ上で実行されていれば
		if ( JavaScript.enabled ) {
			Logger.output( "    Browser Type :", JavaScript.appName, "(" + JavaScript.appCodeName + ")" );
			Logger.output( "    Browser Version :", JavaScript.appVersion );
		}
		
		Logger.br();
		
		// 外部ライブラリの実装状況を出力する
		Logger.output( "  EXTERNAL LIBRARIES" );
		
		var activated:Boolean;
		
		try { activated = !!getDefinitionByName( "caurina.transitions.Tweener" ); } catch ( e:Error ) { activated = false; }
		Logger.output( "    Tweener included :", activated );
		
		try { activated = !!getDefinitionByName( "com.asual.swfaddress.SWFAddress" ); } catch ( e:Error ) { activated = false; }
		Logger.output( "    SWFAddress included :", activated );
		
		try { activated = !!getDefinitionByName( "org.libspark.ui.SWFSize" ); } catch ( e:Error ) { activated = false; }
		Logger.output( "    SWFSize included :", activated );
		
		try { activated = !!getDefinitionByName( "org.libspark.ui.SWFWheel" ); } catch ( e:Error ) { activated = false; }
		Logger.output( "    SWFWheel included :", activated );
		
		Logger.separate();
		Logger.br();
		
		_initialized = true;
	}
	
	
	
	
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function dispose():void {
		//親のメソッドを実行する
		super.dispose();
		
		// 破棄する
		_target = null;
	}
	
	
	
	
	
	/**
	 * シーン移動処理が実行可能になった瞬間に送出されます。
	 */
	private function _managerReady( e:ManagerEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_026 ).toString( _target ), "\n" );
	}
	
	/**
	 * オブジェクトの lock プロパティの値が変更されたときに送出されます。
	 */
	private function _managerLockChange( e:ProcessEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_008 ).toString( _target, _target.lock ) );
	}
	
	/**
	 * 管理下にあるシーンの移動処理が開始された場合に送出されます。
	 */
	private function _processStart( e:ProcessEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_003 ).toString( _target.destinedSceneId.path ) );
	}
	
	/**
	 * 管理下にあるシーンの移動処理中に対象シーンが変更された場合に送出されます。
	 */
	private function _processScene( e:ProcessEvent ):void {
		Logger.info( " ", Logger.getLog( L10NDebugMsg.INFO_004 ).toString( _target.currentSceneId.path ) );
	}
	
	/**
	 * 管理下にあるシーンの移動処理中に対象シーンでイベントが発生した場合に送出されます。
	 */
	private function _processEvent( e:ProcessEvent ):void {
		Logger.info( " ", Logger.getLog( L10NDebugMsg.INFO_005 ).toString( _target.currentSceneId.path, _target.eventType ) );
	}
	
	/**
	 * 管理下にあるシーンの移動処理中に移動先が変更された場合に送出されます。
	 */
	private function _processChange( e:ProcessEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_006 ).toString( _target.destinedSceneId.path ) );
	}
	
	/**
	 * 管理下にあるシーンの移動処理が完了した場合に送出されます。
	 */
	private function _processComplete( e:ProcessEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_007 ), "\n" );
	}
	
	/**
	 * 管理下にあるシーンの移動処理が停止された場合に送出されます。
	 */
	private function _processStop( e:ProcessEvent ):void {
		Logger.warn( Logger.getLog( L10NDebugMsg.WARN_002 ), "\n" );
	}
	
	/**
	 * シーン移動中にエラーが発生した場合に送出されます。
	 */
	private function _processError( e:ProcessEvent ):void {
		Logger.error( Logger.getLog( L10NDebugMsg.ERROR_002 ).toString(), "\n" );
	}
	
	/**
	 * query プロパティの値が更新された場合に送出されます。
	 */
	private function _sceneQueryChange( e:SceneEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_028 ).toString( _target, _target.root.sceneInfo.query ) );
	}
}





/**
 * <p></p>
 * <p></p>
 */
class SceneObjectWatcher extends Watcher {
	
	/**
	 * 
	 */
	private var _target:SceneObject;
	
	/**
	 * 
	 */
	private var _executor:ExecutorObject;
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function get enabled():Boolean { return super.enabled; }
	public override function set enabled( value:Boolean ):void {
		if ( super.enabled = value ) {
			_target.addEventListener( SceneEvent.SCENE_ADDED, _sceneAdded );
			_target.addEventListener( SceneEvent.SCENE_REMOVED, _sceneRemoved );
			_target.addEventListener( SceneEvent.SCENE_ADDED_TO_ROOT, _sceneAddedtoRoot );
			_target.addEventListener( SceneEvent.SCENE_REMOVED_FROM_ROOT, _sceneRemovedFromRoot );
			_target.addEventListener( SceneEvent.SCENE_TITLE_CHANGE, _sceneTitleChange, false, int.MAX_VALUE );
		}
		else {
			_target.removeEventListener( SceneEvent.SCENE_ADDED, _sceneAdded );
			_target.removeEventListener( SceneEvent.SCENE_REMOVED, _sceneRemoved );
			_target.removeEventListener( SceneEvent.SCENE_ADDED_TO_ROOT, _sceneAddedtoRoot );
			_target.removeEventListener( SceneEvent.SCENE_REMOVED_FROM_ROOT, _sceneRemovedFromRoot );
			_target.removeEventListener( SceneEvent.SCENE_TITLE_CHANGE, _sceneTitleChange );
		}
	}
	
	
	
	
	
	/**
	 * <p>新しい SceneObjectWatcher インスタンスを作成します。</p>
	 * <p>Creates a new SceneObjectWatcher object.</p>
	 * 
	 * @param target
	 * <p></p>
	 * <p></p>
	 */
	public function SceneObjectWatcher( target:SceneObject ) {
		// 引数を設定する
		_target = target;
		_executor = _target.executor;
		
		// 親クラスを初期化する
		super( target );
		
		// Executor が存在すれば
		if ( _executor ) {
			Debugger.addTarget( _executor );
		}
	}
	
	
	
	
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function dispose():void {
		//親のメソッドを実行する
		super.dispose();
		
		if ( _executor ) {
			Debugger.removeTarget( _executor );
			_executor = null;
		}
		
		// 破棄する
		_target = null;
	}
	
	
	
	
	
	/**
	 * シーンオブジェクトがシーンリストに追加された場合に送出されます。
	 */
	private function _sceneAdded( e:SceneEvent ):void {
		switch ( e.eventPhase ) {
			case EventPhase.AT_TARGET			: { Logger.info( Logger.getLog( L10NDebugMsg.INFO_018 ).toString( _target ) ); break; }
			case EventPhase.BUBBLING_PHASE		:
			case EventPhase.CAPTURING_PHASE		: { Logger.info( Logger.getLog( L10NDebugMsg.INFO_019 ).toString( _target, e.target ) ); break; }
		}
	}
	
	/**
	 * シーンオブジェクトがシーンリストから削除された場合に送出されます。
	 */
	private function _sceneRemoved( e:SceneEvent ):void {
		switch ( e.eventPhase ) {
			case EventPhase.AT_TARGET			: { Logger.info( Logger.getLog( L10NDebugMsg.INFO_020 ).toString( _target ) ); break; }
			case EventPhase.BUBBLING_PHASE		:
			case EventPhase.CAPTURING_PHASE		: { Logger.info( Logger.getLog( L10NDebugMsg.INFO_021 ).toString( _target, e.target ) ); break; }
		}
	}
	
	/**
	 * シーンオブジェクトが直接、またはシーンオブジェクトを含むサブツリーの追加により、ルートシーン上のシーンリストに追加されたときに送出されます。
	 */
	private function _sceneAddedtoRoot( e:SceneEvent ):void {
		if ( _executor ) {
			Debugger.removeTarget( _executor );
		}
		
		_executor = _target.executor;
		
		if ( _executor ) {
			Debugger.addTarget( _executor );
		}
	}
	
	/**
	 * シーンオブジェクトが直接、またはシーンオブジェクトを含むサブツリーの削除により、ルートシーン上のシーンリストから削除されようとしているときに送出されます。
	 */
	private function _sceneRemovedFromRoot( e:SceneEvent ):void {
		if ( _executor ) {
			Debugger.removeTarget( _executor );
			_executor = null;
		}
	}
	
	/**
	 * シーンオブジェクトの title プロパティが変更された場合に送出されます。
	 */
	private function _sceneTitleChange( e:SceneEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_009 ).toString( _target, _target.title ) );
	}
}





/**
 * <p></p>
 * <p></p>
 */
class CastObjectWatcher extends Watcher {
	
	/**
	 * 
	 */
	private var _target:ICastObject;
	
	/**
	 * 
	 */
	private var _executor:ExecutorObject;
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function get enabled():Boolean { return super.enabled; }
	public override function set enabled( value:Boolean ):void {
		if ( super.enabled = value ) {
			_target.addEventListener( Event.ADDED, _added, false, int.MAX_VALUE );
			_target.addEventListener( Event.REMOVED, _removed, false, int.MAX_VALUE );
			_target.addEventListener( Event.ADDED_TO_STAGE, _addedToStage, false, int.MAX_VALUE );
			_target.addEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage, false, int.MAX_VALUE );
			_target.addEventListener( CastEvent.CAST_ADDED, _castAdded, false, int.MAX_VALUE );
			_target.addEventListener( CastEvent.CAST_REMOVED, _castRemoved, false, int.MAX_VALUE );
			_target.addEventListener( ManagerEvent.MANAGER_ACTIVATE, _managerAcvivate, false, int.MAX_VALUE );
			_target.addEventListener( ManagerEvent.MANAGER_DEACTIVATE, _managerDeacvivate, false, int.MAX_VALUE );
		}
		else {
			_target.removeEventListener( Event.ADDED, _added );
			_target.removeEventListener( Event.REMOVED, _removed );
			_target.removeEventListener( Event.ADDED_TO_STAGE, _addedToStage );
			_target.removeEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage );
			_target.removeEventListener( CastEvent.CAST_ADDED, _castAdded );
			_target.removeEventListener( CastEvent.CAST_REMOVED, _castRemoved );
			_target.removeEventListener( ManagerEvent.MANAGER_ACTIVATE, _managerAcvivate );
			_target.removeEventListener( ManagerEvent.MANAGER_DEACTIVATE, _managerDeacvivate );
		}
	}
	
	
	
	
	
	/**
	 * <p>新しい CastObjectWatcher インスタンスを作成します。</p>
	 * <p>Creates a new CastObjectWatcher object.</p>
	 * 
	 * @param target
	 * <p></p>
	 * <p></p>
	 */
	public function CastObjectWatcher( target:ICastObject ) {
		// 引数を設定する
		_target = target;
		_executor = _target.executor;
		
		// 親クラスを初期化する
		super( target );
		
		// Executor が存在すれば
		if ( _executor ) {
			Debugger.addTarget( _executor );
		}
	}
	
	
	
	
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function dispose():void {
		//親のメソッドを実行する
		super.dispose();
		
		// 破棄する
		_target = null;
	}
	
	
	
	
	
	/**
	 * 
	 */
	private function _added( e:Event ):void {
		switch ( e.eventPhase ) {
			case EventPhase.AT_TARGET			: { Logger.info( Logger.getLog( L10NDebugMsg.INFO_022 ).toString( _target ) ); break; }
			case EventPhase.BUBBLING_PHASE		:
			case EventPhase.CAPTURING_PHASE		: { Logger.info( Logger.getLog( L10NDebugMsg.INFO_023 ).toString( _target, e.target ) ); break; }
		}
	}
	
	/**
	 * 
	 */
	private function _removed( e:Event ):void {
		switch ( e.eventPhase ) {
			case EventPhase.AT_TARGET			: { Logger.info( Logger.getLog( L10NDebugMsg.INFO_024 ).toString( _target ) ); break; }
			case EventPhase.BUBBLING_PHASE		:
			case EventPhase.CAPTURING_PHASE		: { Logger.info( Logger.getLog( L10NDebugMsg.INFO_025 ).toString( _target, e.target ) ); break; }
		}
	}
	
	/**
	 * 
	 */
	private function _addedToStage( e:Event ):void {
		if ( _executor ) {
			Debugger.removeTarget( _executor );
		}
		
		_executor = _target.executor;
		
		if ( _executor ) {
			Debugger.addTarget( _executor );
		}
	}
	
	/**
	 * 
	 */
	private function _removedFromStage( e:Event ):void {
		if ( _executor ) {
			Debugger.removeTarget( _executor );
			_executor = null;
		}
	}
	
	/**
	 * IExecutable オブジェクトが AddChild コマンド、または AddChildAt コマンド経由で表示リストに追加された場合に送出されます。
	 */
	private function _castAdded( e:CastEvent ):void {
	}
	
	/**
	 * IExecutable オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由で表示リストから削除された場合に送出されます。
	 */
	private function _castRemoved( e:CastEvent ):void {
	}
	
	/**
	 * Progression インスタンスとの関連付けがアクティブになったときに送出されます。
	 */
	private function _managerAcvivate( e:ManagerEvent ):void {
		var manageable:IManageable = target as IManageable;
		
		if ( !manageable ) { return; }
		
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_012 ).toString( manageable, manageable.manager ) );
	}
	
	/**
	 * Progression インスタンスとの関連付けが非アクティブになったときに送出されます。
	 */
	private function _managerDeacvivate( e:ManagerEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_013 ).toString( target ) );
	}
}





/**
 * <p></p>
 * <p></p>
 */
class CastButtonWatcher extends CastObjectWatcher {
	
	/**
	 * 
	 */
	private var _target:CastButton;
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function get enabled():Boolean { return super.enabled; }
	public override function set enabled( value:Boolean ):void {
		if ( super.enabled = value ) {
			_target.addEventListener( CastMouseEvent.CAST_MOUSE_DOWN, _castMouseDown, false, int.MAX_VALUE );
			_target.addEventListener( CastMouseEvent.CAST_MOUSE_DOWN_COMPLETE, _castMouseDownComplete, false, int.MAX_VALUE );
			_target.addEventListener( CastMouseEvent.CAST_MOUSE_UP, _castMouseUp, false, int.MAX_VALUE );
			_target.addEventListener( CastMouseEvent.CAST_MOUSE_UP_COMPLETE, _castMouseUpComplete, false, int.MAX_VALUE );
			_target.addEventListener( CastMouseEvent.CAST_ROLL_OVER, _castRollOver, false, int.MAX_VALUE );
			_target.addEventListener( CastMouseEvent.CAST_ROLL_OVER_COMPLETE, _castRollOverComplete, false, int.MAX_VALUE );
			_target.addEventListener( CastMouseEvent.CAST_ROLL_OUT, _castRollOut, false, int.MAX_VALUE );
			_target.addEventListener( CastMouseEvent.CAST_ROLL_OUT_COMPLETE, _castRollOutComplete, false, int.MAX_VALUE );
		}
		else {
			_target.removeEventListener( CastMouseEvent.CAST_MOUSE_DOWN, _castMouseDown );
			_target.removeEventListener( CastMouseEvent.CAST_MOUSE_DOWN_COMPLETE, _castMouseDownComplete );
			_target.removeEventListener( CastMouseEvent.CAST_MOUSE_UP, _castMouseUp );
			_target.removeEventListener( CastMouseEvent.CAST_MOUSE_UP_COMPLETE, _castMouseUpComplete );
			_target.removeEventListener( CastMouseEvent.CAST_ROLL_OVER, _castRollOver );
			_target.removeEventListener( CastMouseEvent.CAST_ROLL_OVER_COMPLETE, _castRollOverComplete );
			_target.removeEventListener( CastMouseEvent.CAST_ROLL_OUT, _castRollOut );
			_target.removeEventListener( CastMouseEvent.CAST_ROLL_OUT_COMPLETE, _castRollOutComplete );
		}
	}
	
	
	
	
	
	/**
	 * <p>新しい CastButtonWatcher インスタンスを作成します。</p>
	 * <p>Creates a new CastButtonWatcher object.</p>
	 * 
	 * @param target
	 * <p></p>
	 * <p></p>
	 */
	public function CastButtonWatcher( target:CastButton ) {
		// 引数を設定する
		_target = target;
		
		// 親クラスを初期化する
		super( target );
	}
	
	
	
	
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function dispose():void {
		//親のメソッドを実行する
		super.dispose();
		
		// 破棄する
		_target = null;
	}
	
	
	
	
	
	/**
	 * Flash Player ウィンドウの CastButton インスタンスの上でユーザーがポインティングデバイスのボタンを押すと送出されます。
	 */
	private function _castMouseDown( e:CastMouseEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_029 ).toString( _target ) );
	}
	
	/**
	 * CastMouseEvent.CAST_MOUSE_DOWN イベント中に実行された非同期処理が完了した場合に送出されます。
	 */
	private function _castMouseDownComplete( e:CastMouseEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_030 ).toString( _target ) );
	}
	
	/**
	 * ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
	 */
	private function _castMouseUp( e:CastMouseEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_031 ).toString( _target ) );
	}
	
	/**
	 * CastMouseEvent.CAST_MOUSE_UP イベント中に実行された非同期処理が完了した場合に送出されます。
	 */
	private function _castMouseUpComplete( e:CastMouseEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_032 ).toString( _target ) );
	}
	
	/**
	 * ユーザーが CastButton インスタンスにポインティングデバイスを合わせたときに送出されます。
	 */
	private function _castRollOver( e:CastMouseEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_033 ).toString( _target ) );
	}
	
	/**
	 * CastMouseEvent.CAST_ROLL_OVER イベント中に実行された非同期処理が完了した場合に送出されます。
	 */
	private function _castRollOverComplete( e:CastMouseEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_034 ).toString( _target ) );
	}
	
	/**
	 * ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
	 */
	private function _castRollOut( e:CastMouseEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_035 ).toString( _target ) );
	}
	
	/**
	 * CastMouseEvent.CAST_ROLL_OUT イベント中に実行された非同期処理が完了した場合に送出されます。
	 */
	private function _castRollOutComplete( e:CastMouseEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_036 ).toString( _target ) );
	}
}





/**
 * <p></p>
 * <p></p>
 */
class ExecutorObjectWatcher extends Watcher {
	
	/**
	 * 
	 */
	private var _target:ExecutorObject;
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function get enabled():Boolean { return super.enabled; }
	public override function set enabled( value:Boolean ):void {
		if ( super.enabled = value ) {
			_target.addEventListener( ExecuteEvent.EXECUTE_START, _executeStart, false, int.MAX_VALUE );
			_target.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete, false, int.MAX_VALUE );
			_target.addEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt, false, int.MAX_VALUE );
			_target.addEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _executeError, false, int.MAX_VALUE );
		}
		else {
			_target.removeEventListener( ExecuteEvent.EXECUTE_START, _executeStart );
			_target.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
			_target.removeEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
			_target.removeEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _executeError );
		}
	}
	
	
	
	
	
	/**
	 * <p>新しい ExecutorObjectWatcher インスタンスを作成します。</p>
	 * <p>Creates a new ExecutorObjectWatcher object.</p>
	 * 
	 * @param target
	 * <p></p>
	 * <p></p>
	 */
	public function ExecutorObjectWatcher( target:ExecutorObject ) {
		// 引数を設定する
		_target = target;
		
		// 親クラスを初期化する
		super( target );
	}
	
	
	
	
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function dispose():void {
		//親のメソッドを実行する
		super.dispose();
		
		// 破棄する
		_target = null;
	}
	
	
	
	
	
	/**
	 * 処理が開始された場合に送出されます。
	 */
	private function _executeStart( e:ExecuteEvent ):void {
		Logger.info( StringUtil.repeat( "  ", _target.depth ) + Logger.getLog( L10NDebugMsg.INFO_016 ).toString( _target, _target.target, _target.eventType ) );
	}
	
	/**
	 * 処理が完了した場合に送出されます。
	 */
	private function _executeComplete( e:ExecuteEvent ):void {
		Logger.info( StringUtil.repeat( "  ", _target.depth ) + Logger.getLog( L10NDebugMsg.INFO_017 ).toString() );
	}
	
	/**
	 * 処理が中断された場合に送出されます。
	 */
	private function _executeInterrupt( e:ExecuteEvent ):void {
		Logger.warn( Logger.getLog( L10NDebugMsg.WARN_003 ) );
	}
	
	/**
	 * 処理の途中でエラーが発生した場合に送出されます。
	 */
	private function _executeError( e:ExecuteErrorEvent ):void {
		Logger.error( Logger.getLog( L10NDebugMsg.ERROR_003 ).toString(), "\n" + e.errorObject.getStackTrace() );
	}
}





/**
 * <p></p>
 * <p></p>
 */
class ResumeExecutorObjectWatcher extends Watcher {
	
	/**
	 * 
	 */
	private var _target:ResumeExecutor;
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function get enabled():Boolean { return super.enabled; }
	public override function set enabled( value:Boolean ):void {
		if ( super.enabled = value ) {
			_target.addEventListener( ExecuteEvent.EXECUTE_START, _executeStart, false, int.MAX_VALUE );
			_target.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete, false, int.MAX_VALUE );
			_target.addEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt, false, int.MAX_VALUE );
			_target.addEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _executeError, false, int.MAX_VALUE );
		}
		else {
			_target.removeEventListener( ExecuteEvent.EXECUTE_START, _executeStart );
			_target.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
			_target.removeEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
			_target.removeEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _executeError );
		}
	}
	
	
	
	
	
	/**
	 * <p>新しい ResumeExecutorObjectWatcher インスタンスを作成します。</p>
	 * <p>Creates a new ResumeExecutorObjectWatcher object.</p>
	 * 
	 * @param target
	 * <p></p>
	 * <p></p>
	 */
	public function ResumeExecutorObjectWatcher( target:ResumeExecutor ) {
		// 引数を設定する
		_target = target;
		
		// 親クラスを初期化する
		super( target );
	}
	
	
	
	
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function dispose():void {
		//親のメソッドを実行する
		super.dispose();
		
		// 破棄する
		_target = null;
	}
	
	
	
	
	
	/**
	 * 処理が開始された場合に送出されます。
	 */
	private function _executeStart( e:ExecuteEvent ):void {
		var executor:ResumeExecutor = e.executeTarget as ResumeExecutor;
		
		Logger.info( StringUtil.repeat( "  ", executor.depth ) + Logger.getLog( L10NDebugMsg.INFO_010 ).toString( executor, executor.target, executor.eventType ) );
	}
	
	/**
	 * 処理が完了した場合に送出されます。
	 */
	private function _executeComplete( e:ExecuteEvent ):void {
		var executor:ResumeExecutor = e.executeTarget as ResumeExecutor;
		
		Logger.info( StringUtil.repeat( "  ", executor.depth ) + Logger.getLog( L10NDebugMsg.INFO_011 ).toString() );
	}
	
	/**
	 * 処理が中断された場合に送出されます。
	 */
	private function _executeInterrupt( e:ExecuteEvent ):void {
		Logger.warn( Logger.getLog( L10NDebugMsg.WARN_000 ) );
	}
	
	/**
	 * 処理の途中でエラーが発生した場合に送出されます。
	 */
	private function _executeError( e:ExecuteErrorEvent ):void {
		Logger.error( Logger.getLog( L10NDebugMsg.ERROR_001 ).toString(), "\n" + e.errorObject.getStackTrace() );
	}
}





/**
 * <p></p>
 * <p></p>
 */
class CommandExecutorObjectWatcher extends Watcher {
	
	/**
	 * 
	 */
	private var _target:CommandExecutor;
	
	/**
	 * 
	 */
	private var _watcher:CommandWatcher;
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function get enabled():Boolean { return super.enabled; }
	public override function set enabled( value:Boolean ):void {
		if ( super.enabled = value ) {
			_target.addEventListener( ExecuteEvent.EXECUTE_START, _executeStart, false, int.MAX_VALUE );
			_target.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete, false, int.MAX_VALUE );
			_target.addEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt, false, int.MAX_VALUE );
			_target.addEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _executeError, false, int.MAX_VALUE );
		}
		else {
			_target.removeEventListener( ExecuteEvent.EXECUTE_START, _executeStart );
			_target.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
			_target.removeEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
			_target.removeEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _executeError );
		}
	}
	
	
	
	
	
	/**
	 * <p>新しい CommandExecutorObjectWatcher インスタンスを作成します。</p>
	 * <p>Creates a new CommandExecutorObjectWatcher object.</p>
	 * 
	 * @param target
	 * <p></p>
	 * <p></p>
	 */
	public function CommandExecutorObjectWatcher( target:CommandExecutor ) {
		// 引数を設定する
		_target = target;
		
		// 親クラスを初期化する
		super( target );
	}
	
	
	
	
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function dispose():void {
		//親のメソッドを実行する
		super.dispose();
		
		if ( _watcher ) {
			_watcher.dispose();
			_watcher = null;
		}
		
		// 破棄する
		_target = null;
	}
	
	
	
	
	
	/**
	 * 処理が開始された場合に送出されます。
	 */
	private function _executeStart( e:ExecuteEvent ):void {
		var executor:CommandExecutor = e.executeTarget as CommandExecutor;
		
		Logger.info( StringUtil.repeat( "  ", executor.depth ) + Logger.getLog( L10NDebugMsg.INFO_010 ).toString( executor, executor.target, executor.eventType ) );
		
		// 現在の対象を取得する
		_watcher = new CommandWatcher( executor.current );
	}
	
	/**
	 * 処理が完了した場合に送出されます。
	 */
	private function _executeComplete( e:ExecuteEvent ):void {
		var executor:CommandExecutor = e.executeTarget as CommandExecutor;
		
		Logger.info( StringUtil.repeat( "  ", executor.depth ) + Logger.getLog( L10NDebugMsg.INFO_011 ).toString() );
		
		// 現在の対象を破棄する
		_watcher.dispose();
		_watcher = null;
	}
	
	/**
	 * 処理が中断された場合に送出されます。
	 */
	private function _executeInterrupt( e:ExecuteEvent ):void {
		Logger.warn( Logger.getLog( L10NDebugMsg.WARN_000 ) );
	}
	
	/**
	 * 処理の途中でエラーが発生した場合に送出されます。
	 */
	private function _executeError( e:ExecuteErrorEvent ):void {
		Logger.error( Logger.getLog( L10NDebugMsg.ERROR_000 ).toString(), "\n" + e.errorObject.getStackTrace() );
	}
}





/**
 * <p></p>
 * <p></p>
 */
class CommandWatcher extends Watcher {
	
	/**
	 * 
	 */
	private var _target:Command;
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function get enabled():Boolean { return super.enabled; }
	public override function set enabled( value:Boolean ):void {
		if ( super.enabled = value ) {
			_target.addEventListener( ExecuteEvent.EXECUTE_START, _executeStart, false, int.MAX_VALUE );
			_target.addEventListener( ExecuteEvent.EXECUTE_POSITION, _executePosition, false, int.MAX_VALUE );
			_target.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete, false, int.MAX_VALUE );
			_target.addEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt, false, int.MAX_VALUE );
			_target.addEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _executeError, false, int.MAX_VALUE );
		}
		else {
			_target.removeEventListener( ExecuteEvent.EXECUTE_START, _executeStart );
			_target.removeEventListener( ExecuteEvent.EXECUTE_POSITION, _executePosition );
			_target.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
			_target.removeEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
			_target.removeEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _executeError );
		}
	}
	
	
	
	
	
	/**
	 * <p>新しい CommandWatcher インスタンスを作成します。</p>
	 * <p>Creates a new CommandWatcher object.</p>
	 * 
	 * @param target
	 * <p></p>
	 * <p></p>
	 */
	public function CommandWatcher( target:Command ) {
		// 引数を設定する
		_target = target;
		
		// 親クラスを初期化する
		super( target );
	}
	
	
	
	
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function dispose():void {
		//親のメソッドを実行する
		super.dispose();
		
		// 破棄する
		_target = null;
	}
	
	
	
	
	
	/**
	 * 処理が開始された場合に送出されます。
	 */
	private function _executeStart( e:ExecuteEvent ):void {
		var command:Command = e.executeTarget as Command;
		
		// 対象が存在しなけれな
		if ( !command ) { return; }
		
		Logger.info( StringUtil.repeat( "  ", command.depth + 1 ) + Logger.getLog( L10NDebugMsg.INFO_014 ).toString( command ) );
	}
	
	/**
	 * リストに登録されているコマンドの実行処理位置が変更された場合に送出されます。
	 */
	private function _executePosition( e:ExecuteEvent ):void {
		var command:Command = e.executeTarget as Command;
		
		// 対象が存在しなけれな
		if ( !command ) { return; }
		
		Logger.info( StringUtil.repeat( "  ", command.depth + 1 ) + Logger.getLog( L10NDebugMsg.INFO_014 ).toString( command ) );
		
		// 対象が CommandList であれば
		if ( command is CommandList ) {
			command.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete, false, int.MAX_VALUE );
		}
	}
	
	/**
	 * 処理が完了した場合に送出されます。
	 */
	private function _executeComplete( e:ExecuteEvent ):void {
		var command:Command = e.executeTarget as Command;
		
		// 対象が存在しなけれな
		if ( !command ) { return; }
		
		Logger.info( StringUtil.repeat( "  ", command.depth + 1 ) + Logger.getLog( L10NDebugMsg.INFO_015 ).toString( command ) );
		
		// 対象が CommandList であれば
		if ( command is CommandList ) {
			command.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
		}
	}
	
	/**
	 * 処理が中断された場合に送出されます。
	 */
	private function _executeInterrupt( e:ExecuteEvent ):void {
		var command:Command = e.executeTarget as Command;
		
		// 対象が存在しなけれな
		if ( !command ) { return; }
		
		Logger.warn( StringUtil.repeat( "  ", command.depth + 1 ) + Logger.getLog( L10NDebugMsg.WARN_001 ).toString( command ) );
		
		// 対象が CommandList であれば
		if ( command is CommandList ) {
			command.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
		}
	}
	
	/**
	 * 処理の途中でエラーが発生した場合に送出されます。
	 */
	private function _executeError( e:ExecuteErrorEvent ):void {
		var command:Command = e.target as Command;
		
		// 対象が存在しなけれな
		if ( !command ) { return; }
		
		Logger.error( StringUtil.repeat( "  ", command.depth + 1 ) + Logger.getLog( L10NDebugMsg.ERROR_001 ).toString( command ), "\n" + e.errorObject.getStackTrace() );
		
		// 対象が CommandList であれば
		if ( command is CommandList ) {
			command.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
		}
	}
}





/**
 * <p></p>
 * <p></p>
 */
class DataHolderWatcher extends Watcher {
	
	/**
	 * 
	 */
	private var _target:DataHolder;
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function get enabled():Boolean { return super.enabled; }
	public override function set enabled( value:Boolean ):void {
		if ( super.enabled = value ) {
			_target.addEventListener( DataProvideEvent.DATA_UPDATE, _update, false, int.MAX_VALUE );
		}
		else {
			_target.removeEventListener( DataProvideEvent.DATA_UPDATE, _update );
		}
	}
	
	
	
	
	
	/**
	 * <p>新しい DataHolderWatcher インスタンスを作成します。</p>
	 * <p>Creates a new DataHolderWatcher object.</p>
	 * 
	 * @param target
	 * <p></p>
	 * <p></p>
	 */
	public function DataHolderWatcher( target:DataHolder ) {
		// 引数を設定する
		_target = target;
		
		// 親クラスを初期化する
		super( target );
	}
	
	
	
	
	
	/**
	 * <p></p>
	 * <p></p>
	 */
	public override function dispose():void {
		//親のメソッドを実行する
		super.dispose();
		
		// 破棄する
		_target = null;
	}
	
	
	
	
	
	/**
	 * 管理するデータが更新された場合に送出されます。
	 */
	private function _update( e:DataProvideEvent ):void {
		Logger.info( Logger.getLog( L10NDebugMsg.INFO_027 ).toString( _target.target, _target ) );
	}
}
