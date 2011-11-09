package{
	import org.flixel.FlxSprite;

	public class WhiteDoor extends FlxSprite {
		[Embed(source="assets/white_door.png")] private var sprite:Class;
		[Embed(source="assets/white_door_242.png")] private var sprite_242:Class;
		[Embed(source="assets/white_door_214.png")] private var sprite_214:Class;
	}

	public WhiteDoor(X:Number,Y:Number,t:uint){
		super(X,Y);
		if (t==242){
			loadGraphic(sprite_242);
		}
		else if (t==214){
			loadGraphic(sprite_214);
		}
		else {
			loadGraphic(sprite);
		}
		offset.x = 4;
		offset.y = 6;
		width = 55;
		height = 87;
	}
}