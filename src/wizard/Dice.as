package wizard 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Dice extends Sprite
	{
		
		public function Dice(width:int, height:int) { OnInit(width, height);  }
		
		/** 
		* サイコロ画像 
		*/ 
		[Embed(source='/image/dice1.png')] 
		private var img_dice1:Class;
		[Embed(source='/image/dice2.png')] 
		private var img_dice2:Class;
		[Embed(source='/image/dice3.png')] 
		private var img_dice3:Class;
		[Embed(source='/image/dice4.png')] 
		private var img_dice4:Class;
		[Embed(source='/image/dice5.png')] 
		private var img_dice5:Class;
		[Embed(source='/image/dice6.png')] 
		private var img_dice6:Class;
		
		private var arr_dice:Array;
		
		/** 
		* サイコロサイズ
		*/ 
		private var dice_width:int;
		private var dice_height:int;
		
		/** 
		* サイコロNO
		*/ 
		private var active_no:int;
		
		private function OnInit(width:int, height:int):void
        {
			arr_dice = [Bitmap(new img_dice1), Bitmap(new img_dice2), Bitmap(new img_dice3), Bitmap(new img_dice4), Bitmap(new img_dice5), Bitmap(new img_dice6)]
			dice_width = width;
			dice_height = height;
			
			arr_dice[0].width = dice_width;
			arr_dice[0].height = dice_height;
			addChild(arr_dice[0]);
        }
		
		public function Shuffle():int
        {
			OnEnterFrame(null);
			return active_no + 1;
        }
		
		public function startShuffle():void
        {
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
        }
		
		public function stopShuffle():int
        {
			removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
			return active_no + 1;
        }
		
		private function OnEnterFrame(e:Event):void
        {
			active_no = Math.floor(Math.random() * 6);
			arr_dice[active_no].width = dice_width;
			arr_dice[active_no].height = dice_height;
			if (this.contains(arr_dice[active_no])) removeChild(arr_dice[active_no]);
			addChild(arr_dice[active_no]);
        }
	}

}