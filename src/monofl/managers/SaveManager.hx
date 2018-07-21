package monofl.managers;

import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.net.SharedObject;
import openfl.utils.Dictionary;

@:meta(Event(name = "complete", Type = "flash.events.Event"))

class SaveManager extends EventDispatcher
{
	public var dataLoaded:Dictionary<String,Dynamic> = new Dictionary<String,Dynamic>();
		
	private var _saver:SharedObject;
	private var _gameName:String;
		
	public function new(gameName:String)
	{
		super();
		this._gameName = gameName;
	}

	public function save(data:Dictionary<String,Dynamic>):Void
	{
		_saver = SharedObject.getLocal(_gameName);
		_saver.data.mySaves = data;
		_saver.flush();
	}
	
	public function load(callback:Dynamic = null):Void
	{
		_saver = SharedObject.getLocal(_gameName);
		dataLoaded = _saver.data.mySaves;
		callback();
	}
}