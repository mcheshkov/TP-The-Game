package{
	import org.flixel.*;

	
	
	public class Pickup extends FlxSprite{
		[Embed (source = "assets/coffee.png")] private var sprite:Class;
		
		public function Pickup(X:Number,Y:Number):void{
			super(X,Y);

			loadGraphic(sprite,true,false,24,24);
			addAnimation('default',[0,1,2],4);

			width=19;
			height=24;
			offset.x=3;
			
			play('default');
		}

		public function pick(player:Player):void{
			player.maxVelocity.x += 100;
			player.acceleration.y -= 100;
			var timer:FlxTimer = new FlxTimer();
			timer.start(5,1,function(t:FlxTimer):void{
					player.maxVelocity.x -= 100;player.acceleration.y += 100;
				});
		}
	}
}