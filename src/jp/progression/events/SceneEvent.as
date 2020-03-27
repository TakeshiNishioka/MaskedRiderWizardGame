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
	import jp.progression.core.ns.progression_internal;
	
	/**
	 * <p>対象の SceneObject オブジェクトがシーンイベントフロー上で処理ポイントに位置した場合や、状態が変化した場合に SceneEvent オブジェクトが送出されます。</p>
	 * <p></p>
	 * 
	 * @author seyself http://blog.seyself.com/
	 * 
	 * @example <listing version="3.0" >
	 * // SceneEvent インスタンスを作成する
	 * var event:SceneEvent = new SceneEvent();
	 * </listing>
	 */
	public class SceneEvent extends Event {
		
		/**
		 * <p>sceneLoad イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_LOAD constant defines the value of the type property of an sceneLoad event object.</p>
		 */
		public static const SCENE_LOAD:String = "sceneLoad";
		
		/**
		 * <p>sceneUnload イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_UNLOAD constant defines the value of the type property of an sceneUnload event object.</p>
		 */
		public static const SCENE_UNLOAD:String = "sceneUnload";
		
		/**
		 * <p>sceneInit イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_INIT constant defines the value of the type property of an sceneInit event object.</p>
		 */
		public static const SCENE_INIT:String = "sceneInit";
		
		/**
		 * <p>sceneInitComplete イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_INIT_COMPLETE constant defines the value of the type property of an sceneInitComplete event object.</p>
		 */
		public static const SCENE_INIT_COMPLETE:String = "sceneInitComplete";
		
		/**
		 * <p>sceneGoto イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_GOTO constant defines the value of the type property of an sceneGoto event object.</p>
		 */
		public static const SCENE_GOTO:String = "sceneGoto";
		
		/**
		 * <p>sceneDescend イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_DESCEND constant defines the value of the type property of an sceneDescend event object.</p>
		 */
		public static const SCENE_DESCEND:String = "sceneDescend";
		
		/**
		 * <p>sceneAscend イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_ASCEND constant defines the value of the type property of an sceneAscend event object.</p>
		 */
		public static const SCENE_ASCEND:String = "sceneAscend";
		
		/**
		 * <p>scenePreLoad イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_PRE_LOAD constant defines the value of the type property of an scenePreLoad event object.</p>
		 */
		public static const SCENE_PRE_LOAD:String = "scenePreLoad";
		
		/**
		 * <p>scenePostUnload イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_POST_UNLOAD constant defines the value of the type property of an scenePostUnload event object.</p>
		 */
		public static const SCENE_POST_UNLOAD:String = "scenePostUnload";
		
		/**
		 * <p>sceneAdded イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_ADDED constant defines the value of the type property of an sceneAdded event object.</p>
		 */
		public static const SCENE_ADDED:String = "sceneAdded";
		
		/**
		 * <p>sceneAddedToRoot イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_ADDED_TO_ROOT constant defines the value of the type property of an sceneAddedToRoot event object.</p>
		 */
		public static const SCENE_ADDED_TO_ROOT:String = "sceneAddedToRoot";
		
		/**
		 * <p>sceneRemoved イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_REMOVED constant defines the value of the type property of an sceneRemoved event object.</p>
		 */
		public static const SCENE_REMOVED:String = "sceneRemoved";
		
		/**
		 * <p>sceneRemovedFromRoot イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_REMOVED_FROM_ROOT constant defines the value of the type property of an sceneRemovedFromRoot event object.</p>
		 */
		public static const SCENE_REMOVED_FROM_ROOT:String = "sceneRemovedFromRoot";
		
		/**
		 * <p>sceneTitleChange イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_TITLE_CHANGE constant defines the value of the type property of an sceneTitleChange event object.</p>
		 */
		public static const SCENE_TITLE_CHANGE:String = "sceneTitleChange";
		
		/**
		 * <p>sceneQueryChange イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_QUERY_CHANGE constant defines the value of the type property of an sceneQueryChange event object.</p>
		 */
		public static const SCENE_QUERY_CHANGE:String = "sceneQueryChange";
		
		
		
		
		
		/**
		 * <p>イベント発生時のカレントイベントタイプを取得します。</p>
		 * <p>The object that is actively processing the Event object with an event listener.</p>
		 */
		public function get targetEventType():String { return _targetEventType; }
		private var _targetEventType:String;
		
		/**
		 * <p>イベントターゲットです。</p>
		 * <p>The event target.</p>
		 */
		public override function get target():Object { return super.target && progression_internal::$target || super.target; }
		
		/**
		 * @private
		 */
		progression_internal var $target:Object;
		
		/**
		 * <p>イベントリスナーで Event オブジェクトをアクティブに処理しているオブジェクトです。</p>
		 * <p></p>
		 */
		public override function get currentTarget():Object { return super.currentTarget && progression_internal::$currentTarget || super.currentTarget; }
		
		/**
		 * @private
		 */
		progression_internal var $currentTarget:Object;
		
		/**
		 * <p>イベントフローの現在の段階です。</p>
		 * <p>The current phase in the event flow.</p>
		 */
		public override function get eventPhase():uint  { return progression_internal::$eventPhase || super.eventPhase; }
		
		/**
		 * @private
		 */
		progression_internal var $eventPhase:uint = 0;
		
		
		
		
		
		/**
		 * <p>新しい SceneEvent インスタンスを作成します。</p>
		 * <p>Creates a new SceneEvent object.</p>
		 * 
		 * @param type
		 * <p>SceneEvent.type としてアクセス可能なイベントタイプです。</p>
		 * <p>The type of the event, accessible as SceneEvent.type.</p>
		 * @param bubbles
		 * <p>SceneEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the SceneEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * <p>SceneEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * <p>Determines whether the SceneEvent object can be canceled. The default values is false.</p>
		 * @param targetEventType
		 * <p>イベント発生時のカレントイベントタイプです。</p>
		 * <p></p>
		 */
		public function SceneEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, targetEventType:String = null ) {
			// 親クラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_targetEventType = targetEventType;
		}
		
		
		
		
		
		/**
		 * <p>SceneEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an SceneEvent subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい SceneEvent インスタンスです。</p>
		 * <p>A new SceneEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new SceneEvent( super.type, super.bubbles, super.cancelable, _targetEventType );
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
			return super.formatToString( "SceneEvent", "type", "bubbles", "cancelable", "eventPhase", "target", "currentTarget", "targetEventType" );
		}
	}
}
