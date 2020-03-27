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
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	/**
	 * <p></p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // ExecuteErrorEvent インスタンスを作成する
	 * var event:ExecuteErrorEvent = new ExecuteErrorEvent();
	 * </listing>
	 */
	public class ExecuteErrorEvent extends ErrorEvent {
		
		/**
		 * <p>error イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ExecuteErrorEvent.EXECUTE_ERROR constant defines the value of the type property of an error event object.</p>
		 */
		public static const EXECUTE_ERROR:String = "executeError";
		
		
		
		
		
		/**
		 * <p>例外が送出された際の対象オブジェクトを取得します。</p>
		 * <p></p>
		 */
		public function get errorTarget():* { return _errorTarget; }
		private var _errorTarget:*;
		
		/**
		 * <p>オブジェクトからスローされた例外を取得します。</p>
		 * <p></p>
		 */
		public function get errorObject():Error { return _errorObject; }
		private var _errorObject:Error;
		
		
		
		
		
		/**
		 * <p>新しい ExecuteErrorEvent インスタンスを作成します。</p>
		 * <p>Creates a new ExecuteErrorEvent object.</p>
		 * 
		 * @param type
		 * <p>ExecuteErrorEvent.type としてアクセス可能なイベントタイプです。</p>
		 * <p>The type of the event, accessible as ExecuteErrorEvent.type.</p>
		 * @param bubbles
		 * <p>ExecuteErrorEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the ExecuteErrorEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * <p>ExecuteErrorEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the ExecuteErrorEvent object can be canceled. The default values is false.</p>
		 * @param errorTarget
		 * <p>例外が送出された際の対象オブジェクトです。</p>
		 * <p></p>
		 * @param errorObject
		 * <p>オブジェクトからスローされた例外です。</p>
		 * <p></p>
		 */
		public function ExecuteErrorEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, errorTarget:* = null, errorObject:Error = null ) {
			// 親クラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_errorTarget = errorTarget;
			_errorObject = errorObject;
		}
		
		
		
		
		
		/**
		 * <p>ExecuteErrorEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an ExecuteErrorEvent subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい ExecuteErrorEvent インスタンスです。</p>
		 * <p>A new ExecuteErrorEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new ExecuteErrorEvent( super.type, super.bubbles, super.cancelable, _errorTarget, _errorObject );
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
			return super.formatToString( "ExecuteErrorEvent", "type", "bubbles", "cancelable", "errorTarget", "errorObject" );
		}
	}
}
