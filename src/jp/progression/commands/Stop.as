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
	import jp.nium.core.debug.Logger;
	import jp.progression.commands.lists.IRepeatable;
	import jp.progression.core.L10N.L10NCommandMsg;
	
	/**
	 * <p>Stop クラスは、親のループ処理を停止させるコマンドクラスです。
	 * このコマンドを使用するためには LoopList コマンド、または ShuttleList コマンドの子として実行させる必要があります。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // Stop インスタンスを作成する
	 * var com:Stop = new Stop();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class Stop extends Command {
		
		/**
		 * <p>親のループ処理を停止させる条件となるループ処理回数を取得します。
		 * この値が 0 に設定されている場合には、無条件にループ処理を停止させます。</p>
		 * <p></p>
		 * 
		 * @see #count
		 * @see #stop()
		 */
		public function get stopCount():int { return _stopCount; }
		private var _stopCount:int = 0;
		
		
		
		
		
		/**
		 * <p>新しい Stop インスタンスを作成します。</p>
		 * <p>Creates a new Stop object.</p>
		 * 
		 * @param count
		 * <p>親のループ処理を停止させる条件となるループ回数です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function Stop( stopCount:int = 0, initObject:Object = null ) {
			// 引数を設定する
			_stopCount = stopCount;
			
			// 親クラスを初期化する
			super( _execute, null, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			var repeatable:IRepeatable = super.parent as IRepeatable;
			
			// 対象が IRepeatable インターフェイスを実装していなければ例外をスローする
			if ( !repeatable ) { super.throwError( this, new Error( Logger.getLog( L10NCommandMsg.ERROR_000 ).toString() ) ); }
			
			// 条件に合致しなければ終了する
			if ( _stopCount > 0 && repeatable.count < _stopCount ) {
				super.executeComplete();
				return;
			}
			
			// 親のループ処理を停止する
			repeatable.stop();
		}
		
		/**
		 * <p>Stop インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Stop subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい Stop インスタンスです。</p>
		 * <p>A new Stop object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new Stop( _stopCount, this );
		}
	}
}
