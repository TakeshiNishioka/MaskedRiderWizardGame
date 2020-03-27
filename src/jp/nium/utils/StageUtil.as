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
package jp.nium.utils {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	
	/**
	 * <p>StageUtil クラスは、Stage 操作のためのユーティリティクラスです。</p>
	 * <p>The StageUtil class is an utility class for stage operation.</p>
	 */
	public class StageUtil {
		
		/**
		 * @private
		 */
		public function StageUtil() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>SWF ファイル書き出し時にドキュメントとして設定されたクラスを返します。</p>
		 * <p>Returns the class that set as document when writing the SWF file.</p>
		 * 
		 * @param stage
		 * <p>ドキュメントを保存している stage インスタンスです。</p>
		 * <p>The stage instance which save the document.</p>
		 * @return
		 * <p>ドキュメントとして設定された表示オブジェクトです。</p>
		 * <p>The display object that set as document.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getDocument( stage:Stage ):Sprite {
			for ( var i:int = 0, l:int = stage.numChildren; i < l; i++ ) {
				var child:Sprite = Sprite( stage.getChildAt( i ) );
				if ( child.root == child ) { return child; }
			}
			return null;
		}
		
		/**
		 * <p>ステージの左マージンを取得します。</p>
		 * <p>Get the left margin of the stage.</p>
		 * 
		 * @param stage
		 * <p>マージンを取得したい stage インスタンスです。</p>
		 * <p>The stage instance to get the margin.</p>
		 * @return
		 * <p>左マージンです。</p>
		 * <p>The left margin.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getMarginLeft( stage:Stage ):Number {
			// ドキュメントクラスを取得する
			var root:Sprite = getDocument( stage );
			
			try {
				var rootWidth:Number = root.loaderInfo.width;
				var stageWidth:Number = stage.stageWidth;
			}
			catch ( e:Error ) { return 0; }
			
			switch ( stage.scaleMode ) {
				case StageScaleMode.NO_SCALE	: {
					switch ( stage.align ) {
						case StageAlign.BOTTOM_LEFT		:
						case StageAlign.LEFT			:
						case StageAlign.TOP_LEFT		: { return 0; }
						case StageAlign.BOTTOM_RIGHT	:
						case StageAlign.RIGHT			:
						case StageAlign.TOP_RIGHT		: { return ( stageWidth - rootWidth ); }
						default							: { return ( stageWidth - rootWidth ) / 2; }
					}
				}
				case StageScaleMode.EXACT_FIT	:
				case StageScaleMode.NO_BORDER	:
				case StageScaleMode.SHOW_ALL	: { return 0; }
			}
			
			return 0;
		}
		
		/**
		 * <p>ステージの上マージンを取得します。</p>
		 * <p>Get the top margin of the stage.</p>
		 * 
		 * @param stage
		 * <p>マージンを取得したい stage インスタンスです。</p>
		 * <p>The stage instance to get the margin.</p>
		 * @return
		 * <p>上マージンです。</p>
		 * <p>The top margin.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getMarginTop( stage:Stage ):Number {
			// ドキュメントクラスを取得する
			var root:Sprite = getDocument( stage );
			
			try {
				var rootHeight:Number = root.loaderInfo.height;
				var stageHeight:Number = stage.stageHeight;
			}
			catch ( e:Error ) { return -1; }
			
			switch ( stage.scaleMode ) {
				case StageScaleMode.NO_SCALE	: {
					switch ( stage.align ) {
						case StageAlign.TOP				:
						case StageAlign.TOP_LEFT		:
						case StageAlign.TOP_RIGHT		: { return 0; }
						case StageAlign.BOTTOM			:
						case StageAlign.BOTTOM_LEFT		:
						case StageAlign.BOTTOM_RIGHT	: { return ( stageHeight - rootHeight ); }
						default							: { return ( stageHeight - rootHeight ) / 2; }
					}
				}
				case StageScaleMode.EXACT_FIT	:
				case StageScaleMode.NO_BORDER	:
				case StageScaleMode.SHOW_ALL	: { return 0; }
			}
			
			return 0;
		}
	}
}
