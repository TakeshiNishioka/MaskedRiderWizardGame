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
	import flash.display.BitmapData;
	import flash.events.Event;
	import jp.nium.core.debug.Logger;
	import jp.nium.display.ExBitmap;
	import jp.progression.core.impls.ICastObject;
	import jp.progression.core.impls.IExecutable;
	import jp.progression.core.impls.IManageable;
	import jp.progression.core.L10N.L10NExecuteMsg;
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.events.CastEvent;
	import jp.progression.events.ManagerEvent;
	import jp.progression.executors.ExecutorObject;
	import jp.progression.Progression;
	
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
	 * <p>非同期処理中にエラーが発生した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ExecuteErrorEvent.EXECUTE_ERROR
	 */
	[Event( name="executeError", type="jp.progression.events.ExecuteErrorEvent" )]
	
	/**
	 * <p>CastBitmap クラスは、ExBitmap クラスの基本機能を拡張し、イベントフローとの連携機能を実装した jp.progression パッケージで使用される基本的な表示オブジェクトクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // CastBitmap インスタンスを作成する
	 * var cast:CastBitmap = new CastBitmap();
	 * </listing>
	 */
	public class CastBitmap extends ExBitmap implements ICastObject, IManageable {
		
		/**
		 * <p>自身の参照を取得します。</p>
		 * <p></p>
		 */
		public function get self():CastBitmap { return CastBitmap( this ); }
		
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
		 * <p>新しい CastBitmap インスタンスを作成します。</p>
		 * <p>Creates a new CastBitmap object.</p>
		 * 
		 * @param bitmapData
		 * <p>BitmapData オブジェクトが参照されます。</p>
		 * <p>The BitmapData object being referenced.</p>
		 * @param pixelSnapping
		 * <p>Bitmap オブジェクトが最も近いピクセルに吸着されるかどうかを示します。</p>
		 * <p>Whether or not the Bitmap object is snapped to the nearest pixel.</p>
		 * @param smoothing
		 * <p>ビットマップを拡大 / 縮小するときにスムージングするかどうかを示します。</p>
		 * <p>Whether or not the bitmap is smoothed when scaled.</p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function CastBitmap( bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false, initObject:Object = null ) {
			// 親クラスを初期化する
			super( bitmapData, pixelSnapping, smoothing, initObject );
			
			// イベントリスナーを登録する
			super.addEventListener( CastEvent.CAST_ADDED, _castAdded, false, 0, true );
			super.addEventListener( CastEvent.CAST_REMOVED, _castRemoved, false, 0, true );
			super.addEventListener( Event.ADDED_TO_STAGE, _addedToStage, false, int.MAX_VALUE, true );
			super.addEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage, false, int.MAX_VALUE, true );
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
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。
		 */
		private function _addedToStage( e:Event ):void {
			// Progression インスタンスとの関連付けを更新する
			updateManager();
			
			// 初期化されていなければ終了する
			if ( !Progression.config ) {
				Logger.warn( Logger.getLog( L10NProgressionMsg.ERROR_017 ).toString( this, "executor" ) );
				return;
			}
			
			// ExecutorObject を作成する
			_executor = new ( Progression.config.executor as Class )( this );
			
			// 親が IExecutable であれば
			var executable:IExecutable = super.parent as IExecutable;
			if ( executable && executable.executor ) {
				executable.executor.addExecutor( _executor );
			}
		}
		
		/**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの削除により、表示リストから削除されようとしているときに送出されます。
		 */
		private function _removedFromStage( e:Event ):void {
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
	}
}
