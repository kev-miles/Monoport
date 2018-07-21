package monofl.managers.complements;

import monofl.Mono;

class Key 
{
	public var isPressed:Bool;
	public var wasPressed:Bool;
	public var wasReleased:Bool;
	
	public function new() 
	{
		
	}
	
	public function press():Void
	{
		isPressed = true;
		wasPressed = true;
		
		if(Main.mono.updateManager == null)
		{
			Main.mono.reportError("Update Manager must be initialized ", "Managers/Complements", "Keys", "press");
		}
		else
		{
			Main.mono.updateManager.addCallBack(markWasPressed);
		}
	}

	public function release():Void
	{
		isPressed = false;
		wasReleased = true;
		Main.mono.updateManager.addCallBack(markWasReleased);
	}
		
	private function markWasPressed():Void
	{
		wasPressed = false;
		Main.mono.updateManager.removeCallBack(markWasPressed);
	}

	private function markWasReleased():Void
	{
		wasReleased = false;
		Main.mono.updateManager.removeCallBack(markWasReleased);
	}
}