/**
 *============================================================
 * copyright(c). www.itoz.jp
 * @author  itoz
 * 2011/4/15
 *============================================================
 *
 */
package jp.itoz.display.views
{
    import jp.itoz.display.FadeSprite;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.events.Event;

    /**
     * モーダル (主に継承して使う)
     * 常に最前面に、画面全体を覆うSpriteと
     * 常にステージ中央にいるSpriteを持つ
     */
    public class ModalView extends FadeSprite
    {
        private var _cover : DisplayObjectContainer;
        private var _center : Sprite;

        public function ModalView()
        {
            super();
            _center = new Sprite();
            cover = drawCover();
        }
        
        // ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        // ======================================================================
        // 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　setter getter
        // ======================================================================
        public function get center() : Sprite{return _center;}
        public function set center(center : Sprite) : void{ _center = center;}

        public function get cover() : DisplayObjectContainer {return _cover; }
        public function set cover(cover : DisplayObjectContainer) : void{
        	removeCover() ;
            _cover = cover;
            setDepth();
        }

        private function setDepth() : void
        {
            addChild(_cover);
            addChild(_center);
            resize(null);
        }

        // ======================================================================
        /**
         * onAdded
         */
        override protected function onAdded(e : Event) : void
        {
            super.onAdded(e);
            setDepth();
            stage.addChild(this);//表示ツリーの最前面にアドチャイルド
            stage.addEventListener(Event.ADDED, onSomthingAddedStage);
            stage.addEventListener(Event.RESIZE, resize);
        }

        // ======================================================================
        /**
         * 常に自分を表示ツリーの最前面に保つ　　　　
         */
        private function onSomthingAddedStage(event : Event) : void
        {
            stage.addChild(this);
        }
        // ======================================================================
        /**
         * 背面全体を覆うカバー　　　　
         */
        protected function drawCover() : Sprite
        {
            var cov : Sprite = new Sprite();
            cov.graphics.clear();
            cov.graphics.beginFill(0x000000, 0.6);
            cov.graphics.drawRect(0, 0, 1280, 800);
            cov.graphics.endFill();
            return cov;
        }

        protected function showCover() : void
        {
            _cover.visible = true;
        }

        protected function hideCover() : void
        {
            _cover.visible = false;
        }
       
        // ======================================================================
        /**
         * resize
         */
        protected function resize(event : Event) : void
        {
            if (stage != null) {
                var sw : Number = stage.stageWidth;
                var sh : Number = stage.stageHeight;
                var scx : int = (sw / 2);
                var scy : int = (sh / 2);
                if (_cover != null) {
                    _cover.width = sw;
                    _cover.height = sh;
                }
                if (_center != null) {
                    _center.x = (scx);
                    _center.y = (scy);
                }
            }
        }

        // ======================================================================
        /**
         * remove　　　
         */
        public function remove() : void
        {
            removeCover();
            if (stage != null) {
                if (stage.hasEventListener(Event.RESIZE)) {
                    stage.removeEventListener(Event.RESIZE, resize);
                }
                if (stage.hasEventListener(Event.ADDED)) {
                    stage.removeEventListener(Event.ADDED, onSomthingAddedStage);
                }
            }
           
            if (_center != null) {
                if (this.contains(_center)) {
                    this.removeChild(_center);
                }
                _center = null;
            }
        }

        private function removeCover() : void
        {
            if (_cover != null) {
                if (this.contains(_cover)) {
                    this.removeChild(_cover);
                }
                _cover = null;
            }
        }
    }
}
