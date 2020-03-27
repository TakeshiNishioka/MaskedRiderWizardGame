/**
 *============================================================
 * copyright(c) 2011  www.itoz.jp
 * @author  itoz
 * 2011/04/15
 *============================================================
 *-2011.4.24 ボタンオーバー時デザインとそれらのリムーブメソッドを追加
 */
package jp.itoz.display.window
{
    import flash.events.MouseEvent;
    import caurina.transitions.Tweener;
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


    /**
     *  ErrorDialog
     */
    public class ErrorDialog extends AbstractErrorDialog 
    {
        /**
         */
        public function ErrorDialog(titleString : String = null, messageString : String = null, errorObject : Error = null,  winWidth : int = 500, winHeight : int = 250, winMargin : int = 15)
        {
            super(titleString, messageString, errorObject,winWidth,winHeight,winMargin);
             
            _titleTextFormat 	= new TextFormat("＿ゴシック", 20, 0x3b496a, true, null, null, null, null, TextFormatAlign.CENTER);
            _messageTextFormat  = new TextFormat("＿ゴシック", 15, 0x333333, null, null, null, null, null, TextFormatAlign.CENTER);
            _errorTextFormat 	= new TextFormat("＿ゴシック", 12, 0x666666, null, null, null, null, null, TextFormatAlign.LEFT);
        }
      
        // ======================================================================
        /** 初期表示状態セット
         */
        override protected function setLayout() : void
        {
            super.setLayout();
            var _w : int = _winW - (_margin * 2);
            //位置をセット
            _titleTextField.width   = _w;
            _messageTextField.width = _w;
            _errorTextField.width   = _w;
            var rightX : int        = -_winW / 2 ;
            var topY   : int        = -_winH / 2;
            _titleTextField.x   = rightX + _margin ;
            _titleTextField.y   = topY + _margin + (_winH * 0.005);
            _messageTextField.x = rightX + _margin ;
            _messageTextField.y = topY + (_winH * 0.28);
            _errorTextField.x   = rightX + _margin;
            _errorTextField.y   = topY + (_winH * 0.43);
            _closeButton.x      = -_closeButton.width / 2;
            _closeButton.y      = _winH / 2 - _closeButton.height - _margin;
            //表示状態セット
            _background.alpha         = 0;
            _background.scaleX        = 1.2;
            _background.scaleY        = 1.2;
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
            super.open();// ここで visibleがtrueになる setLayout()が呼ばれる
            Tweener.addTween(_background, {time:0.5, scaleX:1, scaleY:1, alpha:1, delay:0.2, 
            	transition:"easeOutBack",
            	 onComplete:openComplete});// [★]open完了を伝えるためopenCompleteを呼ぶ
        }
         // ======================================================================
        /** open完了
         */
        override protected function openComplete() : void
        {
            super.openComplete();// ここで mouseChildrenがtrurになる
            _titleTextField.visible = true;
            _messageTextField.visible = true;
            if (_errorTextField != null) {
                _errorTextField.visible = true;
            }
            _closeButton.visible = true;
            Tweener.addTween(_closeButton, {time:0.5, alpha:1});
        }
        
        // ======================================================================
        /** close開始
         */
        override public function close() : void
        {
            super.close();// ここで mouseChildren = false;になる
            _titleTextField.visible = false;
            _messageTextField.visible = false;
            _closeButton.visible = false;
            if (_errorTextField != null) _errorTextField.visible = false;
            Tweener.addTween(_background, {time:0.25
            	, scaleX:0.2
            	, scaleY:0.2
            	, alpha:0
            	, transition:"easeInQuad"
            	, onComplete:closeComplete});// [★]close完了通知するため、closeCompleteを呼ぶ事
        }

        // ======================================================================
        /**
         * close完了
         */
        override protected function closeComplete() : void
        {
            super.closeComplete();// ここで visible = false;になる
        }

       // ======================================================================
        /**クローズボタン変更したい場合ここを書き換え
         */
        override protected function createCloseButton() : InteractiveObject
        {
        	super.createCloseButton();
            var btn : Sprite = new Sprite();
            btn.mouseChildren = false;
            btn.buttonMode = true;
            var btnUp:Shape = btn.addChild(new Shape() ) as Shape;
            btnUp.name="btnUp";
        	var gradType : String = GradientType.LINEAR;
            var gradColors : Array = [0xffffff,0xcdcdcd];
            var gradAlphas : Array = [1, 1];
            var gradRadios : Array = [0,200];
            var gradMrx : Matrix = new Matrix();
            var gradSpread : String = SpreadMethod.PAD;
            gradMrx.createGradientBox(50, 50, Math.PI / 2, 0,0);
            with(btnUp.graphics) {
                clear();
                beginGradientFill(gradType, gradColors, gradAlphas, gradRadios, gradMrx, gradSpread);
                drawRoundRect(0, 0, 150, 50, 3);
                endFill();
            }
            var btnOver : Shape = btn.addChild(new Shape()) as Shape;
            btnOver.name = "btnOver";
            gradColors = [0xa6bbc9, 0xfdfdfd];
            gradRadios = [50, 255];
            with(btnOver.graphics) {
                clear();
                beginGradientFill(gradType, gradColors, gradAlphas, gradRadios, gradMrx, gradSpread);
                drawRoundRect(0, 0, 150, 50, 3);
                endFill();
            }
            btnOver.visible=false;
            gradMrx.createGradientBox(_winH, _winH, Math.PI / 2, 0,0);
            
            btn.filters = [new GlowFilter(0x000000, 0.8,2,2,2)];
            var tf:TextField =btn.addChild(new TextField()) as TextField;
            tf.selectable=false;
            tf.text="OK";
            tf.setTextFormat(new TextFormat("＿ゴシック",17,0x3b496a,true,null,null,null,null,TextFormatAlign.CENTER));
            tf.width=150;
            tf.height = 25;
            tf.y= 12;
            btn.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
            btn.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
            return btn as InteractiveObject;
        }
        
       
        override protected function removeDefaultCloseButton() : void
        {
            var trgBtn : Sprite = _closeButton as Sprite;
            if (trgBtn != null) {
                var upShape : Shape = trgBtn.getChildByName("btnUp") as Shape;
                if (upShape != null) {
                    if (trgBtn.contains(upShape)) {
                        trgBtn.removeChild(upShape);
                    }
                    upShape = null;
                }
                var overShape : Shape = trgBtn.getChildByName("btnOver") as Shape;
                if (overShape != null) {
                    if (trgBtn.contains(overShape)) {
                        trgBtn.removeChild(overShape);
                    }
                    overShape = null;
                }
                if ( trgBtn.hasEventListener(MouseEvent.ROLL_OVER)) {
                    trgBtn.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
                }
                if ( trgBtn.hasEventListener(MouseEvent.ROLL_OUT)) {
                    trgBtn.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
                }
            }
            super.removeDefaultCloseButton();
        }

        private function onRollOut(event : MouseEvent) : void
        {
        	var trgBtn:Sprite = (event.target as Sprite );
        	var upShape:Shape = trgBtn.getChildByName("btnUp") as Shape;
        	var overShape:Shape = trgBtn.getChildByName("btnOver") as Shape;
        	upShape.visible=true;
        	overShape.visible=false;
        }

        private function onRollOver(event : MouseEvent) : void
        {
        	var trgBtn:Sprite = (event.target as Sprite );
        	var upShape:Shape = trgBtn.getChildByName("btnUp") as Shape;
        	var overShape:Shape = trgBtn.getChildByName("btnOver") as Shape;
        	upShape.visible=false;
        	overShape.visible=true;
        }

        // ======================================================================
        /** 背景パネル変更したい場合ここを書き換え
         */
        override protected function createBackground() : DisplayObjectContainer
        {
        	super.createBackground();
            var sp : Sprite = new Sprite() as Sprite;
            var gradType : String = GradientType.LINEAR;
            var gradColors : Array = [0xffffff, 0xcdcdcd, 0xdfdfdf, 0xffffff];
            var gradAlphas : Array = [1, 1, 1, 1];
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
            sp.filters = [new GlowFilter(0x000000, 0.3)];
            return sp as DisplayObjectContainer;
        }
    }
}
