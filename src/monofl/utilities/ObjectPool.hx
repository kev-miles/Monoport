package monofl.utilities;

import monofl.Mono;
	
import openfl.utils.Dictionary;
import openfl.utils.getDefinitionByName;
import openfl.utils.getQualifiedClassName;
	
class ObjectPool
{
	private var _pools:Dictionary<String,Array<Class>>;
		
	public function new()
	{
		_pools = new Dictionary<String,Array<Class>>(); 
	}
		
	/**Returns an object of the pool. 
	* 
	* @param type Type of the object
	* @return Returns the desired object
	* 
	* */
	
	public function getObj(type:Class):Dynamic
	{
		var pool:Array<Class> = getPool(type);
		if(pool.length>0) 
		{
			return pool.pop(); 
		}
		else
		{
			return new type(); 
		}
	}
		
	/**Creates an initial stock.
	* 
	* @param type Type of the object
	* @param amount Ammount to be created
	* 
	* */
	
	public function createAmount(type:Class, amount:Int):Void
	{
		var pool:Array<Class> = getPool(type);
		var i:Int = 1;
		for(i in 1 ... amount -1)
		{
			pool.push(new type()); 
		}
	}
		
		/**Saves the object in the object pool.
		 * 
		 * @param object Object to be saved
		 * @param type Type of the object. (Default: null)
		 * 
		 * */
		public function disposeObject(object:*, type:Class = null):void
		{
				if(!type)
				{
					type = getDefinitionByName(getQualifiedClassName(object)) as Class;
				}
				var pool:Array<Class> = getPool(type); 
				pool.push(object);
		}
		
	/**Search the array and returns it with all the objects inside. 
	* 
	* @param type Type of the object
	* @return Returns the array with the list of objects
	* 
	* */
	
	private function getPool(type:Class):Array<Class>
	{
		return type in _pools ? _pools[type] : _pools[type] = new Array<Class>(); 
	}
}