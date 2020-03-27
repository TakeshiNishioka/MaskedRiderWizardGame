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
	import flash.utils.ByteArray;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	
	/**
	 * <p>ObjectUtil クラスは、オブジェクト操作のためのユーティリティクラスです。</p>
	 * <p>The ObjectUtil class is an utility class for object operation.</p>
	 */
	public class ObjectUtil {
		
		/**
		 * @private
		 */
		public function ObjectUtil() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>対象オブジェクトのプロパティを一括設定します。</p>
		 * <p>Set the whole property of the object.</p>
		 * 
		 * @param target
		 * <p>一括設定したいオブジェクトです。</p>
		 * <p>The object to set.</p>
		 * @param props
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p>The object that contains the property to setup.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function setProperties( target:Object, parameters:Object ):void {
			if ( target is Array ) {
				var targets:Array = target as Array;
			}
			else {
				targets = [ target ];
			}
			
			// プロパティを設定する
			for ( var i:int = 0, l:int = targets.length; i < l; i++ ) {
				for ( var parameter:String in parameters ) {
					// プロパティが存在しなければ次へ
					if ( !( parameter in targets[i] ) ) { continue; }
					
					// プロパティを設定する
					targets[i][parameter] = parameters[parameter];
				}
			}
		}
		
		/**
		 * <p>指定されたオブジェクトを複製して返します。</p>
		 * <p>Returns the copy of the specified object.</p>
		 * 
		 * @param target
		 * <p>対象のオブジェクトです。</p>
		 * <p>The object to copy.</p>
		 * @return
		 * <p>複製されたオブジェクトです。</p>
		 * <p>The copied object.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function clone( target:Object ):Object {
			var byte:ByteArray = new ByteArray();
			byte.writeObject( target );
			byte.position = 0;
			return Object( byte.readObject() );
		}
		
		/**
		 * <p>シンプルな toString() メソッドの実装を提供します。</p>
		 * <p></p>
		 * 
		 * @param target
		 * <p>実装したい対象です。</p>
		 * <p></p>
		 * @param className
		 * <p>対象のクラス名です。</p>
		 * <p></p>
		 * @param args
		 * <p>出力に反映させたいプロパティ名です。</p>
		 * <p></p>
		 * @return
		 * <p>生成されるストリングです。</p>
		 * <p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function formatToString( target:*, className:String, ... args:Array ):String {
			var str:String = "[" + className;
			
			for ( var i:int = 0, l:int = args.length; i < l; i++ ) {
				var name:String = args[i];
				
				if ( !name ) { continue; }
				
				str += " " + name + "=";
				
				var value:* = target[name];
				
				if ( value is String ) {
					str += "\"" + value + "\"";
				}
				else {
					str += value;
				}
			}
			
			return str += "]";
		}
		
		/**
		 * <p>指定されたオブジェクトのクエリーストリング表現を返します。</p>
		 * <p>Returns the query string expression of the specified object.</p>
		 * 
		 * @param query
		 * <p>対象のオブジェクトです。</p>
		 * <p>The object to get the query string.</p>
		 * @return
		 * <p>オブジェクトのクエリーストリング表現です。</p>
		 * <p>The query string expression of the object.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function toQueryString( query:Object ):String {
			// 存在しなければ終了する
			if ( !query ) { return ""; }
			
			// String に変換する
			var str:String = "";
			for ( var p:String in query ) {
				str += p + "=" + query[p] + "&";
			}
			
			// 1 度でもループを処理していれば、最後の & を削除する
			if ( p ) {
				str = str.slice( 0, -1 );
			}
			
			return encodeURI( decodeURI( str ) );
		}
		
		/**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string expression of the specified object.</p>
		 * 
		 * @param target
		 * <p>対象のオブジェクトです。</p>
		 * <p>The object to get the string expression.</p>
		 * @return
		 * <p>オブジェクトのストリング表現です。</p>
		 * <p>The string expression of the object.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function toString( target:Object ):String {
			if ( target is Array ) { return ArrayUtil.toString( target as Array ); }
			
			var str:String = "{";
			
			for ( var p:String in target ) {
				str += p + ":";
				
				var value:* = target[p];
				
				switch ( true ) {
					case value is Array		: { str += ArrayUtil.toString( value ); break; }
					case value is Boolean	:
					case value is Number	:
					case value is int		:
					case value is uint		: { str += value; break; }
					case value is String	: { str += '"' + value.replace( new RegExp( '"', "gi" ), '\\"' ) + '"'; break; }
					default					: { str += toString( value ); }
				}
				
				str += ", ";
			}
			
			// 1 度でもループを処理していれば最後の , を削除する
			if ( p ) {
				str = str.slice( 0, -2 );
			}
			
			str += "}";
			
			return str;
		}
	}
}
