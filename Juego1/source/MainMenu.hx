package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.Json;
import openfl.filesystem.File;
import openfl.utils.Assets;
import load.LenguajeData.Lenguaje;

class MainMenu extends FlxState
{
    var logoText:FlxText;
    var iniciar:FlxText;
    var opciones:FlxText;

    var tierra:FlxSprite;
    var nave:FlxSprite;
    var jsonData:Lenguaje;

	override public function create()
	{
        jsonData = Json.parse(Assets.getText("assets/data/lenguajes/"+FlxG.save.data.idioma+".json"));

        var bg:FlxSprite = new FlxSprite(0,0).loadGraphic("assets/images/fondo.png");
        bg.scale.set(0.8,0.8);
        bg.screenCenter();
        add(bg);

        tierra = new FlxSprite(0,FlxG.height - 80).loadGraphic("assets/images/tierra.png");
        tierra.screenCenter(X);
        add(tierra);

        nave = new FlxSprite(0,FlxG.height - 366).loadGraphic("assets/images/nave.png");
        nave.screenCenter(X);
        nave.scale.set(0.15,0.15);
        add(nave);

        logoText = new FlxText(0, 90, 0, "ExoFuel");
        logoText.setFormat(null, 60);
        logoText.screenCenter(X);
        logoText.angle = -20;
        add(logoText);

        iniciar = new FlxText(0, 250, 0, jsonData.iniciarTXT);
        iniciar.setFormat(null, 20);
        iniciar.screenCenter(X);
        add(iniciar);
        
        opciones = new FlxText(0, 300, 0, jsonData.opcionesTXT);
        opciones.setFormat(null, 20);
        opciones.screenCenter(X);
        add(opciones);

        FlxTween.tween(logoText, {angle: 20}, 3, {type: PINGPONG});

		super.create();
	}

    var selected:Int;
    var start:Bool = false;

	override public function update(elapsed:Float)
	{
        if (start)
        {
            nave.x = FlxG.random.int(60, 70);
            
            new FlxTimer().start(3, function(tmr:FlxTimer)
                {
                    openSubState(new LoadScreen());

                    new FlxTimer().start(7, function(tmr:FlxTimer)
                        {
                            remove(tierra);
                        });
                });
        }

        if (FlxG.mouse.overlaps(iniciar))
        {
            iniciar.setFormat(null, 20, FlxColor.YELLOW);
            
            if (FlxG.mouse.justPressed)
            {
                FlxTween.tween(iniciar, {x: -300}, 3, {ease: FlxEase.backInOut});
                FlxTween.tween(opciones, {x: -300}, 3, {ease: FlxEase.backInOut});
                FlxTween.tween(logoText, {x: -300}, 3, {ease: FlxEase.backInOut});
                selected = 1;

                new FlxTimer().start(4, function(tmr:FlxTimer)
                    {
                        nave.loadGraphic("assets/images/navevolando.png");
                        FlxTween.tween(nave, {y: -300}, 5);
                        start = true;
                    });
            }
        }
        else 
        {
            iniciar.setFormat(null, 20, FlxColor.WHITE);
        }

        if (FlxG.mouse.overlaps(opciones))
        {
            opciones.setFormat(null, 20, FlxColor.YELLOW);
            if (FlxG.mouse.justPressed)
                {
                    openSubState(new Options());
                }
        }
        else 
        {
            opciones.setFormat(null, 20, FlxColor.WHITE);
        }
		super.update(elapsed);
	}
}
