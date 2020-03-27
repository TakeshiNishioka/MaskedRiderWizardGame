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
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import jp.nium.collections.IIdGroup;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.display.IExDisplayObjectContainer;
	import jp.nium.core.ns.nium_internal;
	import jp.nium.core.primitives.StringObject;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.ObjectUtil;
	
	/**
	 * <p>ExSprite クラスは、Sprite クラスの基本機能を拡張した jp.nium パッケージで使用される基本的な表示オブジェクトクラスです。</p>
	 * <p>ExSprite class is a basic display object class used at jp.nium package which extends the basic function of Sprite class.</p>
	 * 
	 * @example <listing version="3.0" >
	 * // ExSprite インスタンスを作成する
	 * var sp:ExSprite = new ExSprite();
	 * </listing>
	 */
	public class ExSprite extends Sprite implements IExDisplayObjectContainer, IIdGroup {
		
		/**
		 * <p>インスタンスのクラス名を取得します。</p>
		 * <p>Indicates the instance className of the IExDisplayObject.</p>
		 */
		public function get className():String { return _classNameObj ? _classNameObj.toString() : ClassUtil.nium_internal::$DEFAULT_CLASS_NAME; }
		private var _classNameObj:StringObject;
		
		/**
		 * <p>インスタンスの識別子を取得または設定します。</p>
		 * <p>Indicates the instance id of the IExDisplayObject.</p>
		 * 
		 * @see jp.nium.display#getInstanceById()
		 */
		public function get id():String { return _id; }
		public function set id( value:String ):void {
			// 既存の登録を取得する
			var instance:IIdGroup = ExMovieClip.nium_internal::$collections.getInstanceById( value );
			
			// すでに存在していれば例外をスローする
			if ( instance ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_022 ).toString( value ) ); }
			
			// 登録する
			_id = ExMovieClip.nium_internal::$collections.registerId( this, value ) ? value : null;
		}
		private var _id:String;
		
		/**
		 * <p>インスタンスのグループ名を取得または設定します。</p>
		 * <p>Indicates the instance group of the IExDisplayObject.</p>
		 * 
		 * @see jp.nium.display#getInstancesByGroup()
		 */
		public function get group():String { return _group; }
		public function set group( value:String ):void { _group = ExMovieClip.nium_internal::$collections.registerGroup( this, value ) ? value : null;  }
		private var _group:String;
		
		/**
		 * <p>子ディスプレイオブジェクトが保存されている配列です。
		 * インデックス値が断続的に指定可能であるため、getChildAt() ではなくこのプロパティを使用して子ディスプレイオブジェクト走査を行います。
		 * この配列を操作することで元の配列を変更することはできません。</p>
		 * <p>The array that saves child display objects.
		 * Because the index value can specify intermittently, it scans the child display object by not using getChildAt() but using this property.
		 * It can not change the original array by operating this array.</p>
		 */
		public function get children():Array { return _children ? _children.slice() : []; }
		private var _children:Array;
		
		/**
		 * <p>startDrag() メソッドを使用したドラッグ処理を行っている最中かどうかを取得します。</p>
		 * <p>Returns if the drag process which uses startDrag() method is executing.</p>
		 * 
		 * @see #startDrag()
		 * @see #stopDrag()
		 */
		public function get isDragging():Boolean { return _isDragging; }
		private var _isDragging:Boolean = false;
		
		/**
		 * 子をキーとしてインデックス値を保持した Dictionary インスタンスを取得します。
		 */
		private var _childToIndex:Dictionary;
		
		
		
		
		
		/**
		 * <p>新しい ExSprite インスタンスを作成します。</p>
		 * <p>Creates a new ExSprite object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function ExSprite( initObject:Object = null ) {
			// クラス名を取得する
			_classNameObj = ClassUtil.nium_internal::$getClassString( this );
			
			// 初期化する
			_children = [];
			_childToIndex = new Dictionary( true );
			
			// 親クラスを初期化する
			super();
			
			// コレクションに登録する
			ExMovieClip.nium_internal::$collections.addInstance( this );
			
			// 既存の子の数を取得する
			var l:int; l = super.numChildren;
			
			// 既存の子を登録する
			for ( var i:int = 0; i < l; i++ ) {
				var child:DisplayObject = super.getChildAt( i );
				_children.push( child );
				_childToIndex[child] = i;
			}
			
			// 初期化する
			ObjectUtil.setProperties( this, initObject );
		}
		
		
		
		
		
		/**
		 * <p>インスタンスに対して、複数のプロパティを一括設定します。</p>
		 * <p>Setup the several instance properties.</p>
		 * 
		 * @param parameters
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p>The object that contains the property to setup.</p>
		 */
		public function setProperties( parameters:Object ):void {
			ObjectUtil.setProperties( this, parameters );
		}
		
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
		public override function addChild( child:DisplayObject ):DisplayObject {
			var highest:DisplayObject = _children[_children.length - 1] as DisplayObject;
			return _addChildAt( child, highest ? _childToIndex[highest] + 1 : 0 );
		}
		
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
		public override function addChildAt( child:DisplayObject, index:int ):DisplayObject {
			return _addChildAt( child, index );
		}
		
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
		public function addChildAtAbove( child:DisplayObject, index:int ):DisplayObject {
			return _addChildAt( child, _getChildAt( index ) ? index + 1 : index );
		}
		
		/**
		 * 
		 */
		private function _addChildAt( child:DisplayObject, index:int ):DisplayObject {
			// 存在しなければ例外をスローする
			if ( !child ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_009 ).toString( "child" ) ); }
			
			// 既存の登録があれば
			if ( child.parent ) {
				// 対象の親が Loader であれば例外をスローする
				if ( child.parent is Loader ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_021 ).toString( this ) ); }
				
				// 登録を削除する
				child.parent.removeChild( child );
			}
			
			// 情報を取得する
			var highest:DisplayObject = _children[_children.length - 1] as DisplayObject;
			var virtualIndex:int = 0;
			var realIndex:int = 0;
			
			// 対象が存在しない、またはインデックスが最高値よりも大きければ
			if ( !highest || index > _childToIndex[highest] ) {
				realIndex = _children.length;
				_children.push( child );
				
				// 登録する
				_childToIndex[child] = index;
			}
			else {
				var children:Array = [];
				for ( var i:int = 0, l:int = _children.length; i < l; i++ ) {
					var target:DisplayObject = DisplayObject( _children[i] );
					virtualIndex = _childToIndex[target];
					
					if ( virtualIndex >= index ) {
						realIndex = i;
						children.push.apply( null, [ child ].concat( _children.slice( i ) ) );
						
						// 登録する
						_childToIndex[child] = index;
						break;
					}
					else {
						children.push( target );
					}
				}
				_children = children;
				
				for ( i = 0, l = _children.length; i < l; i++ ) {
					var target1:DisplayObject = _children[i + 0] as DisplayObject;
					var target2:DisplayObject = _children[i + 1] as DisplayObject;
					var virtual1:int = _childToIndex[target1];
					var virtual2:int = _childToIndex[target2];
					
					if ( virtual1 == virtual2 ) {
						_childToIndex[target2] += 1;
					}
				}
			}
			
			return super.addChildAt( child, realIndex );
		}
		
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
		public override function removeChild( child:DisplayObject ):DisplayObject {
			return _removeChild( child );
		}
		
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
		public override function removeChildAt( index:int ):DisplayObject {
			return _removeChild( _getChildAt( index ) );
		}
		
		/**
		 * 
		 */
		private function _removeChild( child:DisplayObject ):DisplayObject {
			for ( var i:int = 0, l:int = _children.length; i < l; i++ ) {
				var target:DisplayObject = DisplayObject( _children[i] );
				if ( child == target ) {
					_children.splice( i, 1 );
					delete _childToIndex[child];
					break;
				}
			}
			
			return super.removeChild( child );
		}
		
		/**
		 * <p>DisplayObjectContainer に追加されている全ての子 DisplayObject インスタンスを削除します。</p>
		 * <p>Remove the whole child DisplayObject instance which added to the DisplayObjectContainer.</p>
		 */
		public function removeAllChildren():void {
			for ( var i:int = 0, l:int = _children.length; i < l; i++ ) {
				super.removeChild( _children[i] );
			}
			
			_children = [];
			_childToIndex = new Dictionary( true );
		}
		
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
		public override function getChildAt( index:int ):DisplayObject {
			return _getChildAt( index );
		}
		
		/**
		 * 
		 */
		private function _getChildAt( index:int ):DisplayObject {
			for ( var i:int = 0, l:int = _children.length; i < l; i++ ) {
				var child:DisplayObject = DisplayObject( _children[i] );
				if ( index == _childToIndex[child] ) { return child; }
			}
			return null;
		}
		
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
		public override function getChildIndex( child:DisplayObject ):int {
			return _getChildIndex( child );
		}
		
		/**
		 * 
		 */
		private function _getChildIndex( child:DisplayObject ):int {
			if ( _childToIndex[child] == null ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_011 ).toString( "DisplayObject" ) ); }
			return _childToIndex[child];
		}
		
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
		public override function setChildIndex( child:DisplayObject, index:int ):void {
			_setChildIndex( child, index );
		}
		
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
		public function setChildIndexAbove( child:DisplayObject, index:int ):void {
			_setChildIndex( child, _getChildAt( index ) ? index + 1 : index );
		}
		
		/**
		 * 
		 */
		private function _setChildIndex( child:DisplayObject, index:int ):void {
			var realIndex1:int = super.getChildIndex( child );
			var vertualIndex1:int = _childToIndex[child];
			var child2:DisplayObject = child;
			var ascending:Boolean = vertualIndex1 < index;
			
			// 操作範囲を取得する
			var children:Array = [];
			switch ( true ) {
				case vertualIndex1 > index	: {
					for ( var i:int = 0, l:int = realIndex1; i <= l; i++ ) {
						child2 = super.getChildAt( i );
						if ( index <= _childToIndex[child2] ) { break; }
					}
					break;
				}
				case vertualIndex1 == index	: { return; }
				case vertualIndex1 < index	: {
					for ( i = realIndex1, l = super.numChildren; i < l; i++ ) {
						var target:DisplayObject = super.getChildAt( i );
						if ( _childToIndex[target] <= index ) {
							child2 = target;
						}
					}
					break;
				}
			}
			
			// 位置を変更する
			super.setChildIndex( child, super.getChildIndex( child2 ) );
			_childToIndex[child] = index;
			
			// この配列を再構成する
			_updateChildren();
			
			children = _children.slice();
			
			if ( ascending ) {
				children.reverse();
			}
			
			// 仮想インデックスを再構成する
			var previousIndex:int = -1;
			for ( i = 0, l = children.length; i < l; i++ ) {
				child = children[i];
				if ( previousIndex == _childToIndex[child] ) {
					_childToIndex[child] -= ascending ? 1 : -1;
				}
				previousIndex = _childToIndex[child];
			}
		}
		
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
		public override function swapChildren( child1:DisplayObject, child2:DisplayObject ):void {
			_swapChildrenAt( _getChildIndex( child1 ), _getChildIndex( child2 ) );
		}
		
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
		public override function swapChildrenAt( index1:int, index2:int ):void {
			_swapChildrenAt( index1, index2 );
		}
		
		/**
		 * 
		 */
		private function _swapChildrenAt( index1:int, index2:int ):void {
			// 子を取得する
			var child1:DisplayObject = _getChildAt( index1 );
			var child2:DisplayObject = _getChildAt( index2 );
			
			// 対象が子として登録されていなければ例外をスローする
			if ( !child1 || !child2 ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_004 ).toString() ); }
			
			// インデックスの数値によって入れ替える
			if ( index1 < index2 ) {
				var tmpChild:DisplayObject = child1;
				var tmpIndex:int = index1;
				child1 = child2;
				child2 = tmpChild;
				index1 = index2;
				index2 = tmpIndex;
			}
			
			// 子の位置を移動する
			super.swapChildren( child1, child2 );
			_childToIndex[child1] = index2;
			_childToIndex[child2] = index1;
			
			// この配列を再構成する
			_updateChildren();
		}
		
		/**
		 * 
		 */
		private function _updateChildren():void {
			_children = [];
			for ( var i:int = 0, l:int = super.numChildren; i < l; i++ ) {
				_children.push( super.getChildAt( i ) );
			}
		}
		
		/**
		 * <p>指定されたスプライトをユーザーがドラッグできるようにします。</p>
		 * <p>Allow the user to drag the specified sprite.</p>
		 * 
		 * @see #isDragging
		 * 
		 * @param lockCenter
		 * <p>ドラッグ可能なスプライトが、マウス位置の中心にロックされるか (true)、ユーザーがスプライト上で最初にクリックした点にロックされるか (false) を指定します。</p>
		 * <p>Specify the sprite which will be able to drag locks at the center of the mouse position(true) or the first point that the user clicked on the sprite(false).</p>
		 * @param bounds
		 * <p>Sprite の制限矩形を指定する Sprite の親の座標を基準にした相対値です。</p>
		 * <p>Specify the limitation rectangle of the sprite. It is a relative value based on parents' coordinates of the sprite.</p>
		 */
		public override function startDrag( lockCenter:Boolean = false, bounds:Rectangle = null ):void {
			_isDragging = true;
			super.startDrag( lockCenter, bounds );
		}
		
		/**
		 * <p>startDrag() メソッドを終了します。</p>
		 * <p>Ends the startDrag() method.</p>
		 * 
		 * @see #isDragging
		 */
		public override function stopDrag():void {
			_isDragging = false;
			super.stopDrag();
		}
		
		/**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @return
		 * <p>オブジェクトのストリング表現です。</p>
		 * <p>A string representation of the object.</p>
		 */
		public override function toString():String {
			return ObjectUtil.formatToString( this, _classNameObj.toString(), _id ? "id" : null );
		}
	}
}
