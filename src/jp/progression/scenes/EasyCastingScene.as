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
package jp.progression.scenes {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ObjectUtil;
	import jp.nium.utils.StringUtil;
	import jp.progression.commands.display.AddChild;
	import jp.progression.commands.display.AddChildAt;
	import jp.progression.commands.display.RemoveChild;
	import jp.progression.commands.lists.ParallelList;
	import jp.progression.core.casts.EasyCastingContainer;
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.events.DataProvideEvent;
	import jp.progression.events.SceneEvent;
	import jp.progression.executors.CommandExecutor;
	import jp.progression.Progression;
	
	/**
	 * <p>EasyCastingScene クラスは、拡張された PRML 形式の XML データを使用して ActionScript を使用しないコンポーネントベースの開発スタイルを提供するクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // EasyCastingScene インスタンスを作成する
	 * var scene:EasyCastingScene = new EasyCastingScene();
	 * </listing>
	 */
	public class EasyCastingScene extends SceneObject {
		
		/**
		 * すべてのインスタンスを保持した Dictionary インスタンスを取得します。
		 */
		private static var _instances:Dictionary = new Dictionary();
		
		/**
		 * 現在表示しているインスタンスを保持した Dictionary インスタンスを取得します。
		 */
		private static var _displayingList:Dictionary = new Dictionary();
		
		/**
		 * コンテナインスタンスを保持した Dictionary インスタンスを取得します。
		 */
		private static var _containers:Dictionary = new Dictionary();
		
		
		
		
		
		/**
		 * <p>自身に移動した際に表示させる表示オブジェクトを保持した配列を取得します。</p>
		 * <p></p>
		 */
		public function get casts():Array { return _casts.slice(); }
		private var _casts:Array;
		
		/**
		 * キャストオブジェクトのクラス名をキーとして、パラメータを保持した Dictionary インスタンスを取得します。
		 */
		private var _castParameters:Dictionary;
		
		
		
		
		
		/**
		 * <p>新しい EasyCastingScene インスタンスを作成します。</p>
		 * <p>Creates a new EasyCastingScene object.</p>
		 * 
		 * @param name
		 * <p>シーンの名前です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function EasyCastingScene( name:String = null, initObject:Object = null ) {
			// 初期化する
			_casts = [];
			_castParameters = new Dictionary();
			
			// 親クラスを初期化する
			super( name, initObject );
			
			// Progression が CommandExecutor を実装していなければ例外をスローする
			if ( Progression.config.executor != CommandExecutor ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_017 ).toString( className, "CommandExecutor" ) ); }
			
			// イベントリスナーを登録する
			super.addEventListener( SceneEvent.SCENE_INIT, _sceneInit, false, 0, true );
			super.addEventListener( SceneEvent.SCENE_ADDED_TO_ROOT, _sceneAddedToRoot, false, 0, true );
			super.addEventListener( SceneEvent.SCENE_REMOVED_FROM_ROOT, _sceneRemovedFromRoot, false, 0, true );
		}
		
		
		
		
		
		/**
		 * <p>XML データが EasyCasting 拡張 PRML フォーマットに準拠しているかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @param prml
		 * <p>フォーマットを検査したい XML データです。</p>
		 * <p></p>
		 * @return
		 * <p>フォーマットが合致すれば true を、合致しなければ false となります。</p>
		 * <p></p>
		 */
		public static function validate( prml:XML ):Boolean {
			prml = new XML( prml.toXMLString() );
			
			// コンテンツタイプを確認する
			switch ( String( prml.attribute( "type" ) ) ) {
				case "text/easycasting"			:
				case "text/prml.easycasting"	: { break; }
				default							: { return false; }
			}
			
			// 必須プロパティを精査する
			for each ( var cast:XML in prml..cast ) {
				if ( !String( cast.attribute( "cls" ) ) ) { return false; }
			}
			
			// PRML として評価する
			prml.@type = "text/prml.plain";
			
			return SceneObject.validate( prml );
		}
		
		
		
		
		
		/**
		 * <p>この SceneObject インスタンスの子を PRML 形式の XML データから追加します。</p>
		 * <p></p>
		 * 
		 * @param prml
		 * <p>PRML 形式の XML データです。</p>
		 * <p></p>
		 */
		public override function addSceneFromXML( prml:XML ):void {
			// PRML のフォーマットが正しくなければ例外をスローする
			if ( !validate( prml ) ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_005 ).toString( "PRML" ) ); }
			
			// <scene> の cls を上書する
			for each ( var scene:XML in prml..scene ) {
				scene.@cls = "jp.progression.scenes.EasyCastingScene";
			}
			
			// 親のメソッドを実行する
			super.addSceneFromXML( prml );
		}
		
		
		
		
		
		/**
		 * シーンオブジェクト自身が目的地だった場合に、到達した瞬間に送出されます。
		 */
		private function _sceneInit( e:Event ):void {
			// コンテナを作成する
			_containers[super.container] ||= new EasyCastingContainer( this );
			var container:EasyCastingContainer = _containers[super.container];
			
			// コンテナが登録されていなければ登録する
			if ( !super.container.contains( container ) ) {
				super.container.addChild( container );
			}
			
			// コマンドリストを作成する
			var addChildList:ParallelList = new ParallelList();
			var removeChildList:ParallelList = new ParallelList();
			
			// すでに表示されている対象を検索する
			for ( var cls:String in _displayingList ) {
				// 登録されていれば次へ
				if ( _castParameters[cls] ) { continue; }
				
				// コマンドを追加する
				removeChildList.addCommand( new RemoveChild( container, _displayingList[cls] ) );
				
				// 登録から削除する
				delete _displayingList[cls];
			}
			
			// 現在のシーンで必要な対象を追加する
			for ( var cast:String in _castParameters ) {
				// インスタンスを取得する
				var instance:Sprite = _instances[cast];
				
				// プロパティを設定する
				ObjectUtil.setProperties( instance, _castParameters[cast] );
				
				// インデックスを取得する
				var index:String = _castParameters[cast].index;
				
				// コマンドを追加する
				if ( index ) {
					addChildList.addCommand( new AddChildAt( container, instance, parseInt( index ) ) );
				}
				else {
					addChildList.addCommand( new AddChild( container, instance ) );
				}
				
				// 表示中リストに登録する
				_displayingList[cast] = instance;
			}
			
			// コマンドを追加する
			super.addCommand( removeChildList, addChildList );
		}
		
		/**
		 * シーンオブジェクトが直接、またはシーンオブジェクトを含むサブツリーの追加により、ルートシーン上のシーンリストに追加されたときに送出されます。
		 */
		private function _sceneAddedToRoot( e:Event ):void {
			if ( super.dataHolder ) {
				super.dataHolder.addEventListener( DataProvideEvent.DATA_UPDATE, _update, false, 0, true );
			}
		}
		
		/**
		 * シーンオブジェクトが直接、またはシーンオブジェクトを含むサブツリーの削除により、ルートシーン上のシーンリストから削除されようとしているときに送出されます。
		 */
		private function _sceneRemovedFromRoot( e:Event ):void {
			if ( super.dataHolder ) {
				super.dataHolder.removeEventListener( DataProvideEvent.DATA_UPDATE, _update );
			}
		}
		
		/**
		 * 管理するデータが更新された場合に送出されます。
		 */
		private function _update( e:DataProvideEvent ):void {
			// データを取得する
			var xml:XML = new XML( super.toXMLString() );
			
			// cast を取得する
			_castParameters = new Dictionary();
			for each ( var cast:XML in xml.cast ) {
				var o:Object = {};
				
				// アトリビュートを取得する
				for each ( var attribute:XML in cast.attributes() ) {
					o[String( attribute.name() )] = StringUtil.toProperType( attribute );
				}
				
				_castParameters[String( cast.@cls )] = o;
			}
			
			// インスタンスを作成する
			_casts = [];
			for ( var clsPath:String in _castParameters ) {
				try {
					// クラスの参照を取得する
					var cls:Class = getDefinitionByName( clsPath ) as Class;
					
					// インスタンスを生成する
					_instances[clsPath] ||= new cls();
					
					// リストに追加する
					_casts.push( clsPath );
				}
				catch ( e:Error ) {
					// 警告を表示する
					Logger.warn( Logger.getLog( L10NProgressionMsg.ERROR_018 ).toString( clsPath ) );
					
					// 登録を破棄する
					delete _castParameters[clsPath];
				}
			}
		}
	}
}
