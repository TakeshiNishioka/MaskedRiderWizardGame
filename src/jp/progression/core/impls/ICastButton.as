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
package jp.progression.core.impls {
	import flash.events.IEventDispatcher;
	import jp.progression.scenes.SceneId;
	
	/**
	 * @private
	 */
	public interface ICastButton extends IEventDispatcher {
		
		/**
		 * <p>ボタンがクリックされた時の移動先を示すシーン識別子を取得または設定します。
		 * sceneId プロパティと href プロパティが両方とも設定されている場合には、href プロパティの設定が優先されます。</p>
		 * <p></p>
		 * 
		 * @see #href
		 * @see #windowTarget
		 * @see #navigateTo()
		 */
		function get sceneId():SceneId;
		function set sceneId( value:SceneId ):void;
		
		/**
		 * <p>ボタンがクリックされた時の移動先の URL を取得または設定します。
		 * sceneId プロパティと href プロパティが両方とも設定されている場合には、href プロパティの設定が優先されます。</p>
		 * <p></p>
		 * 
		 * @see #sceneId
		 * @see #windowTarget
		 * @see #navigateTo()
		 */
		function get href():String;
		function set href( value:String ):void;
		
		/**
		 * <p>ボタンがクリックされた時の移動先を開くウィンドウ名を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see #sceneId
		 * @see #href
		 * @see #navigateTo()
		 * @see jp.progression.casts.CastButtonWindowTarget
		 */
		function get windowTarget():String;
		function set windowTarget( value:String ):void;
		
		/**
		 * <p>ボタンの機能をキーボードから使用するためのアクセスキーを取得または設定します。
		 * 設定できるキーはアルファベットの A ～ Z までの値です。</p>
		 * <p></p>
		 * 
		 * @see #sceneId
		 * @see #href
		 * @see #windowTarget
		 * @see #navigateTo()
		 */
		function get accessKey():String;
		function set accessKey( value:String ):void;
		
		/**
		 * <p>マウス状態に応じて Executor を使用した処理を行うかどうかを取得または設定します。</p>
		 * <p></p>
		 */
		function get mouseEventEnabled():Boolean;
		function set mouseEventEnabled( value:Boolean ):void;
		
		/**
		 * <p>CastButton インスタンスにポインティングデバイスが合わされているかどうかを取得します。</p>
		 * <p></p>
		 */
		function get isRollOver():Boolean;
		
		/**
		 * <p>CastButton インスタンスでポインティングデバイスのボタンを押されているかどうかを取得します。</p>
		 * <p></p>
		 */
		function get isMouseDown():Boolean;
		
		/**
		 * <p>ボタンの状態を取得します。</p>
		 * <p></p>
		 * 
		 * @see #sceneId
		 * @see jp.progression.casts.CastButtonState
		 */
		
		function get state():int;
		
		/**
		 * <p>指定されたシーン識別子、または URL の示す先に移動します。
		 * 引数が省略された場合には、あらかじめ CastButton インスタンスに指定されている sceneId プロパティ、 href プロパティが示す先に移動します。</p>
		 * <p></p>
		 * 
		 * @see #sceneId
		 * @see #href
		 * @see #windowTarget
		 * 
		 * @param location
		 * <p>移動先を示すシーン識別子、または URL です。</p>
		 * <p></p>
		 * @param window
		 * <p>location パラメータで指定されたドキュメントを表示するブラウザウィンドウまたは HTML フレームです。</p>
		 * <p></p>
		 */
		function navigateTo( location:*, window:String = null ):void;
	}
}
