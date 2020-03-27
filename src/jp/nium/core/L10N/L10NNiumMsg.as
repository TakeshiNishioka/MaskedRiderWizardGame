/**
 * jp.nium Classes
 * 
 * @author Copyright (C) 2007-2009 taka:nium.jp, All Rights Reserved.
 * @version 4.0.1 Public Beta 1.2
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.core.L10N {
	import jp.nium.core.debug.Log;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.I18N.Locale;
	import jp.nium.utils.ClassUtil;
	
	/**
	 * @private
	 */
	public class L10NNiumMsg {
		
		public static const ERROR_000:String = "L10NNiumMsg.ERROR_000";
		Logger.setLog( new Log( ERROR_000, "The method %0 is not implemented." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_000, "メソッド %0 は実装されていません。" ), Locale.JAPANESE );
		
		public static const ERROR_001:String = "L10NNiumMsg.ERROR_001";
		Logger.setLog( new Log( ERROR_001, "The property %0 is not implemented." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_001, "プロパティ %0 は実装されていません。" ), Locale.JAPANESE );
		
		public static const ERROR_002:String = "L10NNiumMsg.ERROR_002";
		Logger.setLog( new Log( ERROR_002, "Illegal write to read-only property %1 on %0." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_002, "%0 の読み取り専用プロパティ %1 へは書き込みできません。" ), Locale.JAPANESE );
		
		public static const ERROR_003:String = "L10NNiumMsg.ERROR_003";
		Logger.setLog( new Log( ERROR_003, "Parameter %0 must be one of the accepted values." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_003, "パラメータ %0 は承認された値の 1 つでなければなりません。" ), Locale.JAPANESE );
		
		public static const ERROR_004:String = "L10NNiumMsg.ERROR_004";
		Logger.setLog( new Log( ERROR_004, "The supplied index is out of bounds." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_004, "指定したインデックスが境界外です。" ), Locale.JAPANESE );
		
		public static const ERROR_005:String = "L10NNiumMsg.ERROR_005";
		Logger.setLog( new Log( ERROR_005, "The format of the %0 is not correct." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_005, "%0 の書式が正しくありません。" ), Locale.JAPANESE );
		
		public static const ERROR_006:String = "L10NNiumMsg.ERROR_006";
		Logger.setLog( new Log( ERROR_006, "The object should inherit the class %0." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_006, "対象はクラス %0 を継承している必要があります。" ), Locale.JAPANESE );
		
		public static const ERROR_007:String = "L10NNiumMsg.ERROR_007";
		Logger.setLog( new Log( ERROR_007, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_007, "%0 はドキュメントクラス以外の用途で使用することはできません。" ), Locale.JAPANESE );
		
		public static const ERROR_008:String = "L10NNiumMsg.ERROR_008";
		Logger.setLog( new Log( ERROR_008, "Invalid %0." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_008, "%0 が無効です。" ), Locale.JAPANESE );
		
		public static const ERROR_009:String = "L10NNiumMsg.ERROR_009";
		Logger.setLog( new Log( ERROR_009, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_009, "パラメータ %0 は null 以外でなければなりません。" ), Locale.JAPANESE );
		
		public static const ERROR_010:String = "L10NNiumMsg.ERROR_010";
		Logger.setLog( new Log( ERROR_010, "%0 class cannot be instantiated." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_010, "クラス %0 を直接インスタンス化することはできません。" ), Locale.JAPANESE );
		
		public static const ERROR_011:String = "L10NNiumMsg.ERROR_011";
		Logger.setLog( new Log( ERROR_011, "The supplied %0 must be a child of the caller." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_011, "指定した %0 は呼び出し元の子でなければなりません。" ), Locale.JAPANESE );
		
		public static const ERROR_012:String = "L10NNiumMsg.ERROR_012";
		Logger.setLog( new Log( ERROR_012, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_012, "指定された範囲 %0 ～ %1 からは、有効な値を取得することができません。" ), Locale.JAPANESE );
		
		public static const ERROR_013:String = "L10NNiumMsg.ERROR_013";
		Logger.setLog( new Log( ERROR_013, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_013, "プロパティ %0 は読み取り専用です。" ), Locale.JAPANESE );
		
		public static const ERROR_014:String = "L10NNiumMsg.ERROR_014";
		Logger.setLog( new Log( ERROR_014, "Loaded file is an unknown type." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_014, "読み込まれたファイルの形式が不明です。" ), Locale.JAPANESE );
		
		public static const ERROR_015:String = "L10NNiumMsg.ERROR_015";
		Logger.setLog( new Log( ERROR_015, "The property name contains prohibited characters." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_015, "プロパティ名に禁止文字が含まれています。" ), Locale.JAPANESE );
		
		public static const ERROR_016:String = "L10NNiumMsg.ERROR_016";
		Logger.setLog( new Log( ERROR_016, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_016, "%0 のフォーマットが正しくありません。" ), Locale.JAPANESE );
		
		public static const ERROR_017:String = "L10NNiumMsg.ERROR_017";
		Logger.setLog( new Log( ERROR_017, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_017, "%0 を使用するには %1 が実装されている必要があります。" ), Locale.JAPANESE );
		
		public static const ERROR_018:String = "L10NNiumMsg.ERROR_018";
		Logger.setLog( new Log( ERROR_018, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_018, "対象 %0 には、指定されたフレーム %1 が存在しません。" ), Locale.JAPANESE );
		
		public static const ERROR_019:String = "L10NNiumMsg.ERROR_019";
		Logger.setLog( new Log( ERROR_019, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_019, "対象 %0 はダイナミッククラスである必要があります。" ), Locale.JAPANESE );
		
		public static const ERROR_020:String = "L10NNiumMsg.ERROR_020";
		Logger.setLog( new Log( ERROR_020, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_020, "対象はインターフェイス %0 を実装している必要があります。" ), Locale.JAPANESE );
		
		public static const ERROR_021:String = "L10NNiumMsg.ERROR_021";
		Logger.setLog( new Log( ERROR_021, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_021, "インターフェイス IExDisplayObjectContainer を実装している対象 %0 に対して、Loader.content に格納されている表示オブジェクトを追加することはできません。" ), Locale.JAPANESE );
		
		public static const ERROR_022:String = "L10NNiumMsg.ERROR_022";
		Logger.setLog( new Log( ERROR_022, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_022, "識別子 %0 は既に使用されています。" ), Locale.JAPANESE );
		
		public static const ERROR_023:String = "L10NNiumMsg.ERROR_023";
		Logger.setLog( new Log( ERROR_023, "ENGLISH MESSAGE IS NOT REGISTERED." ), Locale.ENGLISH );
		Logger.setLog( new Log( ERROR_023, "ドキュメントクラスが ExDocument クラスを継承していないため、プロパティ %0 の値を読み取ることができません。" ), Locale.JAPANESE );
		
		
		
		
		
		/**
		 * @private
		 */
		public function L10NNiumMsg() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
