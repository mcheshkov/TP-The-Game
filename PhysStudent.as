package{
	import org.flixel.*;

	public class PhysStudent extends FlxSprite {
		[Embed(source="assets/phys.png")] private var sprite:Class;
		private var _target:FlxObject;
		private var _bolts:FlxGroup;
		private var _shock:Boolean;

		public function PhysStudent(X:Number,Y:Number,bolts:FlxGroup,target:FlxObject=null){
			super(X,Y);
			_bolts = bolts;

			loadGraphic(sprite,true,true,28,43);
			addAnimation('run',[0,1,2,3],10);
			addAnimation('shock',[4,5,6,7],10);

			play('shock');

			width = 16;
			height = 32;
			offset.x = 2;
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
			if (_shock) return;
			if (_target == null || !_target.alive || (_target.flickering && onScreen() )){
				facing = LEFT;
				velocity.x = -150;
				play('run');
			}
			else if (onScreen() && Math.abs(_target.x - x) < 100){
				play('run');
				if (Math.abs(_target.x - x) < 30){
					addBolt();
					_shock = true;
					velocity.x=0;
					play('shock');
					(new FlxTimer()).start(1,1,function(T:FlxTimer):void{_shock = false;});
					return;
				}
				if (_target.x < x){
					facing = LEFT;
					velocity.x = -150;
				}
				else if (_target.x > x){
					facing = RIGHT;
					velocity.x = 150;
				}
				if (_target.y < y && touching&DOWN){
					velocity.y = -100;
				}
			}
			else{
				play('shock');
			}
		}
		private function addBolt():void{
			var bx:Number;
			var by:Number;
			by = y;
			var b:Bolt = new Bolt(0,0);
			if (facing == LEFT){
				bx = x - b.width;
			}
			else {
				bx = x + width;
			}
			b.x=bx;b.y=by;
			b.facing=facing;
			_bolts.add(b);
		}
	}
}