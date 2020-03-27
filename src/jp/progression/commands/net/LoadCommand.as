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
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.commands.Command;
	import jp.progression.data.Resource;
	
	/**
	 * <p>ダウンロード処理を実行中にデータを受信したときに送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event( name="progress", type="flash.events.ProgressEvent" )]
	
	/**
	 * <p>LoadCommand クラスは、読み込み処理が実装される全てのコマンドの基本となるクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // LoadCommand インスタンスを作成する
	 * var com:LoadCommand = new LoadCommand();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class LoadCommand extends Command implements ILoadable {
		
		/**
		 * <p>リクエストされる URL です。</p>
		 * <p>The URL to be requested.</p>
		 */
		public function get url():String { return _request.url; }
		private var _request:URLRequest;
		
		/**
		 * <p>読み込まれたデータを自動的に Resource として管理するかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		public function get cacheAsResource():Boolean { return _cacheAsResource; }
		public function set cacheAsResource( value:Boolean ):void { _cacheAsResource = value; }
		private var _cacheAsResource:Boolean = true;
		
		/**
		 * <p>自身から見て最後に関連付けられた読み込みデータを取得または設定します。
		 * このコマンドインスタンスが CommandList インスタンス上に存在する場合には、自身より前、または自身の親のデータを取得します。</p>
		 * <p></p>
		 */
		public override function get latestData():* {
			if ( _data != null && _data != undefined ) { return _data; }
			return super.latestData;
		}
		public override function set latestData( value:* ):void { super.latestData = value; }
		
		/**
		 * <p>読み込み操作によって受信したデータです。</p>
		 * <p>The data received from the load operation.</p>
		 */
		public function get data():* { return _data; }
		public function set data( value:* ):void { _data = value; }
		private var _data:*;
		
		/**
		 * <p>現在の読み込み対象を取得します。</p>
		 * <p></p>
		 */
		public function get target():ILoadable { return this; }
		
		/**
		 * <p>percent プロパティの算出時の自身の重要性を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #percent
		 */
		public function get factor():Number { return _factor; }
		public function set factor( value:Number ):void { _factor = value; }
		private var _factor:Number = 1.0;
		
		/**
		 * <p>loaded プロパティと total プロパティから算出される読み込み状態をパーセントで取得します。</p>
		 * <p></p>
		 * 
		 * @see #factor
		 * @see #loaded
		 * @see #total
		 */
		public function get percent():Number { return _bytesTotal ? _bytesLoaded / _bytesTotal * 100 : 0; }
		
		/**
		 * <p>登録されている ILoadable を実装したインスタンスの内、すでに読み込み処理が完了した数を取得します。</p>
		 * <p></p>
		 * 
		 * @see #total
		 */
		public function get loaded():uint { return _loaded; }
		private var _loaded:uint = 0;
		
		/**
		 * <p>登録されている ILoadable を実装したインスタンスの総数を取得します。</p>
		 * <p></p>
		 * 
		 * @see #loaded
		 */
		public function get total():uint { return 1; }
		
		/**
		 * <p>コマンドの読み込み済みのバイト数です。</p>
		 * <p>The number of bytes that are loaded for the command.</p>
		 * 
		 * @see #bytesTotal
		 */
		public function get bytesLoaded():uint { return _bytesLoaded; }
		private var _bytesLoaded:uint = 0;
		
		/**
		 * <p>コマンド全体の圧縮後のバイト数です。</p>
		 * <p>The number of compressed bytes in the entire command.</p>
		 * 
		 * @see #bytesLoaded
		 */
		public function get bytesTotal():uint { return _bytesTotal; }
		private var _bytesTotal:uint = 0;
		
		/**
		 * <p>コマンドオブジェクトが ProgressEvent.PROGRESS イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #scope
		 * @see flash.events.ProgressEvent#PROGRESS
		 */
		public function get onProgress():Function { return _onProgress; }
		public function set onProgress( value:Function ):void { _onProgress = value; }
		private var _onProgress:Function;
		
		
		
		
		
		/**
		 * <p>新しい LoadCommand インスタンスを作成します。</p>
		 * <p>Creates a new LoadCommand object.</p>
		 * 
		 * @param request
		 * <p>ダウンロードする URL を指定する URLRequest オブジェクトです。</p>
		 * <p>A URLRequest object specifying the URL to download.</p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function LoadCommand( request:URLRequest, initObject:Object = null ) {
			// 引数を設定する
			_request = request;
			
			// 親クラスを初期化する
			super( _executeFunction, _interruptFunction, initObject );
			
			// 継承せずにインスタンスを生成しようとしたら例外をスローする
			if ( Object( this ).constructor == LoadCommand ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( super.className ) ); }
			
			// initObject が LoadCommand であれば
			var com:LoadCommand = initObject as LoadCommand;
			if ( com ) {
				// 特定のプロパティを継承する
				_cacheAsResource = com._cacheAsResource;
				_factor = com._factor;
				_onProgress = com._onProgress;
			}
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _executeFunction():void {
			// 初期化する
			_data = null;
			_loaded = 0;
			_bytesLoaded = 0;
			_bytesTotal = 0;
			
			// イベントリスナーを登録する
			super.addEventListener( ProgressEvent.PROGRESS, _progress, false, int.MAX_VALUE );
			
			// この実装を実行する
			executeFunction();
		}
		
		/**
		 * @private
		 */
		protected function executeFunction():void {
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interruptFunction():void {
			// 初期化する
			_data = null;
			_loaded = 0;
			_bytesLoaded = 0;
			_bytesTotal = 0;
			
			// イベントリスナーを解除する
			super.removeEventListener( ProgressEvent.PROGRESS, _progress );
			
			// この実装を実行する
			interruptFunction();
		}
		
		/**
		 * @private
		 */
		protected function interruptFunction():void {
		}
		
		/**
		 * <p>実行中のコマンド処理が完了したことを通知します。
		 * このメソッドを実行するためには、事前に execute() メソッドが実行されている必要があります。</p>
		 * <p></p>
		 * 
		 * @see #state
		 * @see #interrupt()
		 */
		public override function executeComplete():void {
			// 読み込み完了状態にする
			_loaded = 1;
			
			// イベントリスナーを解除する
			super.removeEventListener( ProgressEvent.PROGRESS, _progress );
			
			// リソースとしてキャッシュするのであれば
			if ( _cacheAsResource ) {
				new Resource( _request.url, _data, _bytesTotal, { group:super.group } );
			}
			
			// 親のメソッドを実行する
			super.executeComplete();
		}
		
		/**
		 * <p>LoadCommand インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an LoadCommand subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい LoadCommand インスタンスです。</p>
		 * <p>A new LoadCommand object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new LoadCommand( _request, this );
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
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null, "url", "factor", "cacheAsResource" );
		}
		
		
		
		
		
		/**
		 * ダウンロード処理を実行中にデータを受信したときに送出されます。
		 */
		private function _progress( e:ProgressEvent ):void {
			// 経過を保存する
			_bytesLoaded = e.bytesLoaded;
			_bytesTotal = e.bytesTotal;
			
			// イベントハンドラメソッドを実行する
			if ( _onProgress != null ) {
				_onProgress.apply( super.scope || this );
			}
		}
	}
}
