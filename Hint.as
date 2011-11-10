package{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;	

	public class Hint extends FlxGroup{
		[Embed(source="assets/cyrfont.png")] private var imgFont:Class;
		private const CHARSET:String = " АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя!\\\"#$()*+,-./0123456789:;<=>?@";

		private var _remain:Number;
		private var _bg:FlxSprite;
		private var _text:FlxBitmapFont;

		private const FADETIME:Number = 1;
		
		public function Hint(X:Number,Y:Number,text:String,time:Number){
			super();

			_bg = new FlxSprite(X,Y);
			
			_text = new FlxBitmapFont(imgFont,8,16,CHARSET,CHARSET.length);
			_text.setText(text,true,0,8,"center",true);
			_text.x = X+5;
			_text.y = Y+5;

			_bg.makeGraphic(_text.width+10,_text.height+10,0x88000000);
			FlxG.watch(_bg,"alpha");

			_text.scrollFactor.x=_text.scrollFactor.y=_bg.scrollFactor.x=_bg.scrollFactor.y=0;
			add(_bg);
			add(_text);

			_remain = time;
		}

		public override function update():void{
			if (_remain > 0)
				_remain -= FlxG.elapsed;
			else{
				_bg.alpha -= FlxG.elapsed/FADETIME;
				_text.alpha -= FlxG.elapsed/FADETIME;
			}
			if (_text.alpha == 0 ){
				kill();
			}
		}
	}
}