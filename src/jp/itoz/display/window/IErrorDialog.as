/**
 *============================================================
 * copyright(c) 2011 www.itoz.jp
 * @author  itoz
 * 2011/04/18
 *============================================================
 */
package jp.itoz.display.window
{
    import flash.display.DisplayObjectContainer;
    import flash.display.InteractiveObject;
    import flash.text.TextField;
    import flash.text.TextFormat;


    /**
     *  IErrorWindow.as
     */
    public interface IErrorDialog extends IWindow
    {
        function set title(str : String) : void;
        function get title() : String ;

        function set message(str : String) : void;
        function get message() : String;

        function get titleTextField() : TextField;

        function get messageTextField() : TextField;

        function get errorTextField() : TextField;
        
		function set titleTextFormat(tfm:TextFormat):void;
		function set messageTextFormat(tfm:TextFormat):void;
		function set errorTextFormat(tfm:TextFormat):void;

        function set cover(cover : DisplayObjectContainer) : void;
        function get cover() : DisplayObjectContainer;
        
        function get closeButton() : InteractiveObject;
        function set closeButton(closeBtn : InteractiveObject) : void;

        function get background() : DisplayObjectContainer;
        function set background(bgPanel : DisplayObjectContainer) : void;
    }
}
