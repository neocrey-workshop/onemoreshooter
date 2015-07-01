package  
{
	import adobe.utils.CustomActions;
	import org.flixel.*;
	
	/**
	 * ..
	 * @author neocrey
	 */
	public class PlayState extends FlxState
	{
		
		[Embed(source = "\alkill.mp3")]
		private var Alkill:Class;
		
		[Embed(source = "\explosion.mp3")]
		private var Explosion:Class;
		
		[Embed(source = "\shoot.mp3")]
		private var Shoot:Class;
		
		[Embed(source = "reload.mp3")]
		private var Reload:Class;
		
		private var _back:Background;
		private var _ship:Ship;
		private var _wall:Wall;
		private var _aliens:FlxGroup;
		private var _bullets:FlxGroup;
		private var _spawnTimer:Number;
		private var _spawnInterval:Number = 2.5;
		private var _scoreText:FlxText;
		private var _gameOverText:FlxText;		
		
		override public function create():void 
		{
			
			_back = new Background();
			add(_back);
			
			FlxG.score = 0;
			_scoreText = new FlxText(200, 8, 100, "0");
			_scoreText.setFormat(null, 32, 0xFFFFFFFF, "center");
			add(_scoreText);
			
			FlxG.bgColor = 0xFF000000;
			
			_wall = new Wall();
			add(_wall);
			
			_ship = new Ship();
			add(_ship);
			
			_aliens = new FlxGroup();
			add(_aliens);
			
			_bullets = new FlxGroup();
			add(_bullets);
			
			resetSpawnTimer();
			
			super.create();
		}
		
		override public function update():void
		{
			
			if (FlxG.mouse.justPressed() && _ship.exists)
			{
				FlxG.play(Shoot, 1, false);
				spawnBullet(_ship.getBulletSpawnPosition());
			}
			
			if (FlxG.mouse.justPressed() && _ship.exists==false)
			{
				FlxG.play(Reload, 0.7, false);
				FlxG.fade(0xff000000, 1, gotoReload);
			}

			_spawnTimer -= FlxG.elapsed;
			
			if (_spawnTimer < 0)
			{
				spawnAlien();
				resetSpawnTimer();
			}
			
			super.update();
			
			if (_ship.x > FlxG.width - 16)
			{
				_ship.x = FlxG.width - 16; 
			}
			else if (_ship.x < 16)
			{
				_ship.x = 16;
			}
			
			if (_ship.y > FlxG.height - 16)
			{
				_ship.y = FlxG.height - 16;
			}
			else if (_ship.y < 16)
			{
				_ship.y = 16;
			}
			
			FlxG.overlap(_aliens, _bullets, overlapAlienBullet);
			FlxG.overlap(_aliens, _ship, overlapAlienShip);
			FlxG.overlap(_aliens, _wall, overlapAlienWall);
			
		}
		
		private function createEmitter():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.lifespan = 1;
			emitter.gravity = 0;
			emitter.maxRotation = 0;
			emitter.setXSpeed( -500, 500);
			emitter.setYSpeed( -500, 500);
			var particles:int = 10;
			for (var i:int = 0; i < particles; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(2, 2, 0xFF00FF00);
				particle.exists = false;
				emitter.add(particle);
			}
			emitter.start();
			add(emitter);
			return emitter;
		}
		
		private function createEmitterWall():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.lifespan = 1;
			emitter.gravity = 0;
			emitter.maxRotation = 0;
			emitter.setXSpeed( -500, 500);
			emitter.setYSpeed( -500, 500);
			var particles:int = 50;
			for (var i:int = 0; i < particles; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(5, 5, 0xFFFFFFFF);
				particle.exists = false;
				emitter.add(particle);
			}
			emitter.start();
			add(emitter);
			return emitter;
		}
		
		private function createEmitterShip():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.lifespan = 1;
			emitter.gravity = 0;
			emitter.maxRotation = 0;
			emitter.setXSpeed( -500, 500);
			emitter.setYSpeed( -500, 500);
			var particles:int = 10;
			for (var i:int = 0; i < particles; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(3, 3, 0xFFFFFFFF);
				particle.exists = false;
				emitter.add(particle);
			}
			emitter.start();
			add(emitter);
			return emitter;
		}
		
		private function overlapAlienBullet(alien:Alien, bullet:Bullet):void
		{
			var emitter:FlxEmitter = createEmitter();
			emitter.at(alien);
			alien.kill();
			bullet.kill();
			FlxG.play(Alkill, 1, false);
			FlxG.score += 1;
			_scoreText.text = FlxG.score.toString();
		}
		
		private function overlapAlienShip(alien:Alien, ship:Ship):void
		{
			var emitter:FlxEmitter = createEmitterShip();
			emitter.at(ship);
			ship.kill();
			alien.kill();
			FlxG.shake(0.035,0.5);
			FlxG.play(Explosion, 1, false);
			_gameOverText = new FlxText(0, FlxG.height / 2-30, FlxG.width, "Game over!\nTap to play again");
			_gameOverText.setFormat(null, 16, 0xFFFFFFFF, "center");
			add(_gameOverText);
		}
		
		private function overlapAlienWall(alien:Alien, wall:Wall):void
		{
			var emitter2:FlxEmitter = createEmitterShip();
			emitter2.at(_ship);
			_ship.kill();
			alien.kill();
			var emitter:FlxEmitter = createEmitterWall();
			emitter.at(wall);
			wall.kill();
			FlxG.shake(0.035,0.5);
			FlxG.play(Explosion, 1, false);
			_gameOverText = new FlxText(0, FlxG.height / 2-30, FlxG.width, "Game over!\nTap to play again");
			_gameOverText.setFormat(null, 16, 0xFFFFFFFF, "center");
			add(_gameOverText);
		}
		
		private function spawnBullet(p:FlxPoint):void
			{
				var bullet:Bullet = new Bullet(p.x, p.y);
				_bullets.add(bullet);
			}
		
		private function spawnAlien():void 
		{
			var x:Number = FlxG.width;
			var y:Number = Math.random() * (FlxG.height - 100) + 20;
			_aliens.add(new Alien(x, y));
		}
		
		private function resetSpawnTimer():void
		{
			_spawnTimer = _spawnInterval;
			_spawnInterval *= 0.97;
			if (_spawnInterval < 0.1)
			{
				_spawnInterval = 0.1;
			}
		}
		
		protected function gotoReload():void
		{
			FlxG.switchState(new PlayState());
		}
		
	}

}