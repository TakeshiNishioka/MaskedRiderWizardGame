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
	import jp.nium.core.debug.Log;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.I18N.Locale;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	
	/**
	 * @private
	 */
	public class L10NCommandMsg {
		
		public static const WARN_000:String = "L10NCommandMsg.WARN_000";
		Logger.setLog( new Log( WARN_000, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARN_000, "コマンドリスト %0 の initObject に登録されたコマンド %1 は実行されません。" ), Locale.JAPANESE );
		
		public static const WARN_001:String = "L10NCommandMsg.WARN_001";
		Logger.setLog( new Log( WARN_001, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARN_001, "コマンド %0 のプロパティ %1 が必要とする時間値の単位がミリ秒で指定されている可能性があります。" ), Locale.JAPANESE );
		
		public static const ERROR_000:String = "L10NCommandMsg.ERROR_000";
		Logger.setLog( new Log( ERROR_000, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_000, "コマンド Stop の親は IRepeatable インターフェイスを実装している必要があります。" ), Locale.JAPANESE );
		
		
		
		
		
		/**
		 * @private
		 */
		public function L10NCommandMsg() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
