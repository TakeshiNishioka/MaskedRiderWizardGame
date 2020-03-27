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
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import jp.progression.commands.Command;
	
	/**
	 * <p>LoadSound クラスは、指定された URL からデータの読み込み操作を行うコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // LoadURL インスタンスを作成する
	 * var com:LoadURL = new LoadURL();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class LoadURL extends LoadCommand {
		
		/**
		 * <p>読み込み操作に使用する URLLoader インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get loader():URLLoader { return _loader; }
		private var _loader:URLLoader;
		
		/**
		 * URLRequest を取得します。
		 */
		private var _request:URLRequest;
		
		
		
		
		
		/**
		 * <p>新しい LoadURL インスタンスを作成します。</p>
		 * <p>Creates a new LoadURL object.</p>
		 * 
		 * @param request
		 * <p>読み込むファイルの絶対 URL または相対 URL を表す URLRequest インスタンスです。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function LoadURL( request:URLRequest, initObject:Object = null ) {
			// 引数を設定する
			_request = request;
			
			// 親クラスを初期化する
			super( request, initObject );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		protected override function executeFunction():void {
			// URLLoader が存在しなければ作成する
			_loader = new URLLoader();
			
			// イベントリスナーを登録する
			_loader.addEventListener( Event.COMPLETE, _complete );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, _ioError );
			_loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, _securityError );
			_loader.addEventListener( ProgressEvent.PROGRESS, super.dispatchEvent );
			
			// ファイルを読み込む
			_loader.load( _request );
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
			_loader.removeEventListener( Event.COMPLETE, _complete );
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			_loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, _securityError );
			_loader.removeEventListener( ProgressEvent.PROGRESS, super.dispatchEvent );
		}
		
		/**
		 * <p>LoadURL インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an LoadURL subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい LoadURL インスタンスです。</p>
		 * <p>A new LoadURL object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new LoadURL( _request, this );
		}
		
		
		
		
		
		/**
		 * 受信したすべてのデータがデコードされて URLLoader インスタンスの data プロパティへの保存が完了したときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// データを保持する
			super.data = _loader.data;
			
			// 破棄する
			_destroy();
			
			// 処理を終了する
			super.executeComplete();
		}
		
		/**
		 * URLLoader.load() の呼び出しによってセキュリティサンドボックスの外部にあるサーバーからデータをロードしようとすると送出されます。
		 */
		private function _securityError( e:SecurityErrorEvent ):void {
			// エラー処理を実行する
			super.throwError( this, new SecurityError( e.text ) );
		}
		
		/**
		 * URLLoader.load() の呼び出し時に致命的なエラーが発生してダウンロードが終了した場合に送出されます。
		 */
		private function _ioError( e:IOErrorEvent ):void {
			// エラー処理を実行する
			super.throwError( this, new IOError( e.text ) );
		}
	}
}
