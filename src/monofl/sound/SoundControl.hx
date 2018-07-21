package monofl.sound;

import monofl.Mono;
	
import openfl.events.Event;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;
	
class SoundControl 
{
	public var lastPoint:Float;
	
	private var _soundChannel:SoundChannel;
	private var _soundSetting:SoundTransform;
	private var _sound:Sound;
	private var _doesLoop:Bool;
	private var _loop:Int;
	private var _volume:Float;
	private var _panning:Float;

	public function new() 
	{
		
	}
	
	/** Reproduces a sound.
	* 
	* @param sound Sound to reproduce
	* @param loop Times to make loop. If it's negative, it will do infite times (Default: 0)
	* @param volume Volume of the sound (Default: 1)
	* @param panning Panning of the sound (Default: 0)
	* @param startTime Start time of the sound (Default: 0)
	* 
	*  */
	
	public function reproduceSound(sound:Sound, loop:Int = 0, volume:Float = 1, panning:Float = 0, startTime:Int = 0):Void
	{
		this._loop=loop;
		this._volume=volume;
		this._panning = panning;
		
		if(volume<0)
		{
			volume = 0;
			Main.mono.reportWarning("The sound volume must be at least 0. The volume became 0 by default.", "Sound", "SoundControl", "reproduceSound");
		}
		if(panning<(-1) || panning>1)
		{
			panning = 0;
			Main.mono.reportWarning("The panning must be between -1 and 1. The panning became 0 by default.", "Sound", "SoundControl", "reproduceSound");
		}
		if(startTime<0)
		{
			startTime = 0;
			Main.mono.reportWarning("It is not possible to start a sound in negative time. It started in 0 by default.", "Sound", "SoundControl", "reproduceSound");
		}
		
		this._sound = sound;
		
		#if windows
		_soundChannel = this._sound.play(0);
		#end
		#if html5
		_soundChannel = this._sound.play(0);
		#end
		#if flash
		_soundChannel = new SoundChannel();
		#end
		
		_soundSetting = new SoundTransform(volume, panning);
		
		if(_soundChannel != null)
		{
			if(loop<0)
			{
				_doesLoop=true;
				loop=0;
				_soundChannel = sound.play(startTime, loop, _soundSetting);
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, evSoundComplete);
			}
			else
			{
				_doesLoop=false;
				_soundChannel = sound.play(startTime, loop, _soundSetting);
			}
		}
		else
		{
				Main.mono.reportWarning("Sound channel doesn't exist", "Sound", "SoundControl", "reproduceSound");
		}
	}
		
	/** Pauses the last sound and saves it in lastPoint var.
	* 
	*  */
	
	public function pause():Void
	{
		lastPoint = _soundChannel.position;
		stopSound();
	}
		
	/** Reproduces the last paused sound where it was left.
	* 
	*  */
		
	public function continueSound():Void
	{
		reproduceSound(_sound, _loop, _volume, _panning, Std.int(lastPoint));
	}
		
	/** Stops a sound.
	* 
	*  */
		
	public function stopSound():Void
	{
		_soundChannel.stop();
		if(_doesLoop)
		{
			_soundChannel.removeEventListener(Event.SOUND_COMPLETE, evSoundComplete);
		}
	}
		
	/** Reproduces the sound once it's finished.
	* 
	* @param e Event.
	*  */
	
	private function evSoundComplete(e:Event):Void
	{
		_soundChannel.removeEventListener(Event.SOUND_COMPLETE, evSoundComplete);
		_soundChannel = _sound.play(0, 0, _soundSetting);
		_soundChannel.addEventListener(Event.SOUND_COMPLETE, evSoundComplete);
	}
	
}