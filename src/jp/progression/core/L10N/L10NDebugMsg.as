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
	public class L10NDebugMsg {
		
		public static const INFO_000:String = "L10NDebugMsg.INFO_000";
		Logger.setLog( new Log( INFO_000, "It failed in debugging connection." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_000, "デバッグ接続に失敗しました。" ), Locale.JAPANESE );
		
		public static const INFO_001:String = "L10NDebugMsg.INFO_001";
		Logger.setLog( new Log( INFO_001, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_001, "対象 %0 の監視には対応していなません。" ), Locale.JAPANESE );
		
		public static const INFO_002:String = "L10NDebugMsg.INFO_002";
		Logger.setLog( new Log( INFO_002, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_002, "対象 %0 は、すでに監視対象に設定されています。" ), Locale.JAPANESE );
		
		public static const INFO_003:String = "L10NDebugMsg.INFO_003";
		Logger.setLog( new Log( INFO_003, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_003, "シーン移動を開始, 目的地 = %0" ), Locale.JAPANESE );
		
		public static const INFO_004:String = "L10NDebugMsg.INFO_004";
		Logger.setLog( new Log( INFO_004, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_004, "シーン %0 に移動" ), Locale.JAPANESE );
		
		public static const INFO_005:String = "L10NDebugMsg.INFO_005";
		Logger.setLog( new Log( INFO_005, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_005, "シーン %0 でイベント %1 を実行" ), Locale.JAPANESE );
		
		public static const INFO_006:String = "L10NDebugMsg.INFO_006";
		Logger.setLog( new Log( INFO_006, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_006, "移動先を変更, 目的地 = %0" ), Locale.JAPANESE );
		
		public static const INFO_007:String = "L10NDebugMsg.INFO_007";
		Logger.setLog( new Log( INFO_007, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_007, "シーン移動を完了" ), Locale.JAPANESE );
		
		public static const INFO_008:String = "L10NDebugMsg.INFO_008";
		Logger.setLog( new Log( INFO_008, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_008, "シーン %0 の lock プロパティが %1 に変更されました。" ), Locale.JAPANESE );
		
		public static const INFO_009:String = "L10NDebugMsg.INFO_009";
		Logger.setLog( new Log( INFO_009, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_009, "シーン %0 のタイトルが %1 に変更されました。" ), Locale.JAPANESE );
		
		public static const INFO_010:String = "L10NDebugMsg.INFO_010";
		Logger.setLog( new Log( INFO_010, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_010, "非同期処理を開始, 実行者 = %0, 対象 = %1, 種別 = %2" ), Locale.JAPANESE );
		
		public static const INFO_011:String = "L10NDebugMsg.INFO_011";
		Logger.setLog( new Log( INFO_011, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_011, "非同期処理を完了" ), Locale.JAPANESE );
		
		public static const INFO_012:String = "L10NDebugMsg.INFO_012";
		Logger.setLog( new Log( INFO_012, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_012, "%0 がマネージャーオブジェクト %1 と関連付けられました。" ), Locale.JAPANESE );
		
		public static const INFO_013:String = "L10NDebugMsg.INFO_013";
		Logger.setLog( new Log( INFO_013, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_013, "%0 とマネージャーオブジェクトの関連付けが解除されました。" ), Locale.JAPANESE );
		
		public static const INFO_014:String = "L10NDebugMsg.INFO_014";
		Logger.setLog( new Log( INFO_014, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_014, "%0 コマンドを実行" ), Locale.JAPANESE );
		
		public static const INFO_015:String = "L10NDebugMsg.INFO_015";
		Logger.setLog( new Log( INFO_015, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_015, "%0 コマンドを完了" ), Locale.JAPANESE );
		
		public static const INFO_016:String = "L10NDebugMsg.INFO_016";
		Logger.setLog( new Log( INFO_016, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_016, "同期処理を開始, 実行者 = %0, 対象 = %1, 種別 = %2" ), Locale.JAPANESE );
		
		public static const INFO_017:String = "L10NDebugMsg.INFO_011";
		Logger.setLog( new Log( INFO_017, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_017, "同期処理を完了" ), Locale.JAPANESE );
		
		public static const INFO_018:String = "L10NDebugMsg.INFO_018";
		Logger.setLog( new Log( INFO_018, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_018, "%0 をシーンリストに追加しました。" ), Locale.JAPANESE );
		
		public static const INFO_019:String = "L10NDebugMsg.INFO_019";
		Logger.setLog( new Log( INFO_019, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_019, "%0 に子シーン %1 を追加しました。" ), Locale.JAPANESE );
		
		public static const INFO_020:String = "L10NDebugMsg.INFO_020";
		Logger.setLog( new Log( INFO_020, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_020, "%0 をシーンリストから削除しました。" ), Locale.JAPANESE );
		
		public static const INFO_021:String = "L10NDebugMsg.INFO_021";
		Logger.setLog( new Log( INFO_021, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_021, "%0 から子シーン %1 を削除しました。" ), Locale.JAPANESE );
		
		public static const INFO_022:String = "L10NDebugMsg.INFO_022";
		Logger.setLog( new Log( INFO_022, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_022, "%0 を表示リストに追加しました。" ), Locale.JAPANESE );
		
		public static const INFO_023:String = "L10NDebugMsg.INFO_023";
		Logger.setLog( new Log( INFO_023, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_023, "%0 に子ディスプレイ %1 を追加しました。" ), Locale.JAPANESE );
		
		public static const INFO_024:String = "L10NDebugMsg.INFO_024";
		Logger.setLog( new Log( INFO_024, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_024, "%0 を表示リストから削除しました。" ), Locale.JAPANESE );
		
		public static const INFO_025:String = "L10NDebugMsg.INFO_025";
		Logger.setLog( new Log( INFO_025, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_025, "%0 から子ディスプレイ %1 を削除しました。" ), Locale.JAPANESE );
		
		public static const INFO_026:String = "L10NDebugMsg.INFO_026";
		Logger.setLog( new Log( INFO_026, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_026, "%0 の準備が完了しました。" ), Locale.JAPANESE );
		
		public static const INFO_027:String = "L10NDebugMsg.INFO_027";
		Logger.setLog( new Log( INFO_027, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_027, "%0 のデータが更新されました。" ), Locale.JAPANESE );
		
		public static const INFO_028:String = "L10NDebugMsg.INFO_028";
		Logger.setLog( new Log( INFO_028, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_028, "%0 に関連付けられているクエリ値が %1 に更新されました。" ), Locale.JAPANESE );
		
		public static const INFO_029:String = "L10NDebugMsg.INFO_029";
		Logger.setLog( new Log( INFO_029, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_029, "ボタン %0 でマウスダウンしました。" ), Locale.JAPANESE );
		
		public static const INFO_030:String = "L10NDebugMsg.INFO_030";
		Logger.setLog( new Log( INFO_030, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_030, "ボタン %0 でマウスダウンを完了しました。" ), Locale.JAPANESE );
		
		public static const INFO_031:String = "L10NDebugMsg.INFO_031";
		Logger.setLog( new Log( INFO_031, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_031, "ボタン %0 でマウスアップしました。" ), Locale.JAPANESE );
		
		public static const INFO_032:String = "L10NDebugMsg.INFO_032";
		Logger.setLog( new Log( INFO_032, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_032, "ボタン %0 でマウスアップを完了しました。" ), Locale.JAPANESE );
		
		public static const INFO_033:String = "L10NDebugMsg.INFO_033";
		Logger.setLog( new Log( INFO_033, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_033, "ボタン %0 でロールオーバーしました。" ), Locale.JAPANESE );
		
		public static const INFO_034:String = "L10NDebugMsg.INFO_034";
		Logger.setLog( new Log( INFO_034, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_034, "ボタン %0 でロールオーバーを完了しました。" ), Locale.JAPANESE );
		
		public static const INFO_035:String = "L10NDebugMsg.INFO_035";
		Logger.setLog( new Log( INFO_035, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_035, "ボタン %0 でロールアウトしました。" ), Locale.JAPANESE );
		
		public static const INFO_036:String = "L10NDebugMsg.INFO_036";
		Logger.setLog( new Log( INFO_036, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_036, "ボタン %0 でロールアウトを完了しました。" ), Locale.JAPANESE );
		
		public static const WARN_000:String = "L10NDebugMsg.WARN_000";
		Logger.setLog( new Log( WARN_000, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARN_000, "非同期処理を中断" ), Locale.JAPANESE );
		
		public static const WARN_001:String = "L10NDebugMsg.WARN_001";
		Logger.setLog( new Log( WARN_001, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARN_001, "%0 コマンドを中断" ), Locale.JAPANESE );
		
		public static const WARN_002:String = "L10NDebugMsg.WARN_002";
		Logger.setLog( new Log( WARN_002, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARN_002, "シーン移動を中断" ), Locale.JAPANESE );
		
		public static const WARN_003:String = "L10NDebugMsg.WARN_003";
		Logger.setLog( new Log( WARN_003, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARN_003, "同期処理を中断" ), Locale.JAPANESE );
		
		public static const ERROR_000:String = "L10NDebugMsg.ERROR_000";
		Logger.setLog( new Log( ERROR_000, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_000, "非同期処理中に例外発生" ), Locale.JAPANESE );
		
		public static const ERROR_001:String = "L10NDebugMsg.ERROR_001";
		Logger.setLog( new Log( ERROR_001, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_001, "%0 コマンドの実行中に例外発生" ), Locale.JAPANESE );
		
		public static const ERROR_002:String = "L10NDebugMsg.ERROR_002";
		Logger.setLog( new Log( ERROR_002, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_002, "シーン移動中に例外発生" ), Locale.JAPANESE );
		
		public static const ERROR_003:String = "L10NDebugMsg.ERROR_003";
		Logger.setLog( new Log( ERROR_003, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_003, "同期処理中に例外発生" ), Locale.JAPANESE );
		
		
		
		
		/**
		 * @private
		 */
		public function L10NDebugMsg() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
