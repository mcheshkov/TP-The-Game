package 
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		[Embed(source="assets/level1.txt", mimeType = "application/octet-stream")] private var Level_1:Class;
		[Embed(source="assets/column.png")] private var column_sprite:Class;
		[Embed(source="assets/door_1.png")] private var door_1_sprite:Class;
		
		[Embed(source="assets/BG_1.png")] private var BG_1_sprite:Class;
		
		private var _player:Player;
		private var _exit:FlxSprite;
		private var _level:Level;
		private var _pickups:FlxGroup;
		private var _BG_1:FlxGroup;
		private var _BG_2:FlxGroup;
		private var _BG_pic:FlxSprite;
		
		override public function create():void
		{
			FlxG.bgColor = 0xffcccccc;

			addBG_pic();
			
			_BG_2 = new FlxGroup();
			add(_BG_2);

			_BG_1 = new FlxGroup();
			add(_BG_1);

			addColumns();
			addDoors();

			_exit = new FlxSprite(1100,0);
			_exit.makeGraphic(16,240,0xff0000ff);
			add(_exit);

			_pickups = new FlxGroup();
			add(_pickups);

			_level = new Level(Level_1);
			add(_level);

			_player = new Player(10,100);
			add(_player);

			var pick:Pickup = new Pickup(400,150);
			_pickups.add(pick);

			FlxG.worldBounds = new FlxRect(0,0,_level.width,_level.height);
			setupCamera();

			FlxG.debug = true;
			FlxG.log("Debugger ON");
			FlxG.watch(_level,"height");
			FlxG.watch(_level,"width");
		}

		private function addBG_pic():void{
			_BG_pic = new FlxSprite(0,0);
			_BG_pic.loadGraphic(BG_1_sprite);
			_BG_pic.scrollFactor.x=0;
			_BG_pic.scrollFactor.y=0;
			add(_BG_pic);
		}

		private function addColumns():void{
			var ar:Array = [150,300,450,600];
			var col: FlxSprite;
			for each (var a:Number in ar){
				col = new FlxSprite(a,0);
				col.loadGraphic(column_sprite);
				col.scrollFactor.x=0.5;
				col.scrollFactor.y=0.5;
				_BG_1.add(col);
			}
		}

		private function addDoors():void{
			var ar:Array = [120,240,400,5000];
			var door: FlxSprite;
			for each (var a:Number in ar){
					door = new FlxSprite(a,0);
					door.loadGraphic(door_1_sprite);
					door.scrollFactor.x=0.3;
					door.scrollFactor.y=0.3;
					_BG_2.add(door);
				}
		}

		override public function update():void{
			super.update();
			FlxG.collide(_level,_player);
			if (FlxG.overlap(_player,_exit)){
				FlxG.flash(0xffffffff,0.5,function():void{FlxG.switchState(new MenuState());});
			}
			FlxG.overlap(_player,_pickups,onPickup);
		}

		protected function setupCamera():void{
			FlxG.camera.follow(_player,FlxCamera.STYLE_PLATFORMER);
			FlxG.camera.bounds = new FlxRect(0,0,_level.width,_level.height);
		}

		protected function onPickup(l:FlxObject,r:FlxObject):void{
			if (r is Pickup && l is Player){
				(r as Pickup).pick(l as Player);
				r.kill();
			}
		}
	}
}