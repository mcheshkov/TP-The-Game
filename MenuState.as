package{
	import org.flixel.plugin.photonstorm.FlxBitmapFont;	
	import org.flixel.*;
	
	public class MenuState extends FlxState {
		private const CHARSET:String = " АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя!\\\"#$()*+,-./0123456789:;<=>?@";
		[Embed(source="assets/cyrfont.png")] private var imgFont:Class;
		
		public function MenuState():void{
			//var title:FlxText;
			//title = new FlxText(FlxG.width/2-100,10,100,"The Game");
			//this.add(title);

			//var press_to:FlxText;
			//press_to = new FlxText(FlxG.width-100,FlxG.height-24,100,"Press X to start");
			//this.add(press_to);

			var text:FlxBitmapFont;
			text = new FlxBitmapFont(imgFont,8,16,CHARSET,CHARSET.length);
			text.setText("Турнир Претендентов 2011\n\n\n\n\n\n\nНажмите ПРОБЕЛ чтобы продолжить",true,0,8,"center",true);
			text.x=35;
			text.y=20;
			add(text);

			FlxG.bgColor=0xff000000;
		}

		override public function update():void{
			super.update();
			if (FlxG.keys.justPressed("SPACE")){
				FlxG.keys.update();

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