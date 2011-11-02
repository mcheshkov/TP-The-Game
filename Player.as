package{
	import org.flixel.*;
	
	public class Player extends FlxSprite{
		[Embed (source = "assets/player.png")] private var sprite:Class;

		private var _speed:int = 400;
		private var _bullets:FlxGroup;
		private var can_shoot:Boolean = true;
		
		public function Player(X:Number,Y:Number,bullets:FlxGroup):void{
			super(X,Y);
			loadGraphic(sprite,true,true,28,43);

			addAnimation('stand',[0]);
			addAnimation('run',[1,2,3,4,5,6],10);

			width = 16;
			height = 32;
			offset.x=6;
			offset.y = 4;
			

			//Max speeds
			maxVelocity.x = 200;
			maxVelocity.y = 200;
			//Gravity
			acceleration.y = 400;
			//acceleration.x = 100;
			//Friction
			drag.x = 300;
			//Initial right facing
			facing = RIGHT;
			//Allow collisions
			solid = true;

			health=2;
			_bullets = bullets;
		}

		override public function update():void{
			if(FlxG.keys.LEFT){
				play('run');
				facing = LEFT;
				velocity.x -= _speed * FlxG.elapsed;
			}
			else if (FlxG.keys.RIGHT){
				play('run');
				facing = RIGHT;
				velocity.x += _speed * FlxG.elapsed;
			}
			else if(velocity.x==0){
				play('stand');
			}
			
			if (FlxG.keys.UP && (this.touching&DOWN)){
				velocity.y-= 300;
			}

			if (FlxG.keys.justPressed("C") && can_shoot){
				_bullets.add(new Bullet(x,y,facing));
				can_shoot = false;
				var t:FlxTimer = new FlxTimer();
				t.start(0.5,1,function(t:FlxTimer):void{can_shoot = true;})
			}

			super.update();
		}

		override public function hurt(Damage:Number):void{
			flicker(1);
			super.hurt(Damage);
		}
	}
}