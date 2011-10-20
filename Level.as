package{
	import org.flixel.*;

	public class Level extends FlxTilemap{
		[Embed(source="assets/tiles.png")] private var TilesGraphic:Class;
		
		public function Level(LevelData:Class){
			super();
			loadMap(new LevelData,TilesGraphic);
		}
	}
}