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
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.core.ns.nium_internal;
	import jp.nium.core.primitives.StringObject;
	
	/**
	 * <p>ClassUtil クラスは、クラス操作のためのユーティリティクラスです。</p>
	 * <p>The ClassUtil class is an utility class for class operation.</p>
	 */
	public class ClassUtil {
		
		/**
		 * @private
		 */
		nium_internal static var $DEFAULT_CLASS_NAME:String = "Uninitialized Object";
		
		/**
		 * クラス名を保持した Dictionary インスタンスを取得します。 
		 */
		private static var _classStrings:Dictionary = new Dictionary( true );
		
		
		
		
		
		/**
		 * @private
		 */
		public function ClassUtil() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		nium_internal static function $getClassString( target:* ):StringObject {
			var className:String = getClassName( target );
			return _classStrings[className] ||= new StringObject( className );
		}
		
		/**
		 * <p>対象のクラス名を返します。</p>
		 * <p>Returns the class name of the object.</p>
		 * 
		 * @param target
		 * <p>クラス名を取得する対象です。</p>
		 * <p>The object to get the class name.</p>
		 * @return
		 * <p>クラス名です。</p>
		 * <p>The class name.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getClassName( target:* ):String {
			return getQualifiedClassName( target ).split( "::" ).pop();
		}
		
		/**
		 * <p>対象のクラスパスを返します。</p>
		 * <p>Returns the class path of the object.</p>
		 * 
		 * @param target
		 * <p>クラスパスを取得する対象です。</p>
		 * <p>The class path of the object.</p>
		 * @return
		 * <p>クラスパスです。</p>
		 * <p>The class path.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getClassPath( target:* ):String {
			return getQualifiedClassName( target ).replace( new RegExp( "::", "g" ), "." );
		}
		
		/**
		 * <p>対象のパッケージを返します。</p>
		 * <p>Returns the package of the object.</p>
		 * 
		 * @param target
		 * <p>パッケージを取得する対象です。</p>
		 * <p>The object to get the package.</p>
		 * @return
		 * <p>パッケージです。</p>
		 * <p>The package.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getPackage( target:* ):String {
			return getQualifiedClassName( target ).split( "::" ).shift();
		}
		
		/**
		 * <p>対象のクラスに dynamic 属性が設定されているかどうかを返します。</p>
		 * <p>Returns if the dynamic attribute is set to the class object.</p>
		 * 
		 * @param target
		 * <p>dynamic 属性の有無を調べる対象です。</p>
		 * <p>The object to check if the dynamic attribute is set or not.</p>
		 * @return
		 * <p>dynamic 属性があれば true を、違っていれば false を返します。</p>
		 * <p>Returns true if dynamic attribute is set, otherwise return false.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function isDynamic( target:* ):Boolean {
			return Boolean( StringUtil.toProperType( describeType( target ).attribute( "isDynamic" ) ) );
		}
		
		/**
		 * <p>対象のクラスに final 属性が設定されているかどうかを返します。</p>
		 * <p>Returns if the final attribute is set to the class object.</p>
		 * 
		 * @param target
		 * <p>final 属性の有無を調べる対象です。</p>
		 * <p>The object to check if the final attribute is set or not.</p>
		 * @return
		 * <p>final 属性があれば true を、違っていれば false を返します。</p>
		 * <p>Returns true if final attribute is set, otherwise return false.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function isFinal( target:* ):Boolean {
			return Boolean( StringUtil.toProperType( describeType( target ).attribute( "isFinal" ) ) );
		}
		
		/**
		 * <p>対象のインスタンスが指定されたクラスを継承しているかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @param target
		 * <p>継承関係を調査したいインスタンスです。</p>
		 * <p></p>
		 * @param cls
		 * <p>継承関係を調査委したいクラスです。</p>
		 * <p></p>
		 * @return
		 * <p>継承されていれば true を、それ以外の場合には false を返します。</p>
		 * <p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function isExtended( target:*, cls:Class ):Boolean {
			return Object( target ).constructor == cls;
		}
	}
}
