package monofl.managers;

import monofl.Mono;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.Event;
import openfl.Vector;
import haxe.macro.Type;

class UpdateManager
{
	public var isPaused:Bool;
	
	private var _callBacks:Vector<Dynamic> = new Vector<Dynamic>();
		
	public function new()
	{
		Main.mono.mainStage.addEventListener(Event.ENTER_FRAME, evUpdate);
		Main.mono.reportOpen("UpdateManager.as", "Managers");
	}
		
	private function evUpdate(e:Event):Void
	{
		if(!isPaused)
		{
			var i:Int = 0;
			
			for (i in 0 ... _callBacks.length -1)
			{ 
				_callBacks[i]();
			}
		}
	}
		
	public function addCallBack(call:Dynamic):Void
	{
		_callBacks.push(call);
	}

	public function removeCallBack(call:Dynamic):Void
	{
		var index:Int = _callBacks.indexOf(call);
		if(index != -1)
		{
			_callBacks.splice(index, 1);
		}
	}
}