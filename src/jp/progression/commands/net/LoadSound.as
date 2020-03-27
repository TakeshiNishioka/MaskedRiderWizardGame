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
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import jp.progression.commands.Command;
	
	/**
	 * <p>LoadSound クラスは、指定されたサウンドファイルの読み込み操作を行うコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // LoadSound インスタンスを作成する
	 * var com:LoadSound = new LoadSound();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class LoadSound extends LoadCommand {
		
		/**
		 * <p>読み込み処理に使用する Sound インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get sound():Sound { return _sound; }
		private var _sound:Sound;
		
		/**
		 * <p>ポリシーファイルの存在の確認や、ApplicationDomain 及び SecurityDomain の設定を行う LoaderContext を取得または設定します。</p>
		 * <p></p>
		 */
		public function get context():SoundLoaderContext { return _context; }
		public function set context( value:SoundLoaderContext ):void { _context = value; }
		private var _context:SoundLoaderContext;
		
		/**
		 * URLRequest を取得します。
		 */
		private var _request:URLRequest;
		
		
		
		
		
		/**
		 * <p>新しい LoadSound インスタンスを作成します。</p>
		 * <p>Creates a new LoadSound object.</p>
		 * 
		 * @param request
		 * <p>読み込む MP3 ファイルの絶対 URL または相対 URL を表す URLRequest インスタンスです。</p>
		 * <p></p>
		 * @param sound
		 * <p>読み込み処理に使用する Sound インスタンスです。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function LoadSound( request:URLRequest, sound:Sound = null, initObject:Object = null ) {
			// 引数を設定する
			_request = request;
			_sound = sound;
			
			// 親クラスを初期化する
			super( request, initObject );
			
			// initObject が LoadSound であれば
			var com:LoadSound = initObject as LoadSound;
			if ( com ) {
				// 特定のプロパティを継承する
				_sound = com._sound;
				_context = com._context;
			}
		}
		
		
		
		
		
		/**
		 * @private
		 */
		protected override function executeFunction():void {
			// Sound が存在しなければ作成する
			_sound ||= new Sound();
			
			// イベントリスナーを登録する
			_sound.addEventListener( Event.COMPLETE, _complete );
			_sound.addEventListener( IOErrorEvent.IO_ERROR, _ioError );
			_sound.addEventListener( ProgressEvent.PROGRESS, super.dispatchEvent );
			
			// ファイルを読み込む
			_sound.load( _request, _context );
		}
		
		/**
		 * @private
		 */
		protected override function interruptFunction():void {
			// 読み込みを閉じる
			_sound.close();
			
			// 破棄する
			_destroy();
		}
		
		/**
		 * 破棄します。
		 */
		private function _destroy():void {
			// イベントリスナーを解除する
			_sound.removeEventListener( Event.COMPLETE, _complete );
			_sound.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			_sound.removeEventListener( ProgressEvent.PROGRESS, super.dispatchEvent );
		}
		
		/**
		 * <p>LoadSound インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an LoadSound subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい LoadSound インスタンスです。</p>
		 * <p>A new LoadSound object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new LoadSound( _request, _sound, this );
		}
		
		
		
		
		
		/**
		 * データが正常にロードされたときに送出されます。
		 */
		private function _complete( e:Event ):void { trace( e.type );
			// データを保持する
			super.data = _sound;
			
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
