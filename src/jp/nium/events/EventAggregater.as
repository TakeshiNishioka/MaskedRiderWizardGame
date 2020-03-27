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
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * <p>登録されている全ての EventDispatcher インスタンスがイベントを送出した場合に送出されます。</p>
	 * <p>Dispatch when the whole registered EventDispatcher instance sent.</p>
	 * 
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event( name="complete", type="flash.events.Event" )]
	
	/**
	 * <p>EventAggregater クラスは、複数のイベント発生をまとめて処理し、全てのイベントが送出されたタイミングで Event.COMPLETE イベントを送出します。</p>
	 * <p>EventAggregater class will process the several event generation and send the Event.COMPLETE event when the whole event sent.</p>
	 * 
	 * @example <listing version="3.0" >
	 * // EventAggregater インスタンスを作成する
	 * var aggregater:EventAggregater = new EventAggregater();
	 * </listing>
	 */
	public class EventAggregater extends EventDispatcher {
		
		/**
		 * 登録したイベントリスナー情報を取得します。
		 */
		private var _dispatchers:Dictionary;
		
		/**
		 * 登録したイベントリスナー数を取得します。
		 */
		private var _numDispatchers:int = 0;
		
		
		
		
		
		/**
		 * <p>新しい EventAggregater インスタンスを作成します。</p>
		 * <p>Creates a new EventAggregater object.</p>
		 */
		public function EventAggregater() {
			// Dictionary を作成する
			_dispatchers = new Dictionary();
		}
		
		
		
		
		
		/**
		 * <p>IEventDispatcher インスタンスを登録します。</p>
		 * <p>Register the IEventDispatcher instance.</p>
		 * 
		 * @see #removeEventDispatcher()
		 * 
		 * @param target
		 * <p>登録したい IEventDispatcher インスタンスです。</p>
		 * <p>The IEventDispatcher instance to register.</p>
		 * @param type
		 * <p>登録したいイベントタイプです。</p>
		 * <p>The event type to register.</p>
		 * @param priority
		 * <p>登録したいイベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</p>
		 * <p>The priority level of the event listener to register. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.</p>
		 * @param useWeakReference
		 * <p>登録したいリスナーへの参照が強参照と弱参照のいずれであるかを判断します。デフォルトである強参照の場合は、リスナーのガベージコレクションが回避されます。弱参照では回避されません。</p>
		 * <p>Determines whether the reference to the listener is strong or weak to register. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.</p>
		 */
		public function addEventDispatcher( dispatcher:IEventDispatcher, type:String, useCapture:Boolean = false, priority:int = 0 ):void {
			// 既存のイベントディスパッチャー登録があれば削除する
			removeEventDispatcher( dispatcher, type, useCapture );
			
			// dispatcher の情報を保存する
			_numDispatchers++;
			_dispatchers[_numDispatchers] = {
				id					:_numDispatchers,
				dispatcher			:dispatcher,
				type				:type,
				useCapture			:useCapture,
				priority			:priority,
				dispatched			:false
			};
			
			// イベントリスナーを登録する
			dispatcher.addEventListener( type, _aggregate, useCapture, priority );
		}
		
		/**
		 * <p>IEventDispatcher インスタンスの登録を削除します。</p>
		 * <p>Remove the registered IEventDispatcher instance.</p>
		 * 
		 * @see #addEventDispatcher()
		 * 
		 * @param target
		 * <p>削除したい EventDispatcher インスタンスです。</p>
		 * <p>The IEventDispatcher instance to remove.</p>
		 * @param type
		 * <p>削除したいイベントタイプです。</p>
		 * <p>The event type to remove.</p>
		 * @param useCapture
		 * <p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</p>
		 * <p>Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</p>
		 */
		public function removeEventDispatcher( dispatcher:IEventDispatcher, type:String, useCapture:Boolean = false ):void {
			for each ( var o:Object in _dispatchers ) {
				// 値が違っていれば次へ
				if ( o.dispatcher != dispatcher ) { continue; }
				if ( o.type != type ) { continue; }
				if ( o.useCapture != useCapture ) { continue; }
				
				// イベントリスナーを削除する
				dispatcher.removeEventListener( type, _aggregate, useCapture );
				
				// 情報を削除する
				delete _dispatchers[o.id];
				
				break;
			}
		}
		
		/**
		 * <p>登録済みのイベントを全て未発生状態に設定します。</p>
		 * <p>Set the whole registered event as unsent.</p>
		 */
		public function reset():void {
			// イベント発生を無効化する
			for each ( var o:Object in _dispatchers ) {
				o.dispatched = false;
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
		public override function toString():String {
			return "[object EventAggregater]";
		}
		
		
		
		
		
		/**
		 * 任意のイベントの送出を受け取ります。
		 */
		private function _aggregate( e:Event ):void {
			// イベントディスパッチャー情報を走査する
			for each ( var o:Object in _dispatchers ) {
				// 設定値が違っていれば次へ
				if ( o.dispatcher != e.target ) { continue; }
				if ( o.type != e.type ) { continue; }
				
				// イベント発生を有効化する
				o.dispatched = true;
				break;
			}
			
			// イベントが発生していなければ終了する
			for each ( o in _dispatchers ) {
				if ( !o.dispatched ) { return; }
			}
			
			// イベントを送出する
			super.dispatchEvent( new Event( Event.COMPLETE ) );
		}
	}
}
