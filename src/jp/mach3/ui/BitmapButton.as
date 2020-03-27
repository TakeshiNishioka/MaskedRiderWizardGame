package jp.mach3.ui
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	
	public class BitmapButton extends Sprite
	{
		private var images:Object = {
			normalImage:null,
			overImage:null,
			downImage:null,
			selectedImage:null
		};
		private var _hitRect:Rectangle = null;
		
		private var normalImage:Bitmap;
		private var overImage:Bitmap;
		private var downImage:Bitmap;
		private var selectedImage:Bitmap;
		private var hit:Sprite = new Sprite;
		
		private var rendered:Boolean = false;
		private var _selected:Boolean = false;
		
		public function BitmapButton():void {
		}
		public function setImages(_config:Object):void {
			for ( var i:* in _config ) {
				images[i] = _config[i];
			}
		}
		public function render():void {
			/* append bitmaps */
			for ( var i:* in images ) {
				this[i] = new Bitmap( images[i] );
				addChild(this[i]);
			}
			setStatus(1, 0, 0, 0);
			/* create hit area */
			var rect:Rectangle = ( _hitRect == null ) ?
				new Rectangle( 0, 0, normalImage.width, normalImage.height ) :
				_hitRect;
			var hitShape:Shape = new Shape;
			hitShape.graphics.beginFill(0xffffff, 0);
			hitShape.graphics.drawRect( rect.x, rect.y, rect.width, rect.height );
			hitShape.graphics.endFill();
			hit.addChild(hitShape);
			addChild(hit);
			hitArea = hit;
			/* events */
			buttonMode = true;
			useHandCursor = true;
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			/* end rendering */
			rendered = true;
		}
		private function setStatus( _n:int, _o:int, _d:int, _s:int ):void {
			normalImage.alpha = _n;
			overImage.alpha = _o;
			downImage.alpha = _d;
			selectedImage.alpha = _s;
		}
		private function onMouseOver(e:Event):void {
			if (!_selected) {
				setStatus(0, 1, 0, 0);
			}
		}
		private function onMouseOut(e:Event):void {
			if (!_selected) {
				setStatus(1, 0, 0, 0);
			}
		}
		private function onMouseDown(e:Event):void {
			if (!_selected) {
				setStatus(0, 0, 1, 0);
			}
		}
		private function onMouseUp(e:Event):void {
			if (!_selected) {
				setStatus(0, 1, 0, 0);
			}
		}
		public function get selected():Boolean {
			return _selected;
		}
		public function set selected(_v:Boolean):void {
			_selected = _v;
			if ( _v ) {
				setStatus(0, 0, 0, 1);
			}
		}
		public function get hitRect():Rectangle {
			return _hitRect;
		}
		public function set hitRect(_rect:Rectangle):void {
			if ( !rendered ) {
				_hitRect = _rect;
			} else {
				hit.x = _rect.x;
				hit.y = _rect.y;
				hit.width = _rect.width;
				hit.height = _rect.height;
			}
		}
	}
}