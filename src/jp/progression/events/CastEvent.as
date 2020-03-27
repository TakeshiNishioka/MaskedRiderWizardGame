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
package jp.progression.events {
	import flash.events.Event;
	
	/**
	 * <p>IExecutable インターフェイスを実装したオブジェクトが AddChild コマンドや RemoveChild コマンドなどによって表示リストに追加された場合などに CastEvent オブジェクトが送出されます。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // CastEvent インスタンスを作成する
	 * var event:CastEvent = new CastEvent();
	 * </listing>
	 */
	public class CastEvent extends Event {
		
		/**
		 * <p>castAdded イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastEvent.CAST_ADDED constant defines the value of the type property of an castAdded event object.</p>
		 */
		public static const CAST_ADDED:String = "castAdded";
		
		/**
		 * <p>castAddedComplete イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastEvent.CAST_ADDED_COMPLETE constant defines the value of the type property of an castAddedComplete event object.</p>
		 */
		public static const CAST_ADDED_COMPLETE:String = "castAddedComplete";
		
		/**
		 * <p>castRemoved イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastEvent.CAST_REMOVED constant defines the value of the type property of an castRemoved event object.</p>
		 */
		public static const CAST_REMOVED:String = "castRemoved";
		
		/**
		 * <p>castRemovedComplete イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastEvent.CAST_REMOVED_COMPLETE constant defines the value of the type property of an castRemovedComplete event object.</p>
		 */
		public static const CAST_REMOVED_COMPLETE:String = "castRemovedComplete";
		
		/**
		 * <p>castLoadStart イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastEvent.CAST_LOAD_START constant defines the value of the type property of an castLoadStart event object.</p>
		 */
		public static const CAST_LOAD_START:String = "castLoadStart";
		
		/**
		 * <p>castLoadComplete イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastEvent.CAST_LOAD_COMPLETE constant defines the value of the type property of an castLoadComplete event object.</p>
		 */
		public static const CAST_LOAD_COMPLETE:String = "castLoadComplete";
		
		
		
		
		
		/**
		 * <p>新しい CastEvent インスタンスを作成します。</p>
		 * <p>Creates a new CastEvent object.</p>
		 * 
		 * @param type
		 * <p>CastEvent.type としてアクセス可能なイベントタイプです。</p>
		 * <p>The type of the event, accessible as CastEvent.type.</p>
		 * @param bubbles
		 * <p>CastEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the CastEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * <p>CastEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the CastEvent object can be canceled. The default values is false.</p>
		 */
		public function CastEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			// 親クラスを初期化する
			super( type, bubbles, cancelable );
		}
		
		
		
		
		
		/**
		 * <p>CastEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an CastEvent subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい CastEvent インスタンスです。</p>
		 * <p>A new CastEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new CastEvent( super.type, super.bubbles, super.cancelable );
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
			return super.formatToString( "CastEvent", "type", "bubbles", "cancelable", "eventPhase" );
		}
	}
}
