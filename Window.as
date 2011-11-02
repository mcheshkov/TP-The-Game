package{
	import org.flixel.*;

	public class Window extends FlxSprite {
		[Embed(source="assets/window.png")] private var sprite:Class;
		
		public function Window(X:Number,Y:Number){
			super(X,Y);
			loadGraphic(sprite);
			offset.x = 3;
			offset.y = 11;
			width = 59;
			height = 36;
		}
	}
}