package monofl.visual;

import monofl.Mono;
	
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.Event;
import openfl.display.Graphics;

class Artist 
{
	public function new()
	{
		
	}
		
	/** Draws a rectangle.
	 * 
	 * @param posX X position
	 * @param posY Y position
	 * @param width Width
	 * @param height Height
	 * @param fillColor Fill color (Default: 0x000000)
	 * @param fillApha Alpha of the fill color (Default: 1)
	 * @param lineThickness Width of the border (Default: 0)
	 * @param lineColor Color of the border (Default: 0x000000)
	 * @param lineAlpha Alpha of the border (Default: 1)
	 * 
	 * @return Returns the rectangle as Sprite
	 *  */
	public static function rectangle(posX:Int, posY:Int, width:Int, height:Int, fillColor:Int=0x000000, fillAlpha:Float=1, lineThickness:Float=0, lineColor:Int=0x000000, lineAlpha:Float=1):Sprite
	{
		var result:Sprite = new Sprite();
		
		result.graphics.beginFill(fillColor, fillAlpha);
		if(lineThickness>0)
		{
			result.graphics.lineStyle(lineThickness, lineColor, lineAlpha);
		}
		result.graphics.drawRect(posX, posY, width, height);
		result.graphics.endFill();
		
		return result;
	}
		
	/** Draws a rounded rectangle.
	 * 
	 * @param posX X position
	 * @param posY Y position
	 * @param width Width
	 * @param height Height
	 * @param radius Radius
	 * @param fillColor Fill color (Default: 0x000000)
	 * @param fillAlpha Alpha of the fill color (Default: 1)
	 * 
	 * @return Returns the rectangle as Sprite
	 *  */
	public static function roundedRectangle(posX:Int, posY:Int, width:Int, height:Int, radius:Int, fillColor:Int=0x000000, fillAlpha:Float=1):Sprite
	{
		var result:Sprite = new Sprite();
		
		result.graphics.beginFill(fillColor, fillAlpha);
		result.graphics.drawRoundRect(posX, posY, width, height, radius);
		result.graphics.endFill();
		
		return result;
	}
		
	/** Draws a circle.
	 * 
	 * @param posX X position
	 * @param posY Y position
	 * @param radius Radio
	 * @param fillColor Fill color (Default: 0x000000)
	 * @param fillAlpha Alpha of the fill color (Default: 1)
	 * @param lineThickness Width of the border (Default: 0)
	 * @param lineColor Color of the border (Default: 0x000000)
	 * @param lineAlpha Alpha of the border (Default: 1)
	 * 
	 * @return Returns the circle as Sprite
	 *  */
	public static function circle(posX:Int, posY:Int, radius:Int, fillColor:Int=0x000000, fillAlpha:Float=1, lineThickness:Float=0, lineColor:Int=0x000000, lineAlpha:Float=1):Sprite
	{
		var result:Sprite = new Sprite();
		
		result.graphics.beginFill(fillColor, fillAlpha);
		if(lineThickness>0)
		{
			result.graphics.lineStyle(lineThickness, lineColor, lineAlpha);
		}
		result.graphics.drawCircle(posX, posY, radius);
		result.graphics.endFill();
		
		return result;
	}
		
	/** Draw a elipse.
	 * 
	 * @param posX X position
	 * @param posY Y position
	 * @param width Width position
	 * @param height Height position
	 * @param fillColor Fill color (Default: 0x000000)
	 * @param fillAlphaAlpha of the fill (Default: 1)
	 * @param lineThickness Width of the border (Default: 0)
	 * @param lineColorColor of the border (Default: 0x000000)
	 * @param lineAlpha Alpha of the border (Default: 1)
	 * 
	 * @return Returns the elipse as Sprite
	 *  */
	
	public static function ellipse(posX:Int, posY:Int, width:Int, height:Int, fillColor:Int=0x000000, fillAlpha:Float=1, lineThickness:Float=0, lineColor:Int=0x000000, lineAlpha:Float=1):Sprite
	{
		var result:Sprite = new Sprite();
		
		result.graphics.beginFill(fillColor, fillAlpha);
		if(lineThickness>0)
		{
			result.graphics.lineStyle(lineThickness, lineColor, lineAlpha);
		}
		result.graphics.drawEllipse(posX, posY, width, height);
		result.graphics.endFill();
		
		return result;
	}
		
	/** Draw a line.
	 * 
	 * @param xI X initial position.
	 * @param yI Y initial position.
	 * @param xF X final position.
	 * @param xF Y final position.
	 * @param lineThickness Width of the line (Default: 1).
	 * @param lineColor Color of the line (Default: 0x000000).
	 * @param lineAlpha Alpha of the line (Default: 1).
	 * 
	 * @return Returns the line as Sprite
	 *  */
	
	public static function line(xI:Int, yI:Int, xF:Int, yF:Int, lineThickness:Float= 1, lineColor:Int = 0x000000, lineAlpha:Float = 1):Sprite
	{
		var result:Sprite = new Sprite();
		
		result.graphics.lineStyle(lineThickness, lineColor, lineAlpha);
		result.graphics.moveTo(xI, yI);
		result.graphics.lineTo(xF, yF);
		return result;
	}
}
