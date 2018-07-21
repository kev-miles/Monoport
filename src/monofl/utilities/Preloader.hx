package monofl.utilities;

import openfl.display.DisplayObject;
import openfl.display.MovieClip;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import openfl.utils.getDefinitionByName;

class Preloader extends MovieClip
{
	private var _frameworkModel:MCPreloader;
	private var _loaded:Bool;
		
	public function Preloader()
	{
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}
		
	private function onAdded(e:Event):Void
	{
		_loaded = false;
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
		
	private function onEnterFrame(e:Event):Void
	{
		if(_frameworkModel == null)
		{
			_frameworkModel = new MCPreloader();
			addChild(_frameworkModel);
		}
		if(!_loaded && root.loaderInfo.bytesLoaded >= root.loaderInfo.bytesTotal)
			finish();
		else
			update();
	}
		
	private function update():Void
	{
		_frameworkModel.Bar.Fill.scaleX = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
	}
		
	private function finish():Void
	{
		removeChild(_frameworkModel);
		_frameworkModel = null;
		_loaded = true;
		nextFrame();
		var mainClass:Class = getDefinitionByName("Main") as Class;
		var displayObject:DisplayObject = new mainClass() as DisplayObject;
		addChildAt(displayObject, 0);
	}
}