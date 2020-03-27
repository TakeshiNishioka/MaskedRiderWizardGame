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
package jp.nium.core.display {
	import flash.events.IEventDispatcher;
	
	/**
	 * @private
	 */
	public interface IExDisplayObject extends IEventDispatcher {
		
		/**
		 * <p>インスタンスのクラス名を取得します。</p>
		 * <p>Indicates the instance className of the IExDisplayObject.</p>
		 */
		function get className():String;
		
		
		
		
		
		/**
		 * <p>インスタンスに対して、複数のプロパティを一括設定します。</p>
		 * <p>Setup the several instance properties.</p>
		 * 
		 * @param parameters
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p>The object that contains the property to setup.</p>
		 */
		function setProperties( parameters:Object ):void;
	}
}
