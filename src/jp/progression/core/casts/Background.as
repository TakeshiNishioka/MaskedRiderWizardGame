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
package jp.progression.core.casts {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.display.ExMovieClip;
	import jp.progression.core.impls.ICastObject;
	import jp.progression.core.impls.IManageable;
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.events.ManagerEvent;
	import jp.progression.executors.ExecutorObject;
	import jp.progression.Progression;
	import jp.progression.ui.IContextMenuBuilder;
	
	/**
	 * @private
	 */
	public class Background extends ExMovieClip implements ICastObject, IManageable {
		
		/**
		 * パッケージ内からの呼び出しかどうかを取得します。
		 */
		private static var _internallyCalled:Boolean = false;
		
		
		
		
		
		/**
		 * <p>関連付けられている Progression インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.events.ManagerEvent#MANAGER_ACTIVATE
		 * @see jp.progression.events.ManagerEvent#MANAGER_DEACTIVATE
		 */
		public function get manager():Progression { return _manager; }
		private var _manager:Progression;
		
		/**
		 * @private
		 */
		public function get executor():ExecutorObject { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "executor" ) ); }
		
		/**
		 * IContextMenuBuilder インスタンスを取得します。
		 */
		private var _contextMenuBuilder:IContextMenuBuilder;
		
		
		
		
		
		/**
		 * <p>新しい Background インスタンスを作成します。</p>
		 * <p>Creates a new Background object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function Background( initObject:Object = null ) {
			// 親クラスを初期化する
			super( initObject );
			
			// パッケージ外から呼び出されたら例外をスローする
			if ( !_internallyCalled ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_008 ).toString( "Background" ) ); };
			
			// 初期化する
			_internallyCalled = false;
			
			// 初期化されていなければ終了する
			if ( !Progression.config ) {
				Logger.warn( Logger.getLog( L10NProgressionMsg.ERROR_017 ).toString( this, "contextMenu" ) );
				return;
			}
			
			// コンテクストメニューを作成する
			var cls:Class = Progression.config.contextMenuBuilder;
			if ( cls ) {
				_contextMenuBuilder = new cls( this );
			}
		}
		
		
		
		
		
		/**
		 * @private
		 */
		progression_internal static function $createInstance( manager:Progression ):Background {
			_internallyCalled = true;
			
			// SceneInfo を作成する
			var container:Background = new Background();
			container._manager = manager;
			
			// イベントを送出する
			container.dispatchEvent( new ManagerEvent( ManagerEvent.MANAGER_ACTIVATE ) );
			
			return container;
		}
		
		
		
		
		
		/**
		 * <p>マネージャオブジェクトとの関連付けを更新します。</p>
		 * <p></p>
		 * 
		 * @return
		 * <p>関連付けが成功したら true を、それ以外は false を返します。</p>
		 * <p></p>
		 */
		public function updateManager():Boolean {
			return true;
		}
	}
}
