package monofl.managers.complements;

import openfl.events.Event;

class ScreenEvent extends Event
{
	public inline static var CHANGE_SCREEN:String = "Change Screen";		
	public var screenDestiny:String;
		
	public function new(Type:String, bubbles:Bool=false, cancelable:Bool=false)
	{
		super(Type, bubbles, cancelable);
	}
		
	override public function clone():Event
	{
		return this;
	}
}