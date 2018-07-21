package;

import monofl.Mono;
import openfl.display.Sprite;
import openfl.Lib;
import monofl.visual.PixelColorReader;
import monofl.visual.Artist;
import monofl.managers.NewgroundsAPIManager;

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
		trace(PixelColorReader.readStageColors(mono.mainStage));

		#if flash
		newgroundsAPIManager = new NewgroundsAPIManager("46347:BnXw5PZd", "NPGvmmJhMnoArwuDIYiopQ==", Main.mono.mainStage);
		newgroundsAPIManager.addAd(250, 150);
		#end

		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
	}

}
