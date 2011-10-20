package{
	import org.flixel.*;
	
	public class MenuState extends FlxState {
		public function MenuState():void{
			var title:FlxText;
			title = new FlxText(FlxG.width/2-100,10,100,"The Game");
			this.add(title);

			var press_to:FlxText;
			press_to = new FlxText(FlxG.width-100,FlxG.height-24,100,"Press X to start");
			this.add(press_to);
		}

		override public function update():void{
			super.update();
			if (FlxG.keys.justPressed("X")){
				FlxG.keys.update();
				var YES:FlxText;
				YES = new FlxText(FlxG.width/2+FlxG.random()*100,FlxG.height/2,50,"YES!");
				this.add(YES);
				FlxG.flash(0xffffffff, 0.3,onFade);
				FlxG.fade(0xff000000, 1);	
			}
			else {
				//FlxG.flash(0xff0000ff,0.75);
			}
		}

		private function onFade():void{
			FlxG.switchState(new PlayState());
		}
	}
}