/**
 *============================================================
 * copyright(c). www.itoz.jp
 * @author  itoz
 * 2011/03/15
 *============================================================
 *
 */
package jp.itoz.display
{
    import jp.itoz.events.FadeEvent;
    import flash.events.Event;


    import flash.display.Sprite;

    /**
     * フェードスプライト (主に継承して使う)
     * @example :継承コピペ用
     * <listing version="3.0">
     *  override protected function init(initObj : Object = null) : void{super.init(initObj);}
     *  override protected function onAdded(e:Event) : void{super.onAdded(e);}
     *  
     *  override public function fadeIn(obj:Object =null) : void{super.fadeIn(obj);}
     *  override protected function fadeInProgress() : void{super.fadeInProgress();}
     *  override protected function fadeInComplete() : void{super.fadeInComplete();}
     *  
     *  override public function fadeOut(obj:Object =null) : void{super.fadeOut(obj);}
     *  override protected function fadeOutProgress() : void{super.fadeOutProgress();}
     *  override protected function fadeOutComplete() : void{super.fadeOutComplete();}
     * </listing>
     */
    public class FadeSprite extends Sprite
    {
        public function FadeSprite()
        {
            super();
            init(null);
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        // ======================================================================
        /**
         *初期化
         */
        protected function init(initObj : Object = null) : void
        {
        }

        // ======================================================================
        /**
         *ステージに追加された
         */
        protected function onAdded(event : Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        // ======================================================================
        /**
         *フェードイン
         */
        public function fadeIn(obj : Object = null) : void
        {
            dispatchEvent(new FadeEvent(FadeEvent.FADEIN_START));
        }

        // ======================================================================
        /**
         *フェードインプログレス
         */
        protected function fadeInProgress() : void
        {
            dispatchEvent(new FadeEvent(FadeEvent.FADEIN_PROGRESS));
        }

        // ======================================================================
        /**
         *フェードインコンプリート
         */
        protected function fadeInComplete() : void
        {
            dispatchEvent(new FadeEvent(FadeEvent.FADEIN_COMPLETE));
        }

        // ======================================================================
        /**
         *フェードアウト
         */
        public function fadeOut(obj : Object = null) : void
        {
            dispatchEvent(new FadeEvent(FadeEvent.FADEOUT_START));
        }

        // ======================================================================
        /**
         *フェードアウトプログレス
         */
        protected function fadeOutProgress() : void
        {
            dispatchEvent(new FadeEvent(FadeEvent.FADEOUT_PROGRESS));
        }

        // ======================================================================
        /**
         *フェードアウトコンプリート
         */
        protected function fadeOutComplete() : void
        {
            dispatchEvent(new FadeEvent(FadeEvent.FADEOUT_COMPLETE));
        }
    }
}
