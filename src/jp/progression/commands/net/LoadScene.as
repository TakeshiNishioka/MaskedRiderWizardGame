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
package jp.progression.commands.net {
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.SecurityDomain;
	import jp.nium.core.ns.nium_internal;
	import jp.nium.display.ExMovieClip;
	import jp.progression.commands.Command;
	import jp.progression.scenes.SceneLoader;
	
	/**
	 * <p>LoadScene クラスは、SceneLoader を使用した SWF ファイルの読み込み操作を行うコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // LoadScene インスタンスを作成する
	 * var com:LoadScene = new LoadScene();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class LoadScene extends LoadCommand {
		
		/**
		 * <p>読み込み処理に使用する SceneLoader インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get loader():SceneLoader { return _loader; }
		private var _loader:SceneLoader;
		
		/**
		 * <p>読み込まれた SWF ファイル内に作成される SceneObject インスタンスの container プロパティの値を取得します。</p>
		 * <p></p>
		 */
		public function get loaderContainer():* { return _loaderContainer; }
		private var _loaderContainer:*;
		
		/**
		 * <p>オブジェクトをロードする前に、Flash Player がクロスドメインポリシーファイルの存在を確認するかどうかを取得または指定します。
		 * ただし、読み込み処理が開始された以降は設定を変更することはできません。</p>
		 * <p></p>
		 */
		public function get checkPolicyFile():Boolean { return _checkPolicyFile; }
		public function set checkPolicyFile( value:Boolean ):void { _checkPolicyFile = value; }
		private var _checkPolicyFile:Boolean = false;
		
		/**
		 * <p>Loader オブジェクトで使用する SecurityDomain オブジェクトを取得または設定します。</p>
		 * <p></p>
		 */
		public function get securityDomain():SecurityDomain { return _securityDomain; }
		public function set securityDomain( value:SecurityDomain ):void { _securityDomain = value; }
		private var _securityDomain:SecurityDomain;
		
		/**
		 * URLRequest を取得します。
		 */
		private var _request:URLRequest;
		
		
		
		
		
		/**
		 * <p>新しい LoadScene インスタンスを作成します。</p>
		 * <p>Creates a new LoadScene object.</p>
		 * 
		 * @param request
		 * <p>読み込みたい SWF ファイルの絶対 URL または相対 URL です。</p>
		 * <p></p>
		 * @param loader
		 * <p>読み込み処理に使用する SceneLoader インスタンスです。</p>
		 * <p></p>
		 * @param loaderContainer
		 * <p>読み込まれた SWF ファイルの表示オブジェクトの基準となる Sprite インスタンス、またはインスタンスを示す識別子です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function LoadScene( request:URLRequest, loader:SceneLoader = null, loaderContainerRefOrId:* = null, initObject:Object = null ) {
			// 引数を設定する
			_request = request;
			_loader = loader;
			_loaderContainer = loaderContainerRefOrId;
			
			// 親クラスを初期化する
			super( request, initObject );
			
			// initObject が LoadScene であれば
			var com:LoadScene = initObject as LoadScene;
			if ( com ) {
				// 特定のプロパティを継承する
				_checkPolicyFile = com._checkPolicyFile;
				_securityDomain = com._securityDomain;
			}
		}
		
		
		
		
		
		/**
		 * @private
		 */
		protected override function executeFunction():void {
			// 参照を取得する
			var container:Sprite;
			switch ( true ) {
				case _loaderContainer is Sprite		: { container = Sprite( _loaderContainer ); break; }
				case _loaderContainer is String		: { container = ExMovieClip.nium_internal::$collections.getInstanceById( _loaderContainer ) as Sprite; break; }
			}
			
			// SceneLoader が存在しなければ作成する
			_loader ||= new SceneLoader();
			
			// イベントリスナーを登録する
			_loader.contentSceneInfo.addEventListener( Event.COMPLETE, _complete );
			_loader.contentSceneInfo.addEventListener( IOErrorEvent.IO_ERROR, _ioError );
			_loader.contentSceneInfo.addEventListener( ProgressEvent.PROGRESS, super.dispatchEvent );
			
			// ファイルを読み込む
			_loader.load( _request, container, _checkPolicyFile, _securityDomain );
		}
		
		/**
		 * @private
		 */
		protected override function interruptFunction():void {
			// 読み込みを閉じる
			_loader.close();
			
			// 破棄する
			_destroy();
		}
		
		/**
		 * 破棄します。
		 */
		private function _destroy():void {
			// イベントリスナーを解除する
			_loader.contentSceneInfo.removeEventListener( Event.COMPLETE, _complete );
			_loader.contentSceneInfo.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			_loader.contentSceneInfo.removeEventListener( ProgressEvent.PROGRESS, super.dispatchEvent );
		}
		
		/**
		 * <p>LoadScene インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an LoadScene subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい LoadScene インスタンスです。</p>
		 * <p>A new LoadScene object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new LoadScene( _request, _loader, _loaderContainer, this );
		}
		
		
		
		
		
		/**
		 * データが正常にロードされたときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// データを保持する
			super.data = _loader;
			
			// 破棄する
			_destroy();
			
			// 処理を終了する
			super.executeComplete();
		}
		
		/**
		 * 入出力エラーが発生してロード処理が失敗したときに送出されます。
		 */
		private function _ioError( e:IOErrorEvent ):void {
			// エラー処理を実行する
			super.throwError( this, new IOError( e.text ) );
		}
	}
}
