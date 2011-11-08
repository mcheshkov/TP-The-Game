package{
	import org.flixel.*;
	
	public class HealthBar extends FlxGroup{
		[Embed(source="assets/heart.png")] private var sprite:Class;		
		
		private var _X:Number;
		private var _Y:Number;
		private var _w:Number;
		private var _h:Number;
		
		public function HealthBar(X:Number,Y:Number){
			_X=X;_Y=Y;
			_w=_h=26;
			super();
		}

		public function addHealth(n:Number):void{
			var x:Number,y:Number;
			x = _X + _w*length;
			y = _Y;
			var i:uint;
			for (i=0;i<n;i++){
				FlxG.log("Add");
				
				var sp:FlxSprite =  new FlxSprite(x,y);
				sp.loadGraphic(sprite);
				sp.scrollFactor.x=0;
				sp.scrollFactor.y=0;
				add(sp);
				x+=_w;
			}
		}

		public function removeHealth(n:Number):void{
			var i:int;
			for (i=length-1;i>length-1-n;i--){
				FlxG.log("Remove " + i + " from " + length);
				(members[i] as FlxSprite).flicker(0.5);
				var t:FlxTimer = new FlxTimer();
				t.start(0.5,1,onTimer);
			}
		}

		protected function onTimer(Timer:FlxTimer):void{
			remove(members[length-1],true);
		}
	}
}