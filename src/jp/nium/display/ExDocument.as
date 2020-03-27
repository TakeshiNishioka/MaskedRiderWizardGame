/**
 * jp.nium Classes
 * 
 * @author Copyright (C) 2007-2009 taka:nium.jp, All Rights Reserved.
 * @version 4.0.1 Public Beta 1.2
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.display {
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.events.ExEvent;
	import jp.nium.utils.StageUtil;
	
	/**
	 * <p>SWF ファイルの読み込みが完了し、stage 及び loaderInfo にアクセス可能になった場合に送出されます。</p>
	 * <p>Dispatch when the SWF file completes to read and the stage and the loaderInfo becomes able to access.</p>
	 * 
	 * @eventType jp.nium.events.ExEvent.EX_READY
	 */
	[Event( name="exReady", type="jp.nium.events.ExEvent" )]
	
	/**
	 * <p>ExDocument クラスは、ExMovieClip クラスに対してドキュメントクラスとしての機能拡張を追加した表示オブジェクトクラスです。</p>
	 * <p>The ExDocument class is a display object class that added the functionality expansion as the document class, to the ExMovieClip class.</p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ExDocument extends ExMovieClip {
		
		/**
		 * <p>ロードされた SWF ファイル内の表示オブジェクトの場合、root プロパティはその SWF ファイルが表す表示リストのツリー構造部分の一番上にある表示オブジェクトとなります。</p>
		 * <p>For a display object in a loaded SWF file, the root property is the top-most display object in the portion of the display list's tree structure represented by that SWF file.</p>
		 */
		public static function get root():ExDocument {
			if ( !_created ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_023 ).toString( "root" ) ); }
			return _root;
		}
		private static var _root:ExDocument;
		
		/**
		 * <p>表示オブジェクトのステージです。</p>
		 * <p>The Stage of the display object.</p>
		 */
		public static function get stage():Stage {
			if ( !_created ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_023 ).toString( "stage" ) ); }
			return _stage;
		}
		private static var _stage:Stage;
		
		/**
		 * <p>ステージ左の X 座標を取得します。</p>
		 * <p>Get the left X coordinate of the stage.</p>
		 */
		public static function get left():Number {
			if ( !_created ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_023 ).toString( "left" ) ); }
			return -StageUtil.getMarginLeft( _stage );
		}
		
		/**
		 * <p>ステージ中央の X 座標を取得します。</p>
		 * <p>Get the center X coordinate of the stage.</p>
		 */
		public static function get center():Number {
			if ( !_created ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_023 ).toString( "center" ) ); }
			return ( right + left ) / 2;
		}
		
		/**
		 * <p>ステージ右の X 座標を取得します。</p>
		 * <p>Get the right X coordinate of the stage.</p>
		 */
		public static function get right():Number {
			if ( !_created ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_023 ).toString( "right" ) ); }
			return left + _stage.stageWidth;
		}
		
		/**
		 * <p>ステージ上の Y 座標を取得します。</p>
		 * <p>Get the top Y coordinate of the stage.</p>
		 */
		public static function get top():Number {
			if ( !_created ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_023 ).toString( "top" ) ); }
			return -StageUtil.getMarginTop( _stage );
		}
		
		/**
		 * <p>ステージ中央の Y 座標を取得します。</p>
		 * <p>Get the center Y coordinate of the stage.</p>
		 */
		public static function get middle():Number {
			if ( !_created ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_023 ).toString( "middle" ) ); }
			return ( bottom + top ) / 2;
		}
		
		/**
		 * <p>ステージ下の Y 座標を取得します。</p>
		 * <p>Get the bottom Y coordinate of the stage.</p>
		 */
		public static function get bottom():Number {
			if ( !_created ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_023 ).toString( "bottom" ) ); }
			return top + _stage.stageHeight;
		}
		
		/**
		 * インスタンスが生成されたかどうかを取得します。
		 */
		private static var _created:Boolean = false;
		
		
		
		
		
		/**
		 * <p>ドキュメントの準備が完了しているかどうかを取得します。</p>
		 * <p></p>
		 */
		public function get isReady():Boolean { return _isReady; }
		private var _isReady:Boolean = false;
		
		/**
		 * ステージ上に設置されたかどうかを取得します。
		 */
		private var _isAddedToStage:Boolean = false;
		
		/**
		 * ステージサイズが取得可能になったかどうかを取得します。
		 */
		private var _isStageSize:Boolean = false;
		
		/**
		 * 初期化が完了したかどうかを取得します。
		 */
		private var _isInit:Boolean = false;
		
		/**
		 * 読み込み処理が完了したかどうかを取得します。
		 */
		private var _isComplete:Boolean = false;
		
		/**
		 * 前回のステージの幅を取得します。
		 */
		private var _oldStageWidth:Number = 0.0;
		
		/**
		 * 前回のステージの高さを取得します。
		 */
		private var _oldStageHeight:Number = 0.0;
		
		/**
		 * リサイズの遅延ミリ秒を取得します。
		 */
		private var _resizeDelay:int = 0;
		
		
		
		
		
		/**
		 * <p>新しい ExDocument インスタンスを作成します。</p>
		 * <p>Creates a new ExDocument object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function ExDocument( initObject:Object = null ) {
			// 親クラスを初期化する
			super( initObject );
			
			// root が存在しない、もしくは自身が root ではなければ
			if ( !super.root || this != super.root ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_007 ).toString( super.className ) ); }
			
			// 初期化する
			_root = this;
			_created = true;
			
			// イベントリスナーを登録する
			super.addEventListener( Event.ADDED_TO_STAGE, _addedToStage );
			super.loaderInfo.addEventListener( Event.INIT, _init );
			
			// 既に読み込みが完了していれば
			if ( super.loaderInfo.bytesTotal > 0 && super.loaderInfo.bytesLoaded >= super.loaderInfo.bytesTotal ) {
				_complete( null );
			}
			else {
				super.loaderInfo.addEventListener( Event.COMPLETE, _complete );
			}
		}
		
		
		
		
		
		/**
		 * 
		 */
		private function _checkReady():Boolean {
			if ( _isReady ) { return true; }
			if ( !_isAddedToStage || !_isStageSize || !_isInit || !_isComplete ) { return false; }
			
			// 状態を変更する
			_isReady = true;
			
			// イベントを送出する
			_stage.dispatchEvent( new ExEvent( ExEvent.EX_RESIZE_START ) );
			_stage.dispatchEvent( new ExEvent( ExEvent.EX_RESIZE_PROGRESS ) );
			_stage.dispatchEvent( new ExEvent( ExEvent.EX_RESIZE_COMPLETE ) );
			super.dispatchEvent( new ExEvent( ExEvent.EX_READY ) );
			
			return true;
		}
		
		
		
		
		
		/**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。
		 */
		private function _addedToStage( e:Event ):void {
			// イベントリスナーを解除する
			super.removeEventListener( Event.ADDED_TO_STAGE, _addedToStage );
			
			// stage の参照を保存する
			_stage = super.stage;
			
			// stage を初期化する
			_stage.align = StageAlign.TOP_LEFT;
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// イベントリスナーを追加する
			super.addEventListener( Event.ENTER_FRAME, _enterFrame );
			_stage.addEventListener( Event.RESIZE, _resizeStart );
			
			// 状態を変更する
			_isAddedToStage = true;
			
			// 準備が完了したかどうか確認する
			_checkReady();
		}
		
		/**
		 * SWF ファイルの読み込みが完了した場合に送出されます。
		 */
		private function _init( e:Event ):void {
			// イベントリスナーを解除する
			super.loaderInfo.removeEventListener( Event.INIT, _init );
			
			// 状態を変更する
			_isInit = true;
			
			// 準備が完了したかどうか確認する
			_checkReady();
		}
		
		/**
		 * データが正常にロードされたときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// イベントリスナーを解除する
			super.loaderInfo.removeEventListener( Event.COMPLETE, _complete );
			
			// 状態を変更する
			_isComplete = true;
			
			// 準備が完了したかどうか確認する
			_checkReady();
		}
		
		/**
		 * 
		 */
		private function _enterFrame( e:Event ):void {
			if ( stage.stageWidth <= 0 || stage.stageHeight <= 0 ) { return; }
			
			// イベントリスナーを解除する
			super.removeEventListener( Event.ENTER_FRAME, _enterFrame );
			
			// 状態を変更する
			_isStageSize = true;
			
			// 準備が完了したかどうか確認する
			_checkReady();
		}
		
		/**
		 * SWF ファイルのサイズ変更が開始されたときに送出されます。
		 */
		private function _resizeStart( e:Event ):void {
			// イベントリスナーを解除する
			_stage.removeEventListener( Event.RESIZE, _resizeStart );
			
			// イベントを送出する
			_stage.dispatchEvent( new ExEvent( ExEvent.EX_RESIZE_START ) );
			
			// イベントリスナーを登録する
			super.addEventListener( Event.ENTER_FRAME, _resizeProgress );
		}
		
		/**
		 * SWF ファイルのサイズが変更中であるときに送出されます。
		 */
		private function _resizeProgress( e:Event ):void {
			// イベントを送出する
			_stage.dispatchEvent( new ExEvent( ExEvent.EX_RESIZE_PROGRESS ) );
			
			var stageWidth:Number = _stage.stageWidth;
			var stageHeight:Number = _stage.stageHeight;
			
			// 前回とサイズが変更されていなければ、イベントを送出する
			if ( stageWidth == _oldStageWidth && stageHeight == _oldStageHeight && _resizeDelay++ > _stage.frameRate / 5 ) {
				// 遅延時間を初期化する
				_resizeDelay = 0;
				
				// イベントリスナーを解除する
				super.removeEventListener( Event.ENTER_FRAME, _resizeProgress );
				
				// イベントを送出する
				_stage.dispatchEvent( new ExEvent( ExEvent.EX_RESIZE_COMPLETE ) );
				
				// イベントリスナーを登録する
				_stage.addEventListener( Event.RESIZE, _resizeStart );
			}
			
			// 現在のサイズを保存する
			_oldStageWidth = stageWidth;
			_oldStageHeight = stageHeight;
		}
	}
}
