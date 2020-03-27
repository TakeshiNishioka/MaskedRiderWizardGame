﻿/**
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
package jp.progression.ui {
	import flash.display.InteractiveObject;
	import flash.display.StageDisplayState;
	import flash.events.ContextMenuEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.I18N.Locale;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.core.impls.ICastObject;
	import jp.progression.core.impls.IManageable;
	import jp.progression.core.L10N.L10NSlideLocalMsg;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneObject;
	
	/**
	 * <p>SlideContextMenuBuilder クラスは、SlideConfig として実装された場合に、PowerPoint に類似した操作機能をコンテクストメニューに実装するビルダークラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class SlideContextMenuBuilder implements IContextMenuBuilder {
		
		/**
		 * <p>関連付けられている InteractiveObject インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get target():InteractiveObject { return _target; }
		private var _target:InteractiveObject;
		
		/**
		 * IManageable インスタンスを取得する。
		 */
		private var _manageable:IManageable;
		
		/**
		 * ContextMenu インスタンスを取得する。
		 */
		private var _menu:ContextMenu;
		
		/**
		 * ユーザー定義の ContextMenu インスタンスを取得します。
		 */
		private var _userDefinedMenu:ContextMenu;
		
		
		
		
		
		/**
		 * <p>新しい SlideContextMenuBuilder インスタンスを作成します。</p>
		 * <p>Creates a new SlideContextMenuBuilder object.</p>
		 * 
		 * @param target
		 * <p>関連付けたい InteractiveObject インスタンスです。</p>
		 * <p></p>
		 */
		public function SlideContextMenuBuilder( target:InteractiveObject ) {
			// 対象が ICastObject を実装していなければ例外をスローする
			if ( !( target is ICastObject ) ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_020 ).toString( "ICastObject" ) ); }
			if ( !( target is IManageable ) ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_020 ).toString( "IManageable" ) ); }
			
			// 引数を設定する
			_target = target;
			
			// 対象の型別参照を取得する
			_manageable = _target as IManageable;
			
			// ContextMenu を作成する
			_menu = new ContextMenu();
			
			// イベントリスナーを登録する
			_menu.addEventListener( ContextMenuEvent.MENU_SELECT, _menuSelect );
			
			// 既存のメニューを取得する
			_userDefinedMenu = _target.contextMenu as ContextMenu;
			if ( _userDefinedMenu ) {
				_menu.addEventListener( ContextMenuEvent.MENU_SELECT, _userDefinedMenu.dispatchEvent, false, int.MAX_VALUE );
			}
			
			// ContextMenu を設定する
			_target.contextMenu = _menu;
		}
		
		
		
		
		
		/**
		 * <p>保持しているデータを解放します。
		 * dispose() メソッドが呼び出されると、それ以降はこのインスタンスのメソッドまたはプロパティを呼び出すと失敗し、例外がスローされます。</p>
		 * <p></p>
		 */
		public function dispose():void {
			// 既存のメニューを破棄する
			if ( _userDefinedMenu ) {
				_menu.removeEventListener( ContextMenuEvent.MENU_SELECT, _userDefinedMenu.dispatchEvent );
				_target.contextMenu = _userDefinedMenu;
				_userDefinedMenu = null;
			}
			
			// データを破棄する
			_target = null;
			_menu = null;
		}
		
		
		
		
		
		/**
		 * ユーザーが最初にコンテキストメニューを生成したときに、コンテキストメニューの内容が表示される前に送出されます。
		 */
		private function _menuSelect( e:ContextMenuEvent ):void {
			var menu:ContextMenu = ContextMenu( e.target );
			
			// 既存のメニューを非表示にする
			menu.hideBuiltInItems();
			
			// 新規メニュー項目を構築する
			var items:Array = [];
			var item:ContextMenuItem;
			
			var enabled:Boolean = !!_manageable;
			
			items.push( item = new ContextMenuItem( Locale.getString( L10NSlideLocalMsg.JUMP_NEXT_SLIDE ), true, enabled ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectJumpNextSlide );
			
			items.push( item = new ContextMenuItem( Locale.getString( L10NSlideLocalMsg.JUMP_PREVIOUS_SLIDE ), false, enabled ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectJumpPreviousSlide );
			
			items.push( item = new ContextMenuItem( Locale.getString( L10NSlideLocalMsg.JUMP_FIRST_SLIDE ), true, enabled ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectJumpFirstSlide );
			
			items.push( item = new ContextMenuItem( Locale.getString( L10NSlideLocalMsg.JUMP_LAST_SLIDE ), false, enabled ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectJumpLastSlide );
			
			items.push( item = new ContextMenuItem( Locale.getString( L10NSlideLocalMsg.FULL_SCREEN ), true, true ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectFullScreen );
			
			// 権利表記
			items.push( item = new ContextMenuItem( "Built on " + Progression.NAME + " " + Progression.VERSION.split( "." )[0], true, true ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectBuiltBy );
			
			// 既存のカスタムメニューを取得する
			if ( _userDefinedMenu ) {
				items.unshift.apply( null, _userDefinedMenu.customItems.slice( 0, 15 - items.length ) );
			}
			
			// メニューに反映させる
			menu.customItems = items;
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectJumpNextSlide( e:ContextMenuEvent ):void {
			// Progression インスタンスを取得する
			var manager:Progression = _manageable.manager;
			
			// 存在しなければ終了する
			if ( !manager ) { return; }
			if ( !manager.current ) { return; }
			if ( !manager.current.next ) { return; }
			
			// 次のシーンに移動する
			manager.goto( manager.current.next.sceneId );
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectJumpPreviousSlide( e:ContextMenuEvent ):void {
			// Progression インスタンスを取得する
			var manager:Progression = _manageable.manager;
			
			// 存在しなければ終了する
			if ( !manager ) { return; }
			if ( !manager.current ) { return; }
			if ( !manager.current.previous ) { return; }
			
			// 前のシーンに移動する
			manager.goto( manager.current.previous.sceneId );
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectJumpFirstSlide( e:ContextMenuEvent ):void {
			// Progression インスタンスを取得する
			var manager:Progression = _manageable.manager;
			
			// 存在しなければ終了する
			if ( !manager ) { return; }
			if ( !manager.current ) { return; }
			if ( !manager.current.parent ) { return; }
			
			// 最初のシーンに移動する
			manager.goto( manager.current.parent.scenes[0].sceneId );
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectJumpLastSlide( e:ContextMenuEvent ):void {
			// Progression インスタンスを取得する
			var manager:Progression = _manageable.manager;
			
			// 存在しなければ終了する
			if ( !manager ) { return; }
			if ( !manager.current ) { return; }
			if ( !manager.current.parent ) { return; }
			
			// 最後のシーンに移動する
			var parent:SceneObject = manager.current.parent;
			manager.goto( parent.scenes[parent.numScenes - 1].sceneId );
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectFullScreen( e:ContextMenuEvent ):void {
			try {
				_target.stage.displayState = StageDisplayState.FULL_SCREEN;
			}
			catch ( e:Error ) {}
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectBuiltBy( e:ContextMenuEvent ):void {
			navigateToURL( new URLRequest( Progression.progression_internal::$URL_BUILT_ON ), Progression.URL );
		}
	}
}