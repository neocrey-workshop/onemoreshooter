package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author neocrey
	 */
	public class Bullet extends FlxSprite 
	{
		[Embed(source = "bullets.png")]
		private var ImgBullet:Class;
		
		public function Bullet(x:Number,y:Number):void 
		{
			super(x, y,ImgBullet);
			velocity.x = 1000;
		}
		
	}

}