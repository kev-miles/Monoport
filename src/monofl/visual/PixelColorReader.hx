package monofl.visual;

import openfl.display.BitmapData;
import openfl.display.Stage;
import openfl.utils.Dictionary;

class PixelColorReader
{
	public inline static var TOTAL:String = "Total";
	
	/** Returns the ammount of pixels with each color that the stage has.
	 * @param s The stage
	 * 
	 * @return Returns a dictionary with the result */
	
	public function new()
	{		
		
	}
	 
	public static function readStageColors(s:Stage):Dictionary<String,Int>
	{
		var result:Dictionary<String,Int> = new Dictionary<String,Int>();
		result[TOTAL] = 0;
		
		var bd:BitmapData = new BitmapData(s.stageWidth, s.stageHeight);
		bd.draw(s);
		
		var i:Int = 0;
		var j:Int = 0;
		
		for(i in 0 ... s.stageWidth)
		{
			for(j in 0 ... s.stageHeight)
			{
				var color:String = Std.string((bd.getPixel32(i, j)));
				if(color != "0")
					if(result.get(color) == 0) result[color] = 1;
					else result[color] += 1;
				result[TOTAL]++;
			}
		}
		return result;
	}
}