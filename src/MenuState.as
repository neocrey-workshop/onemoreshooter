package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author neocrey
	 */
	public class MenuState extends FlxState
	{
		[Embed(source = "\music.mp3")]
		private var MenuMusic:Class;
		
		[Embed(source = "reload.mp3")]
		private var SNG:Class;
		
		private var Stars:FlxGroup;
		private var _spawnTimer:Number;
		private var _spawnInterval:Number = 1;
		
		override public function create():void 
		{
			FlxG.playMusic(MenuMusic,1);
			
			FlxG.bgColor = 0xff000000;
			
			Stars = new FlxGroup();
			add(Stars);
			
			resetSpawnTimer();
			
			var text:FlxText;
			text = new FlxText(FlxG.width / 2 - 205, FlxG.height / 3 - 100, 420, "OneMoreShooter");
			text.color = 0xffffff;
			text.alignment = "center";
			text.size = 40;
			add(text);
			
			var text2:FlxText;
			text2 = new FlxText(FlxG.width / 2 - 255, FlxG.height / 3 + 165, 500, "http://neocrey.newgrounds.com");
			text2.alignment = "center";
			text2.color = 0x9090FF;
			text2.size = 16;
			add(text2);
			
			var text3:FlxText;
			text3 = new FlxText(FlxG.width / 2 - 205, FlxG.height / 3 - 34, 400, "Mission: Protect Earth from alien invaders.\nMove your defend-machine with finger and tap on screen when you want to shoot.\nDestroy all aliens and try not to collide with them.\nAvoid collising aliens with main power tower of your ship.\nGood luck, soldier!\n\nTap on screen to start new game.");
			text3.alignment = "center";
			text3.color = 0xC8909F;
			text3.size = 16;
			add(text3);
			
		}
		
		override public function update():void
		{	
			if (FlxG.mouse.justPressed())
			{
				FlxG.play(SNG, 1, false);
				FlxG.fade(0xff000000, 0.3, gotoRoom);
			}
			
			super.update();
			
			_spawnTimer -= FlxG.elapsed;
			
			if (_spawnTimer < 0)
			{
				createStar();
				resetSpawnTimer();
			}
			
		}
		
		protected function gotoRoom():void
		{
			FlxG.switchState(new PlayState());
		}
		
		private function createStar():void 
		{
			var x:Number = FlxG.width;
			var y:Number = Math.random() * (FlxG.height - 100) + 50;
			Stars.add(new Star(x, y));
		}
		
		private function resetSpawnTimer():void
		{
			_spawnTimer = _spawnInterval;
			_spawnInterval *= 0.95;
			if (_spawnInterval < 0.1)
			{
				_spawnInterval = 0.1;
			}
		}
		
	}

}