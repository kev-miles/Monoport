package monofl.math;

import openfl.utils.Dictionary;

class MathSenCosLookupTable 
{
	private var _senD:Dictionary<Int,Null<Float>>;
	private var _cosD:Dictionary<Int,Null<Float>>;
	
	public function new()
	{
		_senD = new Dictionary<Int,Null<Float>>(); 
		_cosD = new Dictionary<Int,Null<Float>>(); 
	}
	
	/** Evaluate sen number.
	* 
	* @param n Number to be evaluated
	* 
	* @return Returns the number */
	
	public function getSen(n:Int):Float
	{
		var result:Float; 
		
		if(_senD[n] == null)
		{
			result = Math.sin(n); 
			_senD[n] = result; 
		}
		else
		{
			result = _senD[n]; 
		}
		return result; 
	}
		
	/** Evaluates cos nummber.
	* 
	* @param n Number to be evaluated
	* 
	* @return Returns the number */
	
	public function getCos(n:Int):Float
	{
		var result:Float; 
		
		if(_cosD[n] == null) 
		{
			result = Math.cos(n); 
			_cosD[n] = result; 
		}
		else 
		{
			result = _cosD[n];
		}
		return result;
	}
}