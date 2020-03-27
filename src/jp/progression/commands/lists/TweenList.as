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
	 * <p>TweenList クラスは、登録された複数のコマンドを開始タイミングをずらしながら実行させるためのコマンドリストクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // TweenList インスタンスを作成する
	 * var list:TweenList = new TweenList();
	 * 
	 * // コマンドを実行する
	 * list.execute();
	 * </listing>
	 */
	public class TweenList extends ParallelList {
		
		/**
		 * <p>処理の実行遅延時間を取得します。</p>
		 * <p></p>
		 * 
		 * @see #easing
		 */
		public function get duration():Number { return _duration; }
		private var _duration:Number = 0;
		
		/**
		 * <p>遅延処理に使用するイージング関数を取得します。</p>
		 * <p></p>
		 * 
		 * @see #duration
		 */
		public function get easing():Function { return _easing; }
		private var _easing:Function;
		
		
		
		
		
		/**
		 * <p>新しい TweenList インスタンスを作成します。</p>
		 * <p>Creates a new TweenList object.</p>
		 * 
		 * @param duration
		 * <p>処理の実行遅延時間です。</p>
		 * <p></p>
		 * @param easing
		 * <p>遅延処理に使用するイージング関数です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 * @param commands
		 * <p>登録したいコマンドインスタンス、関数、数値、配列などを含む配列です。</p>
		 * <p></p>
		 */
		public function TweenList( duration:Number, easing:Function = null, initObject:Object = null, ... commands:Array ) {
			// 引数を設定する
			_duration = duration;
			_easing = easing;
			
			// 親クラスを初期化する
			super( initObject );
			
			// コマンドリストに登録する
			super.addCommand.apply( null, commands );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		protected override function executeFunction():void {
			var easing:Function = _easing || _easeNone;
			
			// 現在登録されている全てのコマンドを取得する
			while ( super.hasNextCommand() ) {
				var time:Number = _duration * position / ( super.numCommands - 1 );
				var com:Command = super.nextCommand();
				com.delay = easing( time, 0, _duration, _duration );
			}
			
			// 親のメソッドを実行する
			super.executeFunction();
		}
		
		/**
		 * 重み付けのされていないイージング関数を実行します。
		 */
		private function _easeNone( t:Number, b:Number, c:Number, d:Number ):Number {
			return c * t / d + b;
		}
		
		/**
		 * <p>TweenList インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an TweenList subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい TweenList インスタンスです。</p>
		 * <p>A new TweenList object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new TweenList( _duration, _easing, this );
		}
	}
}
