package monofl.math;

class MathMatrix 
{

	public function new() 
	{
		
	}
	
	/** Adds two matrixes.
	* 
	* @param matriz1 First matrix
	* @param matriz2 The matrix that will be added to the firts matrix
	* 
	* @return Returns the resulting matrix */
	
	public static function add(matriz1:Array<Array<Int>>, matriz2:Array<Array<Int>>):Array<Array<Int>>
	{
		var result:Array<Array<Int>> = matriz1;
		var i:Int = 0;
		var j:Int = 0;
		
		for(i in 0 ... matriz1.length -1)
		{
				if(Std.is(matriz1[i], Int) || Std.is(matriz2[i],Int))
				{
					Main.mono.reportError("The matrix must be arrays inside the arrays, in the case of having a linear matrix it must be written in the following way: [[x1], [x2], ... [xn]]", "Math", "MathMatrix", "sumar");
				}
				else
				{
					if(matriz1[i].length != matriz2[i].length || matriz1.length != matriz2.length) 
					{
						Main.mono.reportError("The matrixes must have equal quantity of columns as rows there must be no null values", "Math", "MathMatrix", "sumar");
					}
				}
				for(j in 0 ... matriz1[i].length -1) 
				{
					result[i][j]=matriz1[i][j]+matriz2[i][j];
				}
			}
			return result; 
		}
		
		/** Multiplies all the matrix by a value.
		 * 
		 * @param matriz Matrix
		 * @param k Value
		 * 
		 * @return Returns the resulting matrix */
		
	public static function productByScale(matriz:Array<Array<Int>>, k:Int):Array<Array<Int>>
	{
		var i:Int = 0;
		var j:Int = 0;
		
		for (i in 0 ... matriz.length -1) 
		{
			if(Std.is(matriz[i], Int)) 
			{
				Main.mono.reportError("The matrix must be arrays inside the arrays, in the case of having a linear matrix it must be written in the following way: [[x1], [x2], ... [xn]]", "Math", "MathMatrix", "productoPorUnEscalar");
			}
			for (j in 0 ... matriz[i].length -1)
			{
				matriz[i][j] = matriz [i][j]*k;
			}
		}
		return matriz;
	}
}