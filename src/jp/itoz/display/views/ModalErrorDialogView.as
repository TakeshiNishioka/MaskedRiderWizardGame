/**
 *============================================================
 * copyright(c) 2011 www.itoz.jp
 * @author  itoz
 * 2011/04/15
 *============================================================
 *-2011.4.24 複数同時addChild時、二番目以降のErrorDialogの表示オブジェクトの位置を変更しても、変更されないバグを修正
 */
package jp.itoz.display.views
{
    import caurina.transitions.Tweener;
    import jp.itoz.display.window.AbstractErrorDialog;
    import jp.itoz.events.WindowEvent;




    /**
     * エラーメッセージを表示するビュー(シングルトン)
     * AbstractErrorDialogを継承したウィンドウクラスを、add()してfadeIn();
     */
    public class ModalErrorDialogView extends ModalView
    {
        public static var instance : ModalErrorDialogView = null;
        private static var callGetInstance : Boolean = false;
        private var _errors : Array;
        private var _active : Boolean;
        private var _window : AbstractErrorDialog;
        

        public static function getInstance() : ModalErrorDialogView
        {
            if ( instance == null ) {
                callGetInstance = true;
                ModalErrorDialogView.instance = new ModalErrorDialogView();
            }
            return instance;
        }

        public function ModalErrorDialogView()
        {
            if (callGetInstance) {
                super();
                callGetInstance = false;
                _errors = [];
                cover.alpha = 0;
            }
            else {
                throw new Error("This class can not create Instance!");
            }
        }

        // ======================================================================
        /**
         * 表示順番待ち配列に追加
         */
        public function add(window : AbstractErrorDialog) : void
        {
            _errors.push(window);
            center.addChild(window);
        }

        // ======================================================================
        /**
         * 背面カバー　fadeIn
         */
        final override public function fadeIn(obj : Object = null) : void
        {
            // すでにfadeIn済みならなにもしない。
            if (_active) return;
            chechNext();
        }

        // ======================================================================
        /**
         * 背面カバーfadeOut
         */
        final override public function fadeOut(obj : Object = null) : void
        {
            // super.fadeOut();
            Tweener.addTween(cover, {alpha:0, time:0.5, onComplete:fadeOutComplete});
        }

        // ======================================================================
        /**
         * 背面カバーfadeOutComplete
         */
        final override protected function fadeOutComplete() : void
        {
            // super.fadeOutComplete();
            _active = false;
            removeWindow();
            super.hideCover();
        }

        // ======================================================================
        /**
         * 表示するウィンドウがあるかチェック
         */
        private function chechNext() : void
        {
            if (_errors.length != 0) show();
            else fadeOut();
        }


        // =====================================================================
        /**
         * 背面カバーとウィンドウ表示
         */
        private function show() : void
        {
            _active = true;
            showCover();
            openWindow();
        }

        override protected function showCover() : void
        {
            super.showCover();
            Tweener.addTween(cover, {time:1, alpha:1});
        }
        
        // =====================================================================
        /**
         * ウィンドウOpen
         */
        private function openWindow() : void
        {
            removeWindow();
            _window = _errors[0] as AbstractErrorDialog;
            _window.addEventListener(WindowEvent.CLOSE_START, onWindowCloseStart);
            _window.addEventListener(WindowEvent.CLOSE_COMPLETE, onWindowCloseComplete);
            // center.addChild(_window);
            _window.open();
        }

        // =====================================================================
        /**
         * ウィンドウClose スタート
         */
        private function onWindowCloseStart(event : WindowEvent) : void
        {
        	if(_window.hasEventListener(WindowEvent.CLOSE_START)){
        		 _window.removeEventListener(WindowEvent.CLOSE_START, onWindowCloseStart);
            }
            _window.close();
        }

        // =====================================================================
        /**
         * ウィンドウClose コンプリート
         */
        private function onWindowCloseComplete(event : WindowEvent) : void
        {
            removeWindow();
            _errors.shift();
            chechNext();//次のウィンドウあるかチェック
        }

        // =====================================================================
        /**
         * ウィンドウ消去
         */
        private function removeWindow() : void
        {
            if (_window != null) {
                if (center.contains(_window)) {
                    center.removeChild(_window);
                }
                if (_window.hasEventListener(WindowEvent.CLOSE_START)) {
                    _window.removeEventListener(WindowEvent.CLOSE_START, onWindowCloseStart);
                }
                if (_window.hasEventListener(WindowEvent.CLOSE_COMPLETE)) {
                    _window.removeEventListener(WindowEvent.CLOSE_COMPLETE, onWindowCloseComplete);
                }
                _window.remove();
                _window = null;
            }
        }

        // ======================================================================
        /**
         * remove　
         * このメソッド以降、ErrorWindowは機能しなくなる。
         */
        override public function remove() : void
        {
            super.remove();
            removeWindow();
            if (_errors != null) {
                for (var i : int = 0; i < _errors.length; i++) {
                    var win : AbstractErrorDialog = _errors[i];
                    if (win != null) {
                        win.remove();
                    }
                }
                _errors = null;
            }
        }
    }
}

