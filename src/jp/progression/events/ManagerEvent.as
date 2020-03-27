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
	 * <p></p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // ManagerEvent インスタンスを作成する
	 * var event:ManagerEvent = new ManagerEvent();
	 * </listing>
	 */
	public class ManagerEvent extends Event {
		
		/**
		 * <p>managerReady イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ManagerEvent.MANAGER_READY constant defines the value of the type property of an managerReady event object.</p>
		 */
		public static const MANAGER_READY:String = "managerReady";
		
		/**
		 * <p>managerLockChange イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ManagerEvent.MANAGER_LOCK_CHANGE constant defines the value of the type property of an managerLockChange event object.</p>
		 */
		public static const MANAGER_LOCK_CHANGE:String = "managerLockChange";
		
		/**
		 * <p>managerActivate イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ManagerEvent.MANAGER_ACTIVATE constant defines the value of the type property of an managerActivate event object.</p>
		 */
		public static const MANAGER_ACTIVATE:String = "managerActivate";
		
		/**
		 * <p>managerDeactivate イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ManagerEvent.MANAGER_DEACTIVATE constant defines the value of the type property of an managerDeactivate event object.</p>
		 */
		public static const MANAGER_DEACTIVATE:String = "managerDeactivate";
		
		
		
		
		
		/**
		 * <p>新しい ManagerEvent インスタンスを作成します。</p>
		 * <p>Creates a new ManagerEvent object.</p>
		 * 
		 * @param type
		 * <p>ManagerEvent.type としてアクセス可能なイベントタイプです。</p>
		 * <p>The type of the event, accessible as ManagerEvent.type.</p>
		 * @param bubbles
		 * <p>ManagerEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the ManagerEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * <p>ManagerEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the ManagerEvent object can be canceled. The default values is false.</p>
		 */
		public function ManagerEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			// 親クラスを初期化する
			super( type, bubbles, cancelable );
		}
		
		
		
		
		
		/**
		 * <p>ManagerEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an ManagerEvent subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい ManagerEvent インスタンスです。</p>
		 * <p>A new ManagerEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new ManagerEvent( super.type, super.bubbles, super.cancelable );
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
			return super.formatToString( "ManagerEvent", "type", "bubbles", "cancelable" );
		}
	}
}
