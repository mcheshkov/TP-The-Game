package{
	import org.flixel.plugin.photonstorm.FlxBitmapFont;	
	import org.flixel.*;
	
	public class EndState extends FlxState {
		private const CHARSET:String = " АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя!\\\"#$()*+,-./0123456789:;<=>?@";
		[Embed(source="assets/cyrfont.png")] private var imgFont:Class;
		
		public function EndState():void{
			var text:FlxBitmapFont;
			text = new FlxBitmapFont(imgFont,8,16,CHARSET,CHARSET.length);
			text.setText("Поздравляем!\nВы выиграли место в жюри\nТурнира Претендентов\nЖдём Вас 18 ноября в 18:00\nв актовом зале",true,0,8,"center",true);
			text.x=(320-text.width)/2;
			text.y=40;
			add(text);

			FlxG.bgColor=0xff000000;
		}
	}
}