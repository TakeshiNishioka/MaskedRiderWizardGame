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
package jp.nium.models {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import jp.nium.collections.UniqueList;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.events.ModelEvent;
	import jp.nium.utils.ArrayUtil;
	import jp.nium.utils.MovieClipUtil;
	import jp.nium.utils.ObjectUtil;
	
	/**
	 * <p>モデルオブジェクトがモデルリストに追加されたときに送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.nium.events.ModelEvent.MODEL_ADDED
	 */
	[Event( name="modelAdded", type="jp.nium.events.ModelEvent" )]
	
	/**
	 * <p>モデルオブジェクトがモデルリストから削除されようとしているときに送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.nium.events.ModelEvent.MODEL_REMOVED
	 */
	[Event( name="modelRemoved", type="jp.nium.events.ModelEvent" )]
	
	/**
	 * <p>モデルオブジェクトが管理する値が更新される直前に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.nium.events.ModelEvent.MODEL_UPDATE_BEFORE
	 */
	[Event( name="modelUpdateBefore", type="jp.nium.events.ModelEvent" )]
	
	/**
	 * <p>モデルオブジェクトが管理する値の更新に成功した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.nium.events.ModelEvent.MODEL_UPDATE_SUCCESS
	 */
	[Event( name="modelUpdateSuccess", type="jp.nium.events.ModelEvent" )]
	
	/**
	 * <p>モデルオブジェクトが管理する値の更新に失敗した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.nium.events.ModelEvent.MODEL_UPDATE_FAILURE
	 */
	[Event( name="modelUpdateFailure", type="jp.nium.events.ModelEvent" )]
	
	/**
	 * <p>Model クラスは、データの状態を管理し、データ構造の入出力をサポートするモデルクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class Model extends EventDispatcher {
		
		/**
		 * 親となる Model インスタンスの参照を取得します。
		 */
		private var _parent:Model;
		
		/**
		 * 子として登録されている Model インスタンスを含む UniqueList インスタンスを取得します。
		 */
		private var _models:UniqueList;
		
		
		
		
		
		/**
		 * <p>新しい Model インスタンスを作成します。</p>
		 * <p>Creates a new Model object.</p>
		 */
		public function Model() {
			// 初期化する
			_models = new UniqueList();
		}
		
		
		
		
		
		/**
		 * <p>この Model インスタンスに子 Model インスタンスを追加します。</p>
		 * <p></p>
		 * 
		 * @param model
		 * <p>対象の Model インスタンスの子として追加する Model インスタンスです。</p>
		 * <p>The Model instance to add as a scene of this Model instance.</p>
		 * @return
		 * <p>model パラメータで渡す Model インスタンスです。</p>
		 * <p>The Model instance that you pass in the model parameter.</p>
		 */
		protected function _addModel( model:Model ):Model {
			if ( model._parent ) {
				model._parent._removeModel( model );
			}
			
			_models.addItem( model );
			
			model._parent = this;
			
			model.addEventListener( ModelEvent.MODEL_UPDATE_BEFORE, super.dispatchEvent );
			model.addEventListener( ModelEvent.MODEL_UPDATE_SUCCESS, super.dispatchEvent );
			model.addEventListener( ModelEvent.MODEL_UPDATE_FAILURE, super.dispatchEvent );
			
			super.dispatchEvent( new ModelEvent( ModelEvent.MODEL_ADDED, false, true, this ) );
			
			return model;
		}
		
		/**
		 * <p>Model インスタンスの子リストから指定の Model インスタンスを削除します。</p>
		 * <p>Removes the specified child Model instance from the model list of the Model instance.</p>
		 * 
		 * @param model
		 * <p>対象の Model インスタンスの子から削除する Model インスタンスです。</p>
		 * <p>The Model instance to remove.</p>
		 * @return
		 * <p>model パラメータで渡す Model インスタンスです。</p>
		 * <p>The Model instance that you pass in the model parameter.</p>
		 */
		protected function _removeModel( model:Model ):Model {
			_models.removeItem( model );
			
			model._parent = null;
			
			model.removeEventListener( ModelEvent.MODEL_UPDATE_BEFORE, super.dispatchEvent );
			model.removeEventListener( ModelEvent.MODEL_UPDATE_SUCCESS, super.dispatchEvent );
			model.removeEventListener( ModelEvent.MODEL_UPDATE_FAILURE, super.dispatchEvent );
			
			super.dispatchEvent( new ModelEvent( ModelEvent.MODEL_REMOVED, false, true, this ) );
			
			return model;
		}
		
		/**
		 * <p>指定されたモデルオブジェクトが Model インスタンスの子であるか、オブジェクト自体であるかを指定します。</p>
		 * <p>Determines whether the specified Model is a model of the Model instance or the instance itself.</p>
		 * 
		 * @param model
		 * <p>テストする子 Model インスタンスです。</p>
		 * <p>The model object to test.</p>
		 * @return
		 * <p>scene インスタンスが Model の子であるか、コンテナ自体である場合は true となります。そうでない場合は false となります。</p>
		 * <p>true if the model object is a scene of the Model or the container itself; otherwise false.</p>
		 */
		protected function _contains( model:Model ):Boolean {
			return _models.contains( model );
		}
		
		/**
		 * <p>指定されたプロパティの変更動作を問い合わせ、結果をイベントとして通知します。</p>
		 * <p></p>
		 * 
		 * @param name
		 * <p>評価したいプロパティを示すストリングです。</p>
		 * <p></p>
		 * @param oldData
		 * <p>現在のプロパティ値です。</p>
		 * <p></p>
		 * @param newData
		 * <p>新しいプロパティ値です。</p>
		 * <p></p>
		 * @return
		 * <p>評価の結果、問題がなければ新しいプロパティ値を、そうでなければ以前のプロパティ値を返します。</p>
		 * <p></p>
		 */
		protected function _evaluate( name:String, oldData:*, newData:* ):* {
			// 更新されていなければそのまま返す
			if ( oldData == newData ) { return newData; }
			
			// 同一の中身を持つ Array であればそのまま返す
			if ( oldData is Array && newData is Array && ArrayUtil.equals( oldData, newData ) ) { return newData; }
			
			// イベントを送出して、キャンセルされたら終了する
			if ( !super.dispatchEvent( new ModelEvent( ModelEvent.MODEL_UPDATE_BEFORE, false, true, this, name, oldData, newData ) ) ) {
				// 1 フレーム後に失敗を通知する
				MovieClipUtil.doLater( null, super.dispatchEvent, new ModelEvent( ModelEvent.MODEL_UPDATE_FAILURE, false, true, this, name, oldData, oldData ) );
				
				return oldData;
			}
			
			// 1 フレーム後に成功を通知する
			MovieClipUtil.doLater( null, _verify, name, oldData, newData );
			
			return newData;
		}
		
		/**
		 * プロパティ値が正しく更新されているかどうかを評価します。
		 */
		private function _verify( name:String, oldData:*, newData:* ):void {
			var value:* = this[name];
			var result:Boolean = false;
			
			// 型によって比較方法を変更する
			switch ( true ) {
				case value is Array		: { result = ArrayUtil.equals( value as Array, newData as Array ); break; }
				default					: { result = ( value == newData ); }
			}
			
			// 値が正しく更新されていれば
			if ( result ) {
				super.dispatchEvent( new ModelEvent( ModelEvent.MODEL_UPDATE_SUCCESS, false, true, this, name, newData, newData ) );
			}
			else {
				super.dispatchEvent( new ModelEvent( ModelEvent.MODEL_UPDATE_FAILURE, false, true, this, name, oldData, oldData ) );
			}
		}
		
		/**
		 * @private
		 */
		public override function dispatchEvent( event:Event ):Boolean {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "dispatchEvent" ) );
		}
		
		/**
		 * <p>Model インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Model subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい Model インスタンスです。</p>
		 * <p>A new Model object that is identical to the original.</p>
		 */
		public function clone():Model {
			return new Model();
		}
		
		/**
		 * <p>指定されたオブジェクトの XML 表現を返します。</p>
		 * <p>Returns the XML representation of the specified object.</p>
		 * 
		 * @return
		 * <p>オブジェクトの XML 表現です。</p>
		 * <p>A XML representation of the object.</p>
		 */
		public function toXML():XML {
			return new XML();
		}
		
		/**
		 * <p>指定されたオブジェクトの XML ストリング表現を返します。</p>
		 * <p>Returns the XML string representation of the specified object.</p>
		 * 
		 * @return
		 * <p>オブジェクトの XML ストリング表現です。</p>
		 * <p>A XML string representation of the object.</p>
		 */
		public function toXMLString():String {
			return toXML().toXMLString();
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
			return ObjectUtil.formatToString( this, "Model" );
		}
	}
}
