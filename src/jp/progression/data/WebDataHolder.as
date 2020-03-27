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
package jp.progression.data {
	import jp.progression.core.ns.progression_internal;
	import jp.progression.events.ManagerEvent;
	import jp.progression.events.SceneEvent;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneId;
	import jp.progression.scenes.SceneObject;
	
	/**
	 * <p>WebDataHolder クラスは Web 用途に特化したデータ管理を行うモデルクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class WebDataHolder extends DataHolder {
		
		/**
		 * @private
		 */
		progression_internal static var $html:XML;
		
		
		
		
		
		/**
		 * <p>Flash が設置されている HTML ファイルから、条件に合致するデータを取得します。</p>
		 * <p></p>
		 */
		public function get html():XML { return new XML( _html.toXMLString() ); }
		private var _html:XML;
		
		/**
		 * <p>対応する H* エレメントに設定されているストリングを取得します。</p>
		 * <p></p>
		 */
		public function get heading():String { return _heading; }
		private var _heading:String;
		
		/**
		 * 
		 */
		private var _manaer:Progression;
		
		
		
		
		
		/**
		 * <p>新しい WebDataHolder インスタンスを作成します。</p>
		 * <p>Creates a new WebDataHolder object.</p>
		 * 
		 * @param target
		 * <p>関連付けたい SceneObject インスタンスです。</p>
		 * <p></p>
		 */
		public function WebDataHolder( target:SceneObject ) {
			// 親クラスを初期化する
			super( target );
			
			// 初期化する
			_html = new XML();
			
			// イベントリスナーを登録する
			super.target.addEventListener( SceneEvent.SCENE_ADDED_TO_ROOT, _sceneAddedToRoot );
			super.target.addEventListener( SceneEvent.SCENE_REMOVED_FROM_ROOT, _sceneRemovedFromRoot );
		}
		
		
		
		
		
		/**
		 * 
		 */
		private function _update():void {
			// HTML データを取得する
			var html:XML = progression_internal::$html;
			
			// 存在しなければ終了する
			if ( !html ) { return; }
			
			// シーン識別子情報を取得する
			var sceneId:SceneId = super.target.sceneId;
			
			// 存在しなければ終了する
			if ( !sceneId ) { return; }
			
			// ショートパスを取得する
			var shortPath:String = sceneId.toShortPath();
			
			// 条件に合致するノードを取得する
			var htmlcontents:XMLList = html..div.( @id == "htmlcontent" );
			
			// 存在しなければ終了する
			if ( htmlcontents.length() < 1 ) { return; }
			
			// コンテンツを取得する
			var htmlcontent:XML = new XML( htmlcontents[0].toXMLString() );
			
			// 2 階層以下のシーンを指していれば
			if ( sceneId.length > 1 ) {
				// 合致するノードを取得する
				for each ( var div:XML in htmlcontent..div ) {
					// 識別子が合致すれば
					if ( String( div.@id ) == shortPath ) {
						_html = div;
						break;
					}
				}
			}
			else {
				_html = htmlcontent;
			}
			
			// 子の div タグを除去する
			while ( _html.div.length() > 0 ) {
				delete _html.div[0];
			}
			
			// h? 要素を取得する
			for each ( var h:XML in _html.* ) {
				if ( new RegExp( "^h[1-7]$" ).test( h.localName() ) ) {
					_heading = h.text();
					break;
				}
			}
			
			// シーンタイトルが存在しなければ、自動的に設定する
			if ( super.target.title == super.target.name ) {
				super.target.title = _heading;
			}
			
			// データを保持する
			SceneObject.progression_internal::$providingData = super.data;
			
			// 更新する
			super.update();
		}
		
		/**
		 * <p>保持しているデータを解放します。
		 * dispose() メソッドが呼び出されると、それ以降はこのインスタンスのメソッドまたはプロパティを呼び出すと失敗し、例外がスローされます。</p>
		 * <p></p>
		 */
		public override function dispose():void {
			// イベントリスナーを解除する
			super.target.removeEventListener( SceneEvent.SCENE_ADDED_TO_ROOT, _sceneAddedToRoot );
			super.target.removeEventListener( SceneEvent.SCENE_REMOVED_FROM_ROOT, _sceneRemovedFromRoot );
			
			// 破棄する
			_html = null;
			
			super.dispose();
		}
		
		
		
		
		
		/**
		 * 
		 */
		private function _sceneAddedToRoot( e:SceneEvent ):void {
			// Progression の参照を保持する
			_manaer = super.target.manager;
			
			// イベントリスナーを登録する
			_manaer.addEventListener( ManagerEvent.MANAGER_READY, _managerReady, false, int.MAX_VALUE );
			
			// 更新する
			_update();
		}
		
		/**
		 * 
		 */
		private function _sceneRemovedFromRoot( e:SceneEvent ):void {
			// 破棄する
			_manaer = null;
			
			// 初期化する
			_html = new XML();
			_heading = null;
		}
		
		/**
		 * 
		 */
		private function _managerReady( e:ManagerEvent ):void {
			// イベントリスナーを解除する
			_manaer.removeEventListener( ManagerEvent.MANAGER_READY, _managerReady );
			
			// 更新する
			_update();
		}
	}
}
