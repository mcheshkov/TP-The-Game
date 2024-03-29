package 
{
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	import flash.events.*;
	[SWF(width="640", height="480", backgroundColor="#000000")] //Set the size and color of the Flash file
	[Frame(factoryClass="Preloader")]

	public class TheGame extends FlxGame
	{
		public function TheGame()
		{
			super(320,240,MenuState,2); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
			forceDebugger = true;
		}
		protected override function onFocus(FlashEvent:Event=null):void{
			//super.onFocus(FlashEvent);
		}
		protected override function onFocusLost(FlashEvent:Event=null):void{
			//super.onFocusLost(FlashEvent);
		}
	}
}