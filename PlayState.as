package 
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		[Embed(source="assets/level1.txt", mimeType = "application/octet-stream")] private var Level_1:Class;
		
		private var _player:Player;
		private var _exit:FlxSprite;
		private var _level:Level;
		private var _BG_1:FlxGroup;
		private var _BG_2:FlxGroup;
		
		override public function create():void
		{
			FlxG.bgColor = 0xffcccccc;
			
			_exit = new FlxSprite(500,0);
			_exit.makeGraphic(16,240,0xff0000ff);
			add(_exit);

			_BG_2 = new FlxGroup();
			add(_BG_2);

			_BG_1 = new FlxGroup();
			add(_BG_1);

			_player = new Player(10,100);
			this.add(_player);

			_level = new Level(Level_1);
			this.add(_level);
			
			var obj1: FlxSprite = new FlxSprite(100,0);
			obj1.makeGraphic(60,200,0xffccaa88);
			obj1.scrollFactor.x=0.5;
			obj1.scrollFactor.y=0.5;
			_BG_1.add(obj1);
			var obj2: FlxSprite = new FlxSprite(200,0);
			obj2.makeGraphic(60,200,0xff00aa88);
			obj2.scrollFactor.x=0.5;
			obj2.scrollFactor.y=0.5;
			_BG_1.add(obj2);


			var obj3: FlxSprite = new FlxSprite(80,80);
			obj3.makeGraphic(80,120,0xffcc0088);
			obj3.scrollFactor.x=0.3;
			obj3.scrollFactor.y=0.3;
			_BG_2.add(obj3);
			var obj4: FlxSprite = new FlxSprite(240,80);
			obj4.makeGraphic(80,120,0xff44aa11);
			obj4.scrollFactor.x=0.3;
			obj4.scrollFactor.y=0.3;
			_BG_2.add(obj4);

			FlxG.worldBounds = new FlxRect(0,0,_level.width,_level.height);
			setupCamera();

			FlxG.debug = true;
			FlxG.log("Debugger ON");
			FlxG.watch(_level,"height");
			FlxG.watch(_level,"width");
		}

		override public function update():void{
			super.update();
			FlxG.collide(_level,_player);
			if (FlxG.overlap(_player,_exit)){
				FlxG.flash(0xffffffff,0.5,function():void{FlxG.switchState(new MenuState());});
			}
		}

		protected function setupCamera():void{
			FlxG.camera.follow(_player,FlxCamera.STYLE_PLATFORMER);
			FlxG.camera.bounds = new FlxRect(0,0,_level.width,_level.height);
		}
	}
}