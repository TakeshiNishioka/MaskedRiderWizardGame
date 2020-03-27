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
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.commands.Command;
	
	/**
	 * <p>NavigateToURL クラスは、Flash Player のコンテナを含むアプリケーション（通常はブラウザ）でウィンドウを開くか、置き換え操作を行うコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // NavigateToURL インスタンスを作成する
	 * var com:NavigateToURL = new NavigateToURL();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class NavigateToURL extends Command {
		
		/**
		 * <p>リクエストされる URL です。</p>
		 * <p>The URL to be requested.</p>
		 */
		public function get url():String { return _request.url; }
		private var _request:URLRequest;
		
		/**
		 * <p>request パラメータで指定されたドキュメントを表示するブラウザウィンドウまたは HTML フレームです。</p>
		 * <p>The browser window or HTML frame in which to display the document indicated by the request parameter.</p>
		 */
		public function get windowTarget():String { return _windowTarget; }
		private var _windowTarget:String;
		
		
		
		
		
		/**
		 * <p>新しい NavigateToURL インスタンスを作成します。</p>
		 * <p>Creates a new NavigateToURL object.</p>
		 * 
		 * @param request
		 * <p>移動先の URL を指定する URLRequest オブジェクトです。</p>
		 * <p>A URLRequest object that specifies the URL to navigate to.</p>
		 * @param windowTarget
		 * <p>request パラメータで指定されたドキュメントを表示するブラウザウィンドウまたは HTML フレームです。</p>
		 * <p>The browser window or HTML frame in which to display the document indicated by the request parameter.</p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function NavigateToURL( request:URLRequest, windowTarget:String = null, initObject:Object = null ) {
			// 引数を設定する
			_request = request;
			_windowTarget = windowTarget;
			
			// 親クラスを初期化する
			super( _executeFunction, null, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _executeFunction():void {
			// 指定 URL に移動する
			navigateToURL( _request, _windowTarget );
			
			// 処理を終了する
			super.executeComplete();
		}
		
		/**
		 * <p>NavigateToURL インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an NavigateToURL subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい NavigateToURL インスタンスです。</p>
		 * <p>A new NavigateToURL object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new NavigateToURL( _request, _windowTarget );
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
