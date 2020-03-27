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
package jp.progression.core.managers {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.events.ProcessEvent;
	import jp.progression.Progression;
	
	/**
	 * @private
	 */
	public class HistoryManager {
		
		/**
		 * <p>履歴として登録されているシーン識別子を含んだ配列を取得します。</p>
		 * <p></p>
		 */
		public function get items():Array { return _items.concat(); }
		private var _items:Array;
		
		/**
		 * <p>現在の履歴位置を取得します。</p>
		 * <p></p>
		 */
		public function get position():int { return _position; }
		private var _position:int = 0;
		
		/**
		 * 対象となる Progression インスタンスを取得します。
		 */
		private var _target:Progression;
		
		/**
		 * 履歴追加がロックされているかどうかを取得します。
		 */
		private static var _lock:Boolean = false;
		
		
		
		
		
		/**
		 * <p>新しい HistoryManager インスタンスを作成します。</p>
		 * <p>Creates a new HistoryManager object.</p>
		 * 
		 * @param target
		 * <p>関連付けたい Progression インスタンスです。</p>
		 * <p></p>
		 */
		public function HistoryManager( target:Progression ) {
			// 引数を設定する
			_target = target;
			
			// 初期化する
			_items = [];
			
			// イベントリスナーを登録する
			_target.addEventListener( ProcessEvent.PROCESS_START, _processStart );
		}
		
		
		
		
		
		/**
		 * <p>履歴を一つ次に進みます。</p>
		 * <p></p>
		 */
		public function forward():void {
			// 値を更新する
			_position = Math.min( _position + 1, _items.length - 1 );
			
			// 移動する
			_lock = true;
			_target.goto( _items[_position] );
			_lock = false;
		}
		
		/**
		 * <p>履歴を一つ前に戻ります。</p>
		 * <p></p>
		 */
		public function back():void {
			// 値を更新する
			_position = Math.max( 0, _position - 1 );
			
			// 移動する
			_lock = true;
			_target.goto( _items[_position] );
			_lock = false;
		}
		
		/**
		 * <p></p>
		 * <p></p>
		 * 
		 * @param position
		 * <p></p>
		 * <p></p>
		 */
		public function go( position:int ):void {
			// 範囲を超えていたら例外をスローする
			if ( position < 0 || _items.length - 1 < position ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_004 ).toString() ); }
			
			// 移動する
			_lock = true;
			_target.goto( _items[position] );
			_lock = false;
		}
		
		/**
		 * <p>すべての履歴を削除します。</p>
		 * <p></p>
		 */
		public function clear():void {
			_items = [];
			_position = 0;
		}
		
		/**
		 * @private
		 */
		progression_internal function $dispose():void {
			// イベントリスナーを解除する
			_target.removeEventListener( ProcessEvent.PROCESS_START, _processStart );
			
			// 破棄する
			_target = null;
			_items = null;
		}
		
		
		
		
		
		/**
		 * シーン移動処理が開始された場合に送出されます。
		 */
		private function _processStart( e:ProcessEvent ):void {
			// ロックされていたら終了する
			if ( _lock ) { return; }
			
			// 現在位置から後の履歴を削除して、新しく追加する
			_items.splice( _position + 1, _items.length, _target.destinedSceneId );
			
			// 現在位置を移動する
			_position = _items.length - 1;
		}
	}
}
