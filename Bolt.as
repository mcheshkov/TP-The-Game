package{
	import org.flixel.*;

	public class Bolt extends FlxSprite{
		[Embed(source="assets/bolt.png")] private var sprite:Class;

		public function Bolt(X:Number,Y:Number){
			super(X,Y);
			loadGraphic(sprite,true,true,20,39);
			addAnimation('b',[0,1,2,3],20);
			play('b');
		}
	}
}