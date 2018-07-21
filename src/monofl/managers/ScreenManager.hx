package monofl.managers;

//import js.html.NamedNodeMap;
import monofl.Mono;
import monofl.managers.complements.Screen;
import monofl.managers.complements.ScreenEvent;
	
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.Event;
import openfl.utils.Dictionary;
import openfl.Vector;
	
class ScreenManager
{
	private var _screens:Dictionary<String,Dynamic> = new Dictionary<String,Dynamic>();
	private var _currentScreen:Screen;
		
	public function new()
	{
		Main.mono.updateManager.addCallBack(evUpdate);
	}
		
	private function evUpdate():Void
	{
		if(_currentScreen != null && !_currentScreen.isPaused)
		{
			_currentScreen.update();
		}
	}
		
	public function registerScreen(name:String, scr:Dynamic):Void
	{
		_screens[name] = scr;
	}
		
	public function loadScreen(name:String):Void
	{
		var screenClass:Screen = _screens[name]; 
		if(screenClass != null) 
		{
			if(_currentScreen!=null) 
			{
				_currentScreen.exit(); 
				_currentScreen = null; 
			}
			_currentScreen = screenClass;
			_currentScreen.addEventListener("Change Screen", evChange); 
		}
		else
		{
			Main.mono.reportError("The screen has not been registered", "Managers", "ScreenManager", "loadScreen");
		}
	}
		
	public function closeScreen():Void
	{
		if(_currentScreen != null)
		{
			_currentScreen.exit();
			_currentScreen = null;
		}
	}
		
	private function evChange(e:ScreenEvent):Void
	{
		e.stopPropagation();
		loadScreen(e.screenDestiny);
	}
}