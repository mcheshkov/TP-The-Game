package{
	import org.flixel.*;
	
	public class Pickup extends FlxSprite{
		public function Pickup(X:Number,Y:Number):void{
			super(X,Y);

			makeGraphic(16,16,0xffffff00);
		}

		public function pick(player:Player):void{
			player.hurt(1);
		}
	}
}