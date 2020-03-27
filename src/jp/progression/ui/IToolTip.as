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
	
	/**
	 * <p>IToolTip インターフェイスは、対象にツールチップ機能を実装します。</p>
	 * <p></p>
	 */
	public interface IToolTip {
		
		/**
		 * <p>関連付けられている Sprite インスタンスを取得します。</p>
		 * <p></p>
		 */
		function get target():Sprite;
		
		/**
		 * <p>ツールチップに表示するテキストを取得または設定します。</p>
		 * <p></p>
		 */
		function get text():String;
		function set text( value:String ):void;
		
		/**
		 * <p>ツールチップのテキスト色を取得または設定します。</p>
		 * <p></p>
		 */
		function get textColor():uint;
		function set textColor( value:uint ):void;
		
		/**
		 * <p>ツールチップの背景色を取得または設定します。</p>
		 * <p></p>
		 */
		function get backgroundColor():uint;
		function set backgroundColor( value:uint ):void;
		
		/**
		 * <p>ツールチップのボーダー色を取得または設定します。</p>
		 * <p></p>
		 */
		function get borderColor():uint;
		function set borderColor( value:uint ):void;
		
		
		
		
		
		/**
		 * <p>保持しているデータを解放します。
		 * dispose() メソッドが呼び出されると、それ以降はこのインスタンスのメソッドまたはプロパティを呼び出すと失敗し、例外がスローされます。</p>
		 * <p></p>
		 */
		function dispose():void;
	}
}
