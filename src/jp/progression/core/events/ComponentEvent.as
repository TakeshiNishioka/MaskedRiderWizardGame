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
package jp.progression.core.events {
	import flash.events.Event;
	
	/**
	 * @private
	 */
	public class ComponentEvent extends Event {
		
		/**
		 * <p>componentAdded イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ComponentEvent.COMPONENT_ADDED constant defines the value of the type property of an componentAdded event object.</p>
		 */
		public static const COMPONENT_ADDED:String = "componentAdded";
		
		/**
		 * <p>componentRemoved イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ComponentEvent.COMPONENT_REMOVED constant defines the value of the type property of an componentRemoved event object.</p>
		 */
		public static const COMPONENT_REMOVED:String = "componentRemoved";
		
		/**
		 * <p>componentUpdate イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ComponentEvent.COMPONENT_UPDATE constant defines the value of the type property of an componentUpdate event object.</p>
		 */
		public static const COMPONENT_UPDATE:String = "componentUpdate";
		
		/**
		 * <p>componentLoaderActivate イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ComponentEvent.COMPONENT_LOADER_ACTIVATE constant defines the value of the type property of an componentLoaderActivate event object.</p>
		 */
		public static const COMPONENT_LOADER_ACTIVATE:String = "componentLoaderActivate";
		
		/**
		 * <p>componentLoaderDeactivate イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ComponentEvent.COMPONENT_DELOADER_ACTIVATE constant defines the value of the type property of an componentLoaderDeactivate event object.</p>
		 */
		public static const COMPONENT_LOADER_DEACTIVATE:String = "componentLoaderDeactivate";
		
		/**
		 * <p>componentButtonActivate イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ComponentEvent.COMPONENT_BUTTON_ACTIVATE constant defines the value of the type property of an componentButtonActivate event object.</p>
		 */
		public static const COMPONENT_BUTTON_ACTIVATE:String = "componentButtonActivate";
		
		/**
		 * <p>componentButtonDeactivate イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ComponentEvent.COMPONENT_BUTTON_DEACTIVATE constant defines the value of the type property of an componentButtonDeactivate event object.</p>
		 */
		public static const COMPONENT_BUTTON_DEACTIVATE:String = "componentButtonDeactivate";
		
		
		
		
		
		/**
		 * <p>新しい ComponentEvent インスタンスを作成します。</p>
		 * <p>Creates a new ComponentEvent object.</p>
		 * 
		 * @param type
		 * <p>ComponentEvent.type としてアクセス可能なイベントタイプです。</p>
		 * <p>The type of the event, accessible as ComponentEvent.type.</p>
		 * @param bubbles
		 * <p>ComponentEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the ComponentEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * <p>ComponentEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the ComponentEvent object can be canceled. The default values is false.</p>
		 */
		public function ComponentEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			// 親クラスを初期化する
			super( type, bubbles, cancelable );
		}
		
		
		
		
		
		/**
		 * <p>ComponentEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an ComponentEvent subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい ComponentEvent インスタンスです。</p>
		 * <p>A new ComponentEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new ComponentEvent( super.type, super.bubbles, super.cancelable );
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
			return super.formatToString( "ComponentEvent", "type", "bubbles", "cancelable", "eventPhase" );
		}
	}
}
