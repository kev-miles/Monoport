package;

import monofl.Mono;
import openfl.display.Sprite;
import openfl.Lib;
import monofl.visual.Artist;

class Main extends Sprite
{

	public static var mono:Mono;
	public var newgroundsAPIManager:NewgroundsAPIManager;
	public function new() 
	{
		super();
		mono = new Mono(stage);
		var rect = Artist.roundedRectangle(100, 100, 50, 50, 8, 0x00ffcc, 1);
		mono.mainStage.addChild(rect);
	}
}
