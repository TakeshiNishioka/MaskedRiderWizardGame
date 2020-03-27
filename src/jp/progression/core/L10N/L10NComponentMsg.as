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
	public class L10NComponentMsg {
		
		public static const WARNING_000:String = "L10NComponentMsg.WARNING_000";
		Logger.setLog( new Log( WARNING_000, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARNING_000, "対象 %0 には複数のボタンが設定されているため、%1 コンポーネントは無効化されます。" ), Locale.JAPANESE );
		
		public static const WARNING_001:String = "L10NComponentMsg.WARNING_001";
		Logger.setLog( new Log( WARNING_001, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARNING_001, "対象 %0 にボタンコンポーネントがネスト状態で設定されているため、%1 コンポーネントは無効化されます。" ), Locale.JAPANESE );
		
		public static const WARNING_002:String = "L10NComponentMsg.WARNING_002";
		Logger.setLog( new Log( WARNING_002, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARNING_002, "対象 %0 は、ルート直下に設置されていないため、%1 コンポーネントは無効化されます。" ), Locale.JAPANESE );
		
		public static const WARNING_003:String = "L10NComponentMsg.WARNING_003";
		Logger.setLog( new Log( WARNING_003, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARNING_003, "ローダーコンポーネントが対象 %0 の 1 フレーム目に設置されていないため、%1 コンポーネントは無効化されます。" ), Locale.JAPANESE );
		
		public static const WARNING_004:String = "L10NComponentMsg.WARNING_004";
		Logger.setLog( new Log( WARNING_004, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARNING_004, "対象 %0 にはすでにローダーコンポーネントが設置されているため、%1 コンポーネントは無効化されます。" ), Locale.JAPANESE );
		
		public static const WARNING_005:String = "L10NComponentMsg.WARNING_005";
		Logger.setLog( new Log( WARNING_005, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARNING_005, "PRML 定義ファイル %0 の読み込みに失敗しました。" ), Locale.JAPANESE );
		
		public static const WARNING_006:String = "L10NComponentMsg.WARNING_006";
		Logger.setLog( new Log( WARNING_006, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARNING_006, "ローダーコンポーネントを使用する場合には、ドキュメントクラスに任意のクラスを使用することはできません。" ), Locale.JAPANESE );
		
		public static const WARNING_007:String = "L10NComponentMsg.WARNING_007";
		Logger.setLog( new Log( WARNING_007, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARNING_007, "対象 %0 は、アニメーションコンポーネント以外のコンポーネントと併用されているため、%1 コンポーネントは無効化されます。" ), Locale.JAPANESE );
		
		public static const WARNING_008:String = "L10NComponentMsg.WARNING_008";
		Logger.setLog( new Log( WARNING_008, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARNING_008, "対象 %0 は、エフェクトコンポーネント以外のコンポーネントと併用されているため、%1 コンポーネントは無効化されます。" ), Locale.JAPANESE );
		
		public static const WARNING_009:String = "L10NComponentMsg.WARNING_009";
		Logger.setLog( new Log( WARNING_009, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARNING_009, "現在設定されている環境設定 %0 では、同期機能は使用はできません。" ), Locale.JAPANESE );
		
		
		
		
		
		/**
		 * @private
		 */
		public function L10NComponentMsg() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
