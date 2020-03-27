package wizard 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Card extends Sprite
	{
		public function Card(width:int, height:int) { OnInit(width, height);  }
		
		/** 
		* カード画像 
		*/ 
		[Embed(source='/image/card.png')] 
		private var img_bace:Class;
		
		private var urlReq:URLRequest;
		private var loader:Loader;
		
		private var padding:int = 15;
		
		private var img_width:int;
		private var img_height:int;
		
		private var cardData:CardData;
		
		private var txt_name:TextField;
		private var txt_hp:TextField;
		private var txt_mp:TextField;
		
		private var base:Bitmap = Bitmap(new img_bace);
		private function OnInit(width:int, height:int) {
			// 背景の準備 
			base.width = width;
			base.height = height;
			addChild(base);
		}
		
		public function SetCardData(data:CardData):void
        {
			// データ設定
			cardData = data;
			
			// 背景の準備 
			var base:Bitmap = Bitmap(new img_bace);
			base.width = width;
			base.height = height;
			addChild(base);
			
			// 画像の準備 
			loader = new Loader();
			loader.alpha = 0;
			configureListeners(loader.contentLoaderInfo);
			loader.load( new URLRequest( cardData.URL ) );
			img_width = base.width - (padding * 2);
			img_height = img_width;
			
			var format:TextFormat = new TextFormat();
			format.size = 10;
			format.bold = true;
			// NAME
			format.align = TextFormatAlign.CENTER;
			txt_name = new TextField();
			txt_name.defaultTextFormat = format;
			txt_name.border = true;
			txt_name.background = true;
			txt_name.borderColor = 0x000000;
			txt_name.backgroundColor = txt_name.borderColor;
			txt_name.textColor = 0xFFFFFF;
			txt_name.width = base.width - (padding * 2);
			txt_name.height = 15;
			txt_name.x = padding; 
			txt_name.y = img_height + padding; 
			txt_name.alpha = 0;
			addChild(txt_name);
			// HP
			format.align = TextFormatAlign.LEFT;
			txt_hp = new TextField();
			txt_hp.defaultTextFormat = format;
			txt_hp.border = true;
			txt_hp.background = true;
			txt_hp.borderColor = 0x000000;
			txt_hp.backgroundColor = txt_hp.borderColor;
			txt_hp.textColor = 0xFFFFFF;
			txt_hp.width = txt_name.width ;
			txt_hp.height = txt_name.height;
			txt_hp.x = padding; 
			txt_hp.y = txt_name.y + txt_name.height + 5; 
			txt_hp.alpha = 0;
			addChild(txt_hp); 
			// MP
			txt_mp = new TextField();
			txt_mp.defaultTextFormat = format;
			txt_mp.border = true;
			txt_mp.background = true;
			txt_mp.borderColor = 0x000000;
			txt_mp.backgroundColor = txt_hp.borderColor;
			txt_mp.textColor = 0xFF9900;
			txt_mp.width = txt_hp.width ;
			txt_mp.height = txt_hp.height;
			txt_mp.x = padding; 
			txt_mp.y = txt_hp.y + txt_hp.height + 5; 
			txt_mp.alpha = 0;
			addChild(txt_mp); 
			// テキストの設定
			this.SetText();
			
			addEventListener(Event.ENTER_FRAME, FadeIn);
        }
		
		public function configureListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
		}

		public function completeHandler(evt:Event):void
		{
			loader.width = img_width;
			loader.height = img_height;
			loader.x = padding;
			loader.y = padding - 5;
			addChild(loader);
		}
		
		private function SetText():void
		{
			txt_name.text = cardData.Name;
			if (cardData.HP >= 100) {
				txt_hp.textColor = 0x3366FF;
			}
			if (cardData.HP <= 50) {
				txt_hp.textColor = 0xFF6600;
			}
			if (cardData.HP <= 0) {
				cardData.HP = 0;
				txt_hp.textColor = 0xFF0000;
				//SetNoise();
				addEventListener(Event.ENTER_FRAME, FadeOut);
			}
			txt_hp.text = " 【体力】　" + cardData.HP;
			txt_mp.text = " 【魔力】　" + cardData.MP;
		}
		
		private var bitmap_noise:Bitmap;
				
		private function SetNoise():void
		{
			if (bitmap_noise != null && this.contains(bitmap_noise)) this.removeChild(bitmap_noise);
			// ライダー画像の準備 
			var noise_data : BitmapData = new BitmapData( 512 , 512 , true , 0xFFFF8000);
			var rand = Math.floor(Math.random() * 0xFFFF);	// 適当な乱数
			noise_data.noise(rand ,0 , 255 , (8|4|2|1) , false);
			bitmap_noise = new Bitmap(noise_data);
			bitmap_noise.width = img_width;
			bitmap_noise.height = img_height;
			bitmap_noise.x = loader.x;
			bitmap_noise.y = loader.y;
			addChild(bitmap_noise); 
		}
		
		public function GetName():String
		{
			return cardData.Name;
		}
		
		public function GetHP():int
		{
			return cardData.HP;
		}
		
		public function SetDamage(damage:int):int
		{
			cardData.HP -= damage;
			this.SetText();
			return damage;
		}
		
		public function GetAttackPoint(diceNo:int):int
		{
			return diceNo * cardData.MP;
		}
		
		public function Clear():void {
			addEventListener(Event.ENTER_FRAME, FadeOut);
		}
		
		//フェードイン
		private function FadeIn(e:Event):void
		{
			if ( loader.alpha < 1) {
				loader.alpha += 0.05;
				txt_name.alpha += 0.05;
				txt_hp.alpha += 0.05;
				txt_mp.alpha += 0.05;
			} else {
				removeEventListener(Event.ENTER_FRAME, FadeIn);
			}
		}
		
		//フェードアウト
		private function FadeOut(e:Event):void
		{
			if ( loader.alpha > 0 ) {
				loader.alpha -= 0.05;
				txt_name.alpha -= 0.05;
				txt_hp.alpha -= 0.05;
				txt_mp.alpha -= 0.05;
			} else {
				removeEventListener(Event.ENTER_FRAME, FadeOut);
			}
		}

	}
}