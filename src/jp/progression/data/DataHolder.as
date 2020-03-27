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
package jp.progression.data {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.events.DataProvideEvent;
	import jp.progression.scenes.SceneObject;
	
	/**
	 * <p>管理するデータが更新された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType jp.progression.events.DataProvideEvent.DATA_UPDATE
	 */
	[Event( name="dataUpdate", type="jp.progression.events.DataProvideEvent" )]
	
	/**
	 * <p>DataHolder クラスは、シーンに対して汎用的なデータ管理機能を提供します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class DataHolder extends EventDispatcher {
		
		/**
		 * <p>保持しているデータを取得します。</p>
		 * <p></p>
		 */
		public function get data():* { return _data; }
		private var _data:*;
		
		/**
		 * <p>関連付けられている SceneObject インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get target():SceneObject { return _target; }
		private var _target:SceneObject;
		
		
		
		
		
		/**
		 * <p>新しい DataHolder インスタンスを作成します。</p>
		 * <p>Creates a new DataHolder object.</p>
		 * 
		 * @param target
		 * <p>関連付けたい SceneObject インスタンスです。</p>
		 * <p></p>
		 */
		public function DataHolder( target:SceneObject ) {
			// 引数を設定する
			_target = target;
		}
		
		
		
		
		
		/**
		 * <p>保持しているデータを更新します。</p>
		 * <p></p>
		 */
		public function update():void {
			var oldData:* = _data;
			
			// データを更新する
			_data = SceneObject.progression_internal::$providingData;
			SceneObject.progression_internal::$providingData = null;
			
			// イベントを送出する
			super.dispatchEvent( new DataProvideEvent( DataProvideEvent.DATA_UPDATE, false, false, oldData, _data ) );
		}
		
		/**
		 * <p>保持しているデータを解放します。
		 * dispose() メソッドが呼び出されると、それ以降はこのインスタンスのメソッドまたはプロパティを呼び出すと失敗し、例外がスローされます。</p>
		 * <p></p>
		 */
		public function dispose():void {
			// 破棄する
			_data = null;
			_target = null;
		}
		
		/**
		 * @private
		 */
		public override function dispatchEvent( event:Event ):Boolean {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_000 ).toString( "dispatchEvent" ) );
		}
	}
}
