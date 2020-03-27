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
	public class L10NExecuteMsg {
		
		public static const ERROR_000:String = "L10NExecuteMsg.ERROR_000";
		Logger.setLog( new Log( ERROR_000, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_000, "対象の ExecutorObject の準備が十分ではありません。" ), Locale.JAPANESE );
		
		public static const ERROR_001:String = "L10NExecuteMsg.ERROR_001";
		Logger.setLog( new Log( ERROR_001, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_001, "メソッド %0 を実行するには %1 が実装されている必要があります。" ), Locale.JAPANESE );
		
		public static const ERROR_002:String = "L10NExecuteMsg.ERROR_002";
		Logger.setLog( new Log( ERROR_002, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_002, "すでに実行中の %0 を再度実行することはできません。" ), Locale.JAPANESE );
		
		public static const ERROR_003:String = "L10NExecuteMsg.ERROR_003";
		Logger.setLog( new Log( ERROR_003, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_003, "実行されていない %0 を中断、または終了させることはできません。" ), Locale.JAPANESE );
		
		public static const ERROR_004:String = "L10NExecuteMsg.ERROR_004";
		Logger.setLog( new Log( ERROR_004, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_004, "中断処理中の %0 を再度中断することはできません。" ), Locale.JAPANESE );
		
		public static const ERROR_005:String = "L10NExecuteMsg.ERROR_005";
		Logger.setLog( new Log( ERROR_005, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_005, "実行されていない %0 に対してエラーを通知することはできません。\n通知されたエラー: %1" ), Locale.JAPANESE );
		
		public static const ERROR_006:String = "L10NExecuteMsg.ERROR_006";
		Logger.setLog( new Log( ERROR_006, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_006, "%0 の処理がタイムアウトしました。" ), Locale.JAPANESE );
		
		public static const ERROR_007:String = "L10NExecuteMsg.ERROR_007";
		Logger.setLog( new Log( ERROR_007, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_007, "%0 の読み込みが正常に完了できませんでした。" ), Locale.JAPANESE );
		
		public static const ERROR_008:String = "L10NExecuteMsg.ERROR_008";
		Logger.setLog( new Log( ERROR_008, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_008, "再開可能な処理は存在しません。" ), Locale.JAPANESE );
		
		public static const ERROR_009:String = "L10NExecuteMsg.ERROR_009";
		Logger.setLog( new Log( ERROR_009, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_009, "メソッド %0 は、Progression の管理するフローに関連付けられたイベント発生時以外では実行できません。" ), Locale.JAPANESE );
		
		
		
		
		
		/**
		 * @private
		 */
		public function L10NExecuteMsg() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
