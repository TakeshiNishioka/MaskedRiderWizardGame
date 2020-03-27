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
package jp.progression.commands.lists {
	import flash.events.ProgressEvent;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.commands.Command;
	import jp.progression.commands.net.ILoadable;
	import jp.progression.core.L10N.L10NExecuteMsg;
	import jp.progression.events.ExecuteEvent;
	
	/**
	 * <p>ダウンロード処理を実行中にデータを受信したときに送出されます。</p>
	 * <p></p>
	 * 
	 * @eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event( name="progress", type="flash.events.ProgressEvent" )]
	
	/**
	 * <p>LoaderList クラスは、複数の ILoadable インターフェイスを実装したコマンドをまとめて管理するためのコマンドリストクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // LoaderList インスタンスを作成する
	 * var list:LoaderList = new LoaderList();
	 * 
	 * // コマンドを実行する
	 * list.execute();
	 * </listing>
	 */
	public class LoaderList extends SerialList implements ILoadable {
		
		/**
		 * <p>自身から見て最後に関連付けられた読み込みデータを取得または設定します。
		 * このコマンドインスタンスが CommandList インスタンス上に存在する場合には、自身より前、または自身の親のデータを取得します。</p>
		 * <p></p>
		 */
		public override function get latestData():* { return data || super.latestData; }
		public override function set latestData( value:* ):void { super.latestData = value; }
		
		/**
		 * <p>読み込み操作によって受信したデータです。</p>
		 * <p>The data received from the load operation.</p>
		 */
		public function get data():* {
			var data:Array = [];
			var commands:Array = super.commands;
			
			for ( var i:int = 0, l:int = commands.length; i < l; i++ ) {
				var loadable:ILoadable = commands[i] as Command as ILoadable;
				
				if ( !loadable ) { continue; }
				
				var latestData:* = loadable.data;
				
				if ( latestData != null ) {
					data = data.concat( latestData );
				}
				else {
					data.push( latestData );
				}
			}
			
			return data;
		}
		public function set data( value:* ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_013 ).toString( "data" ) ); }
		
		/**
		 * <p>現在の読み込み対象を取得します。</p>
		 * <p></p>
		 */
		public function get target():ILoadable {
			if ( _current is LoaderList ) { return _current.target; }
			if ( _current ) { return _current; }
			return null;
		}
		
		/**
		 * 現在の読み込み対象を取得します。
		 */
		private var _current:ILoadable;
		
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
		public function get percent():Number {
			var commands:Array = super.commands;
			var percent:Number = 0;
			var factor:Number = 0;
			
			for ( var i:int = 0, l:int = commands.length; i < l; i++ ) {
				var command:ILoadable = commands[i] as ILoadable;
				
				if ( !command ) { continue; }
				
				percent += command.percent * command.factor;
				factor += command.factor;
			}
			
			return factor ? percent / factor : 100;
		}
		
		/**
		 * <p>登録されている ILoadable を実装したインスタンスの内、すでに読み込み処理が完了した数を取得します。</p>
		 * <p></p>
		 */
		public function get loaded():uint {
			var commands:Array = super.commands;
			var loaded:int = 0;
			
			for ( var i:int = 0, l:int = commands.length; i < l; i++ ) {
				var command:ILoadable = commands[i] as ILoadable;
				if ( !command ) { continue; }
				loaded += command.loaded;
			}
			
			return loaded;
		}
		
		/**
		 * <p>登録されている ILoadable を実装したインスタンスの総数を取得します。</p>
		 * <p></p>
		 */
		public function get total():uint {
			var commands:Array = super.commands;
			var total:int = 0;
			
			for ( var i:int = 0, l:int = commands.length; i < l; i++ ) {
				var command:ILoadable = commands[i] as ILoadable;
				if ( !command ) { continue; }
				total += command.total;
			}
			
			return total;
		}
		
		/**
		 * <p>コマンドの読み込み済みのバイト数です。</p>
		 * <p>The number of bytes that are loaded for the command.</p>
		 */
		public function get bytesLoaded():uint {
			var command:ILoadable = super.commands[position - 1] as ILoadable;
			if ( command ) { return command.bytesLoaded; }
			return 0;
		}
		
		/**
		 * <p>コマンド全体の圧縮後のバイト数です。</p>
		 * <p>The number of compressed bytes in the entire command.</p>
		 */
		public function get bytesTotal():uint {
			var command:ILoadable = super.commands[position - 1] as ILoadable;
			if ( command ) { return command.bytesTotal; }
			return 0;
		}
		
		/**
		 * エラーが発生中であるかどうかを取得します。
		 */
		private var _error:Boolean = false;
		
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
		 * <p>新しい LoaderList インスタンスを作成します。</p>
		 * <p>Creates a new LoaderList object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 * @param commands
		 * <p>登録したいコマンドインスタンス、関数、数値、配列などを含む配列です。</p>
		 * <p></p>
		 */
		public function LoaderList( initObject:Object = null, ... commands:Array ) {
			// 親クラスを初期化する
			super( initObject );
			
			// initObject が LoaderList であれば
			var com:LoaderList = initObject as LoaderList;
			if ( com ) {
				// 特定のプロパティを継承する
				_factor = com._factor;
				_onProgress = com._onProgress;
			}
			
			// コマンドリストに登録する
			super.addCommand.apply( null, commands );
		}
		
		
		
		
		
		/**
		 * <p>コマンドインスタンスを実行します。</p>
		 * <p></p>
		 * 
		 * @see #state
		 * @see #delay
		 * @see #timeout
		 * @see #scope
		 * @see #extra
		 * @see #executeComplete()
		 * @see #interrupt()
		 * 
		 * @param extra
		 * <p>実行時に設定されるリレーオブジェクトです。</p>
		 * <p></p>
		 */
		public override function execute( extra:Object = null ):void {
			// イベントリスナーを登録する
			super.addEventListener( ExecuteEvent.EXECUTE_POSITION, _executePosition );
			super.addEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
			
			// 初期化する
			_error = false;
			
			// 親のメソッドを実行する
			super.execute( extra );
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
			// すでにエラーが発生していれば終了する
			if ( _error ) { return; }
			
			// イベントリスナーを解除する
			super.removeEventListener( ExecuteEvent.EXECUTE_POSITION, _executePosition );
			super.removeEventListener( ExecuteEvent.EXECUTE_INTERRUPT, _executeInterrupt );
			
			// 正常に読み込みが完了していれば
			if ( percent == 100 ) {
				// 親のメソッドを実行する
				super.executeComplete();
			}
			else {
				// エラー状態にする
				_error = true;
				
				// 例外をスローする
				super.throwError( this, new Error( Logger.getLog( L10NExecuteMsg.ERROR_007 ).toString( super.className ) ) );
			}
		}
		
		/**
		 * 破棄します。
		 */
		private function _destroy():void {
			if ( _current ) {
				// イベントリスナーを解除する
				_current.removeEventListener( ProgressEvent.PROGRESS, _progress );
				
				// 現在の対象を設定する
				_current = null;
			}
		}
		
		/**
		 * <p>LoaderList インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an LoaderList subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい LoaderList インスタンスです。</p>
		 * <p>A new LoaderList object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new LoaderList( this );
		}
		
		
		
		
		
		/**
		 * リストに登録されているコマンドの実行処理位置が変更された場合に送出されます。
		 */
		private function _executePosition( e:ExecuteEvent ):void {
			// 破棄する
			_destroy();
			
			// 現在の対象を設定する
			_current = commands[super.position - 1] as ILoadable;
			
			// イベントリスナーを登録する
			if ( _current ) {
				_current.addEventListener( ProgressEvent.PROGRESS, _progress );
			}
		}
		
		/**
		 * コマンドの処理が中断された場合に送出されます。
		 */
		private function _executeInterrupt( e:ExecuteEvent ):void {
			// 破棄する
			_destroy();
		}
		
		/**
		 * ダウンロード処理を実行中にデータを受信したときに送出されます。
		 */
		private function _progress( e:ProgressEvent ):void {
			// イベントを送出する
			super.dispatchEvent( e );
			
			// イベントハンドラメソッドを実行する
			if ( _onProgress != null ) {
				_onProgress.apply( super.scope || this );
			}
		}
	}
}
