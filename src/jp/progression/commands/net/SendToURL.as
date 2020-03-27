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
	import flash.net.sendToURL;
	import flash.net.URLRequest;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.commands.Command;
	
	/**
	 * <p>SendToURL クラスは、	URL リクエストをサーバーに送信操作を行うコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // SendToURL インスタンスを作成する
	 * var com:SendToURL = new SendToURL();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class SendToURL extends Command {
		
		/**
		 * <p>リクエストされる URL です。</p>
		 * <p>The URL to be requested.</p>
		 */
		public function get url():String { return _request.url; }
		private var _request:URLRequest;
		
		
		
		
		
		/**
		 * <p>新しい SendToURL インスタンスを作成します。</p>
		 * <p>Creates a new SendToURL object.</p>
		 * 
		 * @param request
		 * <p>データの送信先の URL を指定する URLRequest オブジェクトです。</p>
		 * <p>A URLRequest object specifying the URL to send data to.</p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function SendToURL( request:URLRequest, initObject:Object = null ) {
			// 引数を設定する
			_request = request;
			
			// 親クラスを初期化する
			super( _executeFunction, null, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _executeFunction():void {
			// データを送信する
			sendToURL( _request );
			
			// 処理を終了する
			super.executeComplete();
		}
		
		/**
		 * <p>SendToURL インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an SendToURL subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい SendToURL インスタンスです。</p>
		 * <p>A new SendToURL object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new SendToURL( _request );
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
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null, "url" );
		}
	}
}
