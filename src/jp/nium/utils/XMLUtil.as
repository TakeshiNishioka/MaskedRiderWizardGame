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
	 * <p>XMLUtil クラスは、XML 操作のためのユーティリティクラスです。</p>
	 * <p>The XMLUtil class is an utility class for XML operation.</p>
	 */
	public class XMLUtil {
		
		/**
		 * @private
		 */
		public function XMLUtil() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>指定された XMLList インスタンスのオブジェクト表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @param xmllist
		 * <p>変換したい XMLList インスタンスです。</p>
		 * <p>The XMLList instance to convert.</p>
		 * @return
		 * <p>XMLList インスタンスのオブジェクト表現です。</p>
		 * <p>A Object representation of the XMLList instance.</p>
		 * 
		 * @example <listing version="3.0" >
		 * var xml:XMLList = new XMLList( ""
		 * 	+ "<aaa>AAA</aaa>"
		 * 	+ "<bbb>BBB</bbb>"
		 * 	+ "<ccc>CCC</ccc>" );
		 * var obj:Object = XMLUtil.xmlToObject( xml );
		 * trace( obj.aaa ); // AAA を出力します。
		 * trace( obj.bbb ); // BBB を出力します。
		 * trace( obj.ccc ); // CCC を出力します。
		 * </listing>
		 */
		public static function xmlToObject( xmllist:XMLList ):Object {
			var o:Object = {};
			
			for each ( var xml:XML in xmllist ) {
				o[String( xml.name() )] = StringUtil.toProperType( xml.valueOf(), false );
			}
			
			return o;
		}
	}
}
