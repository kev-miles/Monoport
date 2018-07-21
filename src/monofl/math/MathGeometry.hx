package monofl.math;

import monofl.Mono;
import openfl.display.MovieClip;

class MathGeometry
{
	public function MathGeometry()
	{
	}
	
	/** From an object and where it aims, it returs the resulting force in X.
	* 
	* @param objectX The x of the object that will aim
	* @param objectY The y of the object that will aim
	* @param objectiveX The x of the position to aim
	* @param objectiveY The y of the position to aim
	* @param speed The total speed
	* 
	* @return Returns the force in X */
	
	public static function speedX(objectX:Float, objectY:Float, objectiveX:Float, objectiveY:Float, speed:Float):Float
	{
		var radians:Float = getAngleRadians(objectX, objectY, objectiveX, objectiveY);
		var distX:Float = getDist(objectX, objectiveX);
		return Math.cos(radians) * speed;
	}
	
	/** From an object and where it aims, it returs the resulting force in Y.
	* 
	* @param objectX The x of the object that will aim
	* @param objectY The y of the object that will aim
	* @param objectiveX The x of the position to aim
	* @param objectiveY The y of the position to aim
	* @param speed The total speed
	* 
	* @return Returns the force in Y */
	
	public static function speedY(objectX:Float, objectY:Float, objectiveX:Float, objectiveY:Float, speed:Float):Float
	{
		var radians:Float = getAngleRadians(objectX, objectY, objectiveX, objectiveY);
		var distX:Float = getDist(objectX, objectiveX);
		return (Math.sin(radians) * speed);
	}
	
	/** Obtains the angle in radiants between two objects.
	*  
	* @param objectX The x of the object that will aim
	* @param objectY The y of the object that will aim
	* @param objectiveX The x of the position to aim
	* @param objectiveY The y of the position to aim
	* 
	* @return Returns the angle between two objects */
	
	public static function getAngleRadians(objectX:Float, objectY:Float, objectiveX:Float, objectiveY:Float):Float
	{
		return Math.atan2(getDist(objectiveY, objectY), getDist(objectiveX, objectX));
	}
	
	/** Obtains the angle in degrees between two objects.
	*  
	* @param objectX The x of the object that will aim
	* @param objectY The y of the object that will aim
	* @param objectiveX The x of the position to aim
	* @param objectiveY The y of the position to aim
	* 
	* @return Returns the angle between two objects */
	
	public static function getAngle(objectX:Float, objectY:Float, objectiveX:Float, objectiveY:Float):Float
	{
		return (Math.atan2(getDist(objectiveY, objectY), getDist(objectiveX, objectX)))*180/Math.PI; 
	}
		
	/** Obtains the dist between two values.
	* 
	* @param x First value
	* @param y Second value
	* 
	* @return Returns the distance between two values. */
	
	public static function getDist(x:Float, y:Float):Float
	{
		return Math.abs(x - y);
	}
	
	/** Obtains the cos value.
	* 
	* @param displacementBase The base displacement
	* @param angularFrequency The angular frequency (Default: 1)
	* @param amplitude The amplitude of the wave (Default: 1)
	* @param verticalDisplacement The vertical displacement (Default: 0)
	* 
	* @return Returns the cos value.
	* */
	
	public static function getCos(displacementBase:Float, angularFrequency:Float = 1, amplitude:Float = 1, verticalDisplacement:Float = 0):Float
	{
		return amplitude * Math.cos(2 * Math.PI / angularFrequency + displacementBase) + verticalDisplacement;
	}
	
	/** Obtains the sin value.
	* 
	* @param displacementBase The base displacement
	* @param angularFrequency The angular frequency (Default: 1)
	* @param amplitude The amplitude of the wave (Default: 1)
	* @param verticalDisplacement The vertical displacement (Default: 0)
	* 
	* @return Returns the sin value.
	* */
	
	public static function getSin(displacementBase:Float, angularFrequency:Float = 1, amplitude:Float = 1, verticalDisplacement:Float = 0):Float
	{
		return amplitude * Math.sin(2 * Math.PI / angularFrequency + displacementBase) + verticalDisplacement;
	}
}