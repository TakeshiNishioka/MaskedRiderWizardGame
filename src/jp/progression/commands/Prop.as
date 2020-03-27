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
	import jp.nium.utils.ObjectUtil;
	
	/**
	 * <p>Prop クラスは、指定された対象の複数のプロパティを一括で設定するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // Prop インスタンスを作成する
	 * var com:Prop = new Prop();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class Prop extends Command {
		
		/**
		 * <p>プロパティを設定したい対象のオブジェクトを取得します。</p>
		 * <p></p>
		 * 
		 * @see #parameters
		 */
		public function get target():Object { return _target; }
		private var _target:Object;
		
		/**
		 * <p>対象に設定したいプロパティを含んだオブジェクトを取得します。</p>
		 * <p></p>
		 * 
		 * @see #target
		 */
		public function get parameters():Object { return _parameters; }
		private var _parameters:Object;
		
		
		
		
		
		/**
		 * <p>新しい Prop インスタンスを作成します。</p>
		 * <p>Creates a new Prop object.</p>
		 * 
		 * @param target
		 * <p>一括設定したいオブジェクトです。</p>
		 * <p></p>
		 * @param parameters
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function Prop( target:*, parameters:Object, initObject:Object = null ) {
			// 引数を設定する
			_target = target;
			_parameters = parameters;
			
			// 親クラスを初期化する
			super( _executeFunction, null, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _executeFunction():void {
			var list:Array = _target as Array || [ _target ];
			
			// プロパティを設定する
			for ( var i:int = 0, l:int = list.length; i < l; i++ ) {
				ObjectUtil.setProperties( list[i], _parameters );
			}
			
			// 処理を終了する
			super.executeComplete();
		}
		
		/**
		 * <p>Prop インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Prop subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい Prop インスタンスです。</p>
		 * <p>A new Prop object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new Prop( _target, _parameters, this );
		}
	}
}
