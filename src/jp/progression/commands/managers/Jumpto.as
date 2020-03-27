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
package jp.progression.commands.managers {
	import jp.nium.core.debug.Logger;
	import jp.progression.commands.Command;
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.events.ProcessEvent;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneId;
	
	/**
	 * <p>Jumpto クラスは、指定されたシーン識別子の示すシーンに即移動するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // Jumpto インスタンスを作成する
	 * var com:Jumpto = new Jumpto();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class Jumpto extends Command {
		
		/**
		 * <p>移動先を示すシーン識別子を取得します。</p>
		 * <p></p>
		 */
		public function get sceneId():SceneId { return _sceneId; }
		private var _sceneId:SceneId;
		
		/**
		 * Progression インスタンスを取得します。
		 */
		private var _manager:Progression;
		
		
		
		
		
		/**
		 * <p>新しい Jumpto インスタンスを作成します。</p>
		 * <p>Creates a new Jumpto object.</p>
		 * 
		 * @param sceneId
		 * <p>移動先を示すシーン識別子です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function Jumpto( sceneId:SceneId, initObject:Object = null ) {
			// 引数を設定する
			_sceneId = sceneId;
			
			// 親クラスを初期化する
			super( _executeFunction, null, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _executeFunction():void {
			// Progression を取得する
			var manager:Progression = Progression.progression_internal::$collections.getInstanceById( _sceneId.getNameByIndex( 0 ) ) as Progression;
			
			// 存在しなければ例外をスローする
			if ( !manager ) {
				super.throwError( this, new Error( Logger.getLog( L10NProgressionMsg.ERROR_013 ).toString( _sceneId ) ) );
				return;
			}
			
			// 強制移動であり、すでに実行中であれば
			if ( manager.state > 0 ) {
				// Progression の参照を保持する
				_manager = manager;
				
				// イベントリスナーを登録する
				_manager.addEventListener( ProcessEvent.PROCESS_STOP, _processStop );
				
				// 停止する
				_manager.stop();
			}
			else {
				// 移動する
				manager.jumpto( _sceneId, super.extra );
				
				// 処理を終了する
				super.executeComplete();
			}
		}
		
		/**
		 * <p>Jumpto インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Jumpto subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい Jumpto インスタンスです。</p>
		 * <p>A new Jumpto object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new Jumpto( _sceneId, this );
		}
		
		
		
		
		
		/**
		 * 
		 */
		private function _processStop( e:ProcessEvent ):void {
			// イベントリスナーを解除する
			_manager.removeEventListener( ProcessEvent.PROCESS_STOP, _processStop );
			
			// 移動する
			_manager.jumpto( _sceneId, super.extra );
			
			// Progression を破棄する
			_manager = null;
		}
	}
}
