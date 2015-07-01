package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author neocrey
	 */
	public class Wall extends FlxSprite 
	{
		[Embed(source = "wall.png")]
		private var ImgWall:Class;
		
		public function Wall():void 
		{
			super(0, 0,ImgWall);
		}
		
	}

}