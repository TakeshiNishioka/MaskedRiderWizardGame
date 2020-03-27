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
	import jp.progression.commands.Command;
	
	/**
	 * <p>UploadFileRef クラスは、ユーザーが選択したファイルをリモートサーバーにアップロードするコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // UploadFileRef インスタンスを作成する
	 * var com:UploadFileRef = new UploadFileRef();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class UploadFileRef extends LoadCommand {
		
		/**
		 * <p>ユーザーのコンピュータとサーバーとの通信に使用する FileReference インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get fileReference():FileReference { return _fileReference; }
		private var _fileReference:FileReference;
		
		/**
		 * <p>ダイアログボックスに表示するファイルをフィルタにかける場合に使用する FileFilter インスタンスの配列です。</p>
		 * <p>An array of FileFilter instances used to filter the files that are displayed in the dialog box.</p>
		 */
		public function get typeFilter():Array { return _typeFilter; }
		private var _typeFilter:Array;
		
		/**
		 * <p>アップロード POST 操作のファイルデータに先行するフィールド名です。</p>
		 * <p>The field name that precedes the file data in the upload POST operation.</p>
		 */
		public function get uploadDataFieldName():String { return _uploadDataFieldName; }
		public function set uploadDataFieldName( value:String ):void { _uploadDataFieldName = value; }
		private var _uploadDataFieldName:String = "Filedata";
		
		/**
		 * <p>テストファイルアップロードを要求するための設定です。</p>
		 * <p>A setting to request a test file upload.</p>
		 */
		public function get testUpload():Boolean { return _testUpload; }
		public function set testUpload( value:Boolean ):void { _testUpload = value; }
		private var _testUpload:Boolean = false;
		
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
		 * <p>新しい UploadFileRef インスタンスを作成します。</p>
		 * <p>Creates a new UploadFileRef object.</p>
		 * 
		 * @param request
		 * <p>URLRequest オブジェクトです。</p>
		 * <p>The URLRequest object.</p>
		 * @param fileReference
		 * <p>ユーザーのコンピュータとサーバーとの通信に使用する FileReference インスタンスです。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function UploadFileRef( request:URLRequest, fileReference:FileReference = null, initObject:Object = null ) {
			// 引数を設定する
			_request = request;
			_fileReference = fileReference || new FileReference();
			
			// 初期化する
			_typeFilter = [];
			
			// 親クラスを初期化する
			super( request, initObject );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		protected override function executeFunction():void {
			// ファイルを参照する
			if ( _fileReference.browse( _typeFilter ) ) {
				_fileReference.addEventListener( Event.SELECT, _select );
				_fileReference.addEventListener( Event.CANCEL, _cancel );
			}
			else {
				_cancel( null );
			}
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
			_fileReference.removeEventListener( Event.SELECT, _select );
			_fileReference.removeEventListener( Event.CANCEL, _cancel );
			_fileReference.removeEventListener( Event.COMPLETE, _complete );
			_fileReference.removeEventListener( ProgressEvent.PROGRESS, super.dispatchEvent );
			_fileReference.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			_fileReference.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, _securityError );
		}
		
		/**
		 * <p>UploadFileRef インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an UploadFileRef subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい UploadFileRef インスタンスです。</p>
		 * <p>A new UploadFileRef object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new UploadFileRef( _request );
		}
		
		
		
		
		
		/**
		 * 
		 */
		private function _select( e:Event ):void {
			// イベントリスナーを登録する
			_fileReference.addEventListener( Event.CANCEL, _cancel );
			_fileReference.addEventListener( Event.COMPLETE, _complete );
			_fileReference.addEventListener( ProgressEvent.PROGRESS, super.dispatchEvent );
			_fileReference.addEventListener( IOErrorEvent.IO_ERROR, _ioError );
			_fileReference.addEventListener( SecurityErrorEvent.SECURITY_ERROR, _securityError );
			
			// アップロードを開始する
			_fileReference.upload( _request, _uploadDataFieldName, _testUpload );
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
