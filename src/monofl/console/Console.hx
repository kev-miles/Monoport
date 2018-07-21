package monofl.console;

import monofl.Mono;
	
import openfl.display.Stage;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.ui.Keyboard;
import openfl.utils.Dictionary;
import openfl.Vector;

class Console
{
	private var _font:String;
	private var _size:Null<Int>;
	private var _color:Null<Int>;
	private var _consoleText:TextField;
	private var _commands:Dictionary<String,CommandData>;
	private var _isOpen:Bool;
	private var _latestCommands:Vector<TextField> = new Vector<TextField>();
		
	public function new()
	{
		
	}
		
	/** Turns on the console.
	* 
	* @param font Tipografic font of the console (Default: 'Console')
	* @param size Console's font size (Default: 20)
	* @param colour Console's font color (Default: 0x000000)
	* 
	*  */

	public function turnOnConsole(font:String = "Console", size:Null<Int> = 20, color:Null<Int> = 0x000000):Void
	{
		_font = font;
		_size = size;
		_color = color;
		_commands = new Dictionary<String,CommandData>();
		_isOpen = true; 
		_consoleText = new TextField(); 
		_consoleText.type = TextFieldType.INPUT;
		_consoleText.defaultTextFormat = new TextFormat(font, size, color); 
		_consoleText.autoSize = TextFieldAutoSize.LEFT; 
		Main.mono.mainStage.addChild(_consoleText);
		Main.mono.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyDown); 
		addToHistory("Welcome to the console"); 
		addToHistory("     Write 'close' to close the console"); 
		addToHistory("     Write '?' to see the commands list"); 
		registerCommand("?", help, "Returns the list of commands"); 
		registerCommand("cls", cleanConsole, "Clears the console's history"); 
		registerCommand("close", close, "Closes the console");
	}
	
	/** Checks what keys are pressed and affect the console.
	*  */
	
	private function evKeyDown(event:KeyboardEvent):Void
	{
		if(event.keyCode == Keyboard.ENTER)
			executeCommand();
	}
		
	/** Register a command for the console.
	* @param name Command's name
	* @param com The callback of the command
	* @param description The description of the command
	* @param nOfParameters The Float of  parameters to recieve (Default: 0)
	*  */
	
	public function registerCommand(name:String, com:Dynamic, description:String, nOfParameters:Int = 0):Void
	{
		var tempData:CommandData = new CommandData(); 
		tempData.name = name; 
		tempData.command = com; 
		tempData.description = description;
		tempData.numberOfParameters = nOfParameters;
		_commands[name] = tempData;
	}
		
	/** Eliminates a command from the console.
	* @param name Command's name
	*  */
	
	public function unregisterCommand(name:String):Void
	{
		_commands.remove(name);
	}
		
	/** Runs the command that is in the console.
	*  */
	
	public function executeCommand():Void
	{
		var cutResult:Array<String> = _consoleText.text.split(" "); 
		var commandName:String = cutResult[0];
		var tempCommand:CommandData = _commands[commandName];
		cutResult.shift();
			
		if(tempCommand != null)
			if(cutResult.length == tempCommand.numberOfParameters)
				tempCommand.command.apply(null, cutResult);
			else
				addToHistory("+ERROR: Misused the command");
		else
			addToHistory("+ERROR: The command does not exist");
	}
		
	/** Closes the console.
	*  */
		
	private function close():Void
	{
		Main.mono.mainStage.removeChild(_consoleText);
		Main.mono.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evKeyDown); 
		cleanConsole(); 
		_isOpen = false; 
	}
		
	/** Function help of the console. Shows the list of commands.
	*  */
		
	private function help():Void
	{
		addToHistory(" ? ");
		addToHistory("+Function Help was implemented");
		addToHistory("HELP: Next there is a list of the commands that can be used in the console");
		var current:CommandData; 
		for (current in _commands)
		{
			addToHistory("     "+current);
		}
	}
		
	/** Function clean of the console. Clears the history of the console.
	*  */
	
	private function cleanConsole():Void
	{
		var i:Int = 0;
		for (i in 0 ... _latestCommands.length -1)
		{
			if(_latestCommands[i] != null)
			{
				Main.mono.mainStage.removeChild(_latestCommands[i]);
			}
		}
		_latestCommands = new Vector<TextField>();
	}
		
	/** Function Adds text to history.
	*  */
		
	private function addToHistory(texto:String):Void
	{
		_latestCommands.splice(0, 0); 
		Main.mono.mainStage.addChild(_latestCommands[0]); 
		_latestCommands[0].defaultTextFormat = new TextFormat(_font, _size, _color);
		_latestCommands[0].wordWrap = true;
		_latestCommands[0].width = 770;
		_latestCommands[0].autoSize = TextFieldAutoSize.LEFT; 
		_latestCommands[0].text = texto; 
		_latestCommands[0].y=320; 
		_latestCommands[0].x = 13; 
		
		var i:Int = 0;
		for (i in 0 ... _latestCommands.length -1)
		{
			_latestCommands[i].y -=_consoleText.height;
		}
	}
}