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
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	
	/**
	 * @private
	 */
	public interface ICastPreloader extends ICastDocument {
		
		/**
		 * <p>読み込まれるコンテンツよりも前面に表示したい DisplayObject を管理する Sprite インスタンスを取得します。</p>
		 * <p></p>
		 */
		function get foreground():Sprite;
		
		/**
		 * <p>load() メソッドまたは loadBytes() メソッドを使用して読み込まれた SWF ファイルまたはイメージ（JPG、PNG、または GIF）ファイルのルート表示オブジェクトが含まれます。</p>
		 * <p>Contains the root display object of the SWF file or image (JPG, PNG, or GIF) file that was loaded by using the load() or loadBytes() methods.</p>
		 */
		function get content():DisplayObject;
		
		/**
		 * <p>読み込まれるコンテンツよりも背面に表示したい DisplayObject を管理する Sprite インスタンスを取得します。</p>
		 * <p></p>
		 */
		function get background():Sprite;
		
		/**
		 * <p>読み込まれているオブジェクトに対応する LoaderInfo オブジェクトを返します。</p>
		 * <p>Returns a LoaderInfo object corresponding to the object being loaded.</p>
		 */
		function get contentLoaderInfo():LoaderInfo;
		
		/**
		 * <p>そのメディアのロード済みのバイト数です。</p>
		 * <p>The number of bytes that are loaded for the media.</p>
		 */
		function get bytesLoaded():uint;
		
		/**
		 * <p>メディアファイル全体の圧縮後のバイト数です。</p>
		 * <p>The number of compressed bytes in the entire media file.</p>
		 */
		function get bytesTotal():uint;
	}
}
