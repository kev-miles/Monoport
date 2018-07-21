package monofl.console;

import monofl.Mono;
	
class CommandData
{
	public var name:String;
	public var command:Dynamic;
	public var description:String;
	public var numberOfParameters:Int;
	
	public function new()
	{
		
	}
	
	/** Turns String into the command.
	* 
	* 
	* @return Returns a String with the parameters. */
	public function toString():String
	{
		return "+Name: " + name + " / Description: " + description + " / Number  of parameters: "+numberOfParameters;
	}
}