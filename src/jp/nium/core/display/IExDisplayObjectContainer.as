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
	import flash.display.DisplayObject;
	
	/**
	 * @private
	 */
	public interface IExDisplayObjectContainer extends IExDisplayObject {
		
		/**
		 * <p>このオブジェクトの子の数を返します。</p>
		 * <p>Returns the number of children of this object.</p>
		 */
		function get numChildren():int;
		
		/**
		 * <p>子ディスプレイオブジェクトが保存されている配列です。
		 * インデックス値が断続的に指定可能であるため、getChildAt() ではなくこのプロパティを使用して子ディスプレイオブジェクト走査を行います。
		 * この配列を操作することで元の配列を変更することはできません。</p>
		 * <p>The array that saves child display objects.
		 * Because the index value can specify intermittently, it scans the child display object by not using getChildAt() but using this property.
		 * It can not change the original array by operating this array.</p>
		 */
		function get children():Array;
		
		
		
		
		
		/**
		 * <p>この DisplayObjectContainer インスタンスの指定されたインデックス位置に子 DisplayObject インスタンスを追加します。</p>
		 * <p>Adds a child DisplayObject instance to this DisplayObjectContainer instance.</p>
		 * 
		 * @param child
		 * <p>対象の DisplayObjectContainer インスタンスの子として追加する DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance to add as a child of this DisplayObjectContainer instance.</p>
		 * @param index
		 * <p>子を追加するインデックス位置です。</p>
		 * <p>The index position to which the child is added. If you specify a currently occupied index position, the child object that exists at that position and all higher positions are moved up one position in the child list.</p>
		 * @return
		 * <p>child パラメータで渡す DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance that you pass in the child parameter.</p>
		 */
		function addChildAtAbove( child:DisplayObject, index:int ):DisplayObject;
		
		/**
		 * <p>DisplayObjectContainer に追加されている全ての子 DisplayObject インスタンスを削除します。</p>
		 * <p>Removes the whole child DisplayObject instance added to the DisplayObjectContainer.</p>
		 */
		function removeAllChildren():void;
		
		/**
		 * <p>表示オブジェクトコンテナの既存の子の位置を変更します。</p>
		 * <p>Changes the position of an existing child in the display object container.</p>
		 * 
		 * @param child
		 * <p>インデックス番号を変更する子 DisplayObject インスタンスです。</p>
		 * <p>The child DisplayObject instance for which you want to change the index number.</p>
		 * @param index
		 * <p>child インスタンスの結果のインデックス番号です。</p>
		 * <p>The resulting index number for the child display object.</p>
		 */
		function setChildIndexAbove( child:DisplayObject, index:int ):void ;
	}
}
