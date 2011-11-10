package{
	import org.flixel.*;

	public class ChemStudent extends FlxSprite {
		[Embed(source="assets/chem.png")] private var sprite:Class;

		private var _target:FlxObject;
		public var blew:Boolean;

		public function ChemStudent(X:Number,Y:Number,target:FlxObject){
			super(X,Y);

			loadGraphic(sprite,true,true,57,57);
			addAnimation('stand',[0,1],5);
			addAnimation('blow',[0,1,2,3,4,5,6,7,8,9],10);

			height=31;
			width=19;
			offset.x=18;
			offset.y=14;

			play('stand');

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
			blew = false;

			_target = target;
			FlxG.watch(this,'x');
			FlxG.watch(this,'y');
			FlxG.watch(_target,'x');
		}

		public override function update():void{
			var dist:Number;
			dist = FlxU.getDistance(_target.getMidpoint(),getMidpoint());
			if (_target != null && !blew &&
				dist<40){
				blow();
			}
		}

		public function blow():void{
			if (blew) return;
			blew = true;
			acceleration.y=0;
			play('blow');
			(new FlxTimer()).start(0.4,1,function(T:FlxTimer):void{
					height=45;
					width=57;
					y-=14;
					x-=17;
					offset.x=0;
					offset.y=0;
				});
			(new FlxTimer()).start(0.9,1,function(T:FlxTimer):void{kill();});
		}
		public override function kill():void{
			if (!blew) blow();
			else super.kill();
		}
	}
}