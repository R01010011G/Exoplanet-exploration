package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxSubState;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.text.FlxText;

class Options extends FlxSubState
{
    var lenguajes:Array<String> = ["English", "Espanol", "Francais", "Deutsch"];
    var lenguajeselector:Int = 0;
    var lenguajeTXT:FlxText;

    override public function create()
        {
            var bg:FlxSprite = new FlxSprite(0,0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
            bg.alpha = 0.5;
            add(bg);

            lenguajeTXT = new FlxText(0, 0, 0, "<"+lenguajes[lenguajeselector]+">");
            lenguajeTXT.setFormat(null, 50);
            lenguajeTXT.screenCenter(X);
            add(lenguajeTXT);

            super.create();
        }
	override public function update(elapsed:Float)
        {
            if (FlxG.keys.justPressed.ENTER)
            {
                FlxG.save.data.idioma = lenguajes[lenguajeselector];
                FlxG.save.flush();
                FlxG.resetGame();
                close();
            }

            if (FlxG.keys.justPressed.LEFT)
            {
                if (lenguajeselector <= 0)
                {
                    lenguajeselector = 0;
                }
                else 
                {
                    lenguajeselector -= 1;
                }

                lenguajeTXT.text = "<"+lenguajes[lenguajeselector]+">";
            }

            if (FlxG.keys.justPressed.RIGHT)
                {
                    if (lenguajeselector >= lenguajes.length - 1)
                        {
                            lenguajeselector = lenguajes.length - 1;
                        }
                        else 
                        {
                            lenguajeselector += 1;
                        }

                    lenguajeTXT.text = "<"+lenguajes[lenguajeselector]+">";
                }
            super.update(elapsed);
        }
}