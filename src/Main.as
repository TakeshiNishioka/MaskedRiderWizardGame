package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField; 
	import flash.text.TextFieldAutoSize; 
	import flash.geom.*; 
	import flash.media.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.errors.IOError;
	import flash.utils.Dictionary;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import com.adobe.serialization.json.JSON;
	
	import jp.mach3.ui.BitmapButton;
	import br.com.stimuli.loading.*;
	import wizard.*;
	import jp.itoz.display.window.*;
	
	/**
	 * ...
	 * @author Contents Works Inc.
	 */
	public class Main extends Sprite 
	{
		//ウィザードデータ
		[Embed(source="/data/wizard.json", mimeType="application/octet-stream")]
		private const json_wizard:Class;
		private const WizardJson:String = "data/wizard.json";
		private var list_wizard:Dictionary ;
		
		//ファントムデータ
		[Embed(source="/data/phantom.json", mimeType="application/octet-stream")]
		private const json_phantom:Class;
		private const PhantomJson:String = "data/phantom.json";
		private var list_phantom:Dictionary ;
		
		//白い魔法使いデータ
		[Embed(source="/data/whiteWizard.json", mimeType="application/octet-stream")] 
		private const json_whiteWizard:Class;
		private const WhiteWizardJson:String = "data/whiteWizard.json";
		private var list_whiteWizard:Dictionary ;
		
		/** 
		* ベルト用画像 
		*/ 
		[Embed(source='/image/wizardBelt.png')] 
		private const img_wizard_belt:Class;
		private var bitmap_wizard_belt:Bitmap;
		
		/** 
		* スゴロク用画像 
		*/ 
		[Embed(source='/image/startSquare.png')] 
		private const img_start_square:Class;
		[Embed(source='/image/goalSquare.png')] 
		private const img_goal_square:Class;
		[Embed(source='/image/shockerSquare.png')] 
		private const img_shocker_square:Class;
		[Embed(source='/image/wizardSquare.png')] 
		private const img_wizard_square:Class;
		
		[Embed(source='/image/wizardRing.png')] 
		private var img_ring:Class;
		private var bitmap_ring = Bitmap(new img_ring); 

		/** 
		* コマンド用ボタン
		*/ 
		[Embed(source='/image/cmd_on.png')] 
		private const img_cmd_on:Class;
		private var bitmap_cmd_on = Bitmap(new img_cmd_on); 
		private var btn_footmark:BitmapButton;
		private var btn_attack:BitmapButton;
		private var btn_escape:BitmapButton;
		private var btn_ring_flame:BitmapButton;
		private var btn_ring_water:BitmapButton;
		private var btn_ring_hurricane:BitmapButton;
		private var btn_ring_land:BitmapButton;
		
		/** 
		* 音楽 
		*/ 
		[Embed(source='/music/wizard.mp3')]
		private const BGM00:Class;
		[Embed(source='/music/flame.mp3')]
		private const BGM_flame:Class;
		[Embed(source='/music/water.mp3')]
		private const BGM_water:Class;
		[Embed(source='/music/hurricane.mp3')]
		private const BGM_hurricane:Class;
		[Embed(source='/music/land.mp3')]
		private const BGM_land:Class;
		private var channel:SoundChannel;
		
		/** 
		* テキスト 
		*/ 
		public var txt_line1:TextField;
		public var txt_line2:TextField;
		public var txt_line3:TextField;
		public var txt_line4:TextField;
		public var txt_line5:TextField;
		
		/** 
		* CWIロゴ 
		*/ 
		public var _logo_1:Sprite;
		public var _logo_2:Sprite;
		
		/** 
		* フラグ
		*/ 
		public var IsWizard:Boolean = false;
		public var IsBattle:Boolean = false;
		
		var bl:BulkLoader = new BulkLoader( "imageloader" );
		
		private var dice_wizard:Dice;
		private var dice_phantom:Dice;
		
		private var card_wizard:Card;
		private var card_phantom:Card;
		
		public function Main():void 
		{
			if (stage) Init();
			else addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(evt:Event = null):void
		{
			//背景
			this.graphics.beginFill( 0x000000, 0.8 );
			this.graphics.drawRoundRect(0, 0, 715, 510, 10, 10);
			this.graphics.endFill();
			this.graphics.beginFill( 0x000066, 1 );
			this.graphics.drawRoundRect(5, 5, 705, 500, 10, 10);
			this.graphics.endFill();
			
			var cwiB:Sprite = new CwiBlue();
			cwiB.x = 250;
			cwiB.y = 210;
			addChild(cwiB);
			var timer:Timer = new Timer(1, 100);
			// 指定した時間隔で、繰り返し実行されるイベント
			timer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void {
				cwiB.alpha -= 0.01;
			});
			// 指定した回数をすべて消化したときに呼び出されるイベント
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void {
				removeChild(cwiB);
				InitStage(evt);
			});
			// タイマー開始
			timer.start();
		}
		
		private function InitStage(evt:Event):void
		{
			//コマンド背景
			this.graphics.beginFill( 0xFFFFFF, 0.6 );
			this.graphics.drawRoundRect(15, 430, 685, 65, 10, 10);
			this.graphics.endFill();
			
			//ウィザードデータ読み込み
			InitWizardData();
			//ファントムデータ読み込み
			InitPhantomData();
			//白い魔法使いデータ読み込み
			InitWhiteWizardData();
			
			// ベルト
			this.InitWizardBelt(150, 10, 60);
			
			// メッセージボード
			this.InitMsgBoard(160, 255, 370, 20)
			
			// スゴロク
			this.InitSquareLine(30, 370, 50, 11);
			
			// ウィザードカード
			this.SetInitWizardCard();
			// ウィザード用サイコロ
			dice_wizard = new Dice(50, 50);
			dice_wizard.x = 60;
			dice_wizard.y = 285;
			addChild(dice_wizard); 

			// ファントムカード
			this.SetInitPhantomCard();
			// ファントム用サイコロ
			dice_phantom = new Dice(50, 50);
			dice_phantom.x = 585;
			dice_phantom.y = 285;
			addChild(dice_phantom); 
			
			// コマンドの準備 
			bl.add("image/footmark.png");
			bl.add("image/footmark_on.png");
			bl.add("image/attack.png");
			bl.add("image/attack_on.png");
			bl.add("image/escape.png");
			bl.add("image/escape_on.png");
			bl.add("image/flame.png");
			bl.add("image/flame_on.png");
			bl.add("image/water.png");
			bl.add("image/water_on.png");
			bl.add("image/hurricane.png");
			bl.add("image/hurricane_on.png");
			bl.add("image/land.png");
			bl.add("image/land_on.png");
			bl.addEventListener( BulkProgressEvent.COMPLETE, InitCmdBtn );
			bl.start();
			
			var s:Sound = new BGM00();
			channel = s.play(0,0) 
			
			// イベントを登録
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN , KeyDownAction);
		}
		
		/**
		 * ウィザードデータ読み込み
		 */
		private function InitWizardData():void {
			//ウィザード情報を取得 (外部JSON)
			var json:Object = JSON.decode(new json_wizard);
			list_wizard = new Dictionary();
			
			var no:int = 0;
			var data_wizard:CardData;
			for each(var Wizard:Object in json.wizard) {	
				data_wizard = new CardData;
				data_wizard.URL = Wizard.image;
				data_wizard.Name = Wizard.name;
				data_wizard.HP = Wizard.hp;
				data_wizard.MP = Wizard.mp;
				list_wizard[no] = data_wizard;
				no++;
			}
		}
		
		/**
		 * ファントムデータ読み込み
		 */
		private function InitPhantomData():void {
			//ファントム情報を取得 (外部JSON)
			var json:Object = JSON.decode(new json_phantom);
			list_phantom = new Dictionary();
			
			var no:int = 0;
			var data_phantom:CardData;
			for each(var Phantom:Object in json.phantom) {	
				data_phantom = new CardData;
				data_phantom.URL = Phantom.image;
				data_phantom.Name = Phantom.name;
				data_phantom.HP = Phantom.hp;
				data_phantom.MP = Phantom.mp;
				list_phantom[no] = data_phantom;
				no++;
			}
		}
		
		/**
		 * 白い魔法使いデータ読み込み
		 */
		private function InitWhiteWizardData():void {
			//白い魔法使い情報を取得 (外部JSON)
			var json:Object = JSON.decode(new json_whiteWizard);
			list_whiteWizard = new Dictionary();
			
			var no:int = 0;
			var data_whiteWizard:CardData;
			for each(var WhiteWizard:Object in json.wizard) {	
				data_whiteWizard = new CardData;
				data_whiteWizard.URL = WhiteWizard.image;
				data_whiteWizard.Name = WhiteWizard.name;
				data_whiteWizard.HP = WhiteWizard.hp;
				data_whiteWizard.MP = WhiteWizard.mp;
				list_whiteWizard[no] = data_whiteWizard;
				no++;
			}
		}
		
		/**
		 * 白い魔法使いデータ読み込みが完了
		 * @param	evt
		 */
		private function SetupWhiteWizardData(evt:Event):void
		{
			var loader:URLLoader = evt.currentTarget as URLLoader;
			loader.removeEventListener(Event.COMPLETE, SetupWhiteWizardData);
			
			var str:String = loader.data as String;
			if (str) 
			{
				var json:Object = JSON.decode(str);
				list_whiteWizard = new Dictionary();
				
				var no:int = 0;
				var data_whiteWizard:CardData;
				for each(var whiteWizard:Object in json.wizard) {	
					data_whiteWizard = new CardData;
					data_whiteWizard.URL = whiteWizard.image;
					data_whiteWizard.Name = whiteWizard.name;
					data_whiteWizard.HP = whiteWizard.hp;
					data_whiteWizard.MP = whiteWizard.mp;
					list_whiteWizard[no] = data_whiteWizard;
					no++;
				}
			}
		}

		private var cmd_on_no:int; 
		// キーボードを押したときに実行される関数
		function KeyDownAction(e:KeyboardEvent):void {
			var cmd_line_min:int = 1;
			var cmd_line_max:int = 7;
			if (IsBattle) cmd_line_min = 2;
			if (!IsBattle) cmd_line_max = 0;
			
			switch (e.keyCode) {
				case 37 :
					if (cmd_on_no > cmd_line_min && cmd_on_no <= cmd_line_max) {
						bitmap_cmd_on.x -= (45 + 15);
						cmd_on_no--;
					}
					break;
				case 39 :
					if (cmd_on_no >= cmd_line_min && cmd_on_no < cmd_line_max) {
						bitmap_cmd_on.x += (45 + 15);
						cmd_on_no++;
					}
					break;
				case 13 :
					switch(cmd_on_no){
						case 1 : 
							OnBtnFootmarkMouseDown(null);
							break;
						case 2 : 
							OnBtnAttackMouseDown(null);
							break;
						case 3 : 
							OnBtnEscapeMouseDown(null);
							break;
						case 4 : 
							OnBtnRingMouseDown(null, list_wizard[0]);
							break;
						case 5 : 
							OnBtnRingMouseDown(null, list_wizard[1]);
							break;
						case 6 : 
							OnBtnRingMouseDown(null, list_wizard[2]);
							break;
						case 7 : 
							OnBtnRingMouseDown(null, list_wizard[3]);
							break;
					}
				  break;
				default : break;
			}
		};
		
		private function SetInitWizardCard():void {
			var data_wizard:CardData = new CardData;
			data_wizard.URL = "image/haruto.png";
			data_wizard.Name = "操真　晴人";
			data_wizard.HP = 1000;
			data_wizard.MP = 50;
			this.SetWizardCard(data_wizard);
			IsWizard = false;
		}
		
		private function SetWizardCard(data_wizard:CardData):void {
			if (card_wizard != null && this.contains(card_wizard)) this.removeChild(card_wizard);
			card_wizard = new Card(130, 180);
			card_wizard.SetCardData(data_wizard);
			card_wizard.x = 15;
			card_wizard.y = 80;
			addChild(card_wizard); 
		}

		private function SetInitPhantomCard():void {
			if (card_phantom != null && this.contains(card_phantom)) this.removeChild(card_phantom);
			card_phantom = new Card(130, 180);
			card_phantom.x = 560;
			card_phantom.y = 80;
			addChild(card_phantom); 
		}
		
		private function SetPhantomCard(data_phantom:CardData):void {
			if (card_phantom != null && this.contains(card_phantom)) this.removeChild(card_phantom);
			card_phantom = new Card(130, 180);
			card_phantom.SetCardData(data_phantom);
			card_phantom.x = 560;
			card_phantom.y = 80;
			addChild(card_phantom); 
		}
		
		/**
		 * ベルト表示
		 */
		private function InitWizardBelt(x:int, y:int, zoom:int):void 
		{ 
			// ベルト画像の準備 
			bitmap_wizard_belt = Bitmap(new img_wizard_belt); 
			bitmap_wizard_belt.width = bitmap_wizard_belt.width * (zoom * 0.01); 
			bitmap_wizard_belt.height = bitmap_wizard_belt.height * (zoom * 0.01); 
			bitmap_wizard_belt.x = x;
			bitmap_wizard_belt.y = y;
			this.addChild(bitmap_wizard_belt); 
		}
		
		var ShockerSquareNo : Array = new Array();
		var SquareCount:int; 
		var SquareNo:int = 1; 
				
		/**
		 * スゴロク表示
		 */
		private function InitSquareLine(x:int, y:int, size:int, cnt:int):void 
		{ 
			cnt = cnt + 1;
			// ベルト画像の準備 
			var bitmap_start_square = Bitmap(new img_start_square); 
			bitmap_start_square.width = size; 
			bitmap_start_square.height = size; 
			bitmap_start_square.x = x;
			bitmap_start_square.y = y;
			this.addChild(bitmap_start_square); 
			
			for (var i:int = 1; i < cnt; i++) {
				if (Math.floor(Math.random() * 2) > 0) {
					var bitmap_wizard_square = Bitmap(new img_wizard_square); 
					bitmap_wizard_square.width = size; 
					bitmap_wizard_square.height = size; 
					bitmap_wizard_square.x = x + (size * i);
					bitmap_wizard_square.y = y;
					this.addChild(bitmap_wizard_square); 
				}
				else {
					var bitmap_shocker_square = Bitmap(new img_shocker_square); 
					bitmap_shocker_square.width = size; 
					bitmap_shocker_square.height = size; 
					bitmap_shocker_square.x = x + (size * i);
					bitmap_shocker_square.y = y;
					this.addChild(bitmap_shocker_square); 
					ShockerSquareNo.push(i);
				}
			}
			
			var bitmap_goal_square = Bitmap(new img_goal_square); 
			bitmap_goal_square.width = size; 
			bitmap_goal_square.height = size; 
			bitmap_goal_square.x = x + (size * cnt);
			bitmap_goal_square.y = y;
			this.addChild(bitmap_goal_square); 
			
			bitmap_ring.width = size; 
			bitmap_ring.height = size; 
			bitmap_ring.x = x;
			bitmap_ring.y = y;
			this.addChild(bitmap_ring); 
			
			SquareCount = cnt + 1;
		}
		
		/**
		 * メッセージボード表示
		 */
		private function InitMsgBoard(x:int, y:int, width:int, height:int):void 
		{ 
			txt_line1 = new TextField();
			txt_line1.border = true;
			txt_line1.background = txt_line1.border;
			txt_line1.borderColor = 0x000000;
			txt_line1.backgroundColor = txt_line1.borderColor;
			txt_line1.textColor = 0xFFFFFF;
			txt_line1.width = width;
			txt_line1.height = height;
			txt_line1.x = x; 
			txt_line1.y = y; 
			addChild(txt_line1); 
			txt_line2 = new TextField();
			txt_line2.border = true;
			txt_line2.background = txt_line2.border;
			txt_line2.borderColor = 0x000000;
			txt_line2.backgroundColor = txt_line2.borderColor;
			txt_line2.textColor = 0xFFFFFF;
			txt_line2.width = width;
			txt_line2.height = height;
			txt_line2.x = x; 
			txt_line2.y = y + height; 
			addChild(txt_line2); 
			txt_line3 = new TextField();
			txt_line3.border = true;
			txt_line3.background = txt_line3.border;
			txt_line3.borderColor = 0x000000;
			txt_line3.backgroundColor = txt_line3.borderColor;
			txt_line3.textColor = 0xFFFFFF;
			txt_line3.width = width;
			txt_line3.height = height;
			txt_line3.x = x; 
			txt_line3.y = y + height + height;  
			addChild(txt_line3); 
			txt_line4 = new TextField();
			txt_line4.border = true;
			txt_line4.background = txt_line4.border;
			txt_line4.borderColor = 0x000000;
			txt_line4.backgroundColor = txt_line4.borderColor;
			txt_line4.textColor = 0xFFFFFF;
			txt_line4.width = width;
			txt_line4.height = height;
			txt_line4.x = x; 
			txt_line4.y = y + height + height + height;  
			addChild(txt_line4); 
			txt_line5 = new TextField();
			txt_line5.border = true;
			txt_line5.background = txt_line5.border;
			txt_line5.borderColor = 0x000000;
			txt_line5.backgroundColor = txt_line5.borderColor;
			txt_line5.textColor = 0xFFFFFF;
			txt_line5.width = width;
			txt_line5.height = height;
			txt_line5.x = x; 
			txt_line5.y = y + height + height + height + height;  
			addChild(txt_line5);
			
			SetMsg("----------------------------------------操作方法----------------------------------------");
			SetMsg("【足跡】サイコロの目の数だけ進む。");
			SetMsg("【パンチ／非常口】サイコロの目で勝てば攻撃／逃走する。");
			SetMsg("【ウィザードリング】一定時間のみ仮面ライダーウィザードで戦える。");
			SetMsg("----------------------------------------操作方法----------------------------------------");
		}
		
		private function SetCmdBtnOn( no:int): void {
			var x:int = 28;
			bitmap_cmd_on.x = x + ((45 + 15) * no);
			cmd_on_no = no + 1;
		}
		
		/**
		 * コマンドボタン表示
		 */
		private function InitCmdBtn( e:Event ) : void
		{
			var x:int = 30;
			var y:int = 442;
			var padding:int = 15;
			var size:int = 45;
			var x_cut:int = 0;
			
			// コマンド：選択状態
			bitmap_cmd_on = Bitmap(new img_cmd_on); 
			bitmap_cmd_on.width = size; 
			bitmap_cmd_on.height = size; 
			bitmap_cmd_on.x = x - 2;
			bitmap_cmd_on.y = y - 2;
			this.addChild(bitmap_cmd_on); 
			cmd_on_no = 1;
			
			// 足跡
			btn_footmark = new BitmapButton();
			btn_footmark.setImages( {
				normalImage: bl.getBitmapData("image/footmark.png"),
				overImage: bl.getBitmapData("image/footmark_on.png"),
				downImage: bl.getBitmapData("image/footmark_on.png"),
				selectedImage: bl.getBitmapData("image/footmark_on.png")
			} );
			btn_footmark.render();
			btn_footmark.width = size;
			btn_footmark.height = size;
			btn_footmark.x = x + (size * x_cut) + (padding * x_cut);
			btn_footmark.y = y;
			btn_footmark.addEventListener(MouseEvent.MOUSE_DOWN, OnBtnFootmarkMouseDown);
			addChild(btn_footmark);
			x_cut++;
			
			// 攻撃
			btn_attack = new BitmapButton();
			btn_attack.setImages( {
				normalImage: bl.getBitmapData("image/attack.png"),
				overImage: bl.getBitmapData("image/attack_on.png"),
				downImage: bl.getBitmapData("image/attack_on.png"),
				selectedImage: bl.getBitmapData("image/attack_on.png")
			} );
			btn_attack.render();
			btn_attack.width = size;
			btn_attack.height = size;
			btn_attack.x = x + (size * x_cut) + (padding * x_cut);
			btn_attack.y = y;
			btn_attack.addEventListener(MouseEvent.MOUSE_DOWN, OnBtnAttackMouseDown); 
			addChild(btn_attack); 
			x_cut++;
			
			// 逃亡
			btn_escape = new BitmapButton();
			btn_escape.setImages( {
				normalImage: bl.getBitmapData("image/escape.png"),
				overImage: bl.getBitmapData("image/escape_on.png"),
				downImage: bl.getBitmapData("image/escape_on.png"),
				selectedImage: bl.getBitmapData("image/escape_on.png")
			} );
			btn_escape.render();
			btn_escape.width = size;
			btn_escape.height = size;
			btn_escape.x = x + (size * x_cut) + (padding * x_cut);
			btn_escape.y = y;
			btn_escape.addEventListener(MouseEvent.MOUSE_DOWN, OnBtnEscapeMouseDown); 
			addChild(btn_escape); 
			x_cut++;
			
			// フレームリング
			btn_ring_flame = new BitmapButton();
			btn_ring_flame.setImages( {
				normalImage: bl.getBitmapData("image/flame.png"),
				overImage: bl.getBitmapData("image/flame_on.png"),
				downImage: bl.getBitmapData("image/flame_on.png"),
				selectedImage: bl.getBitmapData("image/flame_on.png")
			} );
			btn_ring_flame.render();
			btn_ring_flame.width = size;
			btn_ring_flame.height = size;
			btn_ring_flame.x = x + (size * x_cut) + (padding * x_cut);
			btn_ring_flame.y = y;
			btn_ring_flame.addEventListener(MouseEvent.MOUSE_DOWN, function(event:MouseEvent):void{ OnBtnRingMouseDown(event, list_wizard[0])}); 
			addChild(btn_ring_flame); 
			x_cut++;
			
			// ウォーターリング
			btn_ring_water = new BitmapButton();
			btn_ring_water.setImages( {
				normalImage: bl.getBitmapData("image/water.png"),
				overImage: bl.getBitmapData("image/water_on.png"),
				downImage: bl.getBitmapData("image/water_on.png"),
				selectedImage: bl.getBitmapData("image/water_on.png")
			} );
			btn_ring_water.render();
			btn_ring_water.width = size;
			btn_ring_water.height = size;
			btn_ring_water.x = x + (size * x_cut) + (padding * x_cut);
			btn_ring_water.y = y;
			btn_ring_water.addEventListener(MouseEvent.MOUSE_DOWN, function(event:MouseEvent):void{ OnBtnRingMouseDown(event, list_wizard[1])}); 
			addChild(btn_ring_water); 
			x_cut++;
			
			// ヘラクレスリング
			btn_ring_hurricane = new BitmapButton();
			btn_ring_hurricane.setImages( {
				normalImage: bl.getBitmapData("image/hurricane.png"),
				overImage: bl.getBitmapData("image/hurricane_on.png"),
				downImage: bl.getBitmapData("image/hurricane_on.png"),
				selectedImage: bl.getBitmapData("image/hurricane_on.png")
			} );
			btn_ring_hurricane.render();
			btn_ring_hurricane.width = size;
			btn_ring_hurricane.height = size;
			btn_ring_hurricane.x = x + (size * x_cut) + (padding * x_cut);
			btn_ring_hurricane.y = y;
			btn_ring_hurricane.addEventListener(MouseEvent.MOUSE_DOWN, function(event:MouseEvent):void { OnBtnRingMouseDown(event, list_wizard[2]) } ); 
			addChild(btn_ring_hurricane); 
			x_cut++;
			
			// ランドリング
			btn_ring_land = new BitmapButton();
			btn_ring_land.setImages( {
				normalImage: bl.getBitmapData("image/land.png"),
				overImage: bl.getBitmapData("image/land_on.png"),
				downImage: bl.getBitmapData("image/land_on.png"),
				selectedImage: bl.getBitmapData("image/land_on.png")
			} );
			btn_ring_land.render();
			btn_ring_land.width = size;
			btn_ring_land.height = size;
			btn_ring_land.x = x + (size * x_cut) + (padding * x_cut);
			btn_ring_land.y = y;
			btn_ring_land.addEventListener(MouseEvent.MOUSE_DOWN, function(event:MouseEvent):void{ OnBtnRingMouseDown(event, list_wizard[3])}); 
			addChild(btn_ring_land); 
			x_cut++;
			
			SetVisibleCmdBtn();
		}
		
		private function SetVisibleCmdBtn():void {
			btn_footmark.visible = !IsBattle;
			btn_attack.visible = IsBattle;
			btn_ring_flame.visible = IsBattle;
			btn_ring_water.visible = IsBattle;
			btn_ring_hurricane.visible = IsBattle;
			btn_ring_land.visible = IsBattle;
			btn_escape.visible = IsBattle;
		}
		
		/** 
		* メッセージ表示 
		* @param   text    ボタンのラベル 
		* @return  ボタン 
		*/ 
		private function SetMsg(text:String):void 
		{ 
			if (txt_line1.text.length == 0) txt_line1.text = text;
			else if (txt_line2.text.length == 0) txt_line2.text = text;
			else if (txt_line3.text.length == 0) txt_line3.text = text;
			else if (txt_line4.text.length == 0) txt_line4.text = text;
			else if (txt_line5.text.length == 0) txt_line5.text = text;
			else{
				txt_line1.text = txt_line2.text;
				txt_line2.text = txt_line3.text;
				txt_line3.text = txt_line4.text;
				txt_line4.text = txt_line5.text;
				txt_line5.text = text;
			}
		}

		var SquareGoRight:Boolean = true;
		/** 
		* 足跡ボタンが押された時のイベント 
		* @param   e 
		*/ 
		private function OnBtnFootmarkMouseDown(e:MouseEvent):void 
		{ 
			var dice_no:int;
			// タイマーオブジェクトを作成
			var timer:Timer = new Timer(1,50);
			// 指定した時間隔で、繰り返し実行されるイベント
			timer.addEventListener(TimerEvent.TIMER,function(e:TimerEvent):void{
				dice_wizard.Shuffle();
			});
			// 指定した回数をすべて消化したときに呼び出されるイベント
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,function(e:TimerEvent):void{
				dice_no = dice_wizard.Shuffle();
				var child_timer:Timer = new Timer(1, dice_no * bitmap_ring.width);
				// 指定した時間隔で、繰り返し実行されるイベント
				child_timer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void {
					if (SquareGoRight) bitmap_ring.x++;
					else bitmap_ring.x--;
					SquareNo = (bitmap_ring.x + bitmap_ring.width - 30) / bitmap_ring.width;
					if (SquareNo == SquareCount) SquareGoRight = false;
					if (bitmap_ring.x == 30) SquareGoRight = true;
				});
				// 指定した回数をすべて消化したときに呼び出されるイベント
				child_timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void {
					if (ShockerSquareNo.indexOf(SquareNo - 1, 0) >= 0) {
						var phantom_no:int;
						while (true) {
							phantom_no = Math.floor(Math.random() * GetListCount(list_phantom));
							if (list_phantom[phantom_no].HP > 0) break;
						}
						SetPhantomCard(list_phantom[phantom_no]);
						IsBattle = true;
						SetVisibleCmdBtn();
						SetCmdBtnOn(1);
						SetMsg("『" + card_phantom.GetName() +  "』があらわれた！");
					}
					if (SquareNo == 0 || SquareNo == SquareCount) {
						SetPhantomCard(list_whiteWizard[0]);
						IsBattle = true;
						SetVisibleCmdBtn();
						SetCmdBtnOn(1);
						SetMsg("『" + card_phantom.GetName() +  "』があらわれた！");
					}
				});
				// タイマー開始
				child_timer.start();
			});
			// タイマー開始
			timer.start();
			
			SetCmdBtnOn(0);
		}
		
		private function GetListCount(list:Dictionary):int 
		{
			var n:int = 0;
			for (var key:* in list) {
				n++;
			}
			return n;
		}
		
		/** 
		* 攻撃ボタンが押された時のイベント 
		* @param   e 
		*/ 
		private function OnBtnAttackMouseDown(e:MouseEvent):void 
		{ 
			if (!IsBattle) return;
			
			var dice_wizard_no:int;
			var dice_phantom_no:int;
			// タイマーオブジェクトを作成
			var timer:Timer = new Timer(1,50);
			// 指定した時間隔で、繰り返し実行されるイベント
			timer.addEventListener(TimerEvent.TIMER,function(e:TimerEvent):void{
				dice_wizard.Shuffle();
				dice_phantom.Shuffle();
			});
			// 指定した回数をすべて消化したときに呼び出されるイベント
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void {
				dice_wizard_no = dice_wizard.Shuffle();
				dice_phantom_no = dice_phantom.Shuffle();
				if (dice_wizard_no > dice_phantom_no) {
					var damage_phantom:int = card_phantom.SetDamage(card_wizard.GetAttackPoint(dice_wizard_no - dice_phantom_no));
					SetMsg(card_wizard.GetName() +  "の攻撃！");
					SetMsg(card_phantom.GetName() + "に、" + damage_phantom + " ダメージを与えた！！");
				}
				else if (dice_wizard_no < dice_phantom_no) {
					var damage_wizard:int = card_wizard.SetDamage(card_phantom.GetAttackPoint(dice_phantom_no - dice_wizard_no));
					SetMsg(card_phantom.GetName() +  "の攻撃！");
					SetMsg(card_wizard.GetName() + "は、" + damage_wizard + " ダメージを受けた！！");
				}
				else {
					SetMsg("お互いに攻撃！");
					var damage_phantom:int = card_phantom.SetDamage(card_wizard.GetAttackPoint(dice_wizard_no));
					var damage_wizard:int = card_wizard.SetDamage(card_phantom.GetAttackPoint(dice_phantom_no));
					SetMsg(card_phantom.GetName() + "に、" + damage_phantom + " ダメージを与えた！！");
					SetMsg(card_wizard.GetName() + "は、" + damage_wizard + " ダメージを受けた！！");
				}
				if (card_phantom.GetHP() <= 0) {
					SetMsg(card_phantom.GetName() + "を、倒した！！！");
					IsBattle = false;
					SetVisibleCmdBtn();
					SetCmdBtnOn(0);
				}
				if (card_wizard.GetHP() <= 0) {
						if(IsWizard){
							SetMsg("魔法が解けて『操真　晴人』に戻った！！");
							SetInitWizardCard();
						}else{
							SetMsg(card_wizard.GetName() + "は、絶望した...orz");
							var dialog:OrigineErrorDialog = new OrigineErrorDialog("GAME OVER", "ゲームを再開するにはOKボタンを押してください。");
							dialog.closeButton.addEventListener(MouseEvent.CLICK, OnBtnDialogClose)
							addChild(dialog);
						}
				}
			});
			// タイマー開始
			timer.start();
			
			SetCmdBtnOn(1);
		}
		
		/** 
		* 逃亡ボタンが押された時のイベント 
		* @param   e 
		*/ 
		private function OnBtnEscapeMouseDown(e:MouseEvent):void 
		{
			var dice_wizard_no:int;
			var dice_phantom_no:int;
			// タイマーオブジェクトを作成
			var timer:Timer = new Timer(1,50);
			// 指定した時間隔で、繰り返し実行されるイベント
			timer.addEventListener(TimerEvent.TIMER,function(e:TimerEvent):void{
				dice_wizard.Shuffle();
				dice_phantom.Shuffle();
			});
			// 指定した回数をすべて消化したときに呼び出されるイベント
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void {
				dice_wizard_no = dice_wizard.Shuffle();
				dice_phantom_no = dice_phantom.Shuffle();
				if (dice_wizard_no >= dice_phantom_no) {
					SetMsg("逃走に成功した！");
					card_phantom.Clear();
					IsBattle = false;
					SetVisibleCmdBtn();
					SetCmdBtnOn(0);
				}
				else {
					SetMsg("逃走に失敗した！");
					var damage:int = card_wizard.SetDamage(card_phantom.GetAttackPoint(dice_phantom_no));
					SetMsg(card_phantom.GetName() +  "の攻撃！");
					SetMsg(damage　 + " ダメージを受けた！！");
					if (card_wizard.GetHP() <= 0) {
						if(IsWizard){
							SetMsg("魔法が解けて『操真　晴人』に戻った！！");
							SetInitWizardCard();
						}else{
							SetMsg(card_wizard.GetName() + "は、絶望した...orz");
							var dialog:OrigineErrorDialog = new OrigineErrorDialog("GAME OVER", "ゲームを再開するにはOKボタンを押してください。");
							dialog.closeButton.addEventListener(MouseEvent.CLICK, OnBtnDialogClose)
							addChild(dialog);
						}
					}
				}
			});
			// タイマー開始
			timer.start();
			
			SetCmdBtnOn(2);
		}
		
		private function OnBtnDialogClose(e:MouseEvent):void {
			//晴人を初期化
			SetInitWizardCard();
			//ウィザードデータ読み込み
			InitWizardData();
			//ファントムデータ読み込み
			InitPhantomData();
			//白い魔法使いデータ読み込み
			InitWhiteWizardData();
		}
		
		/** 
		* 変身ボタンが押された時のイベント 
		* @param   e 
		*/ 
		private function OnBtnRingMouseDown(e:MouseEvent, data_wizard:CardData):void 
		{
			if (IsWizard || !IsBattle) return;
			
			if(data_wizard.HP <= 0){
				SetMsg(data_wizard.Name + "になるには魔力が足りない...orz");
				return;
			}
			
			IsWizard = true;
			
			SetWizardCard(data_wizard);
			
			var x:int = 315;
			var y:int = 80;
			
			if (_logo_1 != null && this.contains(_logo_1)) this.removeChild(_logo_1);
			if (_logo_2 != null && this.contains(_logo_2)) this.removeChild(_logo_2);
			
			SetMsg("『仮面ライダーウィザード／" + data_wizard.Name + "』に変身した！！");
			
			_logo_1 = new LogoBlueC()
			_logo_1.width = 75;
			_logo_1.height = 75;
			_logo_1.x = x;
			_logo_1.y = y;
			this.addChild( _logo_1 );
			
			_logo_2 = new LogoBlueCircle()
			_logo_2.width = 35;
			_logo_2.height = 35;
			_logo_2.x = _logo_1.x + 20;
			_logo_2.y = _logo_1.y + 30;
			this.addChild( _logo_2 );
			
			var s:Sound;
			if(data_wizard.URL.indexOf("flame") > 0){
				s= new BGM_flame();
			}
			if(data_wizard.URL.indexOf("water") > 0){
				s= new BGM_water();
			}
			if(data_wizard.URL.indexOf("hurricane") > 0){
				s= new BGM_hurricane();
			}
			if(data_wizard.URL.indexOf("land") > 0){
				s= new BGM_land();
			}
			channel = s.play(0, 1);
			
			// タイマーオブジェクトを作成
			var timer:Timer = new Timer(10,1000);
			// 指定した時間隔で、繰り返し実行されるイベント
			timer.addEventListener(TimerEvent.TIMER,function(e:TimerEvent):void{
				StartWizardBeltRotation();
			});
			// 指定した回数をすべて消化したときに呼び出されるイベント
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,function(e:TimerEvent):void{
				StopWizardBeltRotation();
			});
			// タイマー開始
			timer.start();
		}
		
		/** 
		* ウィザードベルト停止
		*/ 
		private function StopWizardBeltRotation():void 
		{ 
			if (_logo_1 != null && this.contains(_logo_1)) this.removeChild(_logo_1);
			if (_logo_2 != null && this.contains(_logo_2)) this.removeChild(_logo_2);
				
			if (channel != null) channel.stop();
			
			this.stage.removeEventListener(Event.ENTER_FRAME, StartWizardBeltRotation);
			
			if (!IsWizard) return;
			SetMsg("魔法が解けて『操真　晴人』に戻った！！");
			this.SetInitWizardCard();
		}
		
		/** 
		* ウィザードベルト回転
		*/ 
		private function StartWizardBeltRotation():void
		{
			//回転の中心
			var tmp_pos : Point = new Point( ( _logo_1.width/2 ) / (_logo_1.scaleX), (_logo_1.height / 2) / (_logo_1.scaleY));
			 
			//回転前の座標
			var global_pos : Point = _logo_1.localToGlobal(tmp_pos);
			
			_logo_1.rotation += 45;
			   
			//回転後の座標
			var after_pos : Point = _logo_1.localToGlobal(tmp_pos);
			 
			_logo_1.x = _logo_1.x - (after_pos.x - global_pos.x);
			_logo_1.y = _logo_1.y - (after_pos.y - global_pos.y);
		}

		/**
		 * 読み込みエラー
		 * @param	evt
		 */
		private function onIOError(evt:Event):void
		{
			trace("IO_ERROR");
		}
	}
}