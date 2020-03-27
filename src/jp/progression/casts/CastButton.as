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
	import flash.accessibility.Accessibility;
	import flash.accessibility.AccessibilityProperties;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import jp.nium.collections.UniqueList;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.core.debug.Logger;
	import jp.nium.display.ExMovieClip;
	import jp.nium.events.CollectionEvent;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.Progression;
	import jp.progression.core.L10N.L10NExecuteMsg;
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.core.impls.ICastButton;
	import jp.progression.core.impls.ICastObject;
	import jp.progression.core.impls.IExecutable;
	import jp.progression.core.impls.IManageable;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.events.CastEvent;
	import jp.progression.events.CastMouseEvent;
	import jp.progression.events.ExecuteEvent;
	import jp.progression.events.ManagerEvent;
	import jp.progression.events.ProcessEvent;
	import jp.progression.executors.ExecutorObject;
	import jp.progression.scenes.SceneId;
	import jp.progression.ui.IContextMenuBuilder;
	import jp.progression.ui.IToolTip;
	
	/**
	 * <p>IExecutable オブジェクトが AddChild コマンド、または AddChildAt コマンド経由で表示リストに追加された場合に送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastEvent.CAST_ADDED
	 */
	[Event( name="castAdded", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <p>CastEvent.CAST_ADDED イベント中に実行された非同期処理が完了した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastEvent.CAST_ADDED_COMPLETE
	 */
	[Event( name="castAddedComplete", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <p>IExecutable オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由で表示リストから削除された場合に送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastEvent.CAST_REMOVED
	 */
	[Event( name="castRemoved", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <p>CastEvent.CAST_REMOVED イベント中に実行された非同期処理が完了した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastEvent.CAST_REMOVED_COMPLETE
	 */
	[Event( name="castRemovedComplete", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <p>ボタンの状態が変更された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastMouseEvent.CAST_STATE_CHANGE
	 */
	[Event( name="castStateChange", type="jp.progression.events.CastMouseEvent" )]
	
	/**
	 * <p>ボタンが移動処理を開始する直前に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastMouseEvent.CAST_NAVIGATE_BEFORE
	 */
	[Event( name="castNavigateBefore", type="jp.progression.events.CastMouseEvent" )]
	
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
	 * <p>Flash Player ウィンドウの CastButton インスタンスの上でユーザーがポインティングデバイスのボタンを押すと送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastMouseEvent.CAST_MOUSE_DOWN
	 */
	[Event( name="castMouseDown", type="jp.progression.events.CastMouseEvent" )]
	
	/**
	 * <p>CastMouseEvent.CAST_MOUSE_DOWN イベント中に実行された非同期処理が完了した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastMouseEvent.CAST_MOUSE_DOWN_COMPLETE
	 */
	[Event( name="castMouseDownComplete", type="jp.progression.events.CastMouseEvent" )]
	
	/**
	 * <p>ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastMouseEvent.CAST_MOUSE_UP
	 */
	[Event( name="castMouseUp", type="jp.progression.events.CastMouseEvent" )]
	
	/**
	 * <p>CastMouseEvent.CAST_MOUSE_UP イベント中に実行された非同期処理が完了した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastMouseEvent.CAST_MOUSE_UP_COMPLETE
	 */
	[Event( name="castMouseUpComplete", type="jp.progression.events.CastMouseEvent" )]
	
	/**
	 * <p>ユーザーが CastButton インスタンスにポインティングデバイスを合わせたときに送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastMouseEvent.CAST_ROLL_OVER
	 */
	[Event( name="castRollOver", type="jp.progression.events.CastMouseEvent" )]
	
	/**
	 * <p>CastMouseEvent.CAST_ROLL_OVER イベント中に実行された非同期処理が完了した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastMouseEvent.CAST_ROLL_OVER_COMPLETE
	 */
	[Event( name="castRollOverComplete", type="jp.progression.events.CastMouseEvent" )]
	
	/**
	 * <p>ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
	 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastMouseEvent.CAST_ROLL_OUT
	 */
	[Event( name="castRollOut", type="jp.progression.events.CastMouseEvent" )]
	
	/**
	 * <p>CastMouseEvent.CAST_ROLL_OUT イベント中に実行された非同期処理が完了した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.CastMouseEvent.CAST_ROLL_OUT_COMPLETE
	 */
	[Event( name="castRollOutComplete", type="jp.progression.events.CastMouseEvent" )]
	
	/**
	 * <p>非同期処理中にエラーが発生した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ExecuteErrorEvent.EXECUTE_ERROR
	 */
	[Event( name="executeError", type="jp.progression.events.ExecuteErrorEvent" )]
	
	/**
	 * <p>CastButton クラスは、ExMovieClip クラスの基本機能を拡張し、ボタン機能とイベントフローとの連携機能を実装した jp.progression パッケージで使用される基本的な表示オブジェクトクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // CastButton インスタンスを作成する
	 * var cast:CastButton = new CastButton();
	 * </listing>
	 */
	public class CastButton extends ExMovieClip implements ICastObject, ICastButton, IManageable {
		include "_inc/CastObject.contextMenu.inc"
		
		/**
		 * <p>現在、ステージ上に設置されているボタンを含む配列を取得します。</p>
		 * <p></p>
		 */
		public static function get activatedButtons():Array { return _activatedButtons.toArray(); }
		private static var _activatedButtons:UniqueList = new UniqueList();
		
		/**
		 * アクセスキーを判別する正規表現を取得します。
		 */
		private static const _ACCESS_KEY_REGEXP:String = "^[a-z]?$";
		
		
		
		
		
		/**
		 * <p>ボタンがクリックされた時の移動先を示すシーン識別子を取得または設定します。
		 * sceneId プロパティと href プロパティが両方とも設定されている場合には、href プロパティの設定が優先されます。</p>
		 * <p></p>
		 * 
		 * @see #href
		 * @see #windowTarget
		 * @see #navigateTo()
		 */
		public function get sceneId():SceneId { return _sceneId; }
		public function set sceneId( value:SceneId ):void {
			_sceneId = value || SceneId.NaS;
			
			// 移動先が設定されていれば、ボタンを有効化する
			if ( _href || _sceneId ) {
				buttonMode = true;
			}
			else {
				buttonMode = false;
			}
			
			// 更新する
			_collectionUpdate( null );
		}
		private var _sceneId:SceneId;
		
		/**
		 * <p>ボタンがクリックされた時の移動先の URL を取得または設定します。
		 * sceneId プロパティと href プロパティが両方とも設定されている場合には、href プロパティの設定が優先されます。</p>
		 * <p></p>
		 * 
		 * @see #sceneId
		 * @see #windowTarget
		 * @see #navigateTo()
		 */
		public function get href():String { return _href; }
		public function set href( value:String ):void {
			_href = value;
			
			// 移動先が設定されていれば、ボタンを有効化する
			if ( _href || _sceneId ) {
				buttonMode = true;
			}
			else {
				buttonMode = false;
			}
		}
		private var _href:String;
		
		/**
		 * <p>ボタンがクリックされた時の移動先を開くウィンドウ名を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #sceneId
		 * @see #href
		 * @see #navigateTo()
		 * @see jp.progression.casts.CastButtonWindowTarget
		 */
		public function get windowTarget():String { return _windowTarget; }
		public function set windowTarget( value:String ):void { _windowTarget = value; }
		private var _windowTarget:String;
		
		/**
		 * <p>ボタンの機能をキーボードから使用するためのアクセスキーを取得または設定します。
		 * 設定できるキーはアルファベットの A ～ Z までの値です。</p>
		 * <p></p>
		 * 
		 * @see #sceneId
		 * @see #href
		 * @see #windowTarget
		 * @see #navigateTo()
		 */
		public function get accessKey():String { return _accessKey; }
		public function set accessKey( value:String ):void {
			if ( !new RegExp( _ACCESS_KEY_REGEXP, "i" ).test( value ) ) { new Error( Logger.getLog( L10NNiumMsg.ERROR_003 ).toString( "accessKey" ) ); }
			
			_accessKey = value;
			
			// AccessibilityProperties を更新する
			var props:AccessibilityProperties = new AccessibilityProperties();
			props.shortcut = value;
			if ( !super.accessibilityProperties ) {
				super.accessibilityProperties = props;
			}
			
			// アクティブであれば更新する
			if ( Accessibility.active ) {
				Accessibility.updateProperties();
			}
		}
		private var _accessKey:String;
		
		/**
		 * <p>マウス状態に応じて Executor を使用した処理を行うかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		public function get mouseEventEnabled():Boolean { return _mouseEventEnabled; }
		public function set mouseEventEnabled( value:Boolean ):void { _mouseEventEnabled = value; }
		private var _mouseEventEnabled:Boolean = true;
		
		/**
		 * <p>CastButton インスタンスにポインティングデバイスが合わされているかどうかを取得します。</p>
		 * <p></p>
		 */
		public function get isRollOver():Boolean { return _isRollOver; }
		private var _isRollOver:Boolean = false;
		
		/**
		 * <p>CastButton インスタンスでポインティングデバイスのボタンを押されているかどうかを取得します。</p>
		 * <p></p>
		 */
		public function get isMouseDown():Boolean { return _isMouseDown; }
		private var _isMouseDown:Boolean = false;
		
		/**
		 * <p>ボタンの状態を取得します。</p>
		 * <p></p>
		 * 
		 * @see #sceneId
		 * @see jp.progression.casts.CastButtonState
		 */
		public function get state():int { return _state; }
		private var _state:int = -1;
		
		/**
		 * <p>自身の参照を取得します。</p>
		 * <p></p>
		 */
		public function get self():CastButton { return CastButton( this ); }
		
		/**
		 * <p>関連付けられている Progression インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get manager():Progression { return _managerFromSceneId || _manager; }
		private var _managerFromSceneId:Progression;
		private var _manager:Progression;
		
		/**
		 * <p>関連付けられている ExecutorObject インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see #onCastMouseDown;
		 * @see #onCastMouseUp;
		 * @see #onCastRollOver;
		 * @see #onCastRollOut;
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 */
		public function get executor():ExecutorObject { return _executor; }
		private var _executor:ExecutorObject;
		
		/**
		 * マウスダウン/アップイベントを処理する ExecutorObject を取得します。
		 */
		private var _mouseDownUpExecutor:ExecutorObject;
		
		/**
		 * ロールオーバー/アウトイベントを処理する ExecutorObject を取得します。
		 */
		private var _rollOverOutExecutor:ExecutorObject;
		
		/**
		 * CTRL キー、または Shift キーが押されていたかどうかを取得します。
		 */
		private var _isDownCTRLorShiftKey:Boolean = false;
		
		/**
		 * 対象を新しいウィンドウで開くかどうかを取得します。
		 */
		private var _openNewWindow:Boolean = false;
		
		/**
		 * マウスダウン / アップイベント発生時の MouseEvent オブジェクトを取得します。
		 */
		private var _mouseDownUpEvent:MouseEvent;
		
		/**
		 * ロールオーバー / アウトイベント発生時の MouseEvent オブジェクトを取得します。
		 */
		private var _rollOverOutEvent:MouseEvent;
		
		/**
		 * <p>関連付けられている IToolTip インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get toolTip():IToolTip {
			if ( _toolTip ) { return _toolTip; }
			if ( !Progression.config ) {
				Logger.warn( Logger.getLog( L10NProgressionMsg.ERROR_017 ).toString( this, "toolTip" ) );
				return null;
			}
			
			var cls:Class = Progression.config.toolTipRenderer;
			if ( cls ) {
				_toolTip = new cls( this );
			}
			
			return _toolTip;
		}
		public function set toolTip( value:IToolTip ):void {
			if ( _toolTip && value == null ) {
				_toolTip.dispose();
			}
			
			_toolTip = value;
		}
		private var _toolTip:IToolTip;
		
		/**
		 * IContextMenuBuilder インスタンスを取得します。
		 */
		private var _contextMenuBuilder:IContextMenuBuilder;
		
		/**
		 * コンテクストメニューの設定を許可するかどうかを取得します。
		 */
		private var _allowBuildContextMenu:Boolean = false;
		
		/**
		 * Stage の参照を取得します。
		 */
		private var _stage:Stage;
		
		/**
		 * <p>キャストオブジェクトが CastEvent.CAST_ADDED イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.CastEvent#ADDED
		 * @see jp.progression.events.CastEvent#ADDED_COMPLETE
		 */
		public function get onCastAdded():Function { return _onCastAdded; }
		public function set onCastAdded( value:Function ):void { _onCastAdded = value; }
		private var _onCastAdded:Function;
		
		/**
		 * <p>キャストオブジェクトが CastEvent.CAST_ADDED イベントを受け取った場合に呼び出されるオーバーライド・イベントハンドラメソッドです。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.CastEvent#ADDED
		 * @see jp.progression.events.CastEvent#ADDED_COMPLETE
		 */
		protected function atCastAdded():void {}
		
		/**
		 * <p>キャストオブジェクトが CastEvent.CAST_REMOVED イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.CastEvent#REMOVED
		 * @see jp.progression.events.CastEvent#REMOVED_COMPLETE
		 */
		public function get onCastRemoved():Function { return _onCastRemoved; }
		public function set onCastRemoved( value:Function ):void { _onCastRemoved = value; }
		private var _onCastRemoved:Function;
		
		/**
		 * <p>キャストオブジェクトが CastEvent.CAST_REMOVED イベントを受け取った場合に呼び出されるオーバーライド・イベントハンドラメソッドです。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.CastEvent#REMOVED
		 * @see jp.progression.events.CastEvent#REMOVED_COMPLETE
		 */
		protected function atCastRemoved():void {}
		
		/**
		 * <p>キャストオブジェクトが CastMouseEvent.CAST_MOUSE_DOWN イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.CastMouseEvent#MOUSE_DOWN
		 */
		public function get onCastMouseDown():Function { return _onCastMouseDown; }
		public function set onCastMouseDown( value:Function ):void { _onCastMouseDown = value; }
		private var _onCastMouseDown:Function;
		
		/**
		 * <p>キャストオブジェクトが CastMouseEvent.CAST_MOUSE_DOWN イベントを受け取った場合に呼び出されるオーバーライド・イベントハンドラメソッドで。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.CastMouseEvent#MOUSE_DOWN
		 */
		protected function atCastMouseDown():void {}
		
		/**
		 * <p>キャストオブジェクトが CastMouseEvent.CAST_MOUSE_UP イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.CastMouseEvent#MOUSE_UP
		 */
		public function get onCastMouseUp():Function { return _onCastMouseUp; }
		public function set onCastMouseUp( value:Function ):void { _onCastMouseUp = value; }
		private var _onCastMouseUp:Function;
		
		/**
		 * <p>キャストオブジェクトが CastMouseEvent.CAST_MOUSE_UP イベントを受け取った場合に呼び出されるオーバーライド・イベントハンドラメソッドです。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.CastMouseEvent#MOUSE_UP
		 */
		protected function atCastMouseUp():void {}
		
		/**
		 * <p>キャストオブジェクトが CastMouseEvent.CAST_ROLL_OVER イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.CastMouseEvent#ROLL_OVER
		 */
		public function get onCastRollOver():Function { return _onCastRollOver; }
		public function set onCastRollOver( value:Function ):void { _onCastRollOver = value; }
		private var _onCastRollOver:Function;
		
		/**
		 * <p>キャストオブジェクトが CastMouseEvent.CAST_ROLL_OVER イベントを受け取った場合に呼び出されるオーバーライド・イベントハンドラメソッドです。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.CastMouseEvent#ROLL_OVER
		 */
		protected function atCastRollOver():void {}
		
		/**
		 * <p>キャストオブジェクトが CastMouseEvent.CAST_ROLL_OUT イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.CastMouseEvent#ROLL_OUT
		 */
		public function get onCastRollOut():Function { return _onCastRollOut; }
		public function set onCastRollOut( value:Function ):void { _onCastRollOut = value; }
		private var _onCastRollOut:Function;
		
		/**
		 * <p>キャストオブジェクトが CastMouseEvent.CAST_ROLL_OUT イベントを受け取った場合に呼び出されるオーバーライド・イベントハンドラメソッドです。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #addCommand();
		 * @see #insertCommand();
		 * @see #clearCommand();
		 * @see jp.progression.events.CastMouseEvent#ROLL_OUT
		 */
		protected function atCastRollOut():void {}
		
		
		
		
		
		/**
		 * <p>新しい CastButton インスタンスを作成します。</p>
		 * <p>Creates a new CastButton object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function CastButton( initObject:Object = null ) {
			// 親クラスを初期化する
			super( initObject );
			
			// ボタンを有効化する
			super.mouseChildren = false;
			
			// イベントリスナーを登録する
			super.addEventListener( Event.ADDED_TO_STAGE, _addedToStage, false, int.MAX_VALUE, true );
			super.addEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage, false, int.MAX_VALUE, true );
			super.addEventListener( CastEvent.CAST_ADDED, _castAdded, false, 0, true );
			super.addEventListener( CastEvent.CAST_REMOVED, _castRemoved, false, 0, true );
			Progression.progression_internal::$collections.addEventListener( CollectionEvent.COLLECTION_UPDATE, _collectionUpdate, false, 0, true );
		}
		
		
		
		
		
		/**
		 * <p>指定されたシーン識別子、または URL の示す先に移動します。
		 * 引数が省略された場合には、あらかじめ CastButton インスタンスに指定されている sceneId プロパティ、 href プロパティが示す先に移動します。</p>
		 * <p></p>
		 * 
		 * @see #sceneId
		 * @see #href
		 * @see #windowTarget
		 * 
		 * @param location
		 * <p>移動先を示すシーン識別子、または URL です。</p>
		 * <p></p>
		 * @param window
		 * <p>location パラメータで指定されたドキュメントを表示するブラウザウィンドウまたは HTML フレームです。</p>
		 * <p></p>
		 */
		public function navigateTo( location:*, window:String = null ):void {
			_navigateTo( location, window );
		}
		
		/**
		 * 
		 */
		private function _navigateTo( location:*, window:String = null ):void {
			var request:URLRequest;
			var sceneId:SceneId;
			
			// window を設定する
			window ||= "_self";
			
			// location を型によって振り分ける
			switch ( true ) {
				case location is String			: { request = new URLRequest( location ); break; }
				case location is URLRequest		: { request = URLRequest( location ); break; }
				case location is SceneId		: { sceneId = SceneId( location ); break; }
				default							: { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_005 ).toString( "location" ) ); }
			}
			
			// URL を移動する
			if ( request ) {
				navigateToURL( request, window );
			}
			
			// シーンを移動する
			else if ( _managerFromSceneId ) {
				// 同期機能が有効化されていなければ常に _self とする
				window = _managerFromSceneId.sync ? window : "_self";
				
				// 自身が指定されていれば
				if ( window == "_self" ) {
					_managerFromSceneId.goto( sceneId );
				}
				
				// 他のウィンドウが指定されていれば
				else {
					navigateToURL( new URLRequest( "#" + sceneId.toShortPath() ), window );
				}
			}
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
			// 現在の Progression を取得する
			var oldManager:Progression = _manager;
			
			// 親が IManageable であれば
			var manageable:IManageable = super.parent as IManageable;
			if ( manageable ) {
				// Progression を取得する
				_manager = manageable.manager;
			}
			else {
				// Progression を破棄する
				_manager = null;
			}
			
			// 変更されていなければ終了する
			if ( _manager == oldManager ) { return !!_manager; }
			
			// Progression と関連付けられていれば
			if ( _manager ) {
				// イベントを送出する
				super.dispatchEvent( new ManagerEvent( ManagerEvent.MANAGER_ACTIVATE ) );
			}
			else {
				// イベントを送出する
				super.dispatchEvent( new ManagerEvent( ManagerEvent.MANAGER_DEACTIVATE ) );
			}
			
			return !!_manager;
		}
		
		/**
		 * <p>特定のイベントが送出された際に、自動実行させたい Command インスタンスをリストの最後尾に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に初期化されます。
		 * このメソッドを使用するためには executor プロパティに CommandExecutor が実装されている必要があります。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #onCastMouseDown;
		 * @see #onCastMouseUp;
		 * @see #onCastRollOver;
		 * @see #onCastRollOut;
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
			
			var executor:ExecutorObject = _executor;
			switch ( true ) {
				case _mouseDownUpExecutor.dispatching	: { executor = _mouseDownUpExecutor; break; }
				case _rollOverOutExecutor.dispatching	: { executor = _rollOverOutExecutor; break; }
			}
			
			Object( executor ).addCommand.apply( null, commands );
		}
		
		/**
		 * <p>特定のイベントが送出された際に、自動実行させたい Command インスタンスをすでにリストに登録され、実行中の Command インスタンスの次の位置に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に初期化されます。
		 * このメソッドを使用するためには executor プロパティに CommandExecutor が実装されている必要があります。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #onCastMouseDown;
		 * @see #onCastMouseUp;
		 * @see #onCastRollOver;
		 * @see #onCastRollOut;
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
			
			var executor:ExecutorObject = _executor;
			switch ( true ) {
				case _mouseDownUpExecutor.dispatching	: { executor = _mouseDownUpExecutor; break; }
				case _rollOverOutExecutor.dispatching	: { executor = _rollOverOutExecutor; break; }
			}
			
			Object( executor ).insertCommand.apply( null, commands );
		}
		
		/**
		 * <p>登録されている Command インスタンスを削除します。
		 * このメソッドを使用するためには executor プロパティに CommandExecutor が実装されている必要があります。</p>
		 * <p></p>
		 * 
		 * @see #executor
		 * @see #onCastMouseDown;
		 * @see #onCastMouseUp;
		 * @see #onCastRollOver;
		 * @see #onCastRollOut;
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
			
			var executor:ExecutorObject = _executor;
			switch ( true ) {
				case _mouseDownUpExecutor.dispatching	: { executor = _mouseDownUpExecutor; break; }
				case _rollOverOutExecutor.dispatching	: { executor = _rollOverOutExecutor; break; }
			}
			
			Object( executor ).clearCommand( completely );
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
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null, href ? "href" : "sceneId" );
		}
		
		
		
		
		
		/**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。
		 */
		private function _addedToStage( e:Event ):void {
			// イベントリスナーを登録する
			super.addEventListener( MouseEvent.CLICK, _click );
			super.addEventListener( MouseEvent.MOUSE_DOWN, _mouseDown );
			super.addEventListener( MouseEvent.ROLL_OVER, _rollOver );
			super.addEventListener( MouseEvent.ROLL_OUT, _rollOut );
			super.addEventListener( CastMouseEvent.CAST_MOUSE_DOWN, _castMouseDown );
			super.addEventListener( CastMouseEvent.CAST_MOUSE_UP, _castMouseUp );
			super.addEventListener( CastMouseEvent.CAST_ROLL_OVER, _castRollOver );
			super.addEventListener( CastMouseEvent.CAST_ROLL_OUT, _castRollOut );
			super.stage.addEventListener( KeyboardEvent.KEY_DOWN, _keyDown );
			super.stage.addEventListener( KeyboardEvent.KEY_UP, _keyUp );
			
			// Progression インスタンスとの関連付けを更新する
			updateManager();
			
			// アクティブリストに登録する
			_activatedButtons.addItem( this );
			
			// Stage の参照を保持する
			_stage = super.stage;
			
			// 初期化されていなければ終了する
			if ( !Progression.config ) {
				Logger.warn( Logger.getLog( L10NProgressionMsg.ERROR_017 ).toString( this, "executor" ) );
				Logger.warn( Logger.getLog( L10NProgressionMsg.ERROR_017 ).toString( this, "contextMenu" ) );
				return;
			}
			
			// ExecutorObject を作成する
			_executor = new ( Progression.config.executor as Class )( this );
			_mouseDownUpExecutor = new ( Progression.config.executor as Class )( this );
			_rollOverOutExecutor = new ( Progression.config.executor as Class )( this );
			
			// 親が IExecutable であれば
			var executable:IExecutable = super.parent as IExecutable;
			if ( executable && executable.executor ) {
				executable.executor.addExecutor( _executor );
			}
			
			// コンテクストメニューを作成する
			var cls:Class = Progression.config.contextMenuBuilder;
			if ( cls ) {
				_allowBuildContextMenu = true;
				_contextMenuBuilder = new cls( this );
				_allowBuildContextMenu = false;
			}
		}
		
		/**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの削除により、表示リストから削除されようとしているときに送出されます。
		 */
		private function _removedFromStage( e:Event ):void {
			// イベントリスナーを解除する
			super.removeEventListener( MouseEvent.CLICK, _click );
			super.removeEventListener( MouseEvent.MOUSE_DOWN, _mouseDown );
			super.removeEventListener( MouseEvent.MOUSE_UP, _mouseUp );
			super.removeEventListener( MouseEvent.ROLL_OVER, _rollOver );
			super.removeEventListener( MouseEvent.ROLL_OUT, _rollOut );
			super.removeEventListener( CastMouseEvent.CAST_MOUSE_DOWN, _castMouseDown );
			super.removeEventListener( CastMouseEvent.CAST_MOUSE_UP, _castMouseUp );
			super.removeEventListener( CastMouseEvent.CAST_ROLL_OVER, _castRollOver );
			super.removeEventListener( CastMouseEvent.CAST_ROLL_OUT, _castRollOut );
			_stage.removeEventListener( MouseEvent.MOUSE_UP, _mouseUpStage );
			_stage.removeEventListener( KeyboardEvent.KEY_DOWN, _keyDown );
			_stage.removeEventListener( KeyboardEvent.KEY_UP, _keyUp );
			
			// アクティブリストから削除する
			_activatedButtons.removeItem( this );
			
			// Stage の参照を破棄する
			_stage = null;
			
			// Progression インスタンスとの関連付けを更新する
			if ( _manager ) {
				// Progression を破棄する
				_manager = null;
				
				// イベントを送出する
				super.dispatchEvent( new ManagerEvent( ManagerEvent.MANAGER_DEACTIVATE ) );
			}
			
			// ExecutorObject が存在すれば
			if ( _executor ) {
				// 登録済みであれば解除する
				if ( _executor.parent ) {
					_executor.parent.removeExecutor( _executor );
				}
				
				// ExecutorObject を破棄する
				_executor.dispose();
				_executor = null;
			}
			
			// ExecutorObject が存在すれば
			if ( _mouseDownUpExecutor ) {
				// イベントリスナーを解除する
				_mouseDownUpExecutor.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteMouseDownUpExecutor );
				_mouseDownUpExecutor.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteMouseUp );
				
				// 破棄する
				_mouseDownUpExecutor.dispose();
				_mouseDownUpExecutor = null;
			}
			
			// ExecutorObject が存在すれば
			if ( _rollOverOutExecutor ) {
				// イベントリスナーを解除する
				_rollOverOutExecutor.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteRollOverOutExecutor );
				
				// 破棄する
				_rollOverOutExecutor.dispose();
				_rollOverOutExecutor = null;
			}
			
			// 破棄する
			_mouseDownUpEvent = null;
			_rollOverOutEvent = null;
			
			// コンテクストメニューを破棄する
			if ( _contextMenuBuilder ) {
				_allowBuildContextMenu = true;
				_contextMenuBuilder.dispose();
				_contextMenuBuilder = null;
				_allowBuildContextMenu = false;
			}
		}
		
		/**
		 * ユーザーがキーを押したときに送出されます。
		 */
		private function _keyDown( e:KeyboardEvent ):void {
			// CTRL キー、または SHIFT キーが押されているかどうかを設定します。
			_isDownCTRLorShiftKey = e.ctrlKey || e.shiftKey;
			
			// キャラコードが一致しなければ終了する
			if ( !_accessKey || e.charCode != _accessKey.toLowerCase().charCodeAt() ) { return; }
			
			// 移動先が存在すれば移動する
			if ( _href || _sceneId ) {
				_navigateTo( _href || _sceneId, _windowTarget );
			}
		}
		
		/**
		 * ユーザーがキーを離したときに送出されます。
		 */
		private function _keyUp( e:KeyboardEvent ):void {
			// CTRL キー、または SHIFT キーが押されているかどうかを無効化します。
			_isDownCTRLorShiftKey = false;
		}
		
		/**
		 * 
		 */
		private function _click( e:MouseEvent ):void {
			// マウスダウン、またはロール―オーバーされていれば終了する
			if ( _isMouseDown || _isRollOver ) { return; }
			
			// 移動先が存在すれば移動する
			if ( _href || _sceneId ) {
				_navigateTo( _href || _sceneId, _isDownCTRLorShiftKey ? "_blank" : _windowTarget );
			}
		}
		
		/**
		 * Flash Player ウィンドウの InteractiveObject インスタンスの上でユーザーがポインティングデバイスのボタンを押すと送出されます。
		 */
		private function _mouseDown( e:MouseEvent ):void {
			// 状態を変更する
			_isMouseDown = true;
			
			// マウス状態に応じた処理をしないのであれば終了する
			if ( !_mouseEventEnabled ) { return; }
			
			// ExecutorObject が存在しなければ終了する
			if ( !_mouseDownUpExecutor ) { return; }
			
			// すでに実行していたら終了する
			if ( _mouseDownUpExecutor.state > 0 ) {
				_mouseDownUpExecutor.interrupt();
			}
			
			// イベントを保存する
			_mouseDownUpEvent = e;
			
			// 実行する
			_mouseDownUpExecutor.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteMouseDownUpExecutor );
			_mouseDownUpExecutor.execute( new CastMouseEvent( CastMouseEvent.CAST_MOUSE_DOWN, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown, e.delta ) );
			
			// イベントリスナーを登録する
			super.addEventListener( MouseEvent.MOUSE_UP, _mouseUp );
			super.stage.addEventListener( MouseEvent.MOUSE_UP, _mouseUpStage );
		}
		
		/**
		 * ユーザーが InteractiveObject インスタンスからポインティングデバイスを離したときに送出されます。
		 */
		private function _mouseUp( e:MouseEvent ):void {
			// イベントリスナーを解除する
			super.removeEventListener( MouseEvent.MOUSE_UP, _mouseUp );
			super.stage.removeEventListener( MouseEvent.MOUSE_UP, _mouseUpStage );
			
			// 状態を変更する
			_isMouseDown = false;
			
			// マウス状態に応じた処理をしないのであれば終了する
			if ( !_mouseEventEnabled ) { return; }
			
			// ExecutorObject が存在しなければ終了する
			if ( !_mouseDownUpExecutor ) { return; }
			
			// すでに実行していたら中断する
			if ( _mouseDownUpExecutor.state > 0 ) {
				_mouseDownUpExecutor.interrupt();
				
				// イベントを送出する
				super.dispatchEvent( new CastMouseEvent( CastMouseEvent.CAST_MOUSE_DOWN_COMPLETE, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown, e.delta ) );
			}
			
			// 新しいウィンドウで開くかどうかを設定します。
			_openNewWindow = _isDownCTRLorShiftKey;
			
			// イベントを保存する
			_mouseDownUpEvent = e;
			
			// 実行する
			_mouseDownUpExecutor.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteMouseDownUpExecutor );
			_mouseDownUpExecutor.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteMouseUp, false, int.MAX_VALUE );
			_mouseDownUpExecutor.execute( new CastMouseEvent( CastMouseEvent.CAST_MOUSE_UP, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown, e.delta ) );
		}
		
		/**
		 * ユーザーが InteractiveObject インスタンスからポインティングデバイスを離したときに送出されます。
		 */
		private function _mouseUpStage( e:MouseEvent ):void {
			// イベントリスナーを解除する
			super.removeEventListener( MouseEvent.MOUSE_UP, _mouseUp );
			super.stage.removeEventListener( MouseEvent.MOUSE_UP, _mouseUpStage );
			
			// 状態を変更する
			_isMouseDown = false;
			
			// マウス状態に応じた処理をしないのであれば終了する
			if ( !_mouseEventEnabled ) { return; }
			
			// ExecutorObject が存在しなければ終了する
			if ( !_mouseDownUpExecutor ) { return; }
			
			// すでに実行していたら中断する
			if ( _mouseDownUpExecutor.state > 0 ) {
				_mouseDownUpExecutor.interrupt();
				
				// イベントを送出する
				super.dispatchEvent( new CastMouseEvent( CastMouseEvent.CAST_MOUSE_DOWN_COMPLETE, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown, e.delta ) );
			}
			
			// イベントを保存する
			_mouseDownUpEvent = e;
			
			// 実行する
			_mouseDownUpExecutor.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteMouseDownUpExecutor );
			_mouseDownUpExecutor.execute( new CastMouseEvent( CastMouseEvent.CAST_MOUSE_UP, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown, e.delta ) );
			
			// ロールオーバーしておらず、未処理のロールオーバーイベントが存在すれば
			if ( !_isRollOver && _rollOverOutEvent ) {
				_rollOut( _rollOverOutEvent );
			}
		}
		
		/**
		 * 処理が完了した場合に送出されます。
		 */
		private function _executeCompleteMouseDownUpExecutor( e:ExecuteEvent ):void {
			// イベントリスナーを解除する
			_mouseDownUpExecutor.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteMouseDownUpExecutor );
			
			// イベントを送出する
			super.dispatchEvent( new CastMouseEvent( _isMouseDown ? CastMouseEvent.CAST_MOUSE_DOWN_COMPLETE : CastMouseEvent.CAST_MOUSE_UP_COMPLETE, _mouseDownUpEvent.bubbles, _mouseDownUpEvent.cancelable, _mouseDownUpEvent.localX, _mouseDownUpEvent.localY, _mouseDownUpEvent.relatedObject, _mouseDownUpEvent.ctrlKey, _mouseDownUpEvent.altKey, _mouseDownUpEvent.shiftKey, _mouseDownUpEvent.buttonDown, _mouseDownUpEvent.delta ) );
			
			// マウスイベントを破棄する
			_mouseDownUpEvent = null;
		}
		
		/**
		 * 処理が完了した場合に送出されます。
		 */
		private function _executeCompleteMouseUp( e:ExecuteEvent ):void {
			// イベントリスナーを解除する
			_mouseDownUpExecutor.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteMouseUp );
			
			// 移動先が存在すれば移動する
			if ( _href || _sceneId ) {
				// イベントを送出する
				if ( super.dispatchEvent( new CastMouseEvent( CastMouseEvent.CAST_NAVIGATE_BEFORE, false, true ) ) ) {
					_navigateTo( _href || _sceneId, _openNewWindow ? "_blank" : _windowTarget );
				}
				
				// ロールオーバーしておらず、未処理のロールオーバーイベントが存在すれば
				if ( !_isRollOver && _rollOverOutEvent ) {
					_rollOut( _rollOverOutEvent );
				}
			}
			
			// 状態を変更する
			_openNewWindow = false;
		}
		
		/**
		 * ユーザーが InteractiveObject インスタンスにポインティングデバイスを合わせたときに送出されます。
		 */
		private function _rollOver( e:MouseEvent ):void {
			// 状態を変更する
			_isRollOver = true;
			
			// マウス状態に応じた処理をしないのであれば終了する
			if ( !_mouseEventEnabled ) { return; }
			
			// ExecutorObject が存在しなければ終了する
			if ( !_rollOverOutExecutor ) { return; }
			
			// マウスをダウンしていれば終了する
			if ( _isMouseDown ) { return; }
			
			// すでに実行していたら中断する
			if ( _rollOverOutExecutor.state > 0 ) {
				_rollOverOutExecutor.interrupt();
				
				// イベントを送出する
				super.dispatchEvent( new CastMouseEvent( CastMouseEvent.CAST_ROLL_OUT_COMPLETE, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown, e.delta ) );
			}
			
			// イベントを保存する
			_rollOverOutEvent = e;
			
			// 実行する
			_rollOverOutExecutor.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteRollOverOutExecutor );
			_rollOverOutExecutor.execute( new CastMouseEvent( CastMouseEvent.CAST_ROLL_OVER, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown, e.delta ) );
			
			// イベントリスナーを登録する
			super.addEventListener( MouseEvent.ROLL_OUT, _rollOut, false, 0, true );
		}
		
		/**
		 * ユーザーが InteractiveObject インスタンスからポインティングデバイスを離したときに送出されます。
		 */
		private function _rollOut( e:MouseEvent ):void {
			// イベントリスナーを解除する
			super.removeEventListener( MouseEvent.ROLL_OUT, _rollOut );
			
			// 状態を変更する
			_isRollOver = false;
			
			// マウス状態に応じた処理をしないのであれば終了する
			if ( !_mouseEventEnabled ) { return; }
			
			// ExecutorObject が存在しなければ終了する
			if ( !_rollOverOutExecutor ) { return; }
			
			// すでに実行していたら中断する
			if ( _rollOverOutExecutor.state > 0 ) {
				_rollOverOutExecutor.interrupt();
				
				// イベントを送出する
				super.dispatchEvent( new CastMouseEvent( CastMouseEvent.CAST_ROLL_OVER_COMPLETE, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown, e.delta ) );
			}
			
			// イベントを保存する
			_rollOverOutEvent = e;
			
			// 実行する
			_rollOverOutExecutor.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteRollOverOutExecutor );
			_rollOverOutExecutor.execute( new CastMouseEvent( CastMouseEvent.CAST_ROLL_OUT, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown, e.delta ) );
		}
		
		/**
		 * 処理が完了した場合に送出されます。
		 */
		private function _executeCompleteRollOverOutExecutor( e:ExecuteEvent ):void {
			// イベントリスナーを解除する
			_rollOverOutExecutor.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeCompleteRollOverOutExecutor );
			
			// イベントを送出する
			super.dispatchEvent( new CastMouseEvent( _isRollOver ? CastMouseEvent.CAST_ROLL_OVER_COMPLETE : CastMouseEvent.CAST_ROLL_OUT_COMPLETE, _rollOverOutEvent.bubbles, _rollOverOutEvent.cancelable, _rollOverOutEvent.localX, _rollOverOutEvent.localY, _rollOverOutEvent.relatedObject, _rollOverOutEvent.ctrlKey, _rollOverOutEvent.altKey, _rollOverOutEvent.shiftKey, _rollOverOutEvent.buttonDown, _rollOverOutEvent.delta ) );
			
			// マウスイベントを破棄する
			_rollOverOutEvent = null;
		}
		
		/**
		 * IExecutable オブジェクトが AddChild コマンド、または AddChildAt コマンド経由で表示リストに追加された場合に送出されます。
		 */
		private function _castAdded( e:CastEvent ):void {
			// イベントハンドラメソッドを実行する
			atCastAdded();
			if ( _onCastAdded != null ) {
				_onCastAdded.apply( this );
			}
		}
		
		/**
		 * IExecutable オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由で表示リストから削除された場合に送出されます。
		 */
		private function _castRemoved( e:CastEvent ):void {
			// イベントハンドラメソッドを実行する
			atCastRemoved();
			if ( _onCastRemoved != null ) {
				_onCastRemoved.apply( this );
			}
		}
		
		/**
		 * Flash Player ウィンドウの CastButton インスタンスの上でユーザーがポインティングデバイスのボタンを押すと送出されます。
		 */
		private function _castMouseDown( e:CastMouseEvent ):void {
			// イベントハンドラメソッドを実行する
			atCastMouseDown();
			if ( _onCastMouseDown != null ) {
				_onCastMouseDown.apply( this );
			}
		}
		
		/**
		 * ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
		 */
		private function _castMouseUp( e:CastMouseEvent ):void {
			// イベントハンドラメソッドを実行する
			atCastMouseUp();
			if ( _onCastMouseUp != null ) {
				_onCastMouseUp.apply( this );
			}
		}
		
		/**
		 * ユーザーが CastButton インスタンスにポインティングデバイスを合わせたときに送出されます。
		 */
		private function _castRollOver( e:CastMouseEvent ):void {
			// イベントハンドラメソッドを実行する
			atCastRollOver();
			if ( _onCastRollOver != null ) {
				_onCastRollOver.apply( this );
			}
		}
		
		/**
		 * ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
		 */
		private function _castRollOut( e:CastMouseEvent ):void {
			// イベントハンドラメソッドを実行する
			atCastRollOut();
			if ( _onCastRollOut != null ) {
				_onCastRollOut.apply( this );
			}
		}
		
		/**
		 * コレクションに対して、インスタンスが追加された場合に送出されます。
		 */
		private function _collectionUpdate( e:CollectionEvent ):void {
			// シーン識別子が設定されていなければ終了する
			if ( !_sceneId ) { return; }
			
			// Progression インスタンスと関連付けられているかどうかを取得する
			var hasManager:Boolean = !!_managerFromSceneId;
			
			// シーン識別子から取得した Progression インスタンスが存在すれば
			if ( _managerFromSceneId ) {
				_managerFromSceneId.removeEventListener( ProcessEvent.PROCESS_SCENE, _processScene );
			}
			
			// シーン識別子から Progression インスタンスを取得する
			var id:String = _sceneId.getNameByIndex( 0 );
			_managerFromSceneId = Progression.progression_internal::$collections.getInstanceById( id ) as Progression;
			
			// シーン識別子から取得した Progression インスタンスが存在すれば
			if ( _managerFromSceneId ) {
				_managerFromSceneId.addEventListener( ProcessEvent.PROCESS_SCENE, _processScene, false, 0, true );
				
				// イベントを送出する
				super.dispatchEvent( new ManagerEvent( ManagerEvent.MANAGER_ACTIVATE ) );
			}
			else if ( hasManager ) {
				// イベントを送出する
				super.dispatchEvent( new ManagerEvent( ManagerEvent.MANAGER_DEACTIVATE ) );
			}
			
			// 更新する
			_processScene( null );
		}
		
		/**
		 * 管理下にあるシーンの移動処理中に対象シーンが変更された場合に送出されます。
		 */
		private function _processScene( e:ProcessEvent ):void {
			var state:int = _state;
			
			// 現在の状態を取得する
			switch ( true ) {
				case !_sceneId													:
				case !_managerFromSceneId										:
				case !_managerFromSceneId.currentSceneId						: { _state = 0; break; }
				case _sceneId.equals( _managerFromSceneId.currentSceneId )		: { _state = 2; break; }
				case _sceneId.contains( _managerFromSceneId.currentSceneId )	: { _state = 1; break; }
				case _managerFromSceneId.currentSceneId.contains( _sceneId )	: { _state = 3; break; }
				default															: { _state = 4; }
			}
			
			// 状態が変更されていれば
			if ( state != _state ) {
				super.dispatchEvent( new CastMouseEvent( CastMouseEvent.CAST_STATE_CHANGE ) );
			}
		}
	}
}
