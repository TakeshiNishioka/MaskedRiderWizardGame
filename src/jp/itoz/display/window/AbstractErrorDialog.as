/**
 *============================================================
 * copyright(c) 2011 www.itoz.jp
 * @author  itoz
 * 2011/04/18
 *============================================================
 *-2011.4.24 複数同時addChild時、二番目以降のErrorDialogの表示オブジェクトの位置を変更しても、変更されないバグを修正
 */
package jp.itoz.display.window
{
    import flash.display.DisplayObjectContainer;
    import flash.display.InteractiveObject;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import jp.itoz.display.views.ModalErrorDialogView;



    /**
     * 継承用エラーダイアログクラス
     * 
     * <p>[継承ポイント]<p>
     * <pre>
     * 初期表示状態は全てsetLayout()内に定義（addChild時コレが呼ばれる）
     * 
     * フェードイン開始時に open()
     * フェードイン完了時に openComplete()
     * フェードアウト開始時に close()
     * フェードアウト完了時に　closeComplete()
     * を必ず呼ぶ
     * 
     *  background のデザイン変更は createBackground() 内に定義しreturnする
     *  closeButton のデザイン変更は createCloseButton() 内に定義しreturnする
     *  </pre>
     */
    public class AbstractErrorDialog extends AbstractWindow implements IErrorDialog
    {
        // ----------------------------------------------------------------
        //singleton
        protected var _errorView : ModalErrorDialogView;
        // ----------------------------------------------------------------
        //property
        protected var _winW   : int;
        protected var _winH   : int;
        protected var _margin : int;
    	 // ----------------------------------------------------------------
        //data
        protected var _title   : String;
        protected var _message : String;
        protected var _error   : Error ;
         // ----------------------------------------------------------------
        //display objects
        protected var _background : DisplayObjectContainer;
        protected var _titleTextField : TextField;
        protected var _messageTextField : TextField;
        protected var _errorTextField : TextField;
        protected var _closeButton : InteractiveObject;
        // ----------------------------------------------------------------
        // Text Format
        protected var _titleTextFormat   : TextFormat = new TextFormat("＿ゴシック", 20, 0x3b496a, true, null, null, null, null, TextFormatAlign.CENTER);
        protected var _messageTextFormat : TextFormat = new TextFormat("＿ゴシック", 15, 0x333333, null, null, null, null, null, TextFormatAlign.CENTER);
        protected var _errorTextFormat   : TextFormat = new TextFormat("＿ゴシック", 12, 0x666666, null, null, null, null, null, TextFormatAlign.LEFT);

        public function AbstractErrorDialog(titleString : String = null, messageString : String = null, errorObject : Error = null, winWidth : int = 500, winHeight : int = 250, winMargin : int = 15)
        { 
        	super();
            _errorView = ModalErrorDialogView.getInstance();

            _title = (titleString != null) ? titleString : "ERROR TITLE";
            _message = (messageString != null) ? messageString : "Error massage.";
            _error = errorObject;

            _titleTextField = new TextField();
            _titleTextField.wordWrap = true;
            _titleTextField.text = title;
            
            _messageTextField = new TextField();
            _messageTextField.wordWrap = true;
            _messageTextField.text = _message;
            
            _errorTextField = new TextField();
            _errorTextField.wordWrap = true;
            if (_error != null) {
                _errorTextField.text = createErrorText(_error);
            }
            
            _winW = winWidth;
            _winH = winHeight;
            _margin = winMargin;
            
            background  = createBackground();
            closeButton = createCloseButton();
            
            init();
            
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        
        protected function init(initObject : Object = null) : void
        {
        }

      
        // ======================================================================
        /** onAdded
         */
        private function onAdded(e : Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            // 最前面に移動
            stage.addChild(_errorView);
             // 初期表示状態レイアウト
            setLayout();
            // このウィンドウを最前面ビューの順番待ち配列に追加
            _errorView.add(this as AbstractErrorDialog);
            // ビュー表示
            _errorView.fadeIn();
        }

        // ======================================================================
        /** 初期表示状態セット
         */
        protected function setLayout() : void
        {
            setSize(_winW, _winH);
            setMargin(_margin);
            setTextFormats();
            addChild(_background);
            addChild(_titleTextField);
            addChild(_messageTextField);
            addChild(_errorTextField);
            addChild(_closeButton);
        }
       
        // ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // ======================================================================
        // 　　　　　　　　　　　　　　　　　　　　　　　　　背景パネル　コレを継承して中身を書く
        // ======================================================================
        /**背景パネル作成
         */
        protected function createBackground() : DisplayObjectContainer
        {
            return null;
        }

        // ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // ======================================================================
        // 　　　　　　　　　　　　　　　　　　　　　　　　　クローズボタン　コレを継承して中身を書く
        // ======================================================================
        /** クローズボタン作成
         */
        protected function createCloseButton() : InteractiveObject
        {
            return null;
        }
        
        // ======================================================================
        /** クローズボタンクリック　　　
         */
        protected function onCloseClick(e : MouseEvent) : void
        {
            if (_closeButton != null) {
                if (_closeButton.hasEventListener(MouseEvent.CLICK)) {
                    _closeButton.removeEventListener(MouseEvent.CLICK, onCloseClick);
                }
            }
            close();
        }

        // ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // ======================================================================
        // 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　開く処理、閉じる処理
        // ======================================================================
        /**ウィンドウ開く処理
         */
        override public function open() : void
        {
            super.open();
        }

        // ======================================================================
        /** ウィンドウ開き終わった
         */
        override protected function openComplete() : void
        {
        	super.openComplete();
        }
  

        // ======================================================================
        /** ウィンドウ閉じる処理
         */
        override public function close() : void
        {
        	super.close();
        }

        // ======================================================================
        /** ウィンドウ閉じ終わった CLOSE_COMPLETEを配信
         */
        override protected function closeComplete() : void
        {
            super.closeComplete();
        }

        // ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // ======================================================================
        // 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　           　その他
        // ======================================================================
        /** TestField達にFormatセット
         */
        protected function setTextFormats() : void
        {
            _titleTextField.setTextFormat(_titleTextFormat);
        	_messageTextField.setTextFormat(_messageTextFormat);
        	_errorTextField.setTextFormat(_errorTextFormat);
        }

        // ======================================================================
        /**_errorTextFieldに表示するString生成
         */
        protected function createErrorText(error : Error) : String
        {
            return "ID : " + error.errorID + "\n" + "name : " + error.name + "\n" + "message : " + error.message;
        }
        
        // ======================================================================
        /**backgroundサイズ変更。
         */
        private function setSize(windowWidth : int, windowHeight : int) : void
        {
            _winW = windowWidth;
            _winH = windowHeight;
        }

        // ======================================================================
        /**background マージン変更
         */
        private function setMargin(winMargin : int) : void
        {
            _margin = winMargin;
        }
        
        // ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // ======================================================================
        // 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　setter getter
        // ======================================================================

        public function set title(str : String) : void { _title = str;_titleTextField.text = _title;setTextFormats();}
        public function get title()   : String { return _title;}

        public function set message(str : String) : void { _message = str;_messageTextField.text = _message;setTextFormats();}
        public function get message()   : String { return _message;}

        public function get titleTextField() : TextField{return _titleTextField;}

        public function get messageTextField() : TextField{return _messageTextField;}

        public function get errorTextField() : TextField{return _errorTextField;}
        
        public function set titleTextFormat(tfm : TextFormat) : void {_titleTextFormat = tfm;setTextFormats();}
        public function set messageTextFormat(tfm : TextFormat) : void{ _messageTextFormat = tfm; setTextFormats();}
        public function set errorTextFormat(tfm : TextFormat) : void{_errorTextFormat = tfm;setTextFormats();}
        
        public function set cover(cov : DisplayObjectContainer) : void{ _errorView.cover = cov;}
        public function get cover() : DisplayObjectContainer{return _errorView.cover;}

        public function get closeButton() : InteractiveObject{return _closeButton;}
        public function set closeButton(closeBtn : InteractiveObject) : void
        {
        	removeDefaultCloseButton();
            _closeButton = closeBtn;
            _closeButton.addEventListener(MouseEvent.CLICK, onCloseClick,false,0,true);
        }
        
        public function get background() : DisplayObjectContainer{return _background;}
        public function set background(bgPanel : DisplayObjectContainer) : void
        {
            setSize(bgPanel.width, bgPanel.height);
            removeBackground();
            _background = bgPanel;
        }
        
         // ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // ======================================================================
        // 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　remove
        // ======================================================================
        /** remove　　　　
         */
        public function remove() : void
        {
            _errorView = null;
            _title = null;
            _message = null;
            _error = null;
            _titleTextFormat = null;
            _messageTextFormat = null;
            _errorTextFormat = null;
            if (_titleTextField != null) {
                if (this.contains(_titleTextField)) {
                    (_titleTextField.parent).removeChild(_titleTextField);
                }
                _titleTextField = null;
            }
            if (_messageTextField != null) {
                if (this.contains(_messageTextField)) {
                    (_messageTextField.parent).removeChild(_messageTextField);
                }
                _messageTextField = null;
            }
            if (_errorTextField != null) {
                if (this.contains(_errorTextField)) {
                    (_errorTextField.parent).removeChild(_errorTextField);
                }
                _errorTextField = null;
            }
            removeDefaultCloseButton();
            removeBackground();
        }

        // ======================================================================
        /** 背景パネル消去　　　
         */
        protected function removeBackground() : void
        {
            if (_background != null) {
                if (this.contains(_background)) {
                    (_background.parent).removeChild(_background);
                }
                _background = null;
            }
        }

        // ======================================================================
        /** クローズボタン消去　　　
         */
        protected function removeDefaultCloseButton() : void
        {
            if (_closeButton != null) {
                if (this.contains(_closeButton)) {
                    (_closeButton.parent).removeChild(_closeButton);
                }
                if (_closeButton.hasEventListener(MouseEvent.CLICK)) {
                    _closeButton.removeEventListener(MouseEvent.CLICK, onCloseClick);
                }
                _closeButton = null;
            }
        }
    }
}
