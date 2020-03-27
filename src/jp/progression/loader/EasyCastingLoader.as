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
package jp.progression.loader {
	import flash.display.Stage;
	import flash.net.URLRequest;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.Progression;
	import jp.progression.scenes.EasyCastingScene;
	
	/**
	 * <p>EasyCastingLoader クラスは、読み込んだ拡張された PRML 形式の XML ファイルから自動的に、Progression インスタンスを作成するローダークラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // EasyCastingLoader インスタンスを作成する
	 * var loader:EasyCastingLoader = new EasyCastingLoader();
	 * </listing>
	 */
	public class EasyCastingLoader extends PRMLLoader {
		
		// クラスをコンパイルに含める
		EasyCastingScene;
		
		
		
		
		
		/**
		 * <p>新しい EasyCastingLoader インスタンスを作成します。</p>
		 * <p>Creates a new EasyCastingLoader object.</p>
		 * 
		 * @param stage
		 * <p>関連付けたい Stage インスタンスです。</p>
		 * <p></p>
		 * @param request
		 * <p>ダウンロードする URL を指定する URLRequest オブジェクトです。このパラメータを省略すると、ロード操作は開始されません。指定すると、直ちにロード操作が開始されます。詳細については、load を参照してください。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function EasyCastingLoader( stage:Stage, request:URLRequest = null, initObject:Object = null ) {
			// 親クラスを初期化する
			super( stage, request, initObject );
		}
		
		
		
		
		
		/**
		 * <p>XML データから Progression インスタンスを作成します。</p>
		 * <p></p>
		 * 
		 * @param xml
		 * <p>生成に使用する XML データです。</p>
		 * <p></p>
		 * @return
		 * <p>生成された Progression インスタンスです。</p>
		 * <p></p>
		 */
		public override function parse( xml:XML ):Progression {
			// cls 属性の値を全て上書きする
			for each ( var scene:XML in xml..scene ) {
				scene.@cls = "jp.progression.scenes.EasyCastingScene";
			}
			
			// XML の構文が間違っていれば例外をスローする
			if ( !EasyCastingScene.validate( xml ) ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_016 ).toString( "XML" ) ); }
			
			// 親のメソッドを実行する
			return super.parse( xml );
		}
	}
}
