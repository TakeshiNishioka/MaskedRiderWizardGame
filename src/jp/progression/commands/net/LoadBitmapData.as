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
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import jp.progression.commands.Command;
	
	/**
	 * <p>LoadBitmapData クラスは、指定された画像ファイルの読み込み操作を行うコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // LoadBitmapData インスタンスを作成する
	 * var com:LoadBitmapData = new LoadBitmapData();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class LoadBitmapData extends LoadCommand {
		
		/**
		 * <p>ポリシーファイルの存在の確認や、ApplicationDomain 及び SecurityDomain の設定を行う LoaderContext を取得または設定します。</p>
		 * <p></p>
		 */
		public function get context():LoaderContext { return _context; }
		public function set context( value:LoaderContext ):void { _context = value; }
		private var _context:LoaderContext;
		
		/**
		 * URLRequest を取得します。
		 */
		private var _request:URLRequest;
		
		/**
		 * Loader を取得します。
		 */
		private var _loader:Loader;
		
		
		
		
		
		/**
		 * <p>新しい LoadBitmapData インスタンスを作成します。</p>
		 * <p>Creates a new LoadBitmapData object.</p>
		 * 
		 * @param request
		 * <p>読み込みたい JPEG、GIF、または PNG ファイルの絶対 URL または相対 URL です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function LoadBitmapData( request:URLRequest, initObject:Object = null ) {
			// 引数を設定する
			_request = request;
			
			// 親クラスを初期化する
			super( request, initObject );
			
			// initObject が LoadBitmapData であれば
			var com:LoadBitmapData = initObject as LoadBitmapData;
			if ( com ) {
				// 特定のプロパティを継承する
				_context = com._context;
			}
		}
		
		
		
		
		
		/**
		 * @private
		 */
		protected override function executeFunction():void {
			// Loader を作成する
			_loader = new Loader();
			
			// イベントリスナーを登録する
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, _complete );
			_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, _ioError );
			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, super.dispatchEvent );
			
			// ファイルを読み込む
			_loader.load( _request, _context );
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
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, _complete );
			_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, super.dispatchEvent );
			
			// 破棄する
			_loader = null;
		}
		
		/**
		 * <p>LoadBitmapData インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an LoadBitmapData subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい LoadBitmapData インスタンスです。</p>
		 * <p>A new LoadBitmapData object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new LoadBitmapData( _request, this );
		}
		
		
		
		
		
		/**
		 * データが正常にロードされたときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// 対象が Bitmap であれば
			try {
				// データを保持する
				super.data = Bitmap( _loader.content ).bitmapData;
			}
			catch ( err:Error ) {
				super.throwError( this, err.message );
				return;
			}
			
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
