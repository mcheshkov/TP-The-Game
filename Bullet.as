package{
	import org.flixel.*;
	public class Bullet extends FlxSprite{
		[Embed(source="assets/integral.png")] private var sprite:Class;

		public function Bullet(X:Number,Y:Number,dir:uint):void{
			super(X,Y);
			loadGraphic(sprite);
			offset.x = 16;
			offset.y = 9;
			width = 49;
			height = 24;

			velocity.x = 500;
			if (dir == LEFT) velocity.x *= -1;
		}
		override public function update():void{
			if (!onScreen())kill();
		}
	}
}