package monofl;

import openfl.display.Sprite;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.text.TextField;

import monofl.managers.UpdateManager;
import monofl.managers.ScreenManager;
import monofl.managers.InputManager;
import monofl.managers.PauseManager;
import monofl.managers.SaveManager;
import monofl.visual.Artist;

/*TEST
import monofl.visual.Camera2D;
import monofl.utilities.ObjectPool;*/

/*PASS*/
import monofl.visual.Effect;
import monofl.visual.LoopingBackground;
import monofl.visual.PixelColorReader;
import monofl.math.MathCombinatorics;
import monofl.math.MathGeometry;
import monofl.math.MathMatrix;
import monofl.math.MathSenCosLookupTable;
import monofl.sound.SoundControl;
import monofl.controls.GestureController;
import monofl.controls.MobileAccelerometer;
import monofl.managers.NewgroundsAPIManager;
import monofl.console.Console;
import monofl.utilities.Button;
import monofl.utilities.Dijkstra;
import monofl.utilities.StateMachine;
import monofl.utilities.FrameRateAssistant;
import monofl.utilities.Transition;
import monofl.utilities.RouletteWheelSelection;

class Mono
	{
		
		public var mainStage:Stage;
		public var updateManager:UpdateManager;
		public var inputManager:InputManager;
		public var pauseManager:PauseManager;
		public var screenManager:ScreenManager;
		public var saveManager:SaveManager;
		
		private var _mInformation:Bool = false;
		
		public function new(stage:Stage)
		{
			createMarker();
			trace("Framework 'Mono'// Created by Facundo Balboa (MonoFlauta - http://www.monoflauta.com - https://www.facebook.com/MonoFlauta)");
			mainStage = stage;
			createMarker();
		}

		public function initManagers(initScreenManager:Bool = true, initPauseManager:Bool = true, initInputManager:Bool = true, initUpdateManager:Bool = true):Void
		{
			if(initUpdateManager)
			{
				if(updateManager != null) reportWarning("Update Manager was already created", "Mono", "Mono.hx", "initManagers");
				else updateManager = new UpdateManager();
			}
			if(initScreenManager)
			{
				if(updateManager != null) 
				{
					if(screenManager != null) reportWarning("Screen Manager was already created", "Mono", "Mono.hx", "initManagers");
					else screenManager = new ScreenManager();
				}
				else reportError("You can't init Screen Manager without having the update manager", "Mono", "Mono.hx", "initManagers");
			}
			if(initPauseManager)
			{
				if(pauseManager != null) reportWarning("Pause Manager was already created", "Mono", "Mono.hx", "initManagers");
				else pauseManager = new PauseManager();
			}
			if(initInputManager)
			{
				if(inputManager != null) reportWarning("Input Manager was already created", "Mono", "Mono.hx", "initManagers");
				else inputManager = new InputManager();
			}
		}
		
		public function reportError(message:String, folder:String, clas:String, functio:String):Void
		{
			trace("ERROR:");
			trace(message);
			trace("Placed in // Folder: "+folder+" Class: "+clas+" Function: "+functio);
			createMarker();
		}

		public function reportOpen(clas:String, folder:String):Void
		{
			trace("Opened the class: "+clas+" placed in: "+folder);
			createMarker();
		}
		
		public function reportClose(clas:String, folder:String):Void
		{
			trace("Closed class: "+clas+" placed in: "+folder);
			createMarker();
		}
		
		public function reportWarning(message:String, folder:String, clas:String, functio:String):Void
		{
			trace("Warning:" + message);
			trace("Placed in // Folder: "+folder+" Class: "+clas+" Function: "+functio);
			createMarker();
		}
		
		public function reportInformation(message:String, folder:String, clas:String, functio:String):Void
		{
			if(_mInformation)
			{
				trace("Information:" + message);
				trace("Placed in // Folder: "+folder+" Class: "+clas+" Function: "+functio);
				createMarker();
			}
		}

		public function showInformation():Void
		{
			_mInformation = !_mInformation;
		}
		
		public function createMarker():Void
		{
			trace("**************************************************************");
		}
	}