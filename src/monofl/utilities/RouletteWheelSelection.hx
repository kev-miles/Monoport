package monofl.utilities;

import openfl.utils.Dictionary;

class RouletteWheelSelection
{
	public function new()
	{
		
	}
		
	/** Executes RouletteWheelSelection based on a Dictionary.
	* 
	* @param entries All the entries, the keys will be used as the object and the values as the number of chances.
	* 
	* @return Returns the object
	* */
	
	public static function runWithDictionary(entries:Dictionary<Dynamic,Dynamic>):Dynamic
	{
		var total:Float = 0;
		var o:Dynamic;
		
		for(o in entries) total += entries[o];
		
		var r:Float = Math.random() * total;
		
		for(o in entries)
		{
			r -= entries[o];
			if(r <= 0) return o;
		}
		
		return null;
	}
		
	/** Executes RouletteWheelSelection based on a Dictionary.
	* 
	* @param keys The keys that will be used for the RoulleteWheelSelection
	* @param values The values of each key in order
	* 
	* @return Returns the object
	* */
		
	public static function runWithArrays(keys:Array<Dynamic>, values:Array<Dynamic>):Dynamic
	{
		var total:Float = 0;
		var i:Int = 0;
		
		for (i in 0 ... values.length - 1)
		{total += values[i];}
		
		var r:Float = Math.random() * total;
		
		for(i in values.length - 1 ... 0)
		{
			r -= keys[i];
			if(r <= 0) return keys[i];
		}
		
		return null;
	}
}