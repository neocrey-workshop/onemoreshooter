package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author neocrey
	 */
	public class Ship extends FlxSprite
	{
		[Embed(source = "\Ship.png")]
		private var ImgShip:Class;
				
		public function Ship():void
		{
			super(30, 50, ImgShip);
		}
		
		public function getBulletSpawnPosition():FlxPoint
		{
			var p:FlxPoint = new FlxPoint(x + 8, y + 12);
			return p;
		}
		
		override public function update():void
		{
			velocity.x = 0;
			velocity.y = 0;
			
			if (FlxG.mouse.justPressed())
			{
				y = FlxG.mouse.y;
			}
			super.update();
		}
		
	}

}