package;

import flixel.tweens.FlxTween;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;
import load.LenguajeData;
import haxe.Json;
import openfl.filesystem.File;
import openfl.utils.Assets;

class PlayState extends FlxState
{
	var nave:FlxSprite;
	var gasolina:FlxSprite;
	var planeta:FlxSprite;
	var gasolinaText:FlxText;
	var puntaje:FlxText;
	var hud:FlxCamera;

	var puntos:Int = 0;

	var planetasDESC:Array<String> = ["gaseoso", "rocoso", "rocoso", "rocoso", "gaseoso"];
    var jsonData:Lenguaje;

	var naveTween:FlxTween;

	override public function create()
	{
		jsonData = Json.parse(Assets.getText("assets/data/lenguajes/"+FlxG.save.data.idioma+".json"));

		var bg:FlxSprite = new FlxSprite(0,0).loadGraphic("assets/images/fondo.png");
        bg.scale.set(0.8,0.8);
        bg.screenCenter();
        add(bg);

		planeta = new FlxSprite(-700,350).loadGraphic("assets/images/exoplanetas/1.png");
        planeta.scale.set(0.3,0.3);
		planeta.updateHitbox();
        add(planeta); 

		nave = new FlxSprite(0,-20).loadGraphic("assets/images/nave.png");
        nave.screenCenter();
        nave.scale.set(0.15,0.15);
		nave.angle = -90;
        add(nave);

		naveTween = FlxTween.tween(nave, {y: 20}, 5, {type: PINGPONG});

		hud = new FlxCamera();
		hud.bgColor.alpha = 0;
		FlxG.cameras.add(hud, false);

		gasolinaText = new FlxText(FlxG.width - 100, 30, 0, "Gasolina");
		gasolinaText.setFormat(null, 10);
		add(gasolinaText);
		gasolinaText.cameras = [hud];
		
		puntaje = new FlxText(FlxG.width - 100, FlxG.height - 100, 0, jsonData.puntaje+puntos);
		puntaje.setFormat(null, 10);
		add(puntaje);
		puntaje.cameras = [hud];

        openSubState(new load.Contadorinicio());

		gasolina = new FlxSprite(0, 20);
		gasolina.makeGraphic(540, 30, FlxColor.LIME); 
		add(gasolina);
		gasolina.cameras = [hud];

		var timer:FlxTimer = new FlxTimer();
        
        timer.start(3, onTimerComplete, 0);

		aparecerplaneta();

		super.create();
	}
	var randomnumber:Int = 1;
	var moving:Bool = false;
	function aparecerplaneta()
	{
		randomnumber = FlxG.random.int(1,5);
		planeta.x = -700;
		planeta.loadGraphic("assets/images/exoplanetas/"+randomnumber+".png");
		moving = true;
		trace("planeta");
	}

	var gameover:Bool = false;

	override public function update(elapsed:Float)
	{
		if (gameover)
		{
			if (FlxG.keys.justPressed.ENTER)
			{
				FlxG.resetGame();
			}
		}
		puntaje.text = jsonData.puntaje+puntos;

		if (moving)
		{
			planeta.x += 1;
		}

		if (planeta.x >= 1000)
		{
			aparecerplaneta();
			puntos += 50;
		}

		if (FlxG.mouse.overlaps(planeta) && FlxG.mouse.justPressed)
		{
			moving = false;

			FlxTween.tween(nave, {angle: 0}, 1);
			trace(planetasDESC[randomnumber]);

			naveTween.cancel();

			new FlxTimer().start(2, function(tmr:FlxTimer)
                {
					if (planetasDESC[randomnumber] == "rocoso")
						{
							FlxTween.tween(nave, {x: planeta.x - 145}, 1);
							new FlxTimer().start(2, function(tmr:FlxTimer)
							{
								FlxTween.tween(nave, {y: 55}, 1);
								new FlxTimer().start(3, function(tmr:FlxTimer)
									{
										FlxTween.tween(nave, {y: (FlxG.height / 2) - (nave.height / 2)}, 1);
										FlxTween.tween(nave, {x: (FlxG.width / 2) - (nave.width / 2)}, 1);
										FlxTween.tween(nave, {angle: -90}, 1);

										gasolina.scale.x += 0.05;

										puntos += 500;

										moving = true;

										naveTween.start();
									});
							});
						}
						if (planetasDESC[randomnumber] == "gaseoso" || planetasDESC[randomnumber] == null || planetasDESC[randomnumber] == "null")
						{
							FlxTween.tween(nave, {x: planeta.x - 145}, 1);
							new FlxTimer().start(2, function(tmr:FlxTimer)
								{
									FlxTween.tween(nave, {y: planeta.y + 100}, 1);

									new FlxTimer().start(3, function(tmr:FlxTimer)
										{
											var gameover:FlxText = new FlxText(0,0,0,jsonData.gameover);
											gameover.setFormat(null, 50);
											gameover.screenCenter();
											add(gameover);
											gameover.cameras = [hud];
										});
								});
						}
                });
		}

		if(gasolina.scale.x > 0.7599999999999998 )
		{
			gasolina.color = FlxColor.LIME;
		}

		if(gasolina.scale.x < 0.7599999999999998 )
		{
			gasolina.color = FlxColor.YELLOW;
		}

		if(gasolina.scale.x < 0.5499999999999996 )
		{
			gasolina.color = FlxColor.RED;
		}

		super.update(elapsed);
	}

	private function onTimerComplete(timer:FlxTimer):Void {
		if (moving)
		{
			gasolina.origin.x = -150;

			gasolina.x += gasolina.width * gasolina.scale.x / 2;

			gasolina.scale.x -= 0.01;

			gasolina.x -= gasolina.width * gasolina.scale.x / 2;
			trace(gasolina.scale.x);
		}
    }
}
