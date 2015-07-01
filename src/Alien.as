package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author neocrey
	 */
	public class Alien extends FlxSprite
	{
		[Embed(source = "\Alien.png")]
		private var ImgAlien:Class;
		
		public function Alien(x:Number,y:Number):void 
		{
			super(x, y, ImgAlien);
			velocity.x = -200;
		}
		
		override public function update():void
		{
			velocity.y = Math.cos(x / 50) * 300;
			super.update();
		}
		
	}

}