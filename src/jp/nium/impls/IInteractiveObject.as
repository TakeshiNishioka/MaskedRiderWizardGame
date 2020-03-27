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
package jp.nium.impls {
	import flash.ui.ContextMenu;
	
	/**
	 * <p><p>
	 * <p><p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public interface IInteractiveObject extends IDisplayObject {
		
		/**
		 * <p>このオブジェクトに関連付けられたコンテキストメニューを指定します。</p>
		 * <p>Specifies the context menu associated with this object.</p>
		 */
		function get contextMenu():ContextMenu;
		function set contextMenu( value:ContextMenu ):void;
		
		/**
		 * <p>オブジェクトが doubleClick イベントを受け取るかどうかを指定します。</p>
		 * <p>Specifies whether the object receives doubleClick events.</p>
		 */
		function get doubleClickEnabled():Boolean;
		function set doubleClickEnabled( value:Boolean ):void;
		
		/**
		 * <p>このオブジェクトがフォーカス矩形を表示するかどうかを指定します。</p>
		 * <p>Specifies whether this object displays a focus rectangle.</p>
		 */
		function get focusRect():Object;
		function set focusRect( value:Object ):void;
		
		/**
		 * <p>このオブジェクトがマウスメッセージを受け取るかどうかを指定します。</p>
		 * <p>Specifies whether this object receives mouse messages.</p>
		 */
		function get mouseEnabled():Boolean;
		function set mouseEnabled( value:Boolean ):void;
		
		/**
		 * <p>このオブジェクトがタブ順序に含まれるかどうかを指定します。</p>
		 * <p>Specifies whether this object is in the tab order.</p>
		 */
		function get tabEnabled():Boolean;
		function set tabEnabled( value:Boolean ):void;
		
		/**
		 * <p>SWF ファイル内のオブジェクトのタブ順序を指定します。</p>
		 * <p>Specifies the tab ordering of objects in a SWF file.</p>
		 */
		function get tabIndex():int;
		function set tabIndex( value:int ):void;
	}
}
