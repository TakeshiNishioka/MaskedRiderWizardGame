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
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	
	/**
	 * <p>重複する値の登録を許可しないリストオブジェクトです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * var item1:Object = {};
	 * var item2:Object = {};
	 * 
	 * var list:UniqueList = new UniqueList();
	 * 
	 * list.addItem( item1 );
	 * list.addItem( item2 );
	 * list.addItem( item1 );
	 * 
	 * trace( list.numItems == 2 ); // true
	 * trace( list.getItemAt( 1 ) == item1 ); // true
	 * </listing>
	 */
	public class UniqueList {
		
		/**
		 * <p>子アイテムとして登録されているオブジェクト数を取得します。</p>
		 * <p>Returns the number of children of this Item.</p>
		 */
		public function get numItems():int { return _items.length; }
		
		/**
		 * 子アイテムを保持している配列を取得します。
		 */
		private var _items:Array;
		
		
		
		
		
		/**
		 * <p>新しい UniqueList インスタンスを作成します。</p>
		 * <p>Creates a new UniqueList object.</p>
		 * 
		 * @param items
		 * <p>登録したいオブジェクトを含む配列です。</p>
		 * <p></p>
		 */
		public function UniqueList( ... items:Array ) {
			// 引数を設定する
			_items = [];
			
			// 追加する
			for ( var i:int = 0, l:int = items.length; i < l; i++ ) {
				_addItemAt( items[i], _items.length );
			}
		}
		
		
		
		
		
		/**
		 * <p>子アイテムとして登録します。</p>
		 * <p></p>
		 * 
		 * @see #addItemAt()
		 * 
		 * @param item
		 * <p>登録したいオブジェクトです。</p>
		 * <p></p>
		 * @return
		 * <p>item パラメータで渡すオブジェクトです。 </p>
		 * <p></p>
		 */
		public function addItem( item:* ):* {
			return _addItemAt( item, _items.length );
		}
		
		/**
		 * <p>指定されたインデックス位置に子アイテムとして登録します。</p>
		 * <p></p>
		 * 
		 * @see #addItem()
		 * 
		 * @param item
		 * <p>登録したいオブジェクトです。</p>
		 * <p></p>
		 * @param index
		 * <p>子を追加するインデックス位置です。既にオブジェクトが置かれているインデックス位置を指定すると、その位置にあるオブジェクトとその上に位置するすべてのオブジェクトが、子リスト内で 1 つ上の位置に移動します。</p>
		 * <p></p>
		 * @return
		 * <p>item パラメータで渡すオブジェクトです。 </p>
		 * <p></p>
		 */
		public function addItemAt( item:*, index:int ):* {
			return _addItemAt( item, index );
		}
		
		/**
		 * 
		 */
		private function _addItemAt( item:*, index:int ):* {
			// インデックスの範囲を超えていれば例外をスローする
			if ( index < 0 || _items.length < index ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_004 ).toString() ); }
			
			// すでに登録されていれば
			var index2:int = _getItemIndex( item );
			if ( index2 > -1 ) {
				_removeItemAt( index2 );
			}
			
			// 登録する
			_items.splice( index, 0, item );
			
			return item;
		}
		
		/**
		 * <p>子アイテムを削除します。</p>
		 * <p></p>
		 * 
		 * @see #removeItemAt()
		 * 
		 * @param item
		 * <p>削除したいオブジェクトです。</p>
		 * <p></p>
		 * @return
		 * <p>item パラメータで渡すオブジェクトです。 </p>
		 * <p></p>
		 */
		public function removeItem( item:* ):* {
			var index:int = getItemIndex( item );
			
			if ( index < 0 ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_011 ).toString( item ) ); }
			
			return _removeItemAt( index );
		}
		
		/**
		 * <p>指定されたインデックス位置にある子アイテムを削除します。</p>
		 * <p></p>
		 * 
		 * @see #removeItem()
		 * 
		 * @param index
		 * <p>削除したいオブジェクトのインデックス位置です。</p>
		 * <p></p>
		 * @return
		 * <p>削除されたオブジェクトです。 </p>
		 * <p></p>
		 */
		public function removeItemAt( index:int ):* {
			return _removeItemAt( index );
		}
		
		/**
		 * 
		 */
		private function _removeItemAt( index:int ):* {
			// インデックスの範囲を超えていれば例外をスローする
			if ( index < 0 || _items.length < index ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_004 ).toString() ); }
			
			// 登録を解除する
			return _items.splice( index, 1 ) as Object;
		}
		
		/**
		 * <p>指定されたオブジェクトが登録されているかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @param item
		 * <p>テストする子オブジェクトです。</p>
		 * <p></p>
		 * @return
		 * <p>登録されていれば true を、それ以外では false です。</p>
		 * <p></p>
		 */
		public function contains( item:* ):Boolean {
			for ( var i:int = 0, l:int = _items.length; i < l; i++ ) {
				if ( _items[i] == item ) { return true; }
			}
			
			return false;
		}
		
		/**
		 * <p>指定されたインデックス位置にある子アイテムを返します。</p>
		 * <p></p>
		 * 
		 * @param index
		 * <p>子アイテムのインデックス位置です。</p>
		 * <p></p>
		 * @return
		 * <p>指定されたインデックス位置にある子アイテムです。</p>
		 * <p></p>
		 */
		public function getItemAt( index:int ):* {
			return _getItemAt( index );
		}
		
		/**
		 * 
		 */
		private function _getItemAt( index:int ):* {
			// インデックスが範囲外であれば例外をスローする
			if ( index < 0 || numItems < index ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_004 ).toString() ); }
			
			return _items[index] as Object;
		}
		
		/**
		 * <p>子アイテムの登録されているインデックス位置を返します。</p>
		 * <p></p>
		 * 
		 * @see #setItemIndex()
		 * 
		 * @param item
		 * <p>特定するアイテムです。</p>
		 * <p></p>
		 * @return
		 * <p>特定するアイテムのインデックス位置です。</p>
		 * <p></p>
		 */
		public function getItemIndex( item:* ):int {
			return _getItemIndex( item );
		}
		
		/**
		 * 
		 */
		private function _getItemIndex( item:* ):int {
			for ( var i:int = 0, l:int = _items.length; i < l; i++ ) {
				if ( _items[i] == item ) { return i; }
			}
			
			return -1;
		}
		
		/**
		 * <p>既存の子アイテムのインデックス位置を変更します。</p>
		 * <p></p>
		 * 
		 * @see #getItemIndex()
		 * 
		 * @param item
		 * <p>インデックス番号を変更する子アイテムです。</p>
		 * <p></p>
		 * @param index
		 * <p>item オブジェクトの結果のインデックス番号です。</p>
		 * <p></p>
		 */
		public function setItemIndex( item:*, index:int ):void {
			var index1:int = _getItemIndex( item );
			var index2:int = index;
			
			// 位置が範囲外であれば例外をスローする
			if ( index1 < 0 ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_004 ).toString() ); }
			
			_items.splice( index1, 1 );
			_items.splice( index2, 0, item );
		}
		
		/**
		 * <p>指定された 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</p>
		 * <p></p>
		 * 
		 * @see #swapItemsAt()
		 * 
		 * @param item1
		 * <p>先頭の子オブジェクトです。</p>
		 * <p></p>
		 * @param item2
		 * <p>2 番目の子オブジェクトです。</p>
		 * <p></p>
		 */
		public function swapItems( item1:*, item2:* ):void {
			_swapItemsAt( _getItemIndex( item1 ), _getItemIndex( item2 ) );
		}
		
		/**
		 * <p>子リスト内の指定されたインデックス位置に該当する 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</p>
		 * <p></p>
		 * 
		 * @see #swapItems()
		 * 
		 * @param index1
		 * <p>最初の子オブジェクトのインデックス位置です。</p>
		 * <p></p>
		 * @param index2
		 * <p>2 番目の子オブジェクトのインデックス位置です。</p>
		 * <p></p>
		 */
		public function swapItemsAt( index1:int, index2:int ):void {
			_swapItemsAt( index1, index2 );
		}
		
		/**
		 * 
		 */
		private function _swapItemsAt( index1:int, index2:int ):void {
			// 子アイテムを取得する
			var item1:* = _getItemAt( index1 );
			var item2:* = _getItemAt( index2 );
			
			// 対象が子アイテムとして登録されていなければ例外をスローする
			if ( !item1 || !item2 ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_004 ).toString() ); }
			
			// インデックスの数値によって入れ替える
			if ( index1 < index2 ) {
				var tmpItem:* = item1;
				var tmpIndex:int = index1;
				item1 = item2;
				item2 = tmpItem;
				index1 = index2;
				index2 = tmpIndex;
			}
			
			// 子アイテムの位置を移動する
			_items.splice( index1, 1, item2 );
			_items.splice( index2, 1, item1 );
		}
		
		/**
		 * <p>保持しているデータを破棄します。</p>
		 * <p></p>
		 */
		public function dispose():void {
			_items = [];
		}
		
		/**
		 * <p>UniqueList インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an UniqueList subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい UniqueList インスタンスです。</p>
		 * <p>A new UniqueList object that is identical to the original.</p>
		 */
		public function clone():UniqueList {
			var list:UniqueList = new UniqueList();
			list._items = _items.slice();
			return list;
		}
		
		/**
		 * <p>指定されたオブジェクトの配列表現を返します。</p>
		 * <p>Returns the array representation of the specified object.</p>
		 * 
		 * @return
		 * <p>オブジェクトの配列表現です。</p>
		 * <p>A array representation of the object.</p>
		 */
		public function toArray():Array {
			return _items.slice();
		}
	}
}
