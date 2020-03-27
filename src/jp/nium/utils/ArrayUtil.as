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
	 * <p>ArrayUtil クラスは、配列操作のためのユーティリティクラスです。</p>
	 * <p>The ArrayUtil class is an utility class for array operation.</p>
	 */
	public class ArrayUtil {
		
		/**
		 * @private
		 */
		public function ArrayUtil() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>指定された配列に含まれるアイテムのインデックス値を返します。</p>
		 * <p>Returns the index value of the item included in specified array.</p>
		 * 
		 * @param array
		 * <p>検索対象の配列です。</p>
		 * <p>The array to search the object.</>
		 * @param item
		 * <p>検索されるアイテムです。</p>
		 * <p>The item to be searched.</p>
		 * @return
		 * <p>指定されたアイテムのインデックス値、または -1 （指定されたアイテムが見つからない場合）です。</p>
		 * <p>The index value of the specified item or -1 (In case, the specified item could not find).</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getItemIndex( array:Array, item:* ):int {
			for ( var i:int = 0, l:int = array.length; i < l; i++ ) {
				if ( array[i] == item ) { return i; }
			}
			
			return -1;
		}
		
		/**
		 * <p>配列が保持している全てのアイテムの型が指定されたものと合致するかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @param array
		 * <p>対象の配列です。</p>
		 * <p></p>
		 * @param cls
		 * <p>比較するクラスです。</p>
		 * <p></p>
		 * @return
		 * <p>全てのアイテムが合致すれば true を、そうでなければ false を返します。</p>
		 * <p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function validateItems( array:Array, cls:Class ):Boolean {
			for ( var i:int = 0, l:int = array.length; i < l; i++ ) {
				if ( array[i] is cls ) { continue; }
				return false;
			}
			
			return true;
		}
		
		/**
		 * <p>指定された配列の内容が同一のものであるかどうかを比較し、結果を返します。</p>
		 * <p></p>
		 * 
		 * @param array1
		 * <p>先頭の配列です。</p>
		 * <p>The first array object.</p>
		 * @param array2
		 * <p>2 番目の配列です。</p>
		 * <p>The second array object.</p>
		 * @return
		 * <p>同一であれば true を、そうでなければ false を返します。</p>
		 * <p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function equals( array1:Array, array2:Array ):Boolean {
			if ( array1.length != array2.length ) { return false; }
			
			for ( var i:int = 0, l:int = array1.length; i < l; i++ ) {
				if ( array1[i] !== array2[i] ) { return false; }
			}
			
			return true;
		}
		
		/**
		 * <p>新しい配列に再配置します。</p>
		 * <p></p>
		 * 
		 * @param args
		 * <p>再配置したい配列です。</p>
		 * <p></p>
		 * @return
		 * <p>再配置後の配列です。</p>
		 * <p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function toArray( args:Array ):Array {
			var list:Array = [];
			
			for ( var i:int = 0, l:int = args.length; i < l; i++ ) {
				list.push( args[i] );
			}
			
			return list;
		}
		
		/**
		 * <p>指定された配列のストリング表現を返します。</p>
		 * <p>Returns the string expression of the specified array.</p>
		 * 
		 * @param array
		 * <p>対象の配列です。</p>
		 * <p>The array to process.</p>
		 * @return
		 * <p>配列のストリング表現です。</p>
		 * <p>The string expression of the array.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function toString( array:Array ):String {
			var str:String = "[";
			
			for ( var i:int = 0, l:int = array.length; i < l; i++ ) {
				var item:* = array[i];
				
				switch ( true ) {
					case item is Array		: { str += ArrayUtil.toString( item ); break; }
					case item is Boolean	:
					case item is Number		:
					case item is int		:
					case item is uint		: { str += item; break; }
					case item is String		: { str += '"' + item.replace( new RegExp( '"', "gi" ), '\\"' ) + '"'; break; }
					default					: { str += ObjectUtil.toString( item ); }
				}
				
				str += ", ";
			}
			
			// 1 度でもループを処理していれば最後の , を削除する
			if ( i > 0 ) {
				str = str.slice( 0, -2 );
			}
			
			str += "]";
			
			return str;
		}
	}
}
