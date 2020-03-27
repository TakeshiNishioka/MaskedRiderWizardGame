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
	import jp.progression.scenes.SceneObject;
	
	/**
	 * <p>SceneManager オブジェクトが処理を実行、完了、中断、等を行った場合に ProcessEvent オブジェクトが送出されます。
	 * 通常は、Progression オブジェクトを経由してイベントを受け取ります。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // ProcessEvent インスタンスを作成する
	 * var event:ProcessEvent = new ProcessEvent();
	 * </listing>
	 */
	public class ProcessEvent extends Event {
		
		/**
		 * <p>processStart イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ProcessEvent.PROCESS_START constant defines the value of the type property of an processStart event object.</p>
		 */
		public static const PROCESS_START:String = "processStart";
		
		/**
		 * <p>processScene イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ProcessEvent.PROCESS_SCENE constant defines the value of the type property of an processScene event object.</p>
		 */
		public static const PROCESS_SCENE:String = "processScene";
		
		/**
		 * <p>processEvent イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ProcessEvent.PROCESS_EVENT constant defines the value of the type property of an processEvent event object.</p>
		 */
		public static const PROCESS_EVENT:String = "processEvent";
		
		/**
		 * <p>processChange イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ProcessEvent.PROCESS_CHANGE constant defines the value of the type property of an processChange event object.</p>
		 */
		public static const PROCESS_CHANGE:String = "processChange";
		
		/**
		 * <p>processComplete イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ProcessEvent.PROCESS_COMPLETE constant defines the value of the type property of an processComplete event object.</p>
		 */
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * <p>processStop イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ProcessEvent.PROCESS_STOP constant defines the value of the type property of an processStop event object.</p>
		 */
		public static const PROCESS_STOP:String = "processStop";
		
		/**
		 * <p>processError イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ProcessEvent.PROCESS_ERROR constant defines the value of the type property of an processError event object.</p>
		 */
		public static const PROCESS_ERROR:String = "processError";
		
		
		
		
		
		/**
		 * <p>イベント発生時のカレントシーンを取得します。</p>
		 * <p></p>
		 */
		public function get targetScene():SceneObject { return _targetScene; }
		private var _targetScene:SceneObject;
		
		/**
		 * <p>イベント発生時のカレントイベントタイプを取得します。</p>
		 * <p></p>
		 */
		public function get targetEventType():String { return _targetEventType; }
		private var _targetEventType:String;
		
		
		
		
		
		/**
		 * <p>新しい ProcessEvent インスタンスを作成します。</p>
		 * <p>Creates a new ProcessEvent object.</p>
		 * 
		 * @param type
		 * <p>ProcessEvent.type としてアクセス可能なイベントタイプです。</p>
		 * <p>The type of the event, accessible as ProcessEvent.type.</p>
		 * @param bubbles
		 * <p>ProcessEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the ProcessEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * <p>ProcessEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the ProcessEvent object can be canceled. The default values is false.</p>
		 * @param targetScene
		 * <p>イベント発生時のカレントシーンです。</p>
		 * <p></p>
		 * @param targetEventType
		 * <p>イベント発生時のカレントイベントタイプです。</p>
		 * <p></p>
		 */
		public function ProcessEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, targetScene:SceneObject = null, targetEventType:String = null ) {
			// 親クラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_targetScene = targetScene;
			_targetEventType = targetEventType;
		}
		
		
		
		
		
		/**
		 * <p>ProcessEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an ProcessEvent subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい ProcessEvent インスタンスです。</p>
		 * <p>A new ProcessEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new ProcessEvent( super.type, super.bubbles, super.cancelable, _targetScene, _targetEventType );
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
			return super.formatToString( "ProcessEvent", "type", "bubbles", "cancelable", "targetScene", "targetEventType" );
		}
	}
}
