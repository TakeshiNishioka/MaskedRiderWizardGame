/**
 *============================================================
 * copyright(c) 2011 www.itoz.jp
 * @author  itoz
 * 2011/04/18
 *============================================================
 */
package jp.itoz.display.window
{
    import jp.itoz.events.WindowEvent;

    import flash.display.Sprite;

    /**
     *  AbstractWindow.as
     */
    public class AbstractWindow extends Sprite implements IWindow
    {
        public function AbstractWindow()
        {
        	visible = false;
        	mouseChildren = false;
        }

        public function open() : void
        {
            visible = true;
            dispatchEvent(new WindowEvent(WindowEvent.OPEN_START));
        }

        protected function openComplete() : void
        {
        	mouseChildren = true;
            dispatchEvent(new WindowEvent(WindowEvent.OPEN_COMPLETE));
        }

        public function close() : void
        {
        	mouseChildren = false;
            dispatchEvent(new WindowEvent(WindowEvent.CLOSE_START));
        }

        protected function closeComplete() : void
        {
        	visible = false;
            dispatchEvent(new WindowEvent(WindowEvent.CLOSE_COMPLETE));
        }
    }
}
