package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	public var cut:Bool = false;

	var portraitLeft:FlxSprite;
	var portraitLefta:FlxSprite;
	var portraitLeftb:FlxSprite;
	var portraitRight:FlxSprite;

	var bgFade:FlxSprite;

	var bgImage:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'paperclips':
				FlxG.sound.playMusic(Paths.music('neckless'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'ray':
				FlxG.sound.playMusic(Paths.music('neckless'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'bonk':
				FlxG.sound.playMusic(Paths.music('neckless'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'limbs':
				FlxG.sound.playMusic(Paths.music('neckless'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'paperclips' | 'ray' | 'bonk' | 'limbs':
				hasDialog = true;
				dialogBoxSet();
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		bgImage = new FlxSprite().loadGraphic(Paths.image('cutscenes/panel_1', 'shared'));
		bgImage.setGraphicSize(Std.int(bgImage.width * 0.265));
		bgImage.updateHitbox();
		bgImage.screenCenter();
		bgImage.scrollFactor.set();
		bgImage.antialiasing = true;

		if (PlayState.SONG.song.toLowerCase() == 'ray' && cut)
		{
			add(bgImage);
			box.visible = false;
		}
		trace(bgImage.graphic);
		
		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
		{
			portraitLeft = new FlxSprite(-20, 40);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
			portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
		}
		else if (PlayState.SONG.song.toLowerCase() == 'paperclips' || PlayState.SONG.song.toLowerCase() == 'ray' || PlayState.SONG.song.toLowerCase() == 'bonk' || PlayState.SONG.song.toLowerCase() == 'limbs')
		{
			portraitLeft = new FlxSprite(-700, 170);
			portraitLeft.frames = Paths.getSparrowAtlas('portraits');
			portraitLeft.animation.addByPrefix('angry', 'clip ANGY', 24, false);
			portraitLeft.animation.addByPrefix('nervous', 'clip nervous', 24, false);
			portraitLeft.animation.addByPrefix('enter', 'clip portraits', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.12));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;

			portraitLefta = new FlxSprite(-700, 25).loadGraphic(Paths.image('sylvania_portrait', 'shared'));
			portraitLefta.setGraphicSize(Std.int(portraitLefta.width * PlayState.daPixelZoom * 0.12));
			portraitLefta.updateHitbox();
			portraitLefta.setGraphicSize(Std.int(portraitLefta.width * 1.5));
			portraitLefta.scrollFactor.set();

			portraitLeftb = new FlxSprite(-700, 25).loadGraphic(Paths.image('carcal_portrait', 'shared'));
			portraitLeftb.setGraphicSize(Std.int(portraitLeftb.width * PlayState.daPixelZoom * 0.12));
			portraitLeftb.updateHitbox();
			portraitLeftb.setGraphicSize(Std.int(portraitLeftb.width * 1.5));
			portraitLeftb.scrollFactor.set();
			portraitLefta.visible = false;
			portraitLeftb.visible = false;
			if (PlayState.SONG.song.toLowerCase() == 'limbs')
			{
				add(portraitLefta);

				add(portraitLeftb);
			}
		}

		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
		{
			portraitRight = new FlxSprite(0, 40);
			portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
			portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
		}
		else
		{
			portraitRight = new FlxSprite(700, 170);
			portraitRight.frames = Paths.getSparrowAtlas('bfport');
			portraitRight.animation.addByPrefix('enter', 'bfport', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
			/*portraitRight = new FlxSprite(-50, 40);
			portraitRight.frames = Paths.getSparrowAtlas('boyfriendPortrait');
			portraitRight.animation.addByPrefix('enter', 'BF Portrait Enter instance 1', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;*/
		}
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Anime Ace 2.0 BB';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Anime Ace 2.0 BB';
		swagDialogue.color = 0xFF3F2021;
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}
		if (PlayState.SONG.song.toLowerCase() == 'paperclips' || PlayState.SONG.song.toLowerCase() == 'ray' || PlayState.SONG.song.toLowerCase() == 'bonk' || PlayState.SONG.song.toLowerCase() == 'limbs')
		{
			swagDialogue.color = FlxColor.BLACK;
			dropText.color = FlxColor.CYAN;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			if (PlayState.SONG.song.toLowerCase()=='paperclips' || PlayState.SONG.song.toLowerCase()=='ray' || PlayState.SONG.song.toLowerCase()=='bonk' || PlayState.SONG.song.toLowerCase()=='limbs')
			{
				FlxG.sound.play(Paths.sound('clipSkip'), 0.8);
			}
			else
			{
				FlxG.sound.play(Paths.sound('clickText'), 0.8);
			}

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if ((PlayState.SONG.song.toLowerCase() == 'paperclips' || PlayState.SONG.song.toLowerCase() == 'ray' || PlayState.SONG.song.toLowerCase() == 'bonk' || PlayState.SONG.song.toLowerCase() == 'limbs') && !cut)
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				portraitLefta.visible = false;
				portraitLeftb.visible = false;
				if (!portraitLeft.visible)
				{
					leftPortraitSet();
				}
			case 'clip':
				portraitRight.visible = false;
				portraitLefta.visible = false;
				portraitLeftb.visible = false;
				if (!portraitLeft.visible)
				{
					leftPortraitSet();
				}
			case 'clipscared':
				portraitRight.visible = false;
				portraitLefta.visible = false;
				portraitLeftb.visible = false;
				if (!portraitLeft.visible)
				{
					leftPortraitSet();
				}
			case 'clipangry':
				portraitRight.visible = false;
				portraitLefta.visible = false;
				portraitLeftb.visible = false;
				if (!portraitLeft.visible)
				{
					leftPortraitSet();
				}
			case 'bf':
				portraitLeft.visible = false;
				portraitLefta.visible = false;
				portraitLeftb.visible = false;
				if (!portraitRight.visible)
				{
					rightPortraitSet();
				}
			case 'sylvania':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitLefta.visible)
				{
					leftPortraitASet();
				}
			case 'carcal':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitLeftb.visible)
				{
					leftPortraitBSet();
				}
			case 'bgChange':
				backgroundChange();
		}
	}
	function rightPortraitSet():Void
	{
		if (PlayState.SONG.song.toLowerCase()=='paperclips' || PlayState.SONG.song.toLowerCase() == 'ray' || PlayState.SONG.song.toLowerCase() == 'bonk' || PlayState.SONG.song.toLowerCase() == 'limbs')
		{
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('boyfriendText'), 0.6)];
		}
		else
		{
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		}
		portraitRight.visible = true;
		portraitRight.updateHitbox();
		portraitRight.animation.play('enter');
		box.flipX = false;
	}
	function leftPortraitSet():Void
	{
		if (PlayState.SONG.song.toLowerCase()=='paperclips' || PlayState.SONG.song.toLowerCase() == 'ray' || PlayState.SONG.song.toLowerCase() == 'bonk' || PlayState.SONG.song.toLowerCase() == 'limbs')
		{
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('clipTalk'), 0.6)];
		}
		else
		{
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		}
		portraitLeft.visible = true;
		portraitLeft.updateHitbox();
		//portraitLeft.animation.play('enter');
		box.flipX = true;
		portraitLeft.x = 175;
		portraitLeft.y = 200;
	}
	function leftPortraitASet():Void
	{
		if (PlayState.SONG.song.toLowerCase()=='paperclips' || PlayState.SONG.song.toLowerCase() == 'ray' || PlayState.SONG.song.toLowerCase() == 'bonk' || PlayState.SONG.song.toLowerCase() == 'limbs')
		{
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('clipTalk'), 0.6)];
		}
		else
		{
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		}
		portraitLefta.visible = true;
		portraitLefta.updateHitbox();
		//portraitLeft.animation.play('enter');
		box.flipX = true;
		portraitLefta.x = 175;
		portraitLefta.y = 200;
	}
	function leftPortraitBSet():Void
	{
		if (PlayState.SONG.song.toLowerCase()=='paperclips' || PlayState.SONG.song.toLowerCase() == 'ray' || PlayState.SONG.song.toLowerCase() == 'bonk' || PlayState.SONG.song.toLowerCase() == 'limbs')
		{
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('clipTalk'), 0.6)];
		}
		else
		{
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		}
		portraitLeftb.visible = true;
		portraitLeftb.updateHitbox();
		//portraitLeft.animation.play('enter');
		box.flipX = true;
		portraitLeftb.x = 175;
		portraitLeftb.y = 200;
	}
	function backgroundChange():Void
	{
		portraitLeft.visible = false;
		portraitRight.visible = false;
		box.visible = false;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialog/text'), 0.6)];
		if (PlayState.SONG.song.toLowerCase() == 'limbs')
		{
			bgImage.setGraphicSize(Std.int(bgImage.width * 1.55));
			bgImage.updateHitbox();
			bgImage.screenCenter();
			bgImage.scrollFactor.set();
		}
		remove(bgImage);
		bgImage.loadGraphic(Paths.image(('cutscenes/' + dialogueList[0]), 'shared'));
		add(bgImage);
		if (dialogueList[0] == 'panel_4')
		{
			dialogueList.remove(dialogueList[0]);
			startDialogue();
		}
	}
	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
		if (curCharacter == 'clip')
		{
			portraitLeft.animation.play('enter');
		}
		else if (curCharacter == 'clipscared')
		{
			portraitLeft.animation.play('nervous');
		}
		else if (curCharacter == 'clipangry')
		{
			portraitLeft.animation.play('angry');
		}
	}
	function dialogBoxSet():Void
	{
		box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
		box.width = 200;
		box.height = 200;
		box.x = -100;
		box.y = 375;
		box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open0', 24, false);
		box.animation.addByIndices('normal', 'speech bubble normal0', [4], "", 24);
	}
}
