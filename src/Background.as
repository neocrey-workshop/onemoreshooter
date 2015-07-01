package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author neocrey
	 */
	public class Background extends FlxSprite 
	{
		[Embed(source = "back.png")]
		private var ImgBack:Class;
		
		public function Background():void 
		{
			super(0, 0,ImgBack);
		}
		
	}

}