import flixel.input.gamepad.FlxGamepad;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.text.FlxText;


class MessageState extends MusicBeatState
{
    override function create()
    {
        super.create();

        var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

        if (pressedEnter = true)
            FlxG.switchState(new MainMenuState());
        else
            trace("LEAVING THE HOUSE");

		if (!FlxG.sound.music.playing)
        {
            FlxG.sound.playMusic(Paths.music('freakyMenu'));
        }

        if (FlxG.keys.justPressed.ENTER)
        {
            FlxG.switchState(new MainMenuState());

            trace("LEAVING THE STATION");
        }

        var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.15;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

        var messageText:FlxText = new FlxText(100, 100, FlxG.width);
        messageText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
        messageText.text = "HEY DUMBASS, TO ATTACK AND DODGE, PRESS THE SPACE BAR 3 TIMES IN A SECOND.\nIF YOU READ THE GAMEBANANA DESCRIPTION, YOU'D KNOW THIS... -CLIP";
        messageText.screenCenter();
        messageText.size = 30;
        add(messageText);
    }
}