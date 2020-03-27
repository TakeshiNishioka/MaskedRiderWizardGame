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
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.text.TextSnapshot;
	
	/**
	 * <p><p>
	 * <p><p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public interface IDisplayObjectContainer extends IInteractiveObject {
		
		/**
		 * <p>オブジェクトの子に対してマウスが有効かどうかを調べます。</p>
		 * <p>Determines whether or not the children of the object are mouse enabled.</p>
		 */
		function get mouseChildren():Boolean;
		function set mouseChildren( value:Boolean ):void;
		
		/**
		 * <p>このオブジェクトの子の数を返します。</p>
		 * <p>Returns the number of children of this object.</p>
		 */
		function get numChildren():int;
		function set numChildren( value:int ):void;
		
		/**
		 * <p>オブジェクトの子に対してタブが有効かどうかを調べます。</p>
		 * <p>Determines whether the children of the object are tab enabled.</p>
		 */
		function get tabChildren():Boolean;
		function set tabChildren( value:Boolean ):void;
		
		/**
		 * <p>この DisplayObjectContainer インスタンスの TextSnapshot オブジェクトを返します。</p>
		 * <p>Returns a TextSnapshot object for this DisplayObjectContainer instance.</p>
		 */
		function get textSnapshot():TextSnapshot;
		function set textSnapshot( value:TextSnapshot ):void;
		
		
		
		
		
		/**
		 * <p>この DisplayObjectContainer インスタンスに子 DisplayObject インスタンスを追加します。</p>
		 * <p>Adds a child DisplayObject instance to this DisplayObjectContainer instance.</p>
		 * 
		 * @param child
		 * <p>対象の DisplayObjectContainer インスタンスの子として追加する DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance to add as a child of this DisplayObjectContainer instance.</p>
		 * @return
		 * <p>child パラメータで渡す DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance that you pass in the child parameter.</p>
		 */
		function addChild( child:DisplayObject ):DisplayObject;
		
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
		function addChildAt( child:DisplayObject, index:int ):DisplayObject;
		
		/**
		 * <p>特定の point ポイントを指定して呼び出した DisplayObjectContainer.getObjectsUnderPoint() メソッドから返されたリストに、セキュリティ上の制約のために省略される表示オブジェクトがあるかどうかを示します。</p>
		 * <p>Indicates whether the security restrictions would cause any display objects to be omitted from the list returned by calling the DisplayObjectContainer.getObjectsUnderPoint() method with the specified point point.</p>
		 * 
		 * @param point
		 * <p>注目するポイントです。</p>
		 * <p>The point under which to look.</p>
		 * @return
		 * <p>true は、そのポイントがセキュリティ上の制限のある子表示オブジェクトを含んでいることを示します。</p>
		 * <p>true if the point contains child display objects with security restrictions. </p>
		 */
		function areInaccessibleObjectsUnderPoint( point:Point ):Boolean;
		
		/**
		 * <p>指定された表示オブジェクトが DisplayObjectContainer インスタンスの子であるか、オブジェクト自体であるかを指定します。</p>
		 * <p>Determines whether the specified display object is a child of the DisplayObjectContainer instance or the instance itself.</p>
		 * 
		 * @param child
		 * <p>テストする子 DisplayObject インスタンスです。</p>
		 * <p>The child object to test.</p>
		 * @return
		 * <p>child インスタンスが DisplayObjectContainer の子であるか、コンテナ自体である場合は true となります。そうでない場合は false となります。</p>
		 * <p>true if the child object is a child of the DisplayObjectContainer or the container itself; otherwise false.</p>
		 */
		function contains( child:DisplayObject ):Boolean;
		
		/**
		 * <p>指定のインデックス位置にある子表示オブジェクトオブジェクトを返します。</p>
		 * <p>Returns the child display object instance that exists at the specified index.</p>
		 * 
		 * @param index
		 * <p>子 DisplayObject インスタンスのインデックス位置です。</p>
		 * <p>The index position of the child object.</p>
		 * @return
		 * <p>指定されたインデックス位置にある子 DisplayObject インスタンスです。</p>
		 * <p>The child display object at the specified index position.</p>
		 */
		function getChildAt( index:int ):DisplayObject;
		
		/**
		 * <p>指定された名前に一致する子表示オブジェクトを返します。</p>
		 * <p>Returns the child display object that exists with the specified name.</p>
		 * 
		 * @param name
		 * <p>返される子 DisplayObject インスタンスの名前です。</p>
		 * <p>The name of the child to return.</p>
		 * @return
		 * <p>指定された名前を持つ子 DisplayObject インスタンスです。</p>
		 * <p>The child display object with the specified name.</p>
		 */
		function getChildByName( name:String ):DisplayObject;
		
		/**
		 * <p>子 DisplayObject インスタンスのインデックス位置を返します。</p>
		 * <p>Returns the index position of a child DisplayObject instance.</p>
		 * 
		 * @param child
		 * <p>特定する子 DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance to identify.</p>
		 * @return
		 * <p>特定する子 DisplayObject インスタンスのインデックス位置です。</p>
		 * <p>The index position of the child display object to identify.</p>
		 */
		function getChildIndex( child:DisplayObject ):int;
		
		/**
		 * <p>指定されたポイントの下にあり、この DisplayObjectContainer インスタンスの子（または孫など）であるオブジェクトの配列を返します。</p>
		 * <p>Returns an array of objects that lie under the specified point and are children (or grandchildren, and so on) of this DisplayObjectContainer instance.</p>
		 * 
		 * @param point
		 * <p>注目するポイントです。</p>
		 * <p>The point under which to look.</p>
		 * @return
		 * <p>指定されたポイントの下にあり、この DisplayObjectContainer インスタンスの子または孫などであるオブジェクトの配列です。</p>
		 * <p>An array of objects that lie under the specified point and are children (or grandchildren, and so on) of this DisplayObjectContainer instance.</p>
		 */
		function getObjectsUnderPoint( point:Point ):Array;
		
		/**
		 * <p>DisplayObjectContainer インスタンスの子リストから指定の DisplayObject インスタンスを削除します。</p>
		 * <p>Removes the specified child DisplayObject instance from the child list of the DisplayObjectContainer instance.</p>
		 * 
		 * @param child
		 * <p>対象の DisplayObjectContainer インスタンスの子から削除する DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance to remove.</p>
		 * @return
		 * <p>child パラメータで渡す DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance that you pass in the child parameter.</p>
		 */
		function removeChild( child:DisplayObject ):DisplayObject;
		
		/**
		 * <p>DisplayObjectContainer の子リストの指定されたインデックス位置から子 DisplayObject インスタンスを削除します。</p>
		 * <p>Removes a child DisplayObject from the specified index position in the child list of the DisplayObjectContainer.</p>
		 * 
		 * @param index
		 * <p>削除する DisplayObject の子インデックスです。</p>
		 * <p>The child index of the DisplayObject to remove.</p>
		 * @return
		 * <p>削除された DisplayObject インスタンスです。</p>
		 * <p>The DisplayObject instance that was removed.</p>
		 */
		function removeChildAt( index:int ):DisplayObject;
		
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
		function setChildIndex( child:DisplayObject, index:int ):void;
		
		/**
		 * <p>指定された 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</p>
		 * <p>Swaps the z-order (front-to-back order) of the two specified child objects.</p>
		 * 
		 * @param child1
		 * <p>先頭の子 DisplayObject インスタンスです。</p>
		 * <p>The first child object.</p>
		 * @param child2
		 * <p>2 番目の子 DisplayObject インスタンスです。</p>
		 * <p>The second child object.</p>
		 */
		function swapChildren( child1:DisplayObject, child2:DisplayObject ):void;
		
		/**
		 * <p>子リスト内の指定されたインデックス位置に該当する 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</p>
		 * <p>Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list.</p>
		 * 
		 * @param index1
		 * <p>最初の子 DisplayObject インスタンスのインデックス位置です。</p>
		 * <p>The index position of the first child object.</p>
		 * @param index2
		 * <p>2 番目の子 DisplayObject インスタンスのインデックス位置です。</p>
		 * <p>The index position of the second child object.</p>
		 */
		function swapChildrenAt( index1:int, index2:int ):void;
	}
}
