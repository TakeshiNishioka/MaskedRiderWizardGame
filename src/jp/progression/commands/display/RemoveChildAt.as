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
	import flash.display.DisplayObject;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.commands.Command;
	
	/**
	 * <p>RemoveChild クラスは、対象の表示リストから指定された位置の DisplayObject インスタンスを削除するコマンドクラスです。
	 * 削除するインスタンスが ICastObject インターフェイスを実装している場合には、CastEvent.CAST_REMOVED イベントが送出され、
	 * 対象のイベント処理の実行中に、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @see jp.progression.commands.display.RemoveAllChildren
	 * @see jp.progression.commands.display.RemoveChild
	 * @see jp.progression.commands.display.RemoveChildByName
	 * 
	 * @example <listing version="3.0" >
	 * // RemoveChildAt インスタンスを作成する
	 * var com:RemoveChildAt = new RemoveChildAt();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class RemoveChildAt extends RemoveChild {
		
		/**
		 * @private
		 */
		public override function get child():* { return null; }
		
		/**
		 * <p>削除したい子 DisplayObject のインデックス位置を取得します。</p>
		 * <p></p>
		 */
		public function get index():int { return _index; }
		private var _index:int;
		
		
		
		
		
		/**
		 * <p>新しい RemoveChildAt インスタンスを作成します。</p>
		 * <p>Creates a new RemoveChildAt object.</p>
		 * 
		 * @param containerRefOrId
		 * <p>指定された DisplayObject インスタンスを削除する対象の DisplayObjectContainer インスタンス、またはインスタンスを示す識別子です。</p>
		 * <p></p>
		 * @param index
		 * <p>削除したい子 DisplayObject のインデックス位置です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function RemoveChildAt( containerRefOrId:*, index:int, initObject:Object = null ) {
			// 引数を設定する
			_index = index;
			
			// 親クラスを初期化する
			super( containerRefOrId, null, initObject );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		internal override function _getChildRef():DisplayObject {
			return _containerRef.getChildAt( _index );
		}
		
		/**
		 * <p>RemoveChildAt インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an RemoveChildAt subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい RemoveChildAt インスタンスです。</p>
		 * <p>A new RemoveChildAt object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new RemoveChildAt( super.container, _index, this );
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
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null, "container", "index" );
		}
	}
}
