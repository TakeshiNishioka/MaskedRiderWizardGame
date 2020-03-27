﻿/**
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
	 * <p>DataHolder インスタンスが管理するデータに対して各種操作が行われた場合に DataProvideEvent オブジェクトが送出されます。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // DataProvideEvent インスタンスを作成する
	 * var event:DataProvideEvent = new DataProvideEvent();
	 * </listing>
	 */
	public class DataProvideEvent extends Event {
		
		/**
		 * <p>dataUpdate イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The DataProvideEvent.DATA_UPDATE constant defines the value of the type property of an dataUpdate event object.</p>
		 */
		public static const DATA_UPDATE:String = "dataUpdate";
		
		
		
		
		
		/**
		 * <p>以前に設定されていた古いデータを取得します。</p>
		 * <p></p>
		 */
		public function get oldData():* { return _oldData; }
		private var _oldData:*;
		
		/**
		 * <p>新しく設定されるデータを取得します。</p>
		 * <p></p>
		 */
		public function get newData():* { return _newData; }
		private var _newData:*;
		
		
		
		
		
		/**
		 * <p>新しい DataProvideEvent インスタンスを作成します。</p>
		 * <p>Creates a new DataProvideEvent object.</p>
		 * 
		 * @param type
		 * <p>DataProvideEvent.type としてアクセス可能なイベントタイプです。</p>
		 * <p>The type of the event, accessible as DataProvideEvent.type.</p>
		 * @param bubbles
		 * <p>DataProvideEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the DataProvideEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * <p>DataProvideEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the DataProvideEvent object can be canceled. The default values is false.</p>
		 * @param oldData
		 * <p>以前に設定されていた古いデータです。</p>
		 * <p></p>
		 * @param newData
		 * <p>新しく設定されるデータです。</p>
		 * <p></p>
		 */
		public function DataProvideEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, oldData:* = null, newData:* = null ) {
			// 親クラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_oldData = oldData;
			_newData = newData;
		}
		
		
		
		
		
		/**
		 * <p>DataProvideEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an DataProvideEvent subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい DataProvideEvent インスタンスです。</p>
		 * <p>A new DataProvideEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new DataProvideEvent( super.type, super.bubbles, super.cancelable, _oldData, _newData );
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
			return super.formatToString( "DataProvideEvent", "type", "bubbles", "cancelable" );
		}
	}
}
