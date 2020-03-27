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
package jp.nium.collections {
	
	/**
	 * <p>IIdGroup インターフェイスは、インスタンスに識別子や所属を与える基本的なプロパティを実装します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public interface IIdGroup {
		
		/**
		 * <p>インスタンスの識別子を取得または設定します。</p>
		 * <p>Indicates the instance id.</p>
		 */
		function get id():String;
		function set id( value:String ):void;
		
		/**
		 * <p>インスタンスのグループ名を取得または設定します。</p>
		 * <p>Indicates the instance group.</p>
		 */
		function get group():String;
		function set group( value:String ):void;
	}
}
