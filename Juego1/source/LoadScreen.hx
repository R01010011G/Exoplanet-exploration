package;

import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxGradient;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import haxe.Json;
import openfl.utils.Assets;
import load.LenguajeData.Lenguaje;

class LoadScreen extends FlxSubState
{
    var transision:FlxSprite;
    var planeta:FlxSprite;
    var logoText:FlxText;
    var jsonData:Lenguaje;

    override public function create()
        {
            jsonData = Json.parse(Assets.getText("assets/data/lenguajes/"+FlxG.save.data.idioma+".json"));

            transision = new FlxSprite(0,FlxG.height - 366).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
            transision.screenCenter();
            transision.alpha = 0;
            add(transision);

            planeta = new FlxSprite(FlxG.width - 230, FlxG.height - 230).loadGraphic("assets/images/tierra.png");
            planeta.alpha = 0;
            planeta.scale.set(0.3,0.3);
            add(planeta);

            logoText = new FlxText(0, 0, 0, "ExoFuel");
            logoText.setFormat(null, 60);
            logoText.alpha = 0;
            add(logoText);

            var controles:FlxText = new FlxText(0, FlxG.height - 20, 0, jsonData.controles);
            controles.setFormat(null, 8);
            controles.alpha = 0;
            add(controles);

            FlxTween.tween(transision, {alpha: 1}, 3);
            FlxTween.tween(planeta, {alpha: 1}, 3);
            FlxTween.tween(logoText, {alpha: 1}, 3);
            FlxTween.tween(controles, {alpha: 1}, 3);

            new FlxTimer().start(15, function(tmr:FlxTimer)
                {
                    FlxTween.tween(transision, {alpha: 0}, 3);
                    FlxTween.tween(planeta, {alpha: 0}, 3);
                    FlxTween.tween(logoText, {alpha: 0}, 3);
                    FlxTween.tween(controles, {alpha: 0}, 3);

                    new FlxTimer().start(5, function(tmr:FlxTimer)
                        {
                            FlxG.switchState(new PlayState());
                        });
                });
        }

    override public function update(elapsed:Float)
        {
            planeta.angle += 1; 
        }
}