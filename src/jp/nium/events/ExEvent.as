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
	 * <p>ExEvent クラスは、jp.nium パッケージで使用される基本的な Event クラスとして使用されます。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // ExEvent インスタンスを作成する
	 * var event:ExEvent = new ExEvent();
	 * </listing>
	 */
	public class ExEvent extends Event {
		
		/**
		 * <p>ready イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ExEvent.EX_READY constant defines the value of the type property of an ready event object.</p>
		 */
		public static const EX_READY:String = "exReady";
		
		/**
		 * <p>resizeStart イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ExEvent.EX_RESIZE_START constant defines the value of the type property of an resizeStart event object.</p>
		 */
		public static const EX_RESIZE_START:String = "exResizeStart";
		
		/**
		 * <p>resizeProgress イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ExEvent.EX_RESIZE_PROGRESS constant defines the value of the type property of an resizeProgress event object.</p>
		 */
		public static const EX_RESIZE_PROGRESS:String = "exResizeProgress";
		
		/**
		 * <p>resizeComplete イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ExEvent.EX_RESIZE_COMPLETE constant defines the value of the type property of an resizeComplete event object.</p>
		 */
		public static const EX_RESIZE_COMPLETE:String = "exResizeComplete";
		
		
		
		
		
		/**
		 * <p>新しい ExEvent インスタンスを作成します。</p>
		 * <p>Creates a new ExEvent object.</p>
		 * 
		 * @param type
		 * <p>ExEvent.type としてアクセス可能なイベントタイプです。</p>
		 * <p>The type of the event, accessible as ExEvent.type.</p>
		 * @param bubbles
		 * <p>ExEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the ExEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * <p>ExEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the ExEvent object can be canceled. The default values is false.</p>
		 */
		public function ExEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			// 親クラスを初期化する
			super( type, bubbles, cancelable );
		}
		
		
		
		
		
		/**
		 * <p>ExEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an ExEvent subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい ExEvent インスタンスです。</p>
		 * <p>A new ExEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new ExEvent( super.type, super.bubbles, super.cancelable );
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
			return super.formatToString( "ExEvent", "type", "bubbles", "cancelable" );
		}
	}
}
