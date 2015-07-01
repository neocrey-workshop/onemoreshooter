package 
{
	import org.flixel.*;
	
	[SWF(width = "480", height = "320", backgroundColor = "#000000")]
	[Frame(factoryClass = "Preloader")]
	
	public class Main extends FlxGame
	{
		
		public function Main():void 
		{
			super(480, 320, MenuState, 1);			
		}
	}
	
	
}