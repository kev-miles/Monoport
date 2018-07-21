package monofl.managers;

import monofl.managers.complements.Key;
import monofl.Mono;
	
import openfl.display.Stage;
import openfl.events.KeyboardEvent;
import openfl.utils.Dictionary;
	
class InputManager
{
	private var _keys:Array<Key> = new Array<Key>();
	private var _keysByName:Dictionary<String,Key> = new Dictionary<String,Key>();	
	private var _recordingKey:String;

	public function new()
	{
		Main.mono.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyDown);
		Main.mono.mainStage.addEventListener(KeyboardEvent.KEY_UP, evKeyUp);
		Main.mono.reportOpen("InputManager.as", "Managers");
	}

	private function evKeyDown(e:KeyboardEvent):Void
	{
		var k:Key = _keys[e.keyCode];
		if(k == null)
		{
			k = new Key();
			_keys[e.keyCode] = k;
		}			
		if(!k.isPressed)
		{
			k.press();
		}
	}

	private function evKeyUp(e:KeyboardEvent):Void
	{
		var k:Key = _keys[e.keyCode];
		if(k == null)
		{
			k = new Key();
			_keys[e.keyCode] = k;
		}
			
		if(k.isPressed)
		{
			k.release();
		}
	}

	public function addRelationKey(code:Int, name:String):Void
	{
		var k:Key = _keys[code];
		if(k == null)
		{
			k = new Key();
			_keys[code] = k;
		}
			
		_keysByName[name] = k;
	}

	public function getKeyPressed(code:Int):Bool
	{
		return _keys[code] != null ? _keys[code].isPressed : false;
	}

	public function getKeyWasPressed(code:Int):Bool
	{
		return _keys[code] != null ? _keys[code].wasPressed : false;
	}

	public function getKeyReleased(code:Int):Bool
	{
			return _keys[code] != null ? _keys[code].wasReleased : false;
	}

	public function getKeyPressedByName(name:String):Bool
	{
		return _keysByName[name] != null ? _keysByName[name].isPressed : false;
	}

	public function getKeyWasPressedByName(name:String):Bool
	{
		return _keysByName[name] != null ? _keysByName[name].wasPressed : false;
	}
		
	public function getKeyReleasedByName(name:String):Bool
	{
		return _keysByName[name] != null ? _keysByName[name].wasReleased : false;
	}

	public function recordKeyOnRelease(name:String):Void
	{
		_recordingKey = name;
		Main.mono.mainStage.addEventListener(KeyboardEvent.KEY_UP, onReleaseForRecorded);
	}

	private function onReleaseForRecorded(e:KeyboardEvent):Void
	{
		addRelationKey(e.keyCode, _recordingKey);
		Main.mono.mainStage.removeEventListener(KeyboardEvent.KEY_UP, onReleaseForRecorded);
	}
}