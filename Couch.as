package{
	import org.flixel.*;
	
	public class Couch extends FlxSprite{
		[Embed(source="assets/couch1.png")] private var couch1_sprite:Class;
		[Embed(source="assets/couch2.png")] private var couch2_sprite:Class;
		[Embed(source="assets/couch3.png")] private var couch3_sprite:Class;
		[Embed(source="assets/couch4.png")] private var couch4_sprite:Class;
		private var count:uint = 4;

		public function Couch(X:Number,Y:Number,type:uint = 0){
			if (type == 0) type = uint(FlxG.random()*count + 1);
			if (type == count+1) type--;

			super(X,Y);

			var gr:Class;
			switch (type){
			case 1:
				gr = couch1_sprite;
				break;
			case 2:
				gr = couch2_sprite;
				break;
			case 3:
				gr = couch3_sprite;
				break;
			case 4:
				gr = couch4_sprite;
				break;
			}

			loadGraphic(gr);

			offset.x=11;
			offset.y = 28;
			width = 37;
			height = 19;
		}
	}
}