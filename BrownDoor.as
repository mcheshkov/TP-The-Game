package{
	import org.flixel.*;

	public class BrownDoor extends FlxSprite {
		[Embed(source="assets/door_1.png")] private var sprite:Class;
		
		public function BrownDoor(X:Number,Y:Number){
			super(X,Y);
			loadGraphic(sprite);
			offset.x = 4;
			offset.y = 6;
			width = 55;
			height = 87;
		}
	}
}