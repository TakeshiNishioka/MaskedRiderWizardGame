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
	import com.asual.swfaddress.SWFAddress;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.KeyboardEvent;
	import flash.printing.PrintJob;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import jp.nium.external.JavaScript;
	import jp.progression.Progression;
	
	/**
	 * <p>実行中のブラウザの標準的なキーボードショートカットに対応するように、キーボードイベントをマッピングします。
	 * <br /><br />
	 * <strong>キーボード対応表</strong>
	 * <table>
	 * 	<tr>
	 * 		<td>Backspace キー</td>
	 * 		<td rowspan="2">履歴を一つ戻す</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>CTRL キー + 左向き矢印キー</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>CTRL キー + 右向き矢印キー</td>
	 * 		<td>履歴を一つ進める</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>CTRL キー + R キー</td>
	 * 		<td rowspan="2">更新する</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>F5 キー</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>CTRL キー + P キー</td>
	 * 		<td>印刷ダイアログを開く</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>F11 キー</td>
	 * 		<td>フルスクリーンで表示する</td>
	 * 	</tr>
	 * </table>
	 * </p>
	 * <p>
	 * <br /><br />
	 * <strong>Table for keyboard input</strong>
	 * <table>
	 * 	<tr>
	 * 		<td>Backspace key</td>
	 * 		<td rowspan="2"></td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>CTRL key + Left Arrow key</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>CTRL key + Right Arrow key</td>
	 * 		<td></td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>CTRL key + R key</td>
	 * 		<td rowspan="2"></td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>F5 key</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>CTRL key + P key</td>
	 * 		<td></td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>F11 key</td>
	 * 		<td></td>
	 * 	</tr>
	 * </table>
	 * </p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class WebKeyboardMapper implements IKeyboardMapper {
		
		/**
		 * <p>関連付けられている Progression インスタンスを取得します。</p>
		 * <p></p>
		 */
		public function get target():Progression { return _target; }
		private var _target:Progression;
		
		/**
		 * Stage インスタンスを取得します。
		 */
		private var _stage:Stage;
		
		
		
		
		
		/**
		 * <p>新しい WebKeyboardMapper インスタンスを作成します。</p>
		 * <p>Creates a new WebKeyboardMapper object.</p>
		 * 
		 * @param target
		 * <p>関連付けたい Progression インスタンスです。</p>
		 * <p></p>
		 */
		public function WebKeyboardMapper( target:Progression ) {
			// 引数を設定する
			_target = target;
			_stage = _target.stage;
			
			// イベントリスナーを登録する
			_stage.addEventListener( KeyboardEvent.KEY_UP, _keyUp );
		}
		
		
		
		
		
		/**
		 * ユーザーがキーを離したときに送出されます。
		 */
		private function _keyUp( e:KeyboardEvent ):void {
			// フォーカスが TextField に存在している場合は終了する
			if ( _stage.focus is TextField ) { return; }
			
			switch ( e.keyCode ) {
				// 履歴を一つ戻す
				case Keyboard.BACKSPACE	: {
					if ( e.shiftKey || e.ctrlKey ) { return; }
					SWFAddress.back();
					break;
				}
				// 履歴を一つ戻す
				case Keyboard.LEFT		: {
					if ( e.shiftKey || !e.ctrlKey ) { break; }
					SWFAddress.back();
					break;
				}
				// 履歴を一つ進める
				case Keyboard.RIGHT		: {
					if ( e.shiftKey || !e.ctrlKey ) { break; }
					SWFAddress.forward();
					break;
				}
				// 更新する（CTRL キー + R キー）
				case 82					: {
					if ( e.shiftKey || !e.ctrlKey ) { break; }
					JavaScript.reload();
					break;
				}
				// 更新する（F5 キー）
				case Keyboard.F5		: {
					if ( e.shiftKey || e.ctrlKey ) { break; }
					JavaScript.reload();
					break;
				}
				// 印刷する（CTRL キー + P キー）
				case 80					: {
					if ( e.shiftKey || !e.ctrlKey ) { break; }
					
					if ( JavaScript.enabled ) {
						JavaScript.print();
					}
					else {
						var job:PrintJob = new PrintJob();
						if ( job.start() ) {
							job.addPage( Sprite( _target.root.container ) );
							job.send();
						}
					}
					break;
				}
				// フルスクリーンで表示する（F11 キー）
				case Keyboard.F11		: {
					if ( e.shiftKey || e.ctrlKey ) { break; }
					
					try {
						_stage.displayState = StageDisplayState.FULL_SCREEN;
					}
					catch ( e:Error ) {}
					
					break;
				}
			}
		}
	}
}
