
/**
 *============================================================
 * copyright(c).  www.itoz.jp
 * @author  itoz
 *============================================================
 *
 */
package jp.itoz.events
{
	import flash.events.Event;

	/**
	 * FadeSpriteによって送出されるイベント
	 */
	public class FadeEvent extends Event
	{
		public static const FADEIN_START 	 : String = "FADEIN_START";
        public static const FADEIN_PROGRESS  : String = "FADEIN_PROGRESS";
        public static const FADEIN_COMPLETE  : String = "FADEIN_COMPLETE";
        
		public static const FADEOUT_COMPLETE : String = "FADEOUT_COMPLETE";
        public static const FADEOUT_PROGRESS : String = "FADEOUT_PROGRESS";
		public static const FADEOUT_START 	 : String = "FADEOUT_START";
		
		public function FadeEvent (type : String , bubbles : Boolean = false , cancelable : Boolean = false)
		{
			super( type , bubbles , cancelable );
		}
	}
}
