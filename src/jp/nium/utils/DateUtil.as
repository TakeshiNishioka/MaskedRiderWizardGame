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
package jp.nium.utils {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	
	/**
	 * <p>DateUtil クラスは、日付データ操作のためのユーティリティクラスです。</p>
	 * <p>The DateUtil class is an utility class for date data operation.</p>
	 */
	public class DateUtil {
		
		/**
		 * <p>1 ミリ秒をミリ秒単位で表した定数を取得します。</p>
		 * <p>Returns the fixed value which express the 1 millisecond by millisecond unit.</p>
		 */
		public static const ONE_MILLISECOND:int = 1;
		
		/**
		 * <p>ミリ秒の最大値を表す定数を取得します。</p>
		 * <p>Returns the maximum value of the millisecond.</p>
		 */
		public static const MAX_MILLISECOND:int = 1000;
		
		/**
		 * <p>1 秒をミリ秒単位で表した定数を取得します。</p>
		 * <p>Returns the fixed value of 1second by millisecond unit.</p>
		 */
		public static const ONE_SECOND:int = ONE_MILLISECOND * MAX_MILLISECOND;
		
		/**
		 * <p>秒の最大値を表す定数を取得します。</p>
		 * <p>Returns the maximum value of the second.</p>
		 */
		public static const MAX_SECOND:int = 60;
		
		/**
		 * <p>1 分をミリ秒単位で表した定数を取得します。</p>
		 * <p>Returns the fixed value of 1minuite by millisecond unit.</p>
		 */
		public static const ONE_MINUTE:int = ONE_SECOND * MAX_SECOND;
		
		/**
		 * <p>分の最大値を表す定数を取得します。</p>
		 * <p>Returns the maximum value of the minuite.</p>
		 */
		public static const MAX_MINUTE:int = 60;
		
		/**
		 * <p>1 時間をミリ秒単位で表した定数を取得します。</p>
		 * <p>Returns the fixed value of 1hour by millisecond unit.</p>
		 */
		public static const ONE_HOUR:int = ONE_MINUTE * MAX_MINUTE;
		
		/**
		 * <p>時間の最大値を表す定数を取得します。</p>
		 * <p>Returns the maximum value of the hour.</p>
		 */
		public static const MAX_HOUR:int = 24;
		
		/**
		 * <p>1 日をミリ秒単位で表した定数を取得します。</p>
		 * <p>Returns the fixed value of 1day by millisecond unit.</p>
		 */
		public static const ONE_DAY:int = ONE_HOUR * MAX_HOUR;
		
		
		
		
		
		/**
		 * @private
		 */
		public function DateUtil() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>対象の月の最大日数を返します。</p>
		 * <p>Returns the maximum day of the month.</p>
		 * 
		 * @param date
		 * <p>最大日数を取得したい Date インスタンスです。</p>
		 * <p>The date istance to get the maximum day.</p>
		 * @return
		 * <p>最大日数です。</p>
		 * <p>The maximum day.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getMaxDateLength( date:Date ):int {
			var newDate:Date = new Date( date );
			newDate.setMonth( date.getMonth() + 1 );
			newDate.setDate( 0 );
			return newDate.getDate();
		}
		
		/**
		 * <p>W3CDTF 形式のストリングから Date インスタンスを生成して返します。</p>
		 * <p></p>
		 * 
		 * @param date
		 * <p>W3CDTF 形式のストリングです。</p>
		 * <p></p>
		 * @return
		 * <p>生成された Date インスタンスです。</p>
		 * <p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function w3cdtfToDate( time:String ):Date {
			var results:Array = new RegExp( "^(\\d{4})-(\\d{2})-(\\d{2})T(\\d{2}):(\\d{2}):(\\d{2})Z$", "g" ).exec( time ) || [];
			
			var date:Date = new Date();
			date.fullYear = parseInt( results[1] );
			date.month = parseInt( results[2] ) - 1;
			date.date = parseInt( results[3] );
			date.hours = parseInt( results[4] );
			date.minutes = parseInt( results[5] );
			date.seconds = parseInt( results[6] );
			
			return date;
		}
	}
}
