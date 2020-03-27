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
	import jp.nium.models.Model;
	
	/**
	 * <p>ModelEvent クラスは、モデルオブジェクトの管理する値が状態が変更される直前や変更された直後に Model インスタンスによって送出されます。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // ModelEvent インスタンスを作成する
	 * var event:ModelEvent = new ModelEvent();
	 * </listing>
	 */
	public class ModelEvent extends Event {
		
		/**
		 * <p>modelAdded イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ModelEvent.MODEL_ADDED constant defines the value of the type property of an modelAdded event object.</p>
		 */
		public static const MODEL_ADDED:String = "modelAdded";
		
		/**
		 * <p>modelRemoved イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ModelEvent.MODEL_REMOVED constant defines the value of the type property of an modelRemoved event object.</p>
		 */
		public static const MODEL_REMOVED:String = "modelRemoved";
		
		/**
		 * <p>modelUpdateBefore イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ModelEvent.MODEL_UPDATE_BEFORE constant defines the value of the type property of an modelUpdateBefore event object.</p>
		 */
		public static const MODEL_UPDATE_BEFORE:String = "modelUpdateBefore";
		
		/**
		 * <p>modelUpdateSuccess イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ModelEvent.MODEL_UPDATE_SUCCESS constant defines the value of the type property of an modelUpdateSuccess event object.</p>
		 */
		public static const MODEL_UPDATE_SUCCESS:String = "modelUpdateSuccess";
		
		/**
		 * <p>modelUpdateFailure イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ModelEvent.MODEL_UPDATE_FAILURE constant defines the value of the type property of an modelUpdateFailure event object.</p>
		 */
		public static const MODEL_UPDATE_FAILURE:String = "modelUpdateFailure";
		
		
		
		
		
		/**
		 * <p>データ変更処理の対象となる Model インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get modelTarget():Model { return _modelTarget; }
		private var _modelTarget:Model;
		
		/**
		 * <p>変更される Model インスタンスのプロパティ名を取得します。</p>
		 * <p></p>
		 */
		public function get dataName():String { return _dataName; }
		private var _dataName:String;
		
		/**
		 * <p>変更前のデータを取得します。</p>
		 * <p></p>
		 */
		public function get oldData():* { return _oldData; }
		private var _oldData:*;
		
		/**
		 * <p>変更後のデータを取得します。</p>
		 * <p></p>
		 */
		public function get newData():* { return _newData; }
		private var _newData:*;
		
		
		
		
		
		/**
		 * <p>新しい ModelEvent インスタンスを作成します。</p>
		 * <p>Creates a new ModelEvent object.</p>
		 * 
		 * @param type
		 * <p>ModelEvent.type としてアクセス可能なイベントタイプです。</p>
		 * <p>The type of the event, accessible as ModelEvent.type.</p>
		 * @param bubbles
		 * <p>ModelEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the ModelEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * <p>ModelEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the ModelEvent object can be canceled. The default values is false.</p>
		 * @param modelTarget
		 * <p>データ変更処理の対象となる Model インスタンスです。</p>
		 * <p></p>
		 * @param dataName
		 * <p>変更される Model インスタンスのプロパティ名です。</p>
		 * <p></p>
		 * @param oldData
		 * <p>>変更前のデータです。</p>
		 * <p></p>
		 * @param newData
		 * <p>変更後のデータです。</p>
		 * <p></p>
		 */
		public function ModelEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, modelTarget:Model = null, dataName:String = null, oldData:* = null, newData:* = null ) {
			// 親クラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_modelTarget = modelTarget;
			_dataName = dataName;
			_oldData = oldData;
			_newData = newData;
		}
		
		
		
		
		
		/**
		 * <p>ModelEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an ModelEvent subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい ModelEvent インスタンスです。</p>
		 * <p>A new ModelEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new ModelEvent( super.type, super.bubbles, super.cancelable, _modelTarget, _dataName, _oldData, _newData );
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
			return super.formatToString( "ModelEvent", "type", "bubbles", "cancelable", "modelTarget", "dataName", "oldData", "newData" );
		}
	}
}
