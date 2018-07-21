package monofl.controls;

import monofl.Mono;
	
import openfl.events.AccelerometerEvent;
import openfl.events.Event;
import openfl.sensors.Accelerometer;
	
class MobileAccelerometer
{
	public var keyLeft:Bool = false;
	public var keyRight:Bool = false;
	public var keyUp:Bool = false;
		
	private var _isSupported:Bool = false;
	private var _acc1:Accelerometer;
	private var _turnedOn:Bool;
	private var _xTolerance:Float;
	private var _yTolerance:Float;
		
	public function new()
	{
		
	}
		
	/** Turns the controller on.
	* @param toleranceX Sensitivity of the device in X (Default: 0.10)
	* @param toleranceY Sensitivity of the device in Y (Default: 0.10)
	* 
	*  */
	
	public function turnOn(toleranceX:Float=0.10, toleranceY:Float=0.10):Void
	{
		_xTolerance = toleranceX;
		_yTolerance = toleranceY;
		if(_turnedOn)
		{
			Main.mono.reportWarning("The accelerometer was already on", "Controls", "MobileAccelerometer", "turnOn");
		}
		else
		{
			_isSupported=checkSupport();
			if(_isSupported)
			{
				_turnedOn=true;
				_acc1.addEventListener(AccelerometerEvent.UPDATE, updateHandler);
				Main.mono.reportOpen("MobileAccelerometer", "Controls");
			}
			else
			{
				Main.mono.reportError("The device does not support accelerometer", "Controls", "MobileAccelerometer", "turnOn");
			}
		}
	}
		
	/** Turn the controller off.
	* 
	* 
	*  */
	
	public function turnOff():Void
	{
		if(!_turnedOn)
		{
			Main.mono.reportWarning("The accelerometer was already turned off", "Controls", "MobileAccelerometer", "turnOff");
		}
		else
		{
			_turnedOn=false;
			_acc1.removeEventListener(AccelerometerEvent.UPDATE, updateHandler);
			Main.mono.reportClose("MobileAccelerometer", "Controls");
		}
	}
		
	/** Asks whether the device supports the accelerometer.
	* 
	* @return Returns a Bool with the result
	*  */
	
	private function checkSupport():Bool
	{
		return Accelerometer.isSupported;
	}
		
	/** Checks the values of the accelerometer and updates the pressed keys.
	* 
	*  */
		
	private function updateHandler(e:AccelerometerEvent):Void
		
	{
		if(e.accelerationX<(_xTolerance))
		{
			keyLeft = false;
			keyRight = true;
		}
		else if(e.accelerationX>0.10)
		{
			keyLeft = true;
			keyRight = false;
		}
		else
		{
			keyLeft = false;
			keyRight = false;
		}
			
		if(e.accelerationY<(_yTolerance))
		{
			keyUp = true;
		}
		else
		{
			keyUp = false;
		}
	}
}
