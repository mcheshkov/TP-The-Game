package{
	import org.flixel.*;

	public class Bulletin extends FlxSprite {
		public static const MATH:uint = 0;
		public static const PHYS:uint = 1;
		public static const CHEM:uint = 2;
		public static const MEND:uint = 3;
		[Embed(source="assets/bul_math.png")] private var sprite_math:Class;
		[Embed(source="assets/bul_phys.png")] private var sprite_phys:Class;
		[Embed(source="assets/bul_chem.png")] private var sprite_chem:Class;
		[Embed(source="assets/bul_mend.png")] private var sprite_mend:Class;
		
		public function Bulletin(X:Number,Y:Number,t:uint){
			super(X,Y);
			switch(t){
			case MATH: loadGraphic(sprite_math);break;
			case PHYS: loadGraphic(sprite_phys);break;
			case CHEM: loadGraphic(sprite_chem);break;
			case MEND: loadGraphic(sprite_mend);break;
			}
			offset.x = 9;
			offset.y = 16;
			width = 119;
			height = 73;
		}
	}
}