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
package jp.nium.events {
	import flash.events.Event;
	
	/**
	 * <p>コレクションに対して各種操作が行われた場合に CollectionEvent オブジェクトが送出されます。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // CollectionEvent インスタンスを作成する
	 * var event:CollectionEvent = new CollectionEvent();
	 * </listing>
	 */
	public class CollectionEvent extends Event {
		
		/**
		 * <p>collectionUpdate イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CollectionEvent.COLLECTION_UPDATE constant defines the value of the type property of an collectionUpdate event object.</p>
		 */
		public static const COLLECTION_UPDATE:String = "collectionUpdate";
		
		
		
		
		
		/**
		 * <p>新しい CollectionEvent インスタンスを作成します。</p>
		 * <p>Creates a new CollectionEvent object.</p>
		 * 
		 * @param type
		 * <p>CollectionEvent.type としてアクセス可能なイベントタイプです。</p>
		 * <p>The type of the event, accessible as CollectionEvent.type.</p>
		 * @param bubbles
		 * <p>CollectionEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the CollectionEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * <p>CollectionEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the CollectionEvent object can be canceled. The default values is false.</p>
		 */
		public function CollectionEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			// 親クラスを初期化する
			super( type, bubbles, cancelable );
		}
		
		
		
		
		
		/**
		 * <p>CollectionEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an CollectionEvent subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい CollectionEvent インスタンスです。</p>
		 * <p>A new CollectionEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new CollectionEvent( super.type, super.bubbles, super.cancelable );
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
			return super.formatToString( "CollectionEvent", "type", "bubbles", "cancelable", "eventPhase" );
		}
	}
}
