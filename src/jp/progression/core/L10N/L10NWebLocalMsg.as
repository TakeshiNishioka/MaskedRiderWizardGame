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
package jp.progression.core.L10N {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.I18N.Locale;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	
	/**
	 * @private
	 */
	public class L10NWebLocalMsg {
		
		public static const OPEN:String = "open";
		Locale.setString( OPEN, Locale.JAPANESE, "開く" );
		Locale.setString( OPEN, Locale.ENGLISH, "Open ..." );
		Locale.setString( OPEN, Locale.FRENCH, "Ouvrir" );
		Locale.setString( OPEN, Locale.CHINESE, "開啓" );
		
		public static const HISTORY_BACK:String = "historyBack";
		Locale.setString( HISTORY_BACK, Locale.JAPANESE, "前に戻る" );
		Locale.setString( HISTORY_BACK, Locale.ENGLISH, "Back ..." );
		Locale.setString( HISTORY_BACK, Locale.FRENCH, "Retourner" );
		Locale.setString( HISTORY_BACK, Locale.CHINESE, "上一頁" );
		
		public static const HISTORY_FORWARD:String = "historyForward";
		Locale.setString( HISTORY_FORWARD, Locale.JAPANESE, "次に進む" );
		Locale.setString( HISTORY_FORWARD, Locale.ENGLISH, "Forward ..." );
		Locale.setString( HISTORY_FORWARD, Locale.FRENCH, "Avancer" );
		Locale.setString( HISTORY_FORWARD, Locale.CHINESE, "下一頁" );
		
		public static const RELOAD:String = "Reload";
		Locale.setString( RELOAD, Locale.JAPANESE, "更新" );
		Locale.setString( RELOAD, Locale.ENGLISH, "Reload ..." );
		Locale.setString( RELOAD, Locale.FRENCH, "Rafraîchir" );
		Locale.setString( RELOAD, Locale.CHINESE, "更新" );
		
		public static const OPEN_LINK_IN_NEW_WINDOW:String = "OpenLinkInNewWindow";
		Locale.setString( OPEN_LINK_IN_NEW_WINDOW, Locale.JAPANESE, "新規ウィンドウで開く" );
		Locale.setString( OPEN_LINK_IN_NEW_WINDOW, Locale.ENGLISH, "Open Link in New Window ..." );
		Locale.setString( OPEN_LINK_IN_NEW_WINDOW, Locale.FRENCH, "Ouvrir le lien dans une nouvelle fenêtre" );
		Locale.setString( OPEN_LINK_IN_NEW_WINDOW, Locale.CHINESE, "開啓新的視窗" );
		
		public static const COPY_LINK_LOCATION:String = "CopyLinkLocation";
		Locale.setString( COPY_LINK_LOCATION, Locale.JAPANESE, "対象の URL をコピー" );
		Locale.setString( COPY_LINK_LOCATION, Locale.ENGLISH, "Copy Link Location ..." );
		Locale.setString( COPY_LINK_LOCATION, Locale.FRENCH, "Copier le lien" );
		Locale.setString( COPY_LINK_LOCATION, Locale.CHINESE, "複製網址" );
		
		public static const COPY_MAIL_ADDRESS:String = "CopyMailAddress";
		Locale.setString( COPY_MAIL_ADDRESS, Locale.JAPANESE, "メールアドレスをコピー" );
		Locale.setString( COPY_MAIL_ADDRESS, Locale.ENGLISH, "Copy Mail Address ..." );
		Locale.setString( COPY_MAIL_ADDRESS, Locale.FRENCH, "Copier l'addresse e-mail" );
		Locale.setString( COPY_MAIL_ADDRESS, Locale.CHINESE, "複製信箱地址" );
		
		public static const SAVE_TARGET_AS:String = "saveTargetAs";
		Locale.setString( SAVE_TARGET_AS, Locale.JAPANESE, "対象をファイルに保存" );
		Locale.setString( SAVE_TARGET_AS, Locale.ENGLISH, "Save Target As ..." );
		Locale.setString( SAVE_TARGET_AS, Locale.FRENCH, "Enregistrer sous" );
		Locale.setString( SAVE_TARGET_AS, Locale.CHINESE, "" );
		
		public static const SHOW_PICTURE:String = "showPicture";
		Locale.setString( SHOW_PICTURE, Locale.JAPANESE, "画像を表示" );
		Locale.setString( SHOW_PICTURE, Locale.ENGLISH, "Show Picture ..." );
		Locale.setString( SHOW_PICTURE, Locale.FRENCH, "Afficher l'image" );
		Locale.setString( SHOW_PICTURE, Locale.CHINESE, "" );
		
		public static const PRINT_PICTURE:String = "printPicture";
		Locale.setString( PRINT_PICTURE, Locale.JAPANESE, "画像を印刷" );
		Locale.setString( PRINT_PICTURE, Locale.ENGLISH, "Print Picture ..." );
		Locale.setString( PRINT_PICTURE, Locale.FRENCH, "Imprimer l'image" );
		Locale.setString( PRINT_PICTURE, Locale.CHINESE, "" );
		
		public static const SEND_LINK:String = "SendLink";
		Locale.setString( SEND_LINK, Locale.JAPANESE, "URL をメールで送信" );
		Locale.setString( SEND_LINK, Locale.ENGLISH, "Send Link ..." );
		Locale.setString( SEND_LINK, Locale.FRENCH, "Envoyer le lien" );
		Locale.setString( SEND_LINK, Locale.CHINESE, "將網址上傳至信箱" );
		
		public static const PRINT:String = "Print";
		Locale.setString( PRINT, Locale.JAPANESE, "印刷" );
		Locale.setString( PRINT, Locale.ENGLISH, "Print ..." );
		Locale.setString( PRINT, Locale.FRENCH, "Imprimer" );
		Locale.setString( PRINT, Locale.CHINESE, "印刷" );
		
		
		
		
		
		/**
		 * @private
		 */
		public function L10NWebLocalMsg() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
