/**
 *============================================================
 * copyright(c) 2011  www.itoz.jp
 * @author  itoz
 * 2011/04/15
 *============================================================
 */
package jp.itoz.display.window
{
    import flash.display.DisplayObjectContainer;
    import flash.display.GradientType;
    import flash.display.InteractiveObject;
    import flash.display.Shape;
    import flash.display.SpreadMethod;
    import flash.display.Sprite;
    import flash.filters.GlowFilter;
    import flash.geom.Matrix;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import jp.itoz.progression.commands.lists.TextAddAnimationList;
    import jp.itoz.progression.commands.lists.TextCutAnimationList;
    import jp.progression.commands.Prop;
    import jp.progression.commands.lists.LoopList;
    import jp.progression.commands.lists.SerialList;
    import jp.progression.commands.tweens.DoTweener;




    /**
     *  OrigineErrorDialog.as　
     *  [要 Progression]
     */
    public class OrigineErrorDialog extends AbstractErrorDialog 
    {
        private var _openSerialList : SerialList;
        private var _closeSerialList : SerialList;
        private var _twinkleList : LoopList;
        
        /**
         */
        public function OrigineErrorDialog(titleString : String = null, messageString : String = null, errorObject : Error = null, winWidth : int = 500, winHeight : int = 250, winMargin : int = 15)
        {
            super(titleString, messageString, errorObject, 420, 155, 8);// サイズの変更 マージンの変更
            
            _titleTextFormat 	= new TextFormat("＿ゴシック", 12, 0xffffff, true, null, null, null, null, TextFormatAlign.CENTER);
            _messageTextFormat  = new TextFormat("＿ゴシック", 14, 0xc0c600, null, null, null, null, null, TextFormatAlign.CENTER);
            _errorTextFormat 	= new TextFormat("＿ゴシック", 10, 0xaaaaaa, null, null, null, null, null, TextFormatAlign.CENTER);
        }
      
        // ======================================================================
        /** [★]初期表示状態セット
         */
        override protected function setLayout() : void
        {
        	super.setLayout();
            
            var _w : int = _winW - (_margin * 2);
            _titleTextField.width   = _w;
            _messageTextField.width = _w;
            _errorTextField.width   = _w;
            
            var rightX : int = -_winW / 2 ;
            var topY   : int = -_winH / 2 ;
            _titleTextField.x   = rightX + _margin ;
            _titleTextField.y   = topY + _margin;
            _messageTextField.x = rightX + _margin ;
            _messageTextField.y = topY + 42;
            _errorTextField.x   = rightX + _margin;
            _errorTextField.y   = topY + 67;
            _closeButton.x      = -_closeButton.width / 2;
            _closeButton.y      = _winH / 2 - _closeButton.height - _margin;
            
            _background.visible       = false;
            _background.alpha         = 0;
            _background.scaleY        = 0.3;
            _background.scaleX        = 0.2;
            _closeButton.visible      = false;
            _closeButton.alpha        = 0;
            _titleTextField.visible   = false;
            _messageTextField.visible = false;
            _errorTextField.visible   = false;
        }
       

        // ======================================================================
        /** open開始
         */
        override public function open() : void
        {
            super.open();
            
            _titleTextField.text   = "";
            _messageTextField.text = "";
            var errorText : String = _errorTextField.text;
            _errorTextField.text   = "";
            
            _twinkleList = new LoopList();
            _twinkleList.addCommand(
	            [
			        new DoTweener(_titleTextField,{alpha:0.6,time:0.3,transition:"easeInQuad"})
			        ,new DoTweener(_messageTextField,{alpha:0.6,time:0.3,transition:"easeInQuad"})
	            ]
	            ,[
	            	new DoTweener(_titleTextField,{alpha:1,time:0.3,transition:"easeOutQuad"})
	            	,new DoTweener(_messageTextField,{alpha:1,time:0.3,transition:"easeOutQuad"})
	            ]
            );
            _twinkleList.execute();
            
            _openSerialList = new SerialList(
           		{
           			onComplete:function():void{deleteSerialList(_openSerialList);}
           		}
            	,[
            		 new Prop(_background,{visible:true,alpha:0})
            	]
            		,new DoTweener(_background,  {time:0.3,  scaleX:1, alpha:1, delay:0.3, transition:"easeOutBack"})
            		,new DoTweener(_background,  {time:0.2, scaleY:1,   transition:"easeOutBack"})
            	,0.1
            	,[
            		 new Prop(_titleTextField,{visible:true})
            		,new Prop(_messageTextField,{visible:true})
            		,new Prop(_errorTextField,{visible:true})
            		,new Prop(_closeButton,{visible:true,alpha:0})
            	]
            	,[
            		 new TextAddAnimationList(null, _titleTextField, _title,0.01,_titleTextFormat)
            		,new TextAddAnimationList(null, _messageTextField, _message,0.01,_messageTextFormat)
            		,new TextAddAnimationList(null, _errorTextField, errorText,0.01,_errorTextFormat)
            		,new DoTweener(_closeButton,  {time:0.5, alpha:1,delay:0.5})
            	]
            	,function():void{openComplete();}
            );
            _openSerialList.execute();

        }
        
        
       
        // ======================================================================
        /** close開始
         */
        override public function close() : void
        {
            super.close();
            _closeSerialList = new SerialList(
	            {
	            	onComplete:function():void{deleteSerialList(_closeSerialList);}
	            }
	            ,[
	             	new TextCutAnimationList(null, _titleTextField,0.01)
            		,new TextCutAnimationList(null, _messageTextField,0.01)
            		,new TextCutAnimationList(null, _errorTextField,0.01)
            		,new DoTweener(_closeButton,  {time:0.25, alpha:0})
	            ]
        		,new DoTweener(_background,  {time:0.1, scaleY:0.1, transition:"easeOutQuad"})
        		,new DoTweener(_background,  {time:0.2, scaleX:0,  transition:"easeOutQuad"})
            	,function():void{closeComplete();}
            );
            _closeSerialList.execute();
        }
        
        


       // ======================================================================
        /** クローズボタン
         */
        override protected function createCloseButton() : InteractiveObject
        {
        	super.createCloseButton();
            var btn : Sprite = new Sprite();
            btn.mouseChildren = false;
            btn.buttonMode = true;
            var btnBG:Shape = btn.addChild(new Shape() ) as Shape;
        	var gradType : String = GradientType.LINEAR;
            var gradColors : Array = [0x5f5f5f,0x2b2b2b];
            var gradAlphas : Array = [1, 1];
            var gradRadios : Array = [0,200];
            var gradMrx : Matrix = new Matrix();
            var gradSpread : String = SpreadMethod.PAD;
            gradMrx.createGradientBox(20, 20, Math.PI / 2, 0,0);
            with(btnBG.graphics) {
                clear();
                beginGradientFill(gradType, gradColors, gradAlphas, gradRadios, gradMrx, gradSpread);
                drawRoundRect(0, 0, 150, 25, 3);
                endFill();
            }
            btn.filters = [new GlowFilter(0xffffff, 0.8,2,2,2)];
            var tf:TextField =btn.addChild(new TextField()) as TextField;
            tf.selectable=false;
            tf.text="OK";
            tf.setTextFormat(new TextFormat("＿ゴシック",12,0xecebc9,true,null,null,null,null,TextFormatAlign.CENTER));
            tf.width=150;
            tf.height = 25;
            tf.y= 3;
            return btn as InteractiveObject;
        }

        // ======================================================================
        /** 背景パネル
         */
        override protected function createBackground() : DisplayObjectContainer
        {
        	super.createBackground();
            var sp : Sprite = new Sprite() as Sprite;
            var gradType : String = GradientType.LINEAR;
            var gradColors : Array = [0x646565, 0x000000, 0x3c3d3d, 0x000000];
            var gradAlphas : Array = [0.7, 0.9, 0.7, 0.9];
            var gradRadios : Array = [0, 56, 57, 200];
            var gradMrx : Matrix = new Matrix();
            var gradSpread : String = SpreadMethod.PAD;
            gradMrx.createGradientBox(_winH, _winH, Math.PI / 2, -_winW / 2, -_winH / 2);
            with(sp.graphics) {
                clear();
                beginGradientFill(gradType, gradColors, gradAlphas, gradRadios, gradMrx, gradSpread);
                drawRoundRect(-_winW / 2, -_winH / 2, _winW, _winH, 15);
                endFill();
            }
            sp.filters = [new GlowFilter(0x000000, 0.3,32,32,2,2)];
            return sp as DisplayObjectContainer;
        }
        
        // ======================================================================
        /**
         * remove
         */
        override public function remove():void
        {
            super.remove();
            deleteSerialList(_twinkleList);
            deleteSerialList(_closeSerialList);
            deleteSerialList(_openSerialList);
            _openSerialList = null;
            _closeSerialList = null;
        }
         
        private function deleteSerialList(slist : SerialList) : void
        {
            if (slist != null) {
                if (slist.state == 2) {
                    //slist.dispose();
                }
                slist = null;
            }
        }
    }
}
