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
	import flash.events.IEventDispatcher;
	
	/**
	 * <p>EventIntegrator クラスは、IEventIntegrator インターフェイスを実装した、EventDispatcher クラスのサブクラスです。
	 * EventDispatcher クラスを拡張して、イベントをより統合的に扱うことができるようになります。</p>
	 * <p>EventIntegrator class is a subclass of EventDispatcher class which implements IEventIntegrator interface,
	 * It extends the EventDispatcher class and be able to handle the event more integrated.</p>
	 * 
	 * @example <listing version="3.0" >
	 * // EventIntegrator インスタンスを作成する
	 * var integrator:EventIntegrator = new EventIntegrator();
	 * </listing>
	 */
	public class EventIntegrator implements IEventDispatcher {
		
		/**
		 * 登録したイベントリスナー情報を取得します。
		 */
		private var _listeners:Array;
		
		/**
		 * 
		 */
		private var _target:IEventDispatcher;
		
		
		
		
		
		/**
		 * <p>新しい EventIntegrator インスタンスを作成します。</p>
		 * <p>Creates a new EventIntegrator object.</p>
		 * 
		 * @param target
		 * <p>IEventDispatcher インスタンスに送出されるイベントのターゲットオブジェクトです。</p>
		 * <p>The target object for events dispatched to the IEventDispatcher object.</p>
		 */
		public function EventIntegrator( target:IEventDispatcher ) {
			// EventDispatcher を作成する
			_target = target;
			
			// 初期化する
			_listeners = [];
		}
		
		
		
		
		
		/**
		 * 
		 */
		private function _registerListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			// 登録を削除する
			_unregisterListener( type, listener, useCapture );
			
			// イベントリスナー情報を保存する
			_listeners.push( {
				type				:type,
				listener			:listener,
				useCapture			:useCapture,
				priority			:priority,
				useWeakReference	:useWeakReference
			} );
		}
		
		/**
		 * 
		 */
		private function _unregisterListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			for ( var i:int = 0, l:int = _listeners.length; i < l; i++ ) {
				var o:Object = _listeners[i];
				
				// 設定値が違っていれば次へ
				if ( o.type != type ) { continue; }
				if ( o.listener != listener ) { continue; }
				if ( o.useCapture != useCapture ) { continue; }
				
				// 登録情報を削除する
				_listeners.splice( i, 1 );
				break;
			}
		}
		
		/**
		 * <p>イベントリスナーオブジェクトを EventIntegrator インスタンスに登録し、リスナーがイベントの通知を受け取るようにします。
		 * このメソッドを使用して登録されたリスナーを removeEventListener() メソッドで削除した場合には、restoreRemovedListeners() メソッドで再登録させることができます。</p>
		 * <p>Register the event listener object into the EventIntegrator instance to get the event notification.
		 * If the registered listener by this method removed by using removeEventListener() method, it can re-register using restoreRemovedListeners() method.</p>
		 * 
		 * @param type
		 * <p>イベントのタイプです。</p>
		 * <p>The type of event.</p>
		 * @param listener
		 * <p>イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</p>
		 * <p>The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing. The function can have any name.</p>
		 * @param useCapture
		 * <p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</p>
		 * <p>Determines whether the listener works in the capture phase or the target and bubbling phases. If useCapture is set to true, the listener processes the event only during the capture phase and not in the target or bubbling phase. If useCapture is false, the listener processes the event only during the target or bubbling phase. To listen for the event in all three phases, call addEventListener twice, once with useCapture set to true, then again with useCapture set to false.</p>
		 * @param priority
		 * <p>イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</p>
		 * <p>The priority level of the event listener. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.</p>
		 * @param useWeakReference
		 * <p>リスナーへの参照が強参照と弱参照のいずれであるかを判断します。デフォルトである強参照の場合は、リスナーのガベージコレクションが回避されます。弱参照では回避されません。</p>
		 * <p>Determines whether the reference to the listener is strong or weak. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.</p>
		 */
		public function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			// 登録する
			_registerListener( type, listener, useCapture, priority, useWeakReference );
			
			// イベントリスナーを登録する
			_target.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		/**
		 * <p>EventIntegrator インスタンスからリスナーを削除します。
		 * このメソッドを使用して削除されたリスナーは、restoreRemovedListeners() メソッドで再登録させることができます。</p>
		 * <p>Remove the listener from EventIntegrator instance.
		 * The listener removed by using this method can re-register by restoreRemovedListeners() method.</p>
		 * 
		 * @param type
		 * <p>イベントのタイプです。</p>
		 * <p>The type of event.</p>
		 * @param listener
		 * <p>削除するリスナーオブジェクトです。</p>
		 * <p>The listener object to remove.</p>
		 * @param useCapture
		 * <p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</p>
		 * <p>Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</p>
		 */
		public function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			_target.removeEventListener( type, listener, useCapture );
		}
		
		/**
		 * <p>イベントをイベントフローに送出します。</p>
		 * <p>Dispatches an event into the event flow.</p>
		 * 
		 * @param event
		 * <p>イベントフローに送出されるイベントオブジェクトです。イベントが再度送出されると、イベントのクローンが自動的に作成されます。イベントが送出された後にそのイベントの target プロパティは変更できないため、再送出処理のためにはイベントの新しいコピーを作成する必要があります。</p>
		 * <p>The Event object that is dispatched into the event flow. If the event is being redispatched, a clone of the event is created automatically. After an event is dispatched, its target property cannot be changed, so you must create a new copy of the event for redispatching to work.</p>
		 * @return
		 * <p>値が true の場合、イベントは正常に送出されました。値が false の場合、イベントの送出に失敗したか、イベントで preventDefault() が呼び出されたことを示しています。</p>
		 * <p>A value of true if the event was successfully dispatched. A value of false indicates failure or that preventDefault() was called on the event.</p>
		 */
		public function dispatchEvent( event:Event ):Boolean {
			return _target.dispatchEvent( event );
		}
		
		/**
		 * <p>EventIntegrator インスタンスに、特定のイベントタイプに対して登録されたリスナーがあるかどうかを確認します。</p>
		 * <p>Checks whether the EventIntegrator object has any listeners registered for a specific type of event.</p>
		 * 
		 * @param event
		 * <p>イベントのタイプです。</p>
		 * <p>The type of event.</p>
		 * @return
		 * <p>指定したタイプのリスナーが登録されている場合は true に、それ以外の場合は false になります。</p>
		 * <p>A value of true if a listener of the specified type is registered; false otherwise.</p>
		 */
		public function hasEventListener( type:String ):Boolean {
			return _target.hasEventListener( type );
		}
		
		/**
		 * <p>指定されたイベントタイプについて、この EventIntegrator インスタンスまたはその祖先にイベントリスナーが登録されているかどうかを確認します。</p>
		 * <p>Checks whether an event listener is registered with this EventIntegrator object or any of its ancestors for the specified event type.</p>
		 * 
		 * @param event
		 * <p>イベントのタイプです。</p>
		 * <p>The type of event.</p>
		 * @return
		 * <p>指定したタイプのリスナーがトリガされた場合は true に、それ以外の場合は false になります。</p>
		 * <p>A value of true if a listener of the specified type will be triggered; false otherwise.</p>
		 */
		public function willTrigger( type:String ):Boolean {
			return _target.willTrigger( type );
		}
		
		/**
		 * <p>addEventListener() メソッド経由で登録された全てのイベントリスナー登録を削除します。
		 * 完全に登録を削除しなかった場合には、削除されたイベントリスナーを restoreRemovedListeners() メソッドで復帰させることができます。</p>
		 * <p>Remove the whole event listener registered via addEventListener() method.
		 * If do not remove completely, removed event listener can restore by restoreRemovedListeners() method.</p>
		 * 
		 * @param completely
		 * <p>情報を完全に削除するかどうかです。</p>
		 * <p>If it removes the information completely.</p>
		 */
		public function removeAllListeners( completely:Boolean = false ):void {
			for ( var i:int = 0, l:int = _listeners.length; i < l; i++ ) {
				var o:Object = _listeners[i];
				
				// イベントリスナーを解除する
				_target.removeEventListener( o.type, o.listener, o.useCapture );
			}
			
			if ( completely ) {
				_listeners = [];
			}
		}
		
		/**
		 * <p>removeEventListener() メソッド、または removeAllListeners() メソッド経由で削除された全てイベントリスナーを再登録します。</p>
		 * <p>Re-register the whole event listener removed via removeEventListener() or removeAllListeners() method.</p>
		 */
		public function restoreRemovedListeners():void {
			for ( var i:int = 0, l:int = _listeners.length; i < l; i++ ) {
				var o:Object = _listeners[i];
				
				// イベントリスナーを登録する
				_target.addEventListener( o.type, o.listener, o.useCapture, o.priority, o.useWeakReference );
			}
		}
		
		/**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @return
		 * <p>オブジェクトのストリング表現です。</p>
		 * <p>A string representation of the object.</p>
		 */
		public function toString():String {
			return "[object EventIntegrator]";
		}
	}
}
