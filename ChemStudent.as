package{
	import org.flixel.*;

	public class ChemStudent extends FlxSprite {
		[Embed(source="assets/chem.png")] private var sprite:Class;

		private var _target:FlxObject;
		private var blew:Boolean;

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
			FlxG.watch(_target,'x');
		}

		public override function update():void{
			if (_target != null && !blew &&
				FlxU.abs(_target.getMidpoint().x - getMidpoint().x)<40){
				blow();
				(new FlxTimer()).start(0.4,1,function(T:FlxTimer):void{
						height=45;
						width=57;
						y-=14;
						x-=17
						offset.x=0;
						offset.y=0;
					});
			}
		}

		public function blow():void{
			blew = true;
			play('blow');
			(new FlxTimer()).start(1,1,function(T:FlxTimer):void{kill();});
		}
	}
}