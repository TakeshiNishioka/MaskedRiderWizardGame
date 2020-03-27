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
package jp.progression.commands.display {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import jp.nium.core.ns.nium_internal;
	import jp.nium.display.ExMovieClip;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.commands.Command;
	import jp.progression.events.CastEvent;
	import jp.progression.events.ExecuteErrorEvent;
	import jp.progression.events.ExecuteEvent;
	import jp.progression.executors.ExecutorObject;
	
	/**
	 * <p>RemoveChild クラスは、対象の表示リストから DisplayObject インスタンスを削除するコマンドクラスです。
	 * 削除するインスタンスが ICastObject インターフェイスを実装している場合には、CastEvent.CAST_REMOVED イベントが送出され、
	 * 対象のイベント処理の実行中に、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @see jp.progression.commands.display.RemoveAllChildren
	 * @see jp.progression.commands.display.RemoveChildAt
	 * @see jp.progression.commands.display.RemoveChildByName
	 * 
	 * @example <listing version="3.0" >
	 * // RemoveChild インスタンスを作成する
	 * var com:RemoveChild = new RemoveChild();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class RemoveChild extends Command {
		
		/**
		 * <p>指定された DisplayObject インスタンスを削除する対象の DisplayObjectContainer インスタンス、またはインスタンスを示す識別子を取得します。</p>
		 * <p></p>
		 */
		public function get container():* { return _container; }
		private var _container:*;
		
		/**
		 * @private
		 */
		internal var _containerRef:DisplayObjectContainer;
		
		/**
		 * <p>表示リストから削除したい DisplayObject インスタンス、またはインスタンスを示す識別子を取得します。</p>
		 * <p></p>
		 */
		public function get child():* { return _child; }
		private var _child:*;
		
		/**
		 * @private
		 */
		internal var _childRef:DisplayObject;
		
		/**
		 * ExecutorObject インスタンスを取得します。
		 */
		private var _executor:ExecutorObject;
		
		
		
		
		
		/**
		 * <p>新しい RemoveChild インスタンスを作成します。</p>
		 * <p>Creates a new RemoveChild object.</p>
		 * 
		 * @param containerRefOrId
		 * <p>指定された DisplayObject インスタンスを削除する対象の DisplayObjectContainer インスタンス、またはインスタンスを示す識別子です。</p>
		 * <p></p>
		 * @param childRefOrId
		 * <p>表示リストから削除したい DisplayObject インスタンス、またはインスタンスを示す識別子です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function RemoveChild( containerRefOrId:*, childRefOrId:*, initObject:Object = null ) {
			// 引数を設定する
			_container = containerRefOrId;
			_child = childRefOrId;
			
			// 親クラスを初期化する
			super( _executeFunction, _interruptFunction, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _executeFunction():void {
			// 参照を取得する
			_containerRef = _getParentRef();
			_childRef = _getChildRef();
			
			if ( "executor" in _childRef ) {
				// ExecutorObject を取得する
				_executor = Object( _childRef ).executor as ExecutorObject;
				
				// 子が ExecutorObject を実装して、かつ親が存在しなければ
				if ( _executor ) { 
					// すでに実行中であれば中断する
					if ( _executor.state > 0 ) {
						_executor.interrupt();
					}
					
					// イベントリスナーを登録する
					_executor.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
					_executor.addEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
					_executor.addEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _error );
					
					// 実行する
					_executor.execute( new CastEvent( CastEvent.CAST_REMOVED ), super.extra, false );
					return;
				}
			}
			
			// 表示リストから削除する
			_removeChildRef();
			
			// 処理を終了する
			super.executeComplete();
		}
		
		/**
		 * @private
		 */
		internal function _getParentRef():DisplayObjectContainer {
			return _getObjectRef( _container ) as DisplayObjectContainer;
		}
		
		/**
		 * @private
		 */
		internal function _getChildRef():DisplayObject {
			return _getObjectRef( _child );
		}
		
		/**
		 * @private
		 */
		internal function _removeChildRef():void {
			// 表示リストから削除する
			if ( _containerRef.contains( _childRef ) ) {
				_containerRef.removeChild( _childRef );
			}
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interruptFunction():void {
			// 対象が存在し、実行中であれば
			if ( _executor && _executor.state > 0 ) {
				// 中断する
				_executor.interrupt();
			}
			
			// 中断方法によって処理を振り分ける
			if ( _containerRef && _childRef ) {
				switch ( super.interruptType ) {
					// 表示リストから削除する
					case 2	: { _removeChildRef(); break; }
				}
			}
			
			// 破棄する
			_destroy();
		}
		
		/**
		 * @private
		 */
		internal function _getObjectRef( source:* ):DisplayObject {
			switch ( true ) {
				case source is DisplayObject	: { return DisplayObject( source ); }
				case source is String			: { return ExMovieClip.nium_internal::$collections.getInstanceById( source ) as DisplayObject; }
			}
			return null;
		}
		
		/**
		 * 破棄します。
		 */
		private function _destroy():void {
			// 破棄する
			_containerRef = null;
			_childRef = null;
			
			if ( _executor ) {
				// イベントリスナーを解除する
				_executor.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
				_executor.removeEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
				_executor.removeEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _error );
				
				// ExecutorObject を破棄する
				_executor = null;
			}
		}
		
		/**
		 * <p>RemoveChild インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an RemoveChild subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい RemoveChild インスタンスです。</p>
		 * <p>A new RemoveChild object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new RemoveChild( _container, _child, this );
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
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null, "container", "child" );
		}
		
		
		
		
		
		/**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _executeComplete( e:ExecuteEvent ):void {
			// 表示リストから削除する
			_containerRef.removeChild( _childRef );
			
			// イベントを送出する
			_childRef.dispatchEvent( new CastEvent( CastEvent.CAST_REMOVED_COMPLETE ) );
			
			// 破棄する
			_destroy();
			
			// 処理を終了する
			super.executeComplete();
		}
		
		/**
		 * コマンドの処理が中断された場合に送出されます。
		 */
		private function _executeInterrupt( e:ExecuteEvent ):void {
			// 中断する
			super.interrupt( e.enforcedInterrupting );
		}
		
		/**
		 * 処理の途中でエラーが発生した場合に送出されます。
		 */
		private function _error( e:ExecuteErrorEvent ):void {
			// 例外をスローする
			super.throwError( e.errorTarget as Command, e.errorObject );
		}
	}
}
