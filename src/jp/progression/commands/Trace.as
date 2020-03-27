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
	import jp.nium.utils.ArrayUtil;
	import jp.nium.core.debug.Logger;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.ObjectUtil;
	
	/**
	 * <p>Trace クラスは、trace() メソッドを実行するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // Trace インスタンスを作成する
	 * var com:Trace = new Trace();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class Trace extends Command {
		
		/**
		 * コピー元となる Trace インスタンスです。
		 */
		private static var _target:Trace;
		
		
		
		
		
		/**
		 * <p>出力したい内容を取得します。
		 * この値に関数を設定した場合、実行結果を出力します。</p>
		 * <p></p>
		 */
		public function get outputs():Array { return _outputs; }
		private var _outputs:Array;
		
		
		
		
		
		/**
		 * <p>新しい Trace インスタンスを作成します。</p>
		 * <p>Creates a new Trace object.</p>
		 * 
		 * @param outputs
		 * <p>出力したい内容です。</p>
		 * <p></p>
		 */
		public function Trace( ... outputs:Array ) {
			// 引数を設定する
			_outputs = outputs;
			
			// コピー元が設定されていれば
			if ( _target ) {
				_outputs = _target._outputs.slice();
			}
			
			// 親クラスを初期化する
			super( _executeFunction, null, _target );
			
			// 破棄する
			_target = null;
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _executeFunction():void {
			var outputs:Array = _outputs.slice();
			
			// 変換する
			for ( var i:int = 0, l:int = outputs.length; i < l; i++ ) {
				var output:* = outputs[i];
				switch ( true ) {
					case output is Function								: { outputs[i] = outputs[i](); break; }
					case output is Array								: { outputs[i] = ArrayUtil.toString( outputs[i] ); break; }
					case ClassUtil.getClassName( output ) == "Object"	: { outputs[i] = ObjectUtil.toString( outputs[i] ); break; }
				}
			}
			
			// 出力する
			Logger.output.apply( null, outputs );
			
			// 処理を終了する
			super.executeComplete();
		}
		
		/**
		 * <p>Trace インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Trace subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい Trace インスタンスです。</p>
		 * <p>A new Trace object that is identical to the original.</p>
		 */
		public override function clone():Command {
			_target = this;
			return new Trace();
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
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null, "outputs" );
		}
	}
}
