package monofl.math;

class MathCombinatorics 
{
	public function new()
	{
	}
		
	/** Gets the factorial of a uint
	 * 
	 * @param value The value to get factorial
	 * 
	 * @return Returns the factorial of the value */
	public static function getFactorial(value:UInt):UInt
	{
		if(value <= 1) return 1;
		else return value * getFactorial(value - 1);
	}
	
	/** Gets the binomial coefficient of a uint pair
	 * 
	 * @param firstValue The first value
	 * @param secondValue The second value
	 * 
	 * @returns Returns the binomial coefficient */
	
	public static function getBinomialCoefficient(firstValue:UInt, secondValue:UInt):UInt
	{
		if (firstValue == secondValue || secondValue == 0) return 1;
		return Std.int(getFactorial(firstValue) / (getFactorial(secondValue) * getFactorial(firstValue - secondValue)));
	}
}