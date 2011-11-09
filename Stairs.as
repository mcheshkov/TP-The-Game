package{
	import org.flixel.FlxSprite;

	public class Stairs extends FlxSprite {
		[Embed(source="assets/stairs.png")] private var sprite:Class;
		public function Stairs(X:Number,Y:Number){
			super(X,Y);
			loadGraphic(sprite,false,true);
			
			facing = LEFT;
		}
	}
}