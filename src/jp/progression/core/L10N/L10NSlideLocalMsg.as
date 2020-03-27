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
package jp.progression.core.L10N {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.I18N.Locale;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	
	/**
	 * @private
	 */
	public class L10NSlideLocalMsg {
		
		public static const JUMP_NEXT_SLIDE:String = "jumpNextSlide";
		Locale.setString( JUMP_NEXT_SLIDE, Locale.JAPANESE, "次へ" );
		Locale.setString( JUMP_NEXT_SLIDE, Locale.ENGLISH, "Go to Next Slide" );
		Locale.setString( JUMP_NEXT_SLIDE, Locale.FRENCH, "Aller à la page suivante" );
		Locale.setString( JUMP_NEXT_SLIDE, Locale.CHINESE, "" );
		
		public static const JUMP_PREVIOUS_SLIDE:String = "jumpPreviousSlide";
		Locale.setString( JUMP_PREVIOUS_SLIDE, Locale.JAPANESE, "前へ" );
		Locale.setString( JUMP_PREVIOUS_SLIDE, Locale.ENGLISH, "Go to Previous Slide" );
		Locale.setString( JUMP_PREVIOUS_SLIDE, Locale.FRENCH, "Retourner à la page précédante" );
		Locale.setString( JUMP_PREVIOUS_SLIDE, Locale.CHINESE, "" );
		
		public static const JUMP_FIRST_SLIDE:String = "jumpFirstSlide";
		Locale.setString( JUMP_FIRST_SLIDE, Locale.JAPANESE, "最初のスライド" );
		Locale.setString( JUMP_FIRST_SLIDE, Locale.ENGLISH, "Jump to First Slide" );
		Locale.setString( JUMP_FIRST_SLIDE, Locale.FRENCH, "Aller à la première page" );
		Locale.setString( JUMP_FIRST_SLIDE, Locale.CHINESE, "" );
		
		public static const JUMP_LAST_SLIDE:String = "jumpLastSlide";
		Locale.setString( JUMP_LAST_SLIDE, Locale.JAPANESE, "最後のスライド" );
		Locale.setString( JUMP_LAST_SLIDE, Locale.ENGLISH, "Jump to Last Slide" );
		Locale.setString( JUMP_LAST_SLIDE, Locale.FRENCH, "Aller à la dernière page" );
		Locale.setString( JUMP_LAST_SLIDE, Locale.CHINESE, "" );
		
		public static const FULL_SCREEN:String = "fullScreen";
		Locale.setString( FULL_SCREEN, Locale.JAPANESE, "全画面表示" );
		Locale.setString( FULL_SCREEN, Locale.ENGLISH, "Full Screen" );
		Locale.setString( FULL_SCREEN, Locale.FRENCH, "Plein écran" );
		Locale.setString( FULL_SCREEN, Locale.CHINESE, "" );
		
		
		
		
		
		/**
		 * @private
		 */
		public function L10NSlideLocalMsg() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
