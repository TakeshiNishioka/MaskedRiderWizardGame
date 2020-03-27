/**
 *============================================================
 * copyright(c) 2011 www.itoz.jp
 * @author  itoz
 * 2011/04/17 5:22:29
 *============================================================
 */
package jp.itoz.events
{
    import flash.events.Event;

    /**
     * AbstractWindowクラスによって送出されるEvent
     */
    public class WindowEvent extends Event
    {
        /**
         * @eventType WindowEvent.OPEN_START
         */
        public static const OPEN_START : String = "OPEN_START";
        /**
         * @eventType WindowEvent.OPEN_COMPLETE
         */
        public static const OPEN_COMPLETE : String = "OPEN_COMPLETE";
        /**
         * @eventType WindowEvent.CLOSE_START
         */
        public static const CLOSE_START : String = "CLOSE_START";
        /**
         *  @eventType WindowEvent.CLOSE_COMPLETE
         */
        public static const CLOSE_COMPLETE : String = "CLOSE_COMPLETE";

        public function WindowEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
        {
            super(type, bubbles, cancelable);
        }
    }
}
