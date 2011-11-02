package{
	import org.flixel.*;

	public class Column extends FlxSprite{
		[Embed(source="assets/column.png")] private var sprite:Class;

		public function Column(X:Number,Y:Number){
			super(X,Y);

			loadGraphic(sprite);
		}
	}
}