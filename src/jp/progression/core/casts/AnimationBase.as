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
package jp.progression.core.casts {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.progression.casts.CastMovieClip;
	import jp.progression.core.components.animation.IAnimationComp;
	
	/**
	 * @private
	 */
	public class AnimationBase extends CastMovieClip {
		
		/**
		 * <p>コンポーネントの実装として使用される場合の対象コンポーネントを取得します。</p>
		 * <p></p>
		 */
		public function get component():IAnimationComp { return _component; }
		private var _component:IAnimationComp;
		
		
		
		
		
		/**
		 * <p>新しい AnimationBase インスタンスを作成します。</p>
		 * <p>Creates a new AnimationBase object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function AnimationBase( initObject:Object = null ) {
			// 引数を設定する
			_component = initObject as IAnimationComp;
			
			// 親クラスを初期化する
			super( initObject );
			
			// 継承せずにインスタンスを生成しようとしたら例外をスローする
			if ( Object( this ).constructor == AnimationBase ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( super.className ) ); }
		}
	}
}
