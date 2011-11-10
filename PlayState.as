package 
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		[Embed(source="assets/level1.txt", mimeType = "application/octet-stream")] private var Level_1:Class;
		[Embed(source="assets/door_1.png")] private var door_1_sprite:Class;
		
		[Embed(source="assets/BG_1.png")] private var BG_1_sprite:Class;
		[Embed(source="assets/BG_2.png")] private var BG_2_sprite:Class;
		[Embed(source="assets/tile1.png")] private var tile1_sprite:Class;
		[Embed(source="assets/tile2.png")] private var tile2_sprite:Class;

		[Embed(source="assets/music.mp3")] private var music:Class;
		
		private var _player:Player;
		private var _enemies:FlxGroup;
		private var _exit1:Stairs;
		private var _exit2:Stairs;
		private var _level:Level;
		private var _pickups:FlxGroup;
		private var _bullets:FlxGroup;
		private var _bolts:FlxGroup;
		private var _BG_0:FlxGroup;
		private var _BG_1:FlxGroup;
		private var _BG_2:FlxGroup;
		private var _floors:FlxGroup;
		private var _left_bound:FlxObject;
		private var _right_bound:FlxObject;
		private var _hb:HealthBar;
		private var _path1to2:FlxPath;
		private var _path2to3:FlxPath;
		private var onPath:Boolean = false;

		private const H1:Number=900;
		private const H2:Number=600;
		private const H3:Number=300;
		private const W:Number=1500;

		private var H:Number=H1+20;
		
		override public function create():void
		{
			FlxG.bgColor = 0xffcccccc;

			addBG_pic();

			addFloors();
			addBounds();
			
			_BG_2 = new FlxGroup();
			add(_BG_2);

			_BG_1 = new FlxGroup();
			add(_BG_1);

			_BG_0 = new FlxGroup();
			add(_BG_0);

			addColumns();
			addGreekColumns();
			addBrownDoors();
			addWhiteDoors();
			addWindows();
			addCouches();
			addCoffeeMachine();
			addBulletins();

			_exit1 = new Stairs(0,H1);
			_exit1.y-=_exit1.height;
			_exit1.facing = FlxObject.LEFT;
			add(_exit1);

			_exit2 = new Stairs(W,H2);
			_exit2.x-=_exit2.width;
			_exit2.y-=_exit2.height;
			_exit2.facing = FlxObject.RIGHT;
			add(_exit2);

			_pickups = new FlxGroup();
			add(_pickups);
			
			_bullets = new FlxGroup();
			add(_bullets);

			_bolts = new FlxGroup();
			add(_bolts);

			_player = new Player(W-50,H1-70,_bullets);
			_player.facing = FlxObject.LEFT;
			add(_player);

			_enemies = new FlxGroup();
			add(_enemies);
			
			addEnemies();

			var pick:Pickup = new Pickup(630,H1-35);
			_pickups.add(pick);

			FlxG.worldBounds = new FlxRect(0,0,W,H);
			setupCamera();

			addHealthbar();

			initPaths();

			FlxG.playMusic(music,0.3);

			FlxG.debug = true;
			FlxG.log("Debugger ON");
		}

		private function initPaths():void{
			_path1to2 = new FlxPath();
			_path1to2.add(_exit1.x+_exit1.width+1,H1-_player.height+10);
			_path1to2.add(_exit1.x-10,H1-_player.height-_exit1.height-10 + 10);
			_path1to2.add(_exit1.x-10,H2-_player.height+10-8);
			_path1to2.add(_exit1.x,H2-_player.height-4-8);

			_path2to3 = new FlxPath();
			_path2to3.add(_exit2.x-1,H2-_player.height+10);
			_path2to3.add(_exit2.x+_exit2.width+10,H2-_player.height-_exit2.height-10+10);
			_path2to3.add(_exit2.x+_exit2.width+10,H3-_player.height+10-10);
			_path2to3.add(_exit2.x+20,H3-_player.height-4-10);
		}

		private function addGreekColumns():void{
			var col:GreekColumn;
			col = new GreekColumn(140,0,0);
			col.y = H3-col.height - 4;
			col.scrollFactor.x=0.9;
			col.scrollFactor.y=1;
			_BG_1.add(col);
			col = new GreekColumn(50,0,1);
			col.y = H3-col.height - 4;
			col.scrollFactor.x=0.9;
			col.scrollFactor.y=1;
			_BG_1.add(col);
		}

		private function addBulletins():void{
			var b:Bulletin;
			b = new Bulletin(100,H2,Bulletin.MATH);
			b.y-=b.height+50;
			b.scrollFactor.x=0.8;
			_BG_2.add(b);
			b = new Bulletin(1000,H2,Bulletin.PHYS);
			FlxG.watch(b,"x");
			FlxG.watch(b,"y");
			b.y-=b.height+50;
			b.scrollFactor.x=0.8;
			_BG_2.add(b);
			b = new Bulletin(1050,H3,Bulletin.CHEM);
			b.y-=b.height+50;
			b.scrollFactor.x=0.8;
			_BG_2.add(b);
			b = new Bulletin(400,H3,Bulletin.MEND);
			b.y-=b.height+50;
			b.scrollFactor.x=0.8;
			_BG_2.add(b);
		}

		private function addWhiteDoors():void{
			var ar:Array = [400,560,680,770,900];
			var door: WhiteDoor;
			var a:Number;
			for each (a in ar){
					door = new WhiteDoor(a,0,0);
					door.y = H2-door.height-8;
					door.scrollFactor.x=0.8;
					door.scrollFactor.y=1;
					_BG_2.add(door);
				}
			door = new WhiteDoor(30,0,214);
			door.y = H2-door.height-8;
			door.scrollFactor.x=0.8;
			door.scrollFactor.y=1;
			_BG_2.add(door);
			door = new WhiteDoor(1150,0,242);
			door.y = H2-door.height-8;
			door.scrollFactor.x=0.8;
			door.scrollFactor.y=1;
			_BG_2.add(door);

			ar = [200,560,680,770,950];
			for each (a in ar){
					door = new WhiteDoor(a,0,0);
					door.y = H3-door.height-8;
					door.scrollFactor.x=0.8;
					door.scrollFactor.y=1;
					_BG_2.add(door);
				}
		}

		private function addEnemies():void{
			_enemies.add(new MathStudent(450,H1-50,_player));
			_enemies.add(new MathStudent(100,H1-50,_player));
			_enemies.add(new PhysStudent(300,H2-50,_bolts,_player));
			_enemies.add(new PhysStudent(800,H2-50,_bolts,_player));
			_enemies.add(new PhysStudent(850,H2-50,_bolts,_player));
			_enemies.add(new ChemStudent(850,H3-50,_player));
			_enemies.add(new ChemStudent(500,H3-50,_player));
			_enemies.add(new ChemStudent(400,H3-50,_player));
			_enemies.add(new ChemStudent(350,H3-50,_player));
			_enemies.add(new ChemStudent(320,H3-50,_player));
		}

		private function addCoffeeMachine():void{
			var cm:Coffemachine = new Coffemachine(560,0);
			cm.y = H1 - cm.height - 6;
			cm.scrollFactor.x = 0.9;
			_BG_1.add(cm);
		}

		private function addHealthbar():void{
			_hb = new HealthBar(10,10);
			add(_hb);
			_hb.addHealth(_player.health);
		}

		private function addFloors():void{
			_floors = new FlxGroup();
			add(_floors);
			
			var _floor:FlxTileblock = new FlxTileblock(0,H1,W,32);
			_floor.loadTiles(tile1_sprite);
			_floor.height -= 4;
			_floor.offset.y = 4;
			_floors.add(_floor);

			_floor = new FlxTileblock(0,H2,W,32);
			_floor.loadTiles(tile2_sprite);
			_floor.height -= 4;
			_floor.offset.y = 4;
			_floors.add(_floor);

			_floor = new FlxTileblock(0,H3,W,32);
			_floor.loadTiles(tile2_sprite);
			_floor.height -= 4;
			_floor.offset.y = 4;
			_floors.add(_floor);
		}

		private function addBounds():void{
			_left_bound = new FlxObject(-9,0,10,H);
			_left_bound.immovable = true;
			add(_left_bound);;
			_right_bound = new FlxObject(W-1,0,10,H);
			_right_bound.immovable = true;
			add(_right_bound);
		}

		private function addBG_pic():void{
			var _BG_pic:FlxSprite;
			_BG_pic = new FlxSprite(0,0);
			_BG_pic.loadGraphic(BG_1_sprite);
			_BG_pic.y=H1-_BG_pic.height;
			_BG_pic.scrollFactor.x=0;
			_BG_pic.scrollFactor.y=1;
			add(_BG_pic);
			_BG_pic = new FlxSprite(0,0);
			_BG_pic.loadGraphic(BG_2_sprite);
			_BG_pic.y=H2-_BG_pic.height;
			_BG_pic.scrollFactor.x=0;
			_BG_pic.scrollFactor.y=1;
			add(_BG_pic);
			_BG_pic = new FlxSprite(0,0);
			_BG_pic.loadGraphic(BG_2_sprite);
			_BG_pic.y=H3-_BG_pic.height;
			_BG_pic.scrollFactor.x=0;
			_BG_pic.scrollFactor.y=1;
			add(_BG_pic);
		}

		private function addColumns():void{
			var ar:Array = [900,760,620,480];
			var col:Column;
			for each (var a:Number in ar){
				col = new Column(a,0);
				col.y = H1-col.height - 4;
				col.scrollFactor.x=0.9;
				col.scrollFactor.y=1;
				_BG_1.add(col);
			}
		}

		private function addCouches():void{
			var ar:Array = [250,330,400,1300,1200,1100];
			var couch: Couch;
			for each (var a:Number in ar){
					couch = new Couch(a,0);
					couch.y = H1-couch.height;
					_BG_0.add(couch);
				}
		}

		private function addBrownDoors():void{
			var ar:Array = [100,180,560,680,770,950];
			var door: BrownDoor;
			for each (var a:Number in ar){
					door = new BrownDoor(a,0);
					door.y = H1-door.height-8;
					door.scrollFactor.x=0.8;
					door.scrollFactor.y=1;
					_BG_2.add(door);
				}
		}

		private function addWindows():void{
			var ar:Array = [270,350,1180,1100];
			var wind: Window;
			for each (var a:Number in ar){
					wind = new Window(a,0);
					wind.y = H1-wind.height-50;
					wind.scrollFactor.x=0.8;
					wind.scrollFactor.y=1;
					_BG_2.add(wind);
				}
		}

		override public function update():void{
			super.update();
			FlxG.collide(_floors,_player);
			FlxG.collide(_floors,_enemies);
			FlxG.collide(_left_bound,_player);
			FlxG.collide(_right_bound,_player);
			FlxG.overlap(_player,_exit1,onExit1);
			FlxG.overlap(_player,_exit2,onExit2);
			FlxG.overlap(_player,_pickups,onPickup);
			FlxG.overlap(_player,_enemies,onTouchEnemy);
			FlxG.overlap(_player,_bolts,onTouchBolt);
			FlxG.overlap(_bullets,_enemies,onTouchBullet);
		}

		protected function setupCamera():void{
			FlxG.camera.follow(_player,FlxCamera.STYLE_PLATFORMER);
			FlxG.camera.bounds = new FlxRect(0,0,W,H);
			FlxG.camera.deadzone = new FlxRect(140,150,40,70);		
		}

		protected function onPickup(l:FlxObject,r:FlxObject):void{
			if (r is Pickup && l is Player){
				(r as Pickup).pick(l as Player);
				_hb.addHealth(1);
				r.kill();
			}
		}

		protected function onTouchEnemy(l:FlxObject,r:FlxObject):void{
			if (l is Player){
				if (!l.flickering){
					_hb.removeHealth(Math.min(1,_player.health));
					l.hurt(1);
					l.velocity.x = 250;
					if (l.x < r.x) l.velocity.x *= -1;
					l.velocity.y = -50;
				}
			}
			if (r is ChemStudent){
				(r as ChemStudent).blow();
			}
		}

		protected function onTouchBolt(l:FlxObject,r:FlxObject):void{
			if (l is Player){
				if (!l.flickering){
					_hb.removeHealth(Math.min(1,_player.health));
					l.hurt(1);
					l.velocity.x = 250;
					if (l.x < r.x) l.velocity.x *= -1;
					l.velocity.y = -50;
				}
			}
			if (r is Bolt){
				(new FlxTimer()).start(1,1,function (T:FlxTimer):void{r.kill()});
			}
		}

		protected function onTouchBullet(l:FlxObject,r:FlxObject):void{
			if (l is Bullet){
				r.hurt(1);
				l.kill();
			}
		}

		protected function onExit1(l:FlxObject,r:FlxObject):void{
			if (!(l is Player)) return;
			if (!onPath) l.followPath(_path1to2);
			onPath=true;
			_left_bound.solid=false;
			(new FlxTimer()).start(3,1,function (T:FlxTimer):void{
					_player.facing=FlxObject.RIGHT;
					onPath=false;
				});
			(new FlxTimer()).start(4,1,function (T:FlxTimer):void{
					_left_bound.solid=true;
				});
		}

		protected function onExit2(l:FlxObject,r:FlxObject):void{
			if (!(l is Player)) return;
			if (!onPath) l.followPath(_path2to3);
			onPath=true;
			_right_bound.solid=false;
			(new FlxTimer()).start(3,1,function (T:FlxTimer):void{
					_player.facing=FlxObject.LEFT;
					onPath=false;
				});
			(new FlxTimer()).start(4,1,function (T:FlxTimer):void{
					_right_bound.solid=true;
				});
		}
	}
}