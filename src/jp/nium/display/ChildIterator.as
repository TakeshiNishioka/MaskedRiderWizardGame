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
package jp.nium.display {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import jp.nium.core.display.IExDisplayObjectContainer;
	
	/**
	 * <p>ChildIterator クラスは、IExDisplayObjectContainer インターフェイスを実装しているクラスと実装していないクラスを同じ構文で走査するためのイテレータクラスです。</p>
	 * <p>ChildIterator class is an iterator class to scan the class which implements or does not implement the IExDsiplayObjectContainer interface, with same syntax.</p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ChildIterator {
		
		/**
		 * インデックスを整理する対象コンテナを取得します。
		 */
		private var _container:DisplayObjectContainer;
		
		/**
		 * 現在のインデックス位置を取得します。
		 */
		private var _index:int = 0;
		
		
		
		
		
		/**
		 * <p>新しい ChildIterator インスタンスを作成します。</p>
		 * <p>Creates a new ChildIterator object.</p>
		 * 
		 * @param container
		 * <p>関連付けたい DisplayObjectContainer インスタンスです。</p>
		 * <p>The DisplayObjectContainer instance that want to relate.</p>
		 */
		public function ChildIterator( container:DisplayObjectContainer ) {
			// 引数を保存する
			_container = container;
		}
		
		
		
		
		
		/**
		 * <p>現在の対象を返して、次の対象にインデックスを進めます。</p>
		 * <p>Returns the current object and move the index to the next object.</p>
		 * 
		 * @return
		 * <p>現在の対象である DisplayObject インスタンスです。</p>
		 * <p>The current DisplayObject instance.</p>
		 */
		public function next():DisplayObject {
			// 存在しなければ null を返す
			if ( !_container ) { return null; }
			
			// 次へ進める
			var index:int = _index++;
			
			// IExDisplayObjectContainer を実装していれば
			if ( _container is IExDisplayObjectContainer ) {
				return IExDisplayObjectContainer( _container ).children[index] as DisplayObject;
			}
			
			return ( index < _container.numChildren ) ? _container.getChildAt( index ) : null;
		}
		
		/**
		 * <p>現在のインデックス位置に対象が存在するかどうかを返します。</p>
		 * <p>Returns if the object exists in the current index position.</p>
		 * 
		 * @return
		 * <p>対象が存在すれば true を、存在しなければ false です。</p>
		 * <p>Returns true if the object exists and returns false if not.</p>
		 */
		public function hasNext():Boolean {
			if ( !_container ) { return false; }
			
			var result:Boolean = ( _index < _container.numChildren );
			
			if ( !result ) {
				_container = null;
			}
			
			return result;
		}
		
		/**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @return
		 * <p>オブジェクトのストリング表現です。</p>
		 * <p>A string representation of the object.</p>
		 */
		public function toString():String {
			return "[object ChildIterator]";
		}
	}
}
