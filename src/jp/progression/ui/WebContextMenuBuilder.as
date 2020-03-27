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
package jp.progression.ui {
	import com.asual.swfaddress.SWFAddress;
	import flash.display.Bitmap;
	import flash.display.InteractiveObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.printing.PrintJob;
	import flash.system.System;
	import flash.text.TextField;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.escapeMultiByte;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.I18N.Locale;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.external.JavaScript;
	import jp.nium.utils.URLUtil;
	import jp.progression.core.impls.ICastButton;
	import jp.progression.core.impls.ICastObject;
	import jp.progression.core.impls.IManageable;
	import jp.progression.core.L10N.L10NWebLocalMsg;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.Progression;
	
	/**
	 * <p>WebContextMenuBuilder クラスは、WebConfig として実装された場合に、一般的なブラウザ操作が行える機能をコンテクストメニューに実装するビルダークラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class WebContextMenuBuilder implements IContextMenuBuilder {
		
		/**
		 * URL がメーラーのプロトコルを指しているかどうかを判別する正規表現を取得します。
		 */
		private static const _MAIL_ADDRESS_REGEXP:String = "^mailto:";
		
		/**
		 * ダウンロード対象となるファイル形式を判別する正規表現を取得します。
		 */
		private static const _DOWNLOADABLE_FORMAT_REGEXP:String = "[.](zip|lzh|cab|sit|rar|gca|gz|tgz|taz|hqx)$";
		
		/**
		 * 画像ファイル形式を判別する正規表現を取得します。
		 */
		private static const _IMAGE_FORMAT_REGEXP:String = "[.](jpg|jpeg|jpe|png|gif)$";
		
		/**
		 * <p>ダウンロードに関連するオプションを有効化するかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		public static function get useDownloadOption():Boolean { return _useDownloadOption; }
		public static function set useDownloadOption( value:Boolean ):void { _useDownloadOption = value; }
		private static var _useDownloadOption:Boolean = true;
		
		/**
		 * <p>画像に関連するオプションを有効化するかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		public static function get useImageOption():Boolean { return _useImageOption; }
		public static function set useImageOption( value:Boolean ):void { _useImageOption = value; }
		private static var _useImageOption:Boolean = true;
		
		/**
		 * <p>印刷に関連するオプションを有効化するかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		public static function get usePrintOption():Boolean { return _usePrintOption; }
		public static function set usePrintOption( value:Boolean ):void { _usePrintOption = value; }
		private static var _usePrintOption:Boolean = true;
		
		
		
		
		
		/**
		 * <p>関連付けられている InteractiveObject インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get target():InteractiveObject { return _target; }
		private var _target:InteractiveObject;
		
		/**
		 * Loader インスタンスを取得します。
		 */
		private var _loader:Loader;
		
		/**
		 * ICastButton インスタンスを取得します。
		 */
		private var _button:ICastButton;
		
		/**
		 * ContextMenu インスタンスを取得します。
		 */
		private var _menu:ContextMenu;
		
		/**
		 * ユーザー定義の ContextMenu インスタンスを取得します。
		 */
		private var _userDefinedMenu:ContextMenu;
		
		
		
		
		
		/**
		 * <p>新しい WebContextMenuBuilder インスタンスを作成します。</p>
		 * <p>Creates a new WebContextMenuBuilder object.</p>
		 * 
		 * @param target
		 * <p>関連付けたい InteractiveObject インスタンスです。</p>
		 * <p></p>
		 */
		public function WebContextMenuBuilder( target:InteractiveObject ) {
			// 対象が ICastObject を継承していなければ例外をスローする
			if ( !( target is ICastObject ) ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_020 ).toString( "ICastObject" ) ); }
			
			// 引数を設定する
			_target = target;
			
			// 対象の型別参照を取得する
			_loader = _target as Loader;
			_button = _target as ICastButton;
			
			// イベントリスナーを登録する
			if ( _button ) {
				_target.addEventListener( MouseEvent.ROLL_OVER, _rollOver );
				_target.addEventListener( MouseEvent.ROLL_OUT, _rollOut );
			}
			
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
		 * 対象の示すべき URL を取得します。
		 */
		private function _toURL():String {
			var url:String = _target.stage.loaderInfo.url;
			
			// 対象に関連付けられた Progression を取得する
			var manageable:IManageable = _button as IManageable;
			var manager:Progression = manageable ? manageable.manager : null;
			
			// ブラウザ通信が有効化されていれば
			if ( JavaScript.enabled ) {
				url = JavaScript.locationHref;
			}
			
			// 対象がボタンであれば
			if ( _button ) {
				// シーン識別子が設定されていれば
				if ( manager && _button.sceneId ) {
					url = "#" + manager.root.localToGlobal( _button.sceneId ).toShortPath();
				}
				
				// href が設定されていれば
				if ( _button.href ) {
					url = _button.href;
				}
			}
			
			// url がメールアドレスを示していれば
			if ( new RegExp( _MAIL_ADDRESS_REGEXP, "gi" ).test( url ) ) { return url; }
			
			// ブラウザ通信が有効化されていれば
			if ( JavaScript.enabled ) {
				var href:String = JavaScript.locationHref;
				href = href.split( "#" )[0];
				return URLUtil.getAbsolutePath( url, href );
			}
			
			return URLUtil.getAbsolutePath( url, _target.stage.loaderInfo.url );
		}
		
		/**
		 * 
		 */
		private function _createCastObjectMenu( menu:ContextMenu ):void {
			// 既存のメニューを非表示にする
			menu.hideBuiltInItems();
			
			// 新規メニュー項目を構築する
			var items:Array = [];
			var item:ContextMenuItem;
			
			// 履歴を戻る
			items.push( item = new ContextMenuItem( Locale.getString( L10NWebLocalMsg.HISTORY_BACK ), true, true ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectHistoryBack );
			
			// 履歴を進む
			items.push( item = new ContextMenuItem( Locale.getString( L10NWebLocalMsg.HISTORY_FORWARD ), false, true ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectHistoryForward );
			
			// 更新する
			items.push( item = new ContextMenuItem( Locale.getString( L10NWebLocalMsg.RELOAD ), false, JavaScript.enabled ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectReload );
			
			// 対象が示す URL を新しいウィンドウで開く
			items.push( item = new ContextMenuItem( Locale.getString( L10NWebLocalMsg.OPEN_LINK_IN_NEW_WINDOW ), true, true ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectOpenLinkInNewWindow );
			
			// 対象が示す URL が画像であれば
			if ( _useImageOption && _loader && new RegExp( _IMAGE_FORMAT_REGEXP, "gi" ).test( _loader.contentLoaderInfo.url ) ) {
				// 対象が示す URL の画像を表示する
				items.push( item = new ContextMenuItem( Locale.getString( L10NWebLocalMsg.SHOW_PICTURE ), true, true ) );
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectShowPicture );
				
				// 対象を印刷する
				items.push( item = new ContextMenuItem( Locale.getString( L10NWebLocalMsg.PRINT_PICTURE ), false, true ) );
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectPrintPicture );
			}
			
			// 対象が示す URL をコピーする
			items.push( item = new ContextMenuItem( Locale.getString( L10NWebLocalMsg.COPY_LINK_LOCATION ), true, true ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectCopyLinkLocation );
			
			// 対象が示す URL をメールで送信する
			items.push( item = new ContextMenuItem( Locale.getString( L10NWebLocalMsg.SEND_LINK ), false, true ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectSendLink );
			
			// ボタンではなければ
			if ( _usePrintOption ) {
				// 印刷する
				items.push( item = new ContextMenuItem( Locale.getString( L10NWebLocalMsg.PRINT ), false, true ) );
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectPrint );
			}
			
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
		 * 
		 */
		private function _createCastButtonMenu( menu:ContextMenu ):void {
			// 既存のメニューを非表示にする
			menu.hideBuiltInItems();
			
			var items:Array = [];
			var item:ContextMenuItem;
			
			var separateBefore:Boolean = true;
			
			var url:String = _toURL();
			
			// 対象が示す URL を開く
			items.push( item = new ContextMenuItem( Locale.getString( L10NWebLocalMsg.OPEN ), true, true ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectOpen );
			
			// 対象が示す URL を新しいウィンドウで開く
			items.push( item = new ContextMenuItem( Locale.getString( L10NWebLocalMsg.OPEN_LINK_IN_NEW_WINDOW ), false, true ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectOpenLinkInNewWindow );
			
			// 対象が示す URL がバイナリ形式であれば
			if ( _useDownloadOption && new RegExp( _DOWNLOADABLE_FORMAT_REGEXP, "gi" ).test( url ) ) {
				// 対象が示す URL のファイルを保存する
				items.push( item = new ContextMenuItem( Locale.getString( L10NWebLocalMsg.SAVE_TARGET_AS ), true, true ) );
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectSaveTargetAs );
				
				separateBefore = false;
			}
			
			if ( new RegExp( _MAIL_ADDRESS_REGEXP, "gi" ).test( url ) ) {
				// 対象が示すメールアドレスをコピーする
				items.push( item = new ContextMenuItem( Locale.getString( L10NWebLocalMsg.COPY_MAIL_ADDRESS ), true, true ) );
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectCopyMailAddress );
			}
			else {
				// 対象が示す URL をコピーする
				items.push( item = new ContextMenuItem( Locale.getString( L10NWebLocalMsg.COPY_LINK_LOCATION ), true, true ) );
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectCopyLinkLocation );
			}
			
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
		 * 
		 */
		private function _createCastTextFieldMenu( menu:ContextMenu ):void {
			// 既存のメニューを非表示にする
			menu.hideBuiltInItems();
		}
		
		/**
		 * <p>保持しているデータを解放します。
		 * dispose() メソッドが呼び出されると、それ以降はこのインスタンスのメソッドまたはプロパティを呼び出すと失敗し、例外がスローされます。</p>
		 * <p></p>
		 */
		public function dispose():void {
			// イベントリスナーを解除する
			_target.removeEventListener( MouseEvent.ROLL_OVER, _rollOver );
			_target.removeEventListener( MouseEvent.ROLL_OUT, _rollOut );
			
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
		 * ユーザーが InteractiveObject インスタンスにポインティングデバイスを合わせたときに送出されます。
		 */
		private function _rollOver( e:MouseEvent ):void {
			var url:String = _toURL();
			
			// ブラウザのステータスを設定する
			SWFAddress.setStatus( url );
		}
		
		/**
		 * ユーザーが InteractiveObject インスタンスからポインティングデバイスを離したときに送出されます。
		 */
		private function _rollOut( e:MouseEvent ):void {
			// ブラウザのステータスを破棄する
			SWFAddress.setStatus( "" );
		}
		
		/**
		 * ユーザーが最初にコンテキストメニューを生成したときに、コンテキストメニューの内容が表示される前に送出されます。
		 */
		private function _menuSelect( e:ContextMenuEvent ):void {
			if ( e.mouseTarget is TextField ) {
				_createCastTextFieldMenu( ContextMenu( e.target ) );
			}
			else if ( _button && ( _button.href || _button.sceneId ) ) {
				_createCastButtonMenu( ContextMenu( e.target ) );
				return;
			}
			else {
				_createCastObjectMenu( ContextMenu( e.target ) );
			}
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectOpen( e:ContextMenuEvent ):void {
			_button.navigateTo( _toURL() );
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectHistoryBack( e:ContextMenuEvent ):void {
			if ( JavaScript.enabled ) {
				SWFAddress.back();
			}
			else if ( Progression.syncedManager ) {
				Progression.syncedManager.history.back();
			}
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectHistoryForward( e:ContextMenuEvent ):void {
			if ( JavaScript.enabled ) {
				SWFAddress.forward();
			}
			else if ( Progression.syncedManager ) {
				Progression.syncedManager.history.forward();
			}
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectReload( e:ContextMenuEvent ):void {
			JavaScript.reload();
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectOpenLinkInNewWindow( e:ContextMenuEvent ):void {
			if ( _button ) {
				_button.navigateTo( _toURL(), "_blank" );
			}
			else {
				navigateToURL( new URLRequest( _toURL() ), "_blank" );
			}
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectSaveTargetAs( e:ContextMenuEvent ):void {
			navigateToURL( new URLRequest( _toURL() ) );
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectShowPicture( e:ContextMenuEvent ):void {
			navigateToURL( new URLRequest( _loader.contentLoaderInfo.url ) );
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectPrintPicture( e:ContextMenuEvent ):void {
			var bmp:Bitmap = _loader.content as Bitmap;
			
			if ( !bmp ) { return; }
			
			var sp:Sprite = new Sprite();
			sp.addChild( new Bitmap( bmp.bitmapData ) );
			
			var job:PrintJob = new PrintJob();
			if ( job.start() ) {
				job.addPage( sp );
				job.send();
			}
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectCopyMailAddress( e:ContextMenuEvent ):void {
			System.setClipboard( _toURL().replace( new RegExp( _MAIL_ADDRESS_REGEXP, "ig" ), "" ) );
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectCopyLinkLocation( e:ContextMenuEvent ):void {
			System.setClipboard( _toURL() );
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectSendLink( e:ContextMenuEvent ):void {
			var url:String = "mailto:?body=" + escape( _toURL() ) + "%0D%0A";
			
			if ( JavaScript.enabled ) {
				url += "&subject=" + escapeMultiByte( JavaScript.documentTitle );
				JavaScript.locationHref = url;
			}
			else {
				navigateToURL( new URLRequest( url ) );
			}
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectPrint( e:ContextMenuEvent ):void {
			if ( JavaScript.enabled ) {
				JavaScript.print();
			}
			else {
				var job:PrintJob = new PrintJob();
				if ( job.start() ) {
					job.addPage( Sprite( _target.root ) );
					job.send();
				}
			}
		}
		
		/**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectBuiltBy( e:ContextMenuEvent ):void {
			navigateToURL( new URLRequest( Progression.progression_internal::$URL_BUILT_ON ), Progression.URL );
		}
	}
}
