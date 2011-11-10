package{
	import org.flixel.*;

	public class MathStudent extends FlxSprite {
		[Embed(source="assets/math.png")] private var sprite:Class;

		private var _target:FlxObject;

		public function MathStudent(X:Number,Y:Number,target:FlxObject=null){
			super(X,Y);

			loadGraphic(sprite,true,true,28,43);
			addAnimation('run',[0,1,2,3],10);

			play('run');

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

			health=1;

			_target = target;
		}

		override public function update():void{
			if (_target == null || !_target.alive || (_target.flickering && onScreen())){
				facing = LEFT;
				velocity.x = -150;
			}
			else if (onScreen()){
				if (_target.x < x){
					facing = LEFT;
					velocity.x = -100;
				}
				else if (_target.x > x){
					facing = RIGHT;
					velocity.x = 100;
				}
				if (_target.y < y && touching&DOWN){
					velocity.y = -70;
				}
			}
		}
	}
}