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
	
	/**
	 * <p>Break クラスは、実行中の処理を強制的に中断するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // SerialList コマンドを作成する
	 * var com:SerialList = new SerialList();
	 * 
	 * // コマンドを追加する
	 * com.addCommand(
	 * 	new Trace( "success" ),
	 * 	new Break(),
	 * 	new Trace( "failure" )
	 * );
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class Break extends Command {
		
		/**
		 * <p>新しい Break インスタンスを作成します。</p>
		 * <p>Creates a new Break object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function Break( initObject:Object = null ) {
			// 親クラスを初期化する
			super( _execute, null, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// 処理を強制中断する
			super.interrupt();
		}
		
		/**
		 * <p>Break インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Break subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい Break インスタンスです。</p>
		 * <p>A new Break object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new Break( this );
		}
	}
}
