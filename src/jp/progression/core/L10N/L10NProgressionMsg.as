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
	public class L10NProgressionMsg {
		
		public static const INFO_000:String = "L10NProgressionMsg.INFO_000";
		Logger.setLog( new Log( INFO_000, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_000, "外部ライブラリ %0 が有効化されました。" ), Locale.JAPANESE );
		
		public static const INFO_001:String = "L10NProgressionMsg.INFO_001";
		Logger.setLog( new Log( INFO_001, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_001, "SceneObject クラスの container プロパティに関連付けられる対象が Application に変更されました。" ), Locale.JAPANESE );
		
		public static const INFO_002:String = "L10NProgressionMsg.INFO_002";
		Logger.setLog( new Log( INFO_002, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( INFO_002, "同期対象の HTML データを読み込みました。" ), Locale.JAPANESE );
		
		public static const WARN_000:String = "L10NProgressionMsg.WARN_000";
		Logger.setLog( new Log( WARN_000, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARN_000, "ブラウザ以外で実行されたため、SWF ファイルと同階層に存在する同名の HTML ファイルを自動的に読み込みます。" ), Locale.JAPANESE );
		
		public static const WARN_001:String = "L10NProgressionMsg.WARN_001";
		Logger.setLog( new Log( WARN_001, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( WARN_001, "同期対象となる HTML データが発見できませんでした。" ), Locale.JAPANESE );
		
		public static const ERROR_000:String = "L10NProgressionMsg.ERROR_000";
		Logger.setLog( new Log( ERROR_000, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_000, "環境設定 %0 は AIR ランタイム上では初期化できません。" ), Locale.JAPANESE );
		
		public static const ERROR_001:String = "L10NProgressionMsg.ERROR_001";
		Logger.setLog( new Log( ERROR_001, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_001, "環境設定 %0 は AIR ランタイム以外では初期化できません。" ), Locale.JAPANESE );
		
		public static const ERROR_002:String = "L10NProgressionMsg.ERROR_002";
		Logger.setLog( new Log( ERROR_002, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_002, "対象 %0 は、すでに初期化されています。" ), Locale.JAPANESE );
		
		public static const ERROR_003:String = "L10NProgressionMsg.ERROR_003";
		Logger.setLog( new Log( ERROR_003, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_003, "現在の環境設定では、有効なシンクロナイザが指定されていません。" ), Locale.JAPANESE );
		
		public static const ERROR_004:String = "L10NProgressionMsg.ERROR_004";
		Logger.setLog( new Log( ERROR_004, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_004, "対象の %0 プロパティは読み取り専用に設定されています。" ), Locale.JAPANESE );
		
		public static const ERROR_005:String = "L10NProgressionMsg.ERROR_005";
		Logger.setLog( new Log( ERROR_005, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_005, "指定された %0 識別子 %1 はすでに登録されています。" ), Locale.JAPANESE );
		
		public static const ERROR_006:String = "L10NProgressionMsg.ERROR_006";
		Logger.setLog( new Log( ERROR_006, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_006, "環境設定 %0 は MXML アプリケーション以外では初期化できません。" ), Locale.JAPANESE );
		
		public static const ERROR_007:String = "L10NProgressionMsg.ERROR_007";
		Logger.setLog( new Log( ERROR_007, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_007, "Progression 識別子を省略することはできません。" ), Locale.JAPANESE );
		
		public static const ERROR_008:String = "L10NProgressionMsg.ERROR_008";
		Logger.setLog( new Log( ERROR_008, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_008, "すでに初期化済みであるため、環境設定 %0 として初期化できません。" ), Locale.JAPANESE );
		
		public static const ERROR_009:String = "L10NProgressionMsg.ERROR_009";
		Logger.setLog( new Log( ERROR_009, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_009, "対象シーン %0 が十分に読み込まれていないため、移動処理を続行することができません。" ), Locale.JAPANESE );
		
		public static const ERROR_010:String = "L10NProgressionMsg.ERROR_010";
		Logger.setLog( new Log( ERROR_010, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_010, "対象シーン %0 が存在しません。" ), Locale.JAPANESE );
		
		public static const ERROR_011:String = "L10NProgressionMsg.ERROR_011";
		Logger.setLog( new Log( ERROR_011, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_011, "指定されたクラス %0 はコンパイルに含まれていません。" ), Locale.JAPANESE );
		
		public static const ERROR_012:String = "L10NProgressionMsg.ERROR_012";
		Logger.setLog( new Log( ERROR_012, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_012, "プロパティ %0 に指定されているクラス %1 はクラス %2 を継承している必要があります。" ), Locale.JAPANESE );
		
		public static const ERROR_013:String = "L10NProgressionMsg.ERROR_013";
		Logger.setLog( new Log( ERROR_013, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_013, "移動先として設定されている %0　は、有効な移動先ではありません。" ), Locale.JAPANESE );
		
		public static const ERROR_014:String = "L10NProgressionMsg.ERROR_014";
		Logger.setLog( new Log( ERROR_014, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_014, "環境設定が初期化されてないため、対象 %0 の一部の機能は実装されません。" ), Locale.JAPANESE );
		
		public static const ERROR_015:String = "L10NProgressionMsg.ERROR_015";
		Logger.setLog( new Log( ERROR_015, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_015, "対象 %0 に表示オブジェクトを関連付けるには foreground, container, background プロパティのいずれかを経由する必要があります。" ), Locale.JAPANESE );
		
		public static const ERROR_016:String = "L10NProgressionMsg.ERROR_016";
		Logger.setLog( new Log( ERROR_016, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_016, "SceneLoader で読み込む SWF ファイルは、CastDocument クラスを継承している、またはローダーコンポーネントを実装している必要があります。" ), Locale.JAPANESE );
		
		public static const ERROR_017:String = "L10NProgressionMsg.ERROR_017";
		Logger.setLog( new Log( ERROR_017, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_017, "環境設定が初期化される前に実装が要求されたため、対象 %0 のプロパティ %1 は正しく実装されません。" ), Locale.JAPANESE );
		
		public static const ERROR_018:String = "L10NProgressionMsg.ERROR_018";
		Logger.setLog( new Log( ERROR_018, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_018, "指定されたクラス %0 はコンパイルに含まれないため無効化されます。" ), Locale.JAPANESE );
		
		public static const ERROR_019:String = "L10NProgressionMsg.ERROR_019";
		Logger.setLog( new Log( ERROR_019, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_019, "移動先に NaS を指定することはできません。" ), Locale.JAPANESE );
		
		public static const ERROR_020:String = "L10NProgressionMsg.ERROR_020";
		Logger.setLog( new Log( ERROR_020, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_020, "対象 %0 の同期機能はすでに有効化されています。" ), Locale.JAPANESE );
		
		
		
		
		
		/**
		 * @private
		 */
		public function L10NProgressionMsg() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
