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
	import flash.display.DisplayObjectContainer;
	import jp.nium.core.ns.nium_internal;
	import jp.nium.display.ChildIterator;
	import jp.nium.display.ExMovieClip;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.commands.Command;
	import jp.progression.commands.lists.ParallelList;
	import jp.progression.events.ExecuteErrorEvent;
	import jp.progression.events.ExecuteEvent;
	
	/**
	 * <p>RemoveAllChildren クラスは、対象の表示リストに登録されている全ての DisplayObject インスタンスを削除するコマンドクラスです。
	 * 削除するインスタンスが ICastObject インターフェイスを実装している場合には、CastEvent.CAST_REMOVED イベントが送出され、
	 * 対象のイベント処理の実行中に、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @see jp.progression.commands.display.RemoveChild
	 * @see jp.progression.commands.display.RemoveChildAt
	 * @see jp.progression.commands.display.RemoveChildByName
	 * 
	 * @example <listing version="3.0" >
	 * // RemoveAllChildren インスタンスを作成する
	 * var com:RemoveAllChildren = new RemoveAllChildren();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class RemoveAllChildren extends Command {
		
		/**
		 * <p>全てのインスタンスを削除する対象の表示リストを含む DisplayObjectContainer インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get container():* { return _container; }
		private var _container:*;
		
		/**
		 * @private
		 */
		internal var _containerRef:DisplayObjectContainer;
		
		/**
		 * ParallelList インスタンスを取得します。
		 */
		private var _command:ParallelList;
		
		
		
		
		
		/**
		 * <p>新しい RemoveAllChildren インスタンスを作成します。</p>
		 * <p>Creates a new RemoveAllChildren object.</p>
		 * 
		 * @param containerRefOrId
		 * <p>全ての DisplayObject インスタンスを削除する対象の DisplayObjectContainer インスタンス、またはインスタンスを示す識別子です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function RemoveAllChildren( containerRefOrId:*, initObject:Object = null ) {
			// 引数を設定する
			_container = containerRefOrId;
			
			// 親クラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// 参照を取得する
			_containerRef = _getObjectRef( _container );
			
			// ParallelList を作成する
			_command = new ParallelList();

			// 全ての子を消去する
			var iterator:ChildIterator = new ChildIterator( _containerRef );
			while ( iterator.hasNext() ) {
				_command.addCommand( new RemoveChild( _containerRef, iterator.next(), this ) );
			}
			
			// コマンドを実行する
			_command.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
			_command.addEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
			_command.addEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _error );
			_command.execute();
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// すでに実行されていれば
			if ( _command ) {
				_command.interrupt();
			}
			
			// 破棄する
			_destroy();
		}
		
		/**
		 * @private
		 */
		internal function _getObjectRef( source:* ):DisplayObjectContainer {
			switch ( true ) {
				case source is DisplayObjectContainer	: { return DisplayObjectContainer( source ); }
				case source is String					: { return ExMovieClip.nium_internal::$collections.getInstanceById( source ) as DisplayObjectContainer; }
			}
			return null;
		}
		
		/**
		 * 破棄します。
		 */
		private function _destroy():void {
			// 破棄する
			_containerRef = null;
			
			if ( _command ) {
				// イベントリスナーを解除する
				_command.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
				_command.removeEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
				_command.removeEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _error );
				
				// Command を破棄する
				_command = null;
			}
		}
		
		/**
		 * <p>RemoveAllChildren インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an RemoveAllChildren subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい RemoveAllChildren インスタンスです。</p>
		 * <p>A new RemoveAllChildren object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new RemoveAllChildren( _container, this );
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
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null, "container" );
		}
		
		
		
		
		
		/**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _executeComplete( e:ExecuteEvent ):void {
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
