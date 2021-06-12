package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);


		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('bf-s', [0, 1], 0, false, isPlayer);
		animation.add('bf-b', [0, 1], 0, false, isPlayer);
		animation.add('gf', [16], 0, false, isPlayer);
		animation.add('clip', [24, 25], 0, false, isPlayer);
		animation.add('clip-s', [24, 25], 0, false, isPlayer);
		animation.add('clip-f', [24, 25], 0, false, isPlayer);
		animation.add('hazel', [26, 27], 0, false, isPlayer);
		animation.play(char);
		switch(char){
			case 'bf-pixel' | 'senpai' | 'senpai-angry' | 'spirit' | 'gf-pixel':
				{

				}
			default:
				{
					antialiasing = true;
				}
		}
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
