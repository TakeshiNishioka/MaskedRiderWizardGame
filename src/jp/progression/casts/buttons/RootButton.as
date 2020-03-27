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
package jp.progression.casts.buttons {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.core.casts.ButtonBase;
	import jp.progression.events.ManagerEvent;
	import jp.progression.scenes.SceneId;
	
	/**
	 * <p>RootButton クラスは、現在のシーン構造も最も上に位置するルートシーンに移動するボタン機能を提供するコンポーネントクラスです。
	 * このクラスを使用するためには、CommandExecutor が実装される環境設定（BasicAppConfig、WebConfig、等）を使用する必要があります。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // RootButton インスタンスを作成する
	 * var cast:RootButton = new RootButton();
	 * </listing>
	 */
	public class RootButton extends ButtonBase {
		
		/**
		 * <p>関連付けたい Progression 識別子を示すストリングを取得または設定します。</p>
		 * <p></p>
		 */
		public function get managerId():String { return _managerId; }
		public function set managerId( value:String ):void {
			// 書式が正しければ
			if ( SceneId.validateName( value ) ) {
				// 変更されているかどうかを取得する
				var changed:Boolean = ( _managerId != value );
				
				// 更新する
				_managerId = value;
				
				// sceneId を設定する
				if ( changed ) {
					super.sceneId = new SceneId( "/" + value );
				}
			}
			else if ( value ) {
				Logger.warn( Logger.getLog( L10NNiumMsg.ERROR_005 ).toString( value ) );
			}
		}
		private var _managerId:String;
		
		/**
		 * @private
		 */
		public override function get sceneId():SceneId { return super.sceneId; }
		public override function set sceneId( value:SceneId ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "sceneId" ) ); }
		
		/**
		 * @private
		 */
		public override function get href():String { return super.href; }
		public override function set href( value:String ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "href" ) ); }
		
		
		
		
		
		/**
		 * <p>新しい RootButton インスタンスを作成します。</p>
		 * <p>Creates a new RootButton object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function RootButton( initObject:Object = null ) {
			// 親クラスを初期化する
			super( initObject );
			
			// イベントリスナーを登録する
			super.addEventListener( ManagerEvent.MANAGER_ACTIVATE, _managerActivate, false, 0, true );
		}
		
		
		
		
		
		/**
		 * キャストオブジェクトと Progression インスタンスの関連付けがアクティブになったときに送出されます。
		 */
		private function _managerActivate( e:ManagerEvent ):void {
			// Progression 識別子を設定する
			managerId ||= super.manager.id;
		}
	}
}
