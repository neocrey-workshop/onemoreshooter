package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author neocrey
	 */
	public class Star extends FlxSprite
	{
		[Embed(source = "\star.png")]
		private var ImgStar:Class;
		
		public function Star(x:Number,y:Number):void 
		{
			super(x, y, ImgStar);
			velocity.x = -50;
		}
		
		override public function update():void
		{
			velocity.y = 0;
			super.update();
		}
		
	}

}