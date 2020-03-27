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
package jp.progression.commands {
	import jp.nium.collections.UniqueList;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.core.ns.progression_internal;
	
	/**
	 * <p>CommandList クラスは、コマンドリストでコマンドコンテナとして機能する全てのコマンドの基本となるクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // CommandList インスタンスを作成する
	 * var list:CommandList = new CommandList();
	 * 
	 * // コマンドを実行する
	 * list.execute();
	 * </listing>
	 */
	public class CommandList extends Command {
		
		/**
		 * <p>子コマンドインスタンスが保存されている配列です。
		 * この配列を操作することで元の配列を変更することはできません。</p>
		 * <p></p>
		 */
		public function get commands():Array { return _commands ? _commands.toArray() : []; }
		private function get _commands():UniqueList { return __commands ||= new UniqueList(); }
		private var __commands:UniqueList;
		
		/**
		 * <p>子として登録されているコマンド数を取得します。</p>
		 * <p></p>
		 */
		public function get numCommands():int { return _commands ? _commands.numItems : 0; }
		
		/**
		 * <p>現在処理しているコマンド位置を取得または設定します。</p>
		 * <p></p>
		 */
		public function get position():int { return _position; }
		private var _position:int = 0;
		
		/**
		 * 実行処理関数を取得します。
		 */
		private var _executeFunction:Function;
		
		/**
		 * 中断処理関数を取得します。
		 */
		private var _interruptFunction:Function;
		
		
		
		
		
		/**
		 * <p>新しい CommandList インスタンスを作成します。</p>
		 * <p>Creates a new CommandList object.</p>
		 * 
		 * @param executeFunction
		 * <p>実行関数です。</p>
		 * <p></p>
		 * @param interruptFunction
		 * <p>中断関数です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 * @param commands
		 * <p>登録したいコマンドインスタンスを含む配列です。</p>
		 * <p></p>
		 */
		public function CommandList( executeFunction:Function = null, interruptFunction:Function = null, initObject:Object = null, ... commands:Array ) {
			// 引数を設定する
			_executeFunction = executeFunction;
			_interruptFunction = interruptFunction;
			
			// 親クラスを初期化する
			super( executeFunction, interruptFunction, initObject );
			
			// 継承せずにインスタンスを生成しようとしたら例外をスローする
			if ( Object( this ).constructor == CommandList ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( super.className ) ); }
			
			// initObject が CommandList であれば
			var com:CommandList = initObject as CommandList;
			if ( com ) {
				// 特定のプロパティを継承する
				var source:UniqueList = com._commands;
				for ( var i:int = 0, l:int = source.numItems; i < l; i++ ) {
					_addCommandAt( source.getItemAt( i ).clone(), numCommands );
				}
			}
			
			// コマンドリストに登録する
			_addCommand.apply( null, commands );
		}
		
		
		
		
		
		/**
		 * <p>登録されているコマンドリストの最後尾に新しくコマンドインスタンスを追加します。</p>
		 * <p></p>
		 * 
		 * @see #position
		 * @see #insertCommand()
		 * @see #clearCommand()
		 * 
		 * @param commands
		 * <p>登録したいコマンドインスタンスを含む配列です。</p>
		 * <p></p>
		 */
		public function addCommand( ... commands:Array ):void {
			_addCommand.apply( null, commands );
		}
		
		/**
		 * 
		 */
		private function _addCommand( ... commands:Array ):void {
			// コマンドリストに登録する
			for ( var i:int = 0, l:int = commands.length; i < l; i++ ) {
				var command:Command = commands[i] as Command;
				if ( command ) {
					_addCommandAt( command, numCommands );
				}
			}
		}
		
		/**
		 * <p>現在実行中のコマンドインスタンスの次の位置に新しくコマンドインスタンスを追加します。</p>
		 * <p></p>
		 * 
		 * @see #position
		 * @see #addCommand()
		 * @see #clearCommand()
		 * 
		 * @param commands
		 * <p>登録したいコマンドインスタンスを含む配列です。</p>
		 * <p></p>
		 */
		public function insertCommand( ... commands:Array ):void {
			// コマンドリストに登録する
			for ( var i:int = 0, l:int = commands.length; i < l; i++ ) {
				var command:Command = commands[i] as Command;
				if ( command ) {
					_addCommandAt( command, _position + i );
				}
			}
		}
		
		/**
		 * コマンドリストに対して子コマンドを追加します。
		 */
		private function _addCommandAt( command:Command, index:int ):Command {
			// インデックスの範囲を超えていれば例外をスローする
			if ( index < 0 || numCommands < index ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_004 ).toString() ); }
			
			// すでに親が存在していれば解除する
			var parent:CommandList = command.parent;
			if ( parent ) {
				parent._removeCommandAt( parent._commands.getItemIndex( command ) );
				index = Math.min( index, parent.numCommands );
			}
			
			// 登録する
			_commands.addItemAt( command, index );
			command.progression_internal::$parent = this;
			
			return command;
		}
		
		/**
		 * <p>コマンドインスタンスをリストから削除します。</p>
		 * <p></p>
		 * 
		 * @see #position
		 * @see #addCommand()
		 * @see #insertCommand()
		 * 
		 * @param completely
		 * <p>true が設定されている場合は登録されている全ての登録を解除し、false の場合には現在処理中のコマンドインスタンス以降の登録を解除します。</p>
		 * <p></p>
		 */
		public function clearCommand( completely:Boolean = false ):void {
			// 現在のリストをコピーする
			var commands:Array = _commands.toArray();
			
			// 全て、もしくは現在の処理位置以降を削除する
			commands = completely ? commands : commands.splice( _position );
			
			// 親子関係を再設定する
			for ( var i:int = 0, l:int = commands.length; i < l; i++ ) {
				_removeCommandAt( _commands.getItemIndex( commands[i] ) );
			}
			
			// 登録情報が存在しなければ
			if ( _commands.numItems < 1 ) {
				__commands.dispose();
				__commands = null;
			}
			
			// 現在の処理位置を再設定する
			_position = Math.min( _position, numCommands );
		}
		
		/**
		 * コマンドリストから子コマンドを削除します。
		 */
		private function _removeCommandAt( index:int ):Command {
			// 登録されていなければ例外をスローする
			if ( index < 0 || numCommands < index ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_004 ).toString() ); }
			
			// コマンドを取得する
			var command:Command = _commands.getItemAt( index );
			
			// 登録を解除する
			_commands.removeItemAt( index );
			command.progression_internal::$parent = null;
			
			return command;
		}
		
		/**
		 * <p>指定のインデックス位置にある子 Command インスタンスオブジェクトを返します。</p>
		 * <p>Returns the child Command instance that exists at the specified index.</p>
		 * 
		 * @param index
		 * <p>子 Command インスタンスのインデックス位置です。</p>
		 * <p>The index position of the command object.</p>
		 * @return
		 * <p>指定されたインデックス位置にある子 Command インスタンスです。</p>
		 * <p>The child Command at the specified index position.</p>
		 */
		public function getCommandAt( index:int ):Command {
			return _commands.getItemAt( index );
		}
		
		/**
		 * <p>指定された名前に一致する子 Command インスタンスを返します。</p>
		 * <p>Returns the child Command that exists with the specified name.</p>
		 * 
		 * @param name
		 * <p>返される子 Command インスタンスの名前です。</p>
		 * <p>The name of the command to return.</p>
		 * @return
		 * <p>指定された名前を持つ子 Command インスタンスです。</p>
		 * <p>The child Command with the specified name.</p>
		 */
		public function getCommandIndex( command:Command ):int {
			return _commands.getItemIndex( command );
		}
		
		/**
		 * <p>次のコマンドインスタンスを取得して、処理位置を次に進めます。</p>
		 * <p></p>
		 * 
		 * @see #position
		 * @see #hasNextCommand()
		 * @see #reset()
		 * 
		 * @return
		 * <p>次に位置するコマンドインスタンスです。</p>
		 * <p></p>
		 */
		protected function nextCommand():Command {
			return _commands.getItemAt( _position++ );
		}
		
		/**
		 * <p>次のコマンドインスタンスが存在するかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @see #position
		 * @see #nextCommand()
		 * @see #reset()
		 * 
		 * @return
		 * <p>次のコマンドインスタンスが存在すれば true を、それ以外の場合には false です。</p>
		 * <p></p>
		 */
		protected function hasNextCommand():Boolean {
			return Boolean( _position < numCommands );
		}
		
		/**
		 * <p>コマンドの処理位置を最初に戻します。</p>
		 * <p></p>
		 * 
		 * @see #position
		 * @see #nextCommand()
		 * @see #hasNextCommand()
		 */
		protected function reset():void {
			_position = 0;
		}
		
		/**
		 * <p>コマンド処理中に例外が発生したことを通知します。
		 * エラー処理が発生すると、コマンド処理が停止します。
		 * 問題を解決し、通常フローに戻す場合には executeComplete() メソッドを、問題が解決されず中断処理を行いたい場合には interrupt() メソッドを実行してください。
		 * 関数内で問題が解決、または中断処理に移行しなかった場合には ExecuteEvent.ERROR イベントが送出されます。</p>
		 * <p></p>
		 * 
		 * @see #catchError
		 * 
		 * @param target
		 * <p>問題の発生元である Command インスタンスです。</p>
		 * <p></p>
		 * @param error
		 * <p>原因となるエラーオブジェクトです。</p>
		 * <p></p>
		 */
		protected override function throwError( target:Command, error:Error ):void {
			// メッセージを追記する
			var messages:Array = error.message.split( "\n" );
			messages.splice( 1, 0, "\t   on " + _position + "/" + numCommands + " positions of the " + toString() );
			error.message = messages.join( "\n" );
			
			// 親のメソッドを実行する
			super.throwError( target, error );
		}
		
		/**
		 * <p>CommandList インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an CommandList subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい CommandList インスタンスです。</p>
		 * <p>A new CommandList object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new CommandList( _executeFunction, _interruptFunction, this );
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
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null );
		}
	}
}
