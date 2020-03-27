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
package jp.progression.loader {
	import flash.display.Stage;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.core.ns.nium_internal;
	import jp.nium.core.primitives.StringObject;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.Progression;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.scenes.SceneObject;
	
	/**
	 * <p>PRMLLoader クラスは、読み込んだ PRML 形式の XML ファイルから自動的に、Progression インスタンスを作成するローダークラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // PRMLLoader インスタンスを作成する
	 * var loader:PRMLLoader = new PRMLLoader();
	 * </listing>
	 */
	public class PRMLLoader extends URLLoader {
		
		// クラスをコンパイルに含める
		SceneObject;
		
		
		
		
		
		/**
		 * <p>インスタンスのクラス名を取得します。</p>
		 * <p>Indicates the instance className of the SceneObject.</p>
		 */
		public function get className():String { return _classNameObj ? _classNameObj.toString() : ClassUtil.nium_internal::$DEFAULT_CLASS_NAME; }
		private var _classNameObj:StringObject;
		
		/**
		 * <p>関連付けられている Progression インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.events.ManagerEvent#MANAGER_ACTIVATE
		 * @see jp.progression.events.ManagerEvent#MANAGER_DEACTIVATE
		 */
		public function get manager():Progression { return _manager; }
		private var _manager:Progression;
		
		/**
		 * <p>関連付けられている Stage インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get stage():Stage { return _stage; }
		private var _stage:Stage;
		
		/**
		 * <p>読み込み完了後に自動的にシーン移動を開始するかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		public function get autoGoto():Boolean { return _autoGoto; }
		public function set autoGoto( value:Boolean ):void { _autoGoto = value; }
		private var _autoGoto:Boolean = true;
		
		
		
		
		
		/**
		 * <p>新しい PRMLLoader インスタンスを作成します。</p>
		 * <p>Creates a new PRMLLoader object.</p>
		 * 
		 * @param stage
		 * <p>関連付けたい Stage インスタンスです。</p>
		 * <p></p>
		 * @param request
		 * <p>ダウンロードする URL を指定する URLRequest オブジェクトです。このパラメータを省略すると、ロード操作は開始されません。指定すると、直ちにロード操作が開始されます。詳細については、load を参照してください。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function PRMLLoader( stage:Stage, request:URLRequest = null, initObject:Object = null ) {
			// クラス名を取得する
			_classNameObj = ClassUtil.nium_internal::$getClassString( this );
			
			// 引数を設定する
			_stage = stage;
			
			// 初期化する
			ObjectUtil.setProperties( this, initObject );
			
			// request が存在すれば読み込む
			if ( request ) {
				load( request );
			}
		}
		
		
		
		
		
		/**
		 * <p>指定された URL からデータを送信およびロードします。</p>
		 * <p></p>
		 * 
		 * @param request
		 * <p>ダウンロードする URL を指定する URLRequest オブジェクトです。</p>
		 * <p></p>
		 */
		public override function load( request:URLRequest ):void {
			// すでに Progression が生成されていれば
			if ( _manager ) {
				_manager.progression_internal::$dispose();
				_manager = null;
			}
			
			// イベントリスナーを登録する
			super.addEventListener( Event.COMPLETE, _complete, false, int.MAX_VALUE );
			super.addEventListener( IOErrorEvent.IO_ERROR, _ioError, false, int.MAX_VALUE );
			
			// 親のメソッドを実行する
			super.load( request );
		}
		
		/**
		 * <p>XML データから Progression インスタンスを作成します。</p>
		 * <p></p>
		 * 
		 * @param xml
		 * <p>生成に使用する XML データです。</p>
		 * <p></p>
		 * @return
		 * <p>生成された Progression インスタンスです。</p>
		 * <p></p>
		 */
		public function parse( xml:XML ):Progression {
			// XML の構文が間違っていれば例外をスローする
			if ( !SceneObject.validate( xml ) ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_016 ).toString( "XML" ) ); }
			
			return Progression.createFromXML( _stage, xml );
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
			return ObjectUtil.formatToString( this, _classNameObj.toString(), "autoGoto" );
		}
		
		
		
		
		
		/**
		 * データが正常にロードされたときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// イベントリスナーを解除する
			super.removeEventListener( Event.COMPLETE, _complete );
			super.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			
			// Progression を作成する
			_manager = parse( new XML( data ) );
			
			// 自動移動が有効化されていれば
			if ( _autoGoto ) {
				// 初期シーンに移動する
				if ( _manager.sync ) {
					_manager.goto( _manager.syncedSceneId );
				}
				else {
					_manager.goto( _manager.root.sceneId );
				}
			}
		}
		
		/**
		 * 入出力エラーが発生して読み込み処理が失敗したときに送出されます。
		 */
		private function _ioError( e:IOErrorEvent ):void {
			// イベントリスナーを解除する
			super.removeEventListener( Event.COMPLETE, _complete );
			super.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			
			// 例外をスローする
			throw new IOError( e.text );
		}
	}
}
