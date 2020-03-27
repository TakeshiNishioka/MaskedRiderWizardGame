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
	 * <p>リストに登録されているコマンドの実行処理位置が変更された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.ExecuteEvent.EXECUTE_POSITION
	 */
	[Event( name="executePosition", type="jp.progression.events.ExecuteEvent" )]
	
	/**
	 * <p>SerialList クラスは、指定された複数のコマンドを 1 つづつ順番に実行させるためのコマンドリストクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // SerialList インスタンスを作成する
	 * var list:SerialList = new SerialList();
	 * 
	 * // コマンドを実行する
	 * list.execute();
	 * </listing>
	 */
	public class SerialList extends CommandList {
		
		/**
		 * 現在処理中の Command インスタンスを取得します。 
		 */
		private var _current:Command;
		
		/**
		 * 処理が実行中かどうかを取得します。
		 */
		private var _running:Boolean = false;
		
		/**
		 * 強制的な中断処理であるかどうかを取得します。
		 */
		private var _enforced:Boolean = false;
		
		/**
		 * <p>コマンドオブジェクトが ExecuteEvent.EXECUTE_POSITION イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #scope
		 * @see jp.progression.events.ExecuteEvent#POSITION
		 */
		public function get onPosition():Function { return _onPosition; }
		public function set onPosition( value:Function ):void { _onPosition = value; }
		private var _onPosition:Function;
		
		
		
		
		
		/**
		 * <p>新しい SerialList インスタンスを作成します。</p>
		 * <p>Creates a new SerialList object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 * @param commands
		 * <p>登録したいコマンドインスタンス、関数、数値、配列などを含む配列です。</p>
		 * <p></p>
		 */
		public function SerialList( initObject:Object = null, ... commands:Array ) {
			// 親クラスを初期化する
			super( executeFunction, interruptFunction, initObject );
			
			// initObject が SerialList であれば
			var com:SerialList = initObject as SerialList;
			if ( com ) {
				// 特定のプロパティを継承する
				_onPosition = com._onPosition;
			}
			
			// initObject に自身のサブクラス以外のコマンドが指定されたら警告する
			var com2:Command = initObject as Command;
			if ( com2 && !( com2 is SerialList ) ) {
				Logger.warn( Logger.getLog( L10NCommandMsg.WARN_000 ).toString( super.className, com2.className ) );
			}
			
			// コマンドリストに登録する
			super.addCommand.apply( null, CommandUtil.convert( this, commands ) );
			
			// イベントリスナーを登録する
			super.addEventListener( ExecuteEvent.EXECUTE_POSITION, _executePosition, false, 0, true );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		protected function executeFunction():void {
			// 実行中でなければ初期化する
			if ( !_running ) {
				super.reset();
			}
			
			// 状態を再設定する
			_running = true;
			
			// 次のコマンドが存在すれば
			if ( super.hasNextCommand() ) {
				// 現在の対象コマンドを取得する
				_current = super.nextCommand();
				
				// イベントリスナーを登録する
				_current.addEventListener( ExecuteEvent.EXECUTE_POSITION, dispatchEvent );
				_current.addEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
				_current.addEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
				_current.addEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _error );
				
				// イベントを送出する
				super.dispatchEvent( new ExecuteEvent( ExecuteEvent.EXECUTE_POSITION, false, false, _current ) );
				
				// 処理を実行する
				_current.execute( extra );
			}
			else {
				// 実行を停止する
				_running = false;
				
				// 処理を終了する
				super.executeComplete();
			}
		}
		
		/**
		 * @private
		 */
		protected function interruptFunction():void {
			// 実行中であれば
			if ( _current && _current.state > 0 ) {
				// 現在の対象を保存する
				var current:Command = _current;
				
				// 破棄する
				_destroy();
				
				// 中断処理を実行する
				current.interrupt( _enforced );
			}
			
			// 状態を変更する
			_enforced = false;
			_running = false;
		}
		
		/**
		 * <p>コマンド処理を中断します。
		 * このメソッドを実行するためには、事前に execute() メソッドが実行されている必要があります。</p>
		 * <p></p>
		 * 
		 * @see #state
		 * @see #scope
		 * @see #execute()
		 * 
		 * @param enforced
		 * <p>親が存在する場合に、親の処理も中断させたい場合には true を、自身のみ中断したい場合には false を指定します。</p>
		 * <p></p>
		 */
		public override function interrupt( enforced:Boolean = false ):void {
			// 強制的に中断するかどうかを保存する
			_enforced = enforced;
			
			// 親のメソッドを実行する
			super.interrupt( enforced );
		}
		
		/**
		 * <p>登録されているコマンドの最後尾に新しくコマンドを追加します。
		 * 関数を指定した場合には、自動的に Func コマンドに変換され、
		 * 数値を指定した場合には、自動的に Wait コマンドに変換され、
		 * 配列を指定した場合には、自動的に ParallelList コマンドに変換され、
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
		public override function addCommand( ...commands:Array ):void {
			// 親のメソッドを実行する
			super.addCommand.apply( null, CommandUtil.convert( this, commands ) );
		}
		
		/**
		 * <p>現在実行中のコマンドの次の位置に新しくコマンドを追加します。
		 * 関数を指定した場合には、自動的に Func コマンドに変換され、
		 * 数値を指定した場合には、自動的に Wait コマンドに変換され、
		 * 配列を指定した場合には、自動的に ParallelList コマンドに変換され、
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
		public override function insertCommand( ...commands:Array ):void {
			// 親のメソッドを実行する
			super.insertCommand.apply( null, CommandUtil.convert( this, commands ) );
		}
		
		/**
		 * 破棄します。
		 */
		private function _destroy():void {
			if ( _current ) {
				// イベントリスナーを解除する
				_current.removeEventListener( ExecuteEvent.EXECUTE_POSITION, dispatchEvent );
				_current.removeEventListener( ExecuteEvent.EXECUTE_COMPLETE, _executeComplete );
				_current.removeEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
				_current.removeEventListener( ExecuteErrorEvent.EXECUTE_ERROR, _error );
				
				// 破棄する
				_current = null;
			}
		}
		
		/**
		 * <p>SerialList インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an SerialList subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい SerialList インスタンスです。</p>
		 * <p>A new SerialList object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new SerialList( this );
		}
		
		
		
		
		
		/**
		 * リストに登録されているコマンドの実行処理位置が変更された場合に送出されます。
		 */
		private function _executePosition( e:ExecuteEvent ):void {
			// イベントハンドラメソッドを実行する
			if ( _onPosition != null ) {
				_onPosition.apply( scope || this );
			}
		}
		
		/**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _executeComplete( e:ExecuteEvent ):void {
			// 破棄する
			_destroy();
			
			if ( super.state == 2 ) {
				// 処理を実行する
				executeFunction();
			}
			else {
				// 中断処理を実行する
				interrupt( e.enforcedInterrupting );
			}
		}
		
		/**
		 * コマンドの処理が中断された場合に送出されます。
		 */
		private function _executeInterrupt( e:ExecuteEvent ):void {
			if ( e.enforcedInterrupting ) {
				// 中断処理を実行する
				interrupt( e.enforcedInterrupting );
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
