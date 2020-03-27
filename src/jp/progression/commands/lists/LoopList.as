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
	import jp.progression.commands.Command;
	
	/**
	 * <p>LoopList クラスは、登録された複数のコマンドを 1 つづつ順番に実行し、全て完了したら再度始めから実行していくコマンドリストクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // LoopList インスタンスを作成する
	 * var list:LoopList = new LoopList();
	 * 
	 * // コマンドを実行する
	 * list.execute();
	 * </listing>
	 */
	public class LoopList extends SerialList implements IRepeatable {
		
		/**
		 * <p>実行したいループ処理数を取得または設定します。
		 * この値が 0 に設定されている場合には、stop() メソッドで終了させるまで処理し続けます。</p>
		 * <p></p>
		 * 
		 * @see #count
		 * @see #stop()
		 */
		public function get repeatCount():int { return _repeatCount; }
		public function set repeatCount( value:int ):void { _repeatCount = value; }
		private var _repeatCount:int = 0;
		
		/**
		 * <p>現在のループ処理回数です。</p>
		 * <p></p>
		 * 
		 * @see #repeatCount
		 * @see #stop()
		 */
		public function get count():int { return _count; }
		private var _count:int = 0;
		
		
		
		
		
		/**
		 * <p>新しい LoopList インスタンスを作成します。</p>
		 * <p>Creates a new LoopList object.</p>
		 * 
		 * @param repeatCount
		 * <p>実行したいループ処理数です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 * @param commands
		 * <p>登録したいコマンドインスタンス、関数、数値、配列などを含む配列です。</p>
		 * <p></p>
		 */
		public function LoopList( repeatCount:int = 0, initObject:Object = null, ... commands:Array ) {
			// 引数を設定する
			_repeatCount = repeatCount;
			
			// 親クラスを初期化する
			super( initObject );
			
			// コマンドリストに登録する
			super.addCommand.apply( null, commands );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		protected override function executeFunction():void {
			// 指定回数実行していれば
			if ( _repeatCount && position == super.numCommands && _count == _repeatCount - 1 ) {
				// カウントアップする
				_count++;
				
				// 終了する
				stop();
				return;
			}
			
			// 次が存在しなければ
			if ( !super.hasNextCommand() ) {
				// カウントアップする
				_count++;
				
				// 親のメソッドを実行する
				super.reset();
			}
			
			// 親のメソッドを実行する
			super.executeFunction();
		}
		
		/**
		 * <p>実行中のループ処理を停止させます。</p>
		 * <p></p>
		 * 
		 * @see #count
		 * @see #repeatCount
		 */
		public function stop():void {
			// 処理を終了する
			super.executeComplete();
		}
		
		/**
		 * <p>コマンドの処理位置を最初に戻します。</p>
		 * <p></p>
		 */
		protected override function reset():void {
			_count = 0;
			super.reset();
		}
		
		/**
		 * <p>LoopList インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an LoopList subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい LoopList インスタンスです。</p>
		 * <p>A new LoopList object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new LoopList( _repeatCount, this );
		}
	}
}
