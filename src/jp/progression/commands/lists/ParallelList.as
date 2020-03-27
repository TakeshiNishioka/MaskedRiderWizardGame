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
package jp.progression.commands.lists {
	import jp.nium.core.debug.Logger;
	import jp.progression.commands.Command;
	import jp.progression.commands.CommandList;
	import jp.progression.core.L10N.L10NCommandMsg;
	import jp.progression.core.utils.CommandUtil;
	import jp.progression.events.ExecuteErrorEvent;
	import jp.progression.events.ExecuteEvent;
	
	/**
	 * <p>ParallelList クラスは、登録された複数のコマンドを全て同時に実行させるためのコマンドリストクラスです。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ExecuteEvent.EXECUTE_POSITION
	 */
	[Event( name="executePosition", type="jp.progression.events.ExecuteEvent" )]
	
	/**
	 * <p>ParallelList クラスは、指定された複数のコマンドを全て同時に実行させるためのコマンドリストクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // ParallelList インスタンスを作成する
	 * var list:ParallelList = new ParallelList();
	 * 
	 * // コマンドを実行する
	 * list.execute();
	 * </listing>
	 */
	public class ParallelList extends CommandList {
		
		/**
		 * 現在処理中の Command インスタンスを保存した配列を取得します。 
		 */
		private var _commands:Array;
		
		
		
		
		
		/**
		 * <p>新しい ParallelList インスタンスを作成します。</p>
		 * <p>Creates a new ParallelList object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 * @param commands
		 * <p>登録したいコマンドインスタンス、関数、数値、配列などを含む配列です。</p>
		 * <p></p>
		 */
		public function ParallelList( initObject:Object = null, ... commands:Array ) {
			// 初期化する
			_commands = [];
			
			// 親クラスを初期化する
			super( executeFunction, interruptFunction, initObject );
			
			// initObject に自身のサブクラス以外のコマンドが指定されたら警告する
			var com:Command = initObject as Command;
			if ( com && !( com is ParallelList ) ) {
				Logger.warn( Logger.getLog( L10NCommandMsg.WARN_000 ).toString( super.className, com.className ) );
			}
			
			// コマンドリストに登録する
			addCommand.apply( null, commands );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		protected function executeFunction():void {
			// 初期化する
			super.reset();
			_commands = [];
			
			// 現在登録されている全てのコマンドを取得する
			while ( super.hasNextCommand() ) {
				var com:Command = super.nextCommand();
				
				// イベントリスナーを登録する
				com.addEventListener( ExecuteEvent.EXECUTE_POSITION, dispatchEvent );
				com.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
				com.addEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
				com.addEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _error );
				
				// 登録する
				_commands.push( com );
			}
			
			// 登録されていれば
			if ( _commands.length ) {
				// コマンドを同時に実行する
				var commands:Array = _commands.slice();
				for ( var i:int = 0, l:int = commands.length; i < l; i++ ) {
					com = commands[i];
					
					// イベントを送出する
					super.dispatchEvent( new ExecuteEvent( ExecuteEvent.EXECUTE_POSITION, false, false, com ) );
					
					// 実行中であれば実行する
					if ( state == 2 ) {
						com.execute( extra );
					}
				}
			}
			else {
				// 処理を終了する
				super.executeComplete();
			}
		}
		
		/**
		 * @private
		 */
		protected function interruptFunction():void {
			// コマンドを同時に中断する
			var commands:Array = _commands.slice();
			for ( var i:int = 0, l:int = commands.length; i < l; i++ ) {
				var com:Command = commands[i];
				
				// イベントリスナーを解除する
				com.removeEventListener( ExecuteEvent.EXECUTE_POSITION, dispatchEvent );
				com.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
				com.removeEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
				com.removeEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _error );
				
				// 実行中であれば中断する
				if ( com.state > 0 ) {
					com.interrupt();
				}
			}
			
			// 初期化する
			_commands = [];
		}
		
		/**
		 * 破棄します。
		 */
		private function _destroy( command:Command ):void {
			if ( command ) {
				// イベントリスナーを解除する
				command.removeEventListener( ExecuteEvent.EXECUTE_POSITION, dispatchEvent );
				command.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
				command.removeEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
				command.removeEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _error );
				
				// 登録から削除する
				for ( var i:int = 0, l:int = _commands.length; i < l; i++ ) {
					if ( _commands[i] != command ) { continue; }
					
					_commands.splice( i, 1 );
					break;
				}
			}
		}
		
		/**
		 * <p>登録されているコマンドの最後尾に新しくコマンドを追加します。
		 * 関数を指定した場合には、自動的に Func コマンドに変換され、
		 * 数値を指定した場合には、自動的に Wait コマンドに変換され、
		 * 配列を指定した場合には、自動的に SerialList コマンドに変換され、
		 * それ以外の値は、全て自動的に Trace コマンドに変換されます。</p>
		 * <p></p>
		 * 
		 * @see #position
		 * @see #insertCommand()
		 * @see #clearCommand()
		 * 
		 * @param commands
		 * <p>登録したいコマンドを含む配列です。</p>
		 * <p></p>
		 */
		public override function addCommand( ... commands:Array ):void {
			// 親のメソッドを実行する
			super.addCommand.apply( null, CommandUtil.convert( this, commands ) );
		}
		
		/**
		 * <p>現在実行中のコマンドの次の位置に新しくコマンドを追加します。
		 * 関数を指定した場合には、自動的に Func コマンドに変換され、
		 * 数値を指定した場合には、自動的に Wait コマンドに変換され、
		 * 配列を指定した場合には、自動的に SerialList コマンドに変換され、
		 * それ以外の値は、全て自動的に Trace コマンドに変換されます。</p>
		 * <p></p>
		 * 
		 * @see #position
		 * @see #addCommand()
		 * @see #clearCommand()
		 * 
		 * @param commands
		 * <p>登録したいコマンドを含む配列です。</p>
		 * <p></p>
		 * @return
		 * <p>自身の参照です。</p>
		 * <p></p>
		 */
		public override function insertCommand( ... commands:Array ):void {
			// 親のメソッドを実行する
			super.insertCommand.apply( null, CommandUtil.convert( this, commands ) );
		}
		
		/**
		 * <p>ParallelList インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an ParallelList subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい ParallelList インスタンスです。</p>
		 * <p>A new ParallelList object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new ParallelList( this );
		}
		
		
		
		
		
		/**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _executeComplete( e:ExecuteEvent ):void {
			// 破棄する
			_destroy( Command( e.target ) );
			
			// まだ存在すれば終了する
			if ( _commands.length > 0 ) { return; }
			
			// 実行中であれば終了する
			if ( super.state > 0 ) {
				super.executeComplete();
			}
		}
		
		/**
		 * コマンドの処理が中断された場合に送出されます。
		 */
		private function _executeInterrupt( e:ExecuteEvent ):void {
			if ( e.enforcedInterrupting ) {
				// 処理を中断する
				super.interrupt( e.enforcedInterrupting );
			}
			else {
				// 処理を完了する
				super.executeComplete();
			}
		}
		
		/**
		 * 処理の途中でエラーが発生した場合に送出されます。
		 */
		private function _error( e:ExecuteErrorEvent ):void {
			// エラー処理を実行する
			super.throwError( e.errorTarget as Command, e.errorObject );
		}
	}
}
