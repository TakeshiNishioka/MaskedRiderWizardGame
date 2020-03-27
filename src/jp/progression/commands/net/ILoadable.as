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
	import flash.events.IEventDispatcher;
	
	/**
	 * <p>ILoadable インターフェイスは、対象のコマンドに読み込み処理操作を実装します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public interface ILoadable extends IEventDispatcher {
		
		/**
		 * <p>読み込み操作によって受信したデータです。</p>
		 * <p>The data received from the load operation.</p>
		 */
		function get data():*;
		function set data( value:* ):void;
		
		/**
		 * <p>現在の読み込み対象を取得します。</p>
		 * <p></p>
		 */
		function get target():ILoadable;
		
		/**
		 * <p>percent プロパティの算出時の自身の重要性を取得または設定します。</p>
		 * <p></p>
		 */
		function get factor():Number;
		function set factor( value:Number ):void;
		
		/**
		 * <p>loaded プロパティと total プロパティから算出される読み込み状態をパーセントで取得します。</p>
		 * <p></p>
		 */
		function get percent():Number;
		
		/**
		 * <p>登録されている ILoadable を実装したインスタンスの内、すでに読み込み処理が完了した数を取得します。</p>
		 * <p></p>
		 */
		function get loaded():uint;
		
		/**
		 * <p>登録されている ILoadable を実装したインスタンスの総数を取得します。</p>
		 * <p></p>
		 */
		function get total():uint;
		
		/**
		 * <p>対象の読み込み済みのバイト数です。</p>
		 * <p>The number of bytes that are loaded for the target.</p>
		 */
		function get bytesLoaded():uint;
		
		/**
		 * <p>全体の圧縮後のバイト数です。</p>
		 * <p>The number of compressed bytes in the entire target.</p>
		 */
		function get bytesTotal():uint;
	}
}
