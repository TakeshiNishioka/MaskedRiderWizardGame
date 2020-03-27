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
	 * <p>Command オブジェクトが処理を実行、完了、中断、等を行った場合に ExecuteEvent オブジェクトが送出されます。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // ExecuteEvent インスタンスを作成する
	 * var event:ExecuteEvent = new ExecuteEvent();
	 * </listing>
	 */
	public class ExecuteEvent extends Event {
		
		/**
		 * <p>executeStart イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ExecuteEvent.EXECUTE_START constant defines the value of the type property of an executeStart event object.</p>
		 */
		public static const EXECUTE_START:String = "executeStart";
		
		/**
		 * <p>executePosition イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ExecuteEvent.EXECUTE_POSITION constant defines the value of the type property of an executePosition event object.</p>
		 */
		public static const EXECUTE_POSITION:String = "executePosition";
		
		/**
		 * <p>executeComplete イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ExecuteEvent.EXECUTE_COMPLETE constant defines the value of the type property of an executeComplete event object.</p>
		 */
		public static const EXECUTE_COMPLETE:String = "executeComplete";
		
		/**
		 * <p>executeInterrupt イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ExecuteEvent.EXECUTE_INTERRUPT constant defines the value of the type property of an executeInterrupt event object.</p>
		 */
		public static const EXECUTE_INTERRUPT:String = "executeInterrupt";
		
		
		
		
		
		/**
		 * <p>実行対象となるオブジェクトを取得します。</p>
		 * <p></p>
		 */
		public function get executeTarget():Object { return _executeTarget; }
		private var _executeTarget:Object;
		
		/**
		 * <p>強制中断であるかどうかを取得します。</p>
		 * <p></p>
		 */
		public function get enforcedInterrupting():Boolean { return _enforcedInterrupting; }
		private var _enforcedInterrupting:Boolean = false;
		
		
		
		
		
		/**
		 * <p>新しい ExecuteEvent インスタンスを作成します。</p>
		 * <p>Creates a new ExecuteEvent object.</p>
		 * 
		 * @param type
		 * <p>ExecuteEvent.type としてアクセス可能なイベントタイプです。</p>
		 * <p>The type of the event, accessible as ExecuteEvent.type.</p>
		 * @param bubbles
		 * <p>ExecuteEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the ExecuteEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * <p>ExecuteEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the ExecuteEvent object can be canceled. The default values is false.</p>
		 * @param executeTarget
		 * <p>実行対象となるオブジェクトです。</p>
		 * <p></p>
		 * @param enforcedInterrupting
		 * <p>強制中断であるかどうかです。</p>
		 * <p></p>
		 */
		public function ExecuteEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, executeTarget:Object = null, enforcedInterrupting:Boolean = false ) {
			// 親クラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_executeTarget = executeTarget;
			_enforcedInterrupting = enforcedInterrupting;
		}
		
		
		
		
		
		/**
		 * <p>ExecuteEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an ExecuteEvent subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい ExecuteEvent インスタンスです。</p>
		 * <p>A new ExecuteEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new ExecuteEvent( super.type, super.bubbles, super.cancelable, _executeTarget, _enforcedInterrupting );
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
			return super.formatToString( "ExecuteEvent", "type", "bubbles", "cancelable", "executeTarget", "enforcedInterrupting" );
		}
	}
}

