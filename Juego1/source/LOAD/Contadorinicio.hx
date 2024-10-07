package load;

import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

class Contadorinicio extends FlxSubState
{
    override public function create()
        {
    
            new FlxTimer().start(3, function(tmr:FlxTimer)
                {
                    var con1:FlxText = new FlxText(0, 0, 0, "3");
                    con1.setFormat(null, 50);
                    con1.screenCenter();
                    add(con1);
                    new FlxTimer().start(1.5, function(tmr:FlxTimer)
                        {
                            remove(con1);
                            var con2:FlxText = new FlxText(0, 0, 0, "2");
                            con2.setFormat(null, 50);
                            con2.screenCenter();
                            add(con2);
                            new FlxTimer().start(1.5, function(tmr:FlxTimer)
                                {
                                    remove(con2);
                                    var con3:FlxText = new FlxText(0, 0, 0, "1");
                                    con3.setFormat(null, 50);
                                    con3.screenCenter();
                                    add(con3);
    
                                    new FlxTimer().start(1.5, function(tmr:FlxTimer)
                                        {
                                            remove(con3);
                                            var con4:FlxText = new FlxText(0, 0, 0, "Go!");
                                            con4.setFormat(null, 50);
                                            con4.screenCenter();
                                            add(con4);
    
                                            new FlxTimer().start(1.5, function(tmr:FlxTimer)
                                                {
                                                    remove(con4);
                                                    close();
                                                });
                                        });
                                });
                        });
                });
    
            super.create();
        }
    
}