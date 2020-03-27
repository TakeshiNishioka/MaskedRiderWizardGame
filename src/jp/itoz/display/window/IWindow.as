/**
 *============================================================
 * copyright(c) 2011 www.itoz.jp
 * @author  itoz
 * 2011/04/18
 *============================================================
 */
package jp.itoz.display.window
{
    import flash.events.IEventDispatcher;

    /**
     *  IWindow.as
     */
    public interface IWindow extends IEventDispatcher
    {
        function open() : void;

        function close() : void;
    }
}
