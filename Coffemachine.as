package{
	import org.flixel.*;

	public class Coffemachine extends FlxSprite {
		[Embed(source="assets/coffeemachine.png")] private var sprite:Class;
		
		public function Coffemachine(X:Number,Y:Number){
			super(X,Y);
			loadGraphic(sprite);
			offset.x = 15;
			offset.y = 15;
			width = 60;
			height = 127;
		}
	}
}