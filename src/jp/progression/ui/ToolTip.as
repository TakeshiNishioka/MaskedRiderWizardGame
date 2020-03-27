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
package jp.progression.ui {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import jp.nium.utils.StageUtil;
	
	/**
	 * <p>ToolTip クラスは、基本的なツールチップを提供するクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ToolTip implements IToolTip {
		
		/**
		 * <p>初期値となるツールチップのテキスト色を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #textColor
		 */
		public static function get defaultTextColor():uint { return _defaultTextColor; }
		public static function set defaultTextColor( value:uint ):void { _defaultTextColor = value; }
		private static var _defaultTextColor:uint = 0x000000;
		
		/**
		 * <p>初期値となるツールチップの背景色を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #backgroundColor
		 */
		public static function get defaultBackgroundColor():uint { return _defaultBackgroundColor; }
		public static function set defaultBackgroundColor( value:uint ):void { _defaultBackgroundColor = value; }
		private static var _defaultBackgroundColor:uint = 0xFFFFEE;
		
		/**
		 * <p>初期値となるツールチップのボーダー色を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #borderColor
		 */
		public static function get defaultBorderColor():uint { return _defaultBorderColor; }
		public static function set defaultBorderColor( value:uint ):void { _defaultBorderColor = value; }
		private static var _defaultBorderColor:uint = 0x000000;
		
		/**
		 * <p>初期値となるツールチップのフィルター設定を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #filters
		 */
		public static function get defaultFilters():Array { return _defaultFilters; }
		public static function set defaultFilters( value:Array ):void { _defaultFilters = value; }
		private static var _defaultFilters:Array;
		
		/**
		 * <p>初期値となるツールチップを表示するまでの遅延時間をミリ秒で取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #delay
		 */
		public static function get defaultDelay():Number { return _defaultDelay; }
		public static function set defaultDelay( value:Number ):void { _defaultDelay = value; }
		private static var _defaultDelay:Number = 0.75;
		
		/**
		 * ToolTip インスタンスを取得します。
		 */
		private static var _current:ToolTip;
		
		/**
		 * Stage インスタンスを取得します。
		 */
		private static var _stage:Stage;
		
		/**
		 * TextField インスタンスを取得します。
		 */
		private static var _textField:TextField;
		
		/**
		 * Timer インスタンスを取得します。
		 */
		private static var _timer:Timer = new Timer( 0, 1 );
		_timer.addEventListener( TimerEvent.TIMER_COMPLETE, _timerComplete );
		
		/**
		 * 画面端から離す距離を取得します。
		 */
		private static var _padding:Number = 5;
		
		/**
		 * マウスの X 座標からずらすツールチップの距離を取得します。
		 */
		private static var _marginX:Number = 5;
		
		/**
		 * マウスの Y 座標からずらすツールチップの距離を取得します。
		 */
		private static var _marginY:Number = 22;
		
		/**
		 * マウスに追従する際の摩擦係数を取得します。
		 */
		private static var _friction:Number = 0.25;
		
		/**
		 * ツールチップに適用する DropShadowFilter フィルターを取得します。
		 */
		private static var _dropShadow:DropShadowFilter = new DropShadowFilter( 1, 45, 0x000000, 0.5, 4, 4, 1 );
		
		
		
		
		
		/**
		 * <p>関連付けられている Sprite インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get target():Sprite { return _target; }
		private var _target:Sprite;
		
		/**
		 * <p>ツールチップに表示するテキストを取得または設定します。
		 * この値が設定されていない状態では、ツールチップは表示されません。</p>
		 * <p></p>
		 */
		public function get text():String { return _text; }
		public function set text( value:String ):void {
			if ( _text ) {
				// イベントリスナーを解除する
				_target.removeEventListener( MouseEvent.ROLL_OVER, _rollOver );
				_target.removeEventListener( MouseEvent.ROLL_OUT, _rollOut );
			}
			
			_text = value;
			
			if ( _text ) {
				// イベントリスナーを登録する
				_target.addEventListener( MouseEvent.ROLL_OVER, _rollOver );
			}
		}
		private var _text:String;
		
		/**
		 * <p>ツールチップのテキスト色を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #defaultTextColor
		 */
		public function get textColor():uint { return _textColor; }
		public function set textColor( value:uint ):void { _textColor = value; }
		private var _textColor:uint = 0x000000;
		
		/**
		 * <p>ツールチップの背景色を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #defaultBackgroundColor
		 */
		public function get backgroundColor():uint { return _backgroundColor; }
		public function set backgroundColor( value:uint ):void { _backgroundColor = value; }
		private var _backgroundColor:uint = 0xFFFFEE;
		
		/**
		 * <p>ツールチップのボーダー色を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #defaultBorderColor
		 */
		public function get borderColor():uint { return _borderColor; }
		public function set borderColor( value:uint ):void { _borderColor = value; }
		private var _borderColor:uint = 0x000000;
		
		/**
		 * <p>ツールチップのフィルター設定を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #defaultFilters
		 */
		public function get filters():Array { return _filters;  }
		public function set filters( value:Array ):void { _filters = value; }
		private var _filters:Array;
		
		/**
		 * <p>ツールチップを表示するまでの遅延時間を秒で取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #defaultDelay
		 */
		public function get delay():Number { return _delay; }
		public function set delay( value:Number ):void { _delay = value; }
		private var _delay:Number = 0.0;
		
		
		
		
		
		/**
		 * <p>新しい ToolTip インスタンスを作成します。</p>
		 * <p>Creates a new ToolTip object.</p>
		 * 
		 * @param target
		 * <p>関連付けたい Sprite インスタンスです。</p>
		 * <p></p>
		 */
		public function ToolTip( target:Sprite ) {
			// 引数を設定する
			_target = target;
			
			// 初期化する
			_textColor = _defaultTextColor;
			_backgroundColor = _defaultBackgroundColor;
			_borderColor = _defaultBorderColor;
			_filters = _defaultFilters ? _defaultFilters.slice() : null;
			_delay = _defaultDelay;
		}
		
		
		
		
		
		/**
		 * <p>保持しているデータを解放します。
		 * dispose() メソッドが呼び出されると、それ以降はこのインスタンスのメソッドまたはプロパティを呼び出すと失敗し、例外がスローされます。</p>
		 * <p></p>
		 */
		public function dispose():void {
			// イベントリスナーを解除する
			_target.removeEventListener( MouseEvent.ROLL_OVER, _rollOver );
			_target.removeEventListener( MouseEvent.ROLL_OUT, _rollOut );
			
			// データを破棄する
			_target = null;
			_filters = null;
		}
		
		
		
		
		
		/**
		 * Timer.repeatCount で設定された数の要求が完了するたびに送出されます。
		 */
		private static function _timerComplete( e:TimerEvent ):void {
			// すでに表示されていれば削除する
			if ( _textField ) {
				_textField.parent.removeChild( _textField );
				_textField = null;
			}
			
			// TextField を作成する
			_textField = new TextField();
			_textField.defaultTextFormat = new TextFormat( "_ゴシック", 12, null, null, null, null, null, null, null, 3, 1 );
			_textField.text = _current._text;
			_textField.autoSize = TextFieldAutoSize.LEFT;
			_textField.background = true;
			_textField.backgroundColor = _current._backgroundColor;
			_textField.border = true;
			_textField.borderColor = _current._borderColor;
			_textField.textColor = _current._textColor;
			_textField.mouseEnabled = false;
			_textField.multiline = true;
			_textField.selectable = false;
			_textField.wordWrap = true;
			_textField.filters = [ _dropShadow ].concat( _current._filters || [] );
			
			// 位置を補正する
			_textField.x = _stage.mouseX + _marginX;
			_textField.y = _stage.mouseY + _marginY;
			_textField.x = Math.min( _stage.stageWidth - StageUtil.getMarginLeft( _stage ) - _textField.width - _padding, _textField.x );
			_textField.y = Math.min( _stage.stageHeight - StageUtil.getMarginTop( _stage ) - _textField.height - _padding * 3, _textField.y );
			
			// イベントリスナーを登録する
			_stage.addEventListener( Event.ENTER_FRAME, _enterFrame );
			_stage.addEventListener( Event.RESIZE, _resize );
			
			// イベントを実行する
			_resize( null );
			
			// 初期位置を設定する
			_textField.x = Math.min( _stage.stageWidth - StageUtil.getMarginLeft( _stage ) - _textField.width - _padding, _stage.mouseX + _marginX );
			_textField.y = Math.min( _stage.stageHeight - StageUtil.getMarginTop( _stage ) - _textField.height - _padding * 3, _stage.mouseY + _marginY );
			
			// 画面に表示する
			_stage.addChild( _textField );
		}
		
		/**
		 * 再生ヘッドが新しいフレームに入るときに送出されます。
		 */
		private static function _enterFrame( e:Event ):void {
			// 移動先の位置を取得します。
			var x:Number = _stage.mouseX + _marginX;
			var y:Number = _stage.mouseY + _marginY;
			
			// ステージからはみ出ている場合に補正する
			x = Math.min( _stage.stageWidth - StageUtil.getMarginLeft( _stage ) - _textField.width - _padding, x );
			y = Math.min( _stage.stageHeight - StageUtil.getMarginTop( _stage ) - _textField.height - _padding * 3, y );
			
			// マウスを追従する
			_textField.x += ( x - _textField.x ) * _friction;
			_textField.y += ( y - _textField.y ) * _friction;
		}
		
		/**
		 * 
		 */
		private static function _resize( e:Event ):void {
			// サイズを補正する
			_textField.wordWrap = false;
			_textField.autoSize = TextFieldAutoSize.LEFT;
			_textField.width = Math.min( _textField.width + 2, _stage.stageWidth - _padding * 2 );
			_textField.wordWrap = true;
		}
		
		/**
		 * Flash Player ウィンドウの InteractiveObject インスタンスの上でユーザーがポインティングデバイスのボタンを押すと送出されます。
		 */
		private static function _mouseDown( e:MouseEvent ):void {
			// イベントリスナーを解除する
			_stage.removeEventListener( Event.ENTER_FRAME, _enterFrame );
			_stage.removeEventListener( Event.RESIZE, _resize );
			_stage.removeEventListener( MouseEvent.MOUSE_DOWN, _mouseDown );
			
			// タイマーを停止する
			_timer.stop();
			
			// すでに表示されていれば削除する
			if ( _textField ) {
				_textField.parent.removeChild( _textField );
				_textField = null;
			}
		}
		
		/**
		 * ユーザーが InteractiveObject インスタンスにポインティングデバイスを合わせたときに送出されます。
		 */
		private function _rollOver( e:MouseEvent ):void {
			// イベントリスナーを解除する
			_target.removeEventListener( MouseEvent.ROLL_OVER, _rollOver );
			
			// 現在のツールチップを設定する
			_current = this;
			_stage = _target.stage;
			
			// タイマーを開始する
			_timer.reset();
			_timer.delay = _delay * 1000;
			_timer.start();
			
			// イベントリスナーを登録する
			_target.addEventListener( MouseEvent.ROLL_OUT, _rollOut );
			_stage.addEventListener( MouseEvent.MOUSE_DOWN, _mouseDown );
		}
		
		/**
		 * ユーザーが InteractiveObject インスタンスからポインティングデバイスを離したときに送出されます。
		 */
		private function _rollOut( e:MouseEvent ):void {
			// イベントリスナーを解除する
			_target.removeEventListener( MouseEvent.ROLL_OUT, _rollOut );
			
			// Stage が存在すれば
			if ( _stage ) {
				// イベントリスナーを解除する
				_stage.removeEventListener( Event.ENTER_FRAME, _enterFrame );
				_stage.removeEventListener( Event.RESIZE, _resize );
				_stage.removeEventListener( MouseEvent.MOUSE_DOWN, _mouseDown );
			}
			
			// タイマーを停止する
			_timer.stop();
			
			// すでに表示されていれば削除する
			if ( _textField ) {
				_textField.parent.removeChild( _textField );
				_textField = null;
			}
			
			// 現在のツールチップを破棄する
			_current = null;
			_stage = null;
			
			// イベントリスナーを登録する
			_target.addEventListener( MouseEvent.ROLL_OVER, _rollOver );
		}
	}
}
