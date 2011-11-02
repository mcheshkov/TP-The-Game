package 
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		[Embed(source="assets/level1.txt", mimeType = "application/octet-stream")] private var Level_1:Class;
		[Embed(source="assets/column.png")] private var column_sprite:Class;
		[Embed(source="assets/door_1.png")] private var door_1_sprite:Class;
		
		[Embed(source="assets/BG_1.png")] private var BG_1_sprite:Class;
		[Embed(source="assets/tile1.png")] private var tile1_sprite:Class;
		
		private var _player:Player;
		private var _enemies:FlxGroup;
		private var _exit:FlxSprite;
		private var _level:Level;
		private var _pickups:FlxGroup;
		private var _bullets:FlxGroup;
		private var _BG_0:FlxGroup;
		private var _BG_1:FlxGroup;
		private var _BG_2:FlxGroup;
		private var _BG_pic:FlxSprite;
		private var _floor:FlxTileblock;

		private var _w:Number;
		private var _h:Number;
		
		override public function create():void
		{
			_h=240;
			_w=1500;
			
			FlxG.bgColor = 0xffcccccc;

			addBG_pic();
			
			_BG_2 = new FlxGroup();
			add(_BG_2);

			_BG_1 = new FlxGroup();
			add(_BG_1);

			_BG_0 = new FlxGroup();
			add(_BG_0);

			addColumns();
			addDoors();
			addCouches();

			_exit = new FlxSprite(1100,0);
			_exit.makeGraphic(16,240,0xff0000ff);
			add(_exit);

			_pickups = new FlxGroup();
			add(_pickups);

			addFloor();
			
			_bullets = new FlxGroup();
			add(_bullets);

			_player = new Player(10,100,_bullets);
			add(_player);

			_enemies = new FlxGroup();
			add(_enemies);
			
			_enemies.add(new MathStudent(500,100,_player));

			var pick:Pickup = new Pickup(400,150);
			_pickups.add(pick);

			FlxG.worldBounds = new FlxRect(0,0,_w,_h);
			setupCamera();

			FlxG.debug = true;
			FlxG.log("Debugger ON");
		}

		private function addFloor():void{
			_floor = new FlxTileblock(0,_h-32,_w,32);
			_floor.loadTiles(tile1_sprite);
			_floor.height -= 4;
			_floor.offset.y = 4;
			add(_floor);
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

		private function addCouches():void{
			var ar:Array = [150,300,450,600];
			var couch: Couch;
			for each (var a:Number in ar){
					couch = new Couch(a,0);
					_BG_0.add(couch);
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
			FlxG.collide(_floor,_player);
			FlxG.collide(_floor,_enemies);
			if (FlxG.overlap(_player,_exit)){
				FlxG.flash(0xffffffff,0.5,function():void{FlxG.switchState(new MenuState());});
			}
			FlxG.overlap(_player,_pickups,onPickup);
			FlxG.overlap(_player,_enemies,onTouchEnemy);
			FlxG.overlap(_bullets,_enemies,onTouchBullet);
		}

		protected function setupCamera():void{
			FlxG.camera.follow(_player,FlxCamera.STYLE_PLATFORMER);
			FlxG.camera.bounds = new FlxRect(0,0,_w,_h);
		}

		protected function onPickup(l:FlxObject,r:FlxObject):void{
			if (r is Pickup && l is Player){
				(r as Pickup).pick(l as Player);
				r.kill();
			}
		}

		protected function onTouchEnemy(l:FlxObject,r:FlxObject):void{
			if (l is Player){
				if (!l.flickering){
					l.hurt(1);
					l.velocity.x = 250;
					if (l.x < r.x) l.velocity.x *= -1;
					l.velocity.y = -50;
				}
			}
		}

		protected function onTouchBullet(l:FlxObject,r:FlxObject):void{
			if (l is Bullet){
				r.hurt(1);
				l.kill();
			}
		}
	}
}