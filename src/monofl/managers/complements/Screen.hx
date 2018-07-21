package monofl.managers.complements;


import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.events.EventDispatcher;

@:meta(Event(name = "Change Screen", Type = "mono.managers.complements.ScreenEvent"))

class Screen extends EventDispatcher
{

	public var isPaused:Bool;

	public function new(name:String)
	{
		super();
	}

	public function update():Void
	{
		
	}

	public function changeScreen(name:String):Void
	{
		var myEvent:ScreenEvent = new ScreenEvent( ScreenEvent.CHANGE_SCREEN );
		myEvent.screenDestiny = name;
		dispatchEvent(myEvent);
	}

	public function exit():Void
	{
	}
}
