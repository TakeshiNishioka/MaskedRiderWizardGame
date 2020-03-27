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
	import jp.progression.events.ProcessEvent;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneId;
	import jp.progression.scenes.SceneObject;
	
	/**
	 * <p>NextButton クラスは、現在のシーン位置を基準として次のシーンに相当する対象に移動するボタン機能を提供するコンポーネントクラスです。
	 * このクラスを使用するためには、CommandExecutor が実装される環境設定（BasicAppConfig、WebConfig、等）を使用する必要があります。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // NextButton インスタンスを作成する
	 * var cast:NextButton = new NextButton();
	 * </listing>
	 */
	public class NextButton extends ButtonBase {
		
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
		 * <p>次のシーンが存在しない場合に、一番先頭のシーンに移動するかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		public function get useTurnBack():Boolean { return _useTurnBack; }
		public function set useTurnBack( value:Boolean ):void { _useTurnBack = value; }
		private var _useTurnBack:Boolean = false;
		
		/**
		 * <p>キーボードの右矢印キーを押した際にボタンを有効化するかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		public function get useRightKey():Boolean { return _useRightKey; }
		public function set useRightKey( value:Boolean ):void { _useRightKey = value; }
		private var _useRightKey:Boolean = true;
		
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
		 * Progression インスタンスを取得します。 
		 */
		private var _manager:Progression;
		
		
		
		
		
		/**
		 * <p>新しい NextButton インスタンスを作成します。</p>
		 * <p>Creates a new NextButton object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function NextButton( initObject:Object = null ) {
			// 親クラスを初期化する
			super( initObject );
			
			// イベントリスナーを登録する
			super.addEventListener( ManagerEvent.MANAGER_ACTIVATE, _managerActivate, false, 0, true );
			super.addEventListener( ManagerEvent.MANAGER_DEACTIVATE, _managerDeactivate, false, 0, true );
			
			// Progression インスタンスと関連付けられていれば
			if ( super.manager ) {
				_managerActivate( null );
			}
		}
		
		
		
		
		
		/**
		 * キャストオブジェクトと Progression インスタンスの関連付けがアクティブになったときに送出されます。
		 */
		private function _managerActivate( e:ManagerEvent ):void {
			// Progression の参照を取得する
			_manager = super.manager;
			
			// イベントリスナーを登録する
			_manager.addEventListener( ProcessEvent.PROCESS_SCENE, _processScene );
		}
		
		/**
		 * キャストオブジェクトと Progression インスタンスの関連付けが非アクティブになったときに送出されます。
		 */
		private function _managerDeactivate( e:ManagerEvent ):void {
			// イベントリスナーを解除する
			_manager.removeEventListener( ProcessEvent.PROCESS_SCENE, _processScene );
			
			// Progression の参照を破棄する
			_manager = null;
		}
		
		/**
		 * 管理下にあるシーンの移動処理中に対象シーンが変更された場合に送出されます。
		 */
		private function _processScene( e:ProcessEvent ):void {
			// 現在のカレントシーンを取得する
			var current:SceneObject = super.manager.current;
			
			// 存在しなければ終了する
			if ( !current ) { return; }
			
			// 現在の親子関係を取得する
			var next:SceneObject = current.next;
			var parent:SceneObject = current.parent;
			next ||= ( parent && _useTurnBack ) ? parent.getSceneAt( 0 ) : current;
			
			// 移動先を指定する
			super.sceneId = next.sceneId;
		}
	}
}
