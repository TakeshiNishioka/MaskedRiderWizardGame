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
	import flash.display.DisplayObjectContainer;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.commands.Command;
	
	/**
	 * <p>RemoveChildFromParent クラスは、対象が設置されている親の表示リストから DisplayObject インスタンスを削除するコマンドクラスです。
	 * 削除するインスタンスが ICastObject インターフェイスを実装している場合には、CastEvent.CAST_REMOVED イベントが送出され、
	 * 対象のイベント処理の実行中に、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @see jp.progression.commands.display.RemoveAllChildren
	 * @see jp.progression.commands.display.RemoveChild
	 * @see jp.progression.commands.display.RemoveChildByName
	 * 
	 * @example <listing version="3.0" >
	 * // RemoveChildFromParent インスタンスを作成する
	 * var com:RemoveChildFromParent = new RemoveChildFromParent();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class RemoveChildFromParent extends RemoveChild {
		
		/**
		 * @private
		 */
		public override function get container():* { return null; }
		
		
		
		
		
		/**
		 * <p>新しい RemoveChildFromParent インスタンスを作成します。</p>
		 * <p>Creates a new RemoveChildFromParent object.</p>
		 * 
		 * @param childRefOrId
		 * <p>表示リストから削除したい DisplayObject インスタンス、またはインスタンスを示す識別子です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function RemoveChildFromParent( childRefOrId:*, initObject:Object = null ) {
			// 親クラスを初期化する
			super( null, childRefOrId, initObject );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		internal override function _getParentRef():DisplayObjectContainer {
			return _getObjectRef( child ).parent;
		}
		
		/**
		 * <p>RemoveChildFromParent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an RemoveChildFromParent subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい RemoveChildFromParent インスタンスです。</p>
		 * <p>A new RemoveChildFromParent object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new RemoveChildFromParent( super.child, this );
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
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null, "child" );
		}
	}
}
