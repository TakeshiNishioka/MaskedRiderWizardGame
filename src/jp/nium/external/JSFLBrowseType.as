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
package jp.nium.external {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	
	/**
	 * <p>JSFLBrowseType クラスは、JSFL クラスの browseForFileURL() メソッドを使用した際のファイルの参照操作の種類を示す値を提供します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class JSFLBrowseType {
		
		/**
		 * <p>browseForFileURL() メソッドに対してファイルを開くように指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.nium.external.JSFL#browseForFileURL()
		 */
		public static const OPEN:String = "open";
		
		/**
		 * <p>browseForFileURL() メソッドに対してファイルを選択するように指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.nium.external.JSFL#browseForFileURL()
		 */
		public static const SELECT:String = "select";
		
		/**
		 * <p>browseForFileURL() メソッドに対してファイルを保存するように指定します。</p>
		 * <p></p>
		 * 
		 * @see jp.nium.external.JSFL#browseForFileURL()
		 */
		public static const SAVE:String = "save";
		
		
		
		
		
		/**
		 * @private
		 */
		public function JSFLBrowseType() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
