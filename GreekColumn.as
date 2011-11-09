package{
	import org.flixel.FlxSprite;

	public class GreekColumn extends FlxSprite {
		[Embed(source="assets/greek1.png")] private var sprite1:Class;
		[Embed(source="assets/greek2.png")] private var sprite2:Class;

		public function GreekColumn(X:Number,Y:Number,t:uint){
			super(X,Y);
			if (t==1) loadGraphic(sprite1);
			else loadGraphic(sprite2);
		}
	}
}