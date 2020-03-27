/**
 * Progression 4
 * 
 * @author Copyright (C) 2007-2009 taka:nium.jp, All Rights Reserved.
 * @version 4.0.1 Public Beta 1.2
 * @see http://progression.jp/
 * 
 * Progression Software is released under the Progression Software License:
 * http://progression.jp/ja/overview/license
 * 
 * Progression Libraries is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.progression.commands.display {
	import jp.nium.core.display.IExDisplayObjectContainer;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.commands.Command;
	
	/**
	 * <p>AddChildAt クラスは、対象の表示リストに DisplayObject インスタンスを指定された位置に追加するコマンドクラスです。
	 * 追加するインスタンスが ICastObject インターフェイスを実装している場合には、CastEvent.CAST_ADDED イベントが送出され、
	 * 対象のイベント処理の実行中に、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @see jp.progression.commands.display.AddChild
	 * @see jp.progression.commands.display.AddChildAt
	 * 
	 * @example <listing version="3.0" >
	 * // AddChildAtAbove インスタンスを作成する
	 * var com:AddChildAtAbove = new AddChildAtAbove();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class AddChildAtAbove extends AddChild {
		
		/**
		 * <p>DisplayObject を追加するインデックス位置を取得します。</p>
		 * <p></p>
		 */
		public function get index():int { return _index; }
		private var _index:int;
		
		
		
		
		
		/**
		 * <p>新しい AddChildAtAbove インスタンスを作成します。</p>
		 * <p>Creates a new AddChildAtAbove object.</p>
		 * 
		 * @param containerRefOrId
		 * <p>指定された DisplayObject インスタンスを追加する対象の DisplayObjectContainer インスタンス、またはインスタンスを示す識別子です。</p>
		 * <p></p>
		 * @param childRefOrId
		 * <p>表示リストに追加したい DisplayObject インスタンス、またはインスタンスを示す識別子です。</p>
		 * <p></p>
		 * @param index
		 * <p>子を追加するインデックス位置です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function AddChildAtAbove( containerRefOrId:*, childRefOrId:*, index:int, initObject:Object = null ) {
			// 引数を設定する
			_index = index;
			
			// 親クラスを初期化する
			super( containerRefOrId, childRefOrId, initObject );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		internal override function _addChildRef():void {
			// 表示リストに追加する
			IExDisplayObjectContainer( _containerRef ).addChildAtAbove( _childRef, _index );
		}
		
		/**
		 * <p>AddChildAtAbove インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an AddChildAtAbove subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい AddChildAtAbove インスタンスです。</p>
		 * <p>A new AddChildAtAbove object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new AddChildAtAbove( super.container, super.child, _index, this );
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
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null, "container", "child", "index" );
		}
	}
}
