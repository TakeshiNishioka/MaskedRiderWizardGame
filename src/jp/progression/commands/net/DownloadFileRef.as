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
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.commands.Command;
	
	/**
	 * <p>DownloadFileRef クラスは、リモートサーバーからファイルをダウンロードするためのコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // DownloadFileRef インスタンスを作成する
	 * var com:DownloadFileRef = new DownloadFileRef();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class DownloadFileRef extends LoadCommand {
		
		/**
		 * <p>ユーザーのコンピュータとサーバーとの通信に使用する FileReference インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get fileReference():FileReference { return _fileReference; }
		private var _fileReference:FileReference;
		
		/**
		 * <p>ダウンロードするファイルとしてダイアログボックスに表示するデフォルトファイル名です。</p>
		 * <p>The default filename displayed in the dialog box for the file to be downloaded.</p>
		 */
		public function get defaultFileName():String { return _defaultFileName; }
		private var _defaultFileName:String;
		
		/**
		 * @private
		 */
		public override function get data():* { return null; }
		public override function set data( value:* ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_001 ).toString( "data" ) ); }
		
		/**
		 * URLRequest を取得します。
		 */
		private var _request:URLRequest;
		
		
		
		
		
		/**
		 * <p>新しい DownloadFileRef インスタンスを作成します。</p>
		 * <p>Creates a new DownloadFileRef object.</p>
		 * 
		 * @param request
		 * <p>URLRequest オブジェクトです。</p>
		 * <p>The URLRequest object.</p>
		 * @param fileReference
		 * <p>ユーザーのコンピュータとサーバーとの通信に使用する FileReference インスタンスです。</p>
		 * <p></p>
		 * @param defaultFileName
		 * <p>ダウンロードするファイルとしてダイアログボックスに表示するデフォルトファイル名です。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function DownloadFileRef( request:URLRequest, fileReference:FileReference = null, defaultFileName:String = null, initObject:Object = null ) {
			// 引数を設定する
			_request = request;
			_fileReference = fileReference || new FileReference();
			_defaultFileName = defaultFileName;
			
			// 親クラスを初期化する
			super( request, initObject );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		protected override function executeFunction():void {
			// イベントリスナーを登録する
			_fileReference.addEventListener( Event.CANCEL, _cancel );
			_fileReference.addEventListener( Event.COMPLETE, _complete );
			_fileReference.addEventListener( ProgressEvent.PROGRESS, super.dispatchEvent );
			_fileReference.addEventListener( IOErrorEvent.IO_ERROR, _ioError );
			_fileReference.addEventListener( SecurityErrorEvent.SECURITY_ERROR, _securityError );
			
			// ダウンロードを開始する
			_fileReference.download( _request, _defaultFileName );
		}
		
		/**
		 * @private
		 */
		protected override function interruptFunction():void {
			// 実行中の処理をキャンセルする
			_fileReference.cancel();
			
			// 破棄する
			_destroy();
		}
		
		/**
		 * 破棄します。
		 */
		private function _destroy():void {
			// イベントリスナーを解除する
			_fileReference.removeEventListener( Event.CANCEL, _cancel );
			_fileReference.removeEventListener( Event.COMPLETE, _complete );
			_fileReference.removeEventListener( ProgressEvent.PROGRESS, super.dispatchEvent );
			_fileReference.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			_fileReference.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, _securityError );
		}
		
		/**
		 * <p>DownloadFileRef インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an DownloadFileRef subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい DownloadFileRef インスタンスです。</p>
		 * <p>A new DownloadFileRef object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new DownloadFileRef( _request, _fileReference, _defaultFileName );
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
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null, "url", "defaultFileName", "factor" );
		}
		
		
		
		
		
		/**
		 * 
		 */
		private function _cancel( e:Event ):void {
			// 破棄する
			_destroy();
			
			// 処理を終了する
			super.executeComplete();
		}
		
		/**
		 * 
		 */
		private function _complete( e:Event ):void {
			// 破棄する
			_destroy();
			
			// 処理を終了する
			super.executeComplete();
		}
		
		/**
		 * 
		 */
		private function _ioError( e:IOErrorEvent ):void {
			// エラー処理を実行する
			super.throwError( this, new IOError( e.text ) );
		}
		
		/**
		 * 
		 */
		private function _securityError( e:SecurityErrorEvent ):void {
			// エラー処理を実行する
			super.throwError( this, new SecurityError( e.text ) );
		}
	}
}
