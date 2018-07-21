package monofl.visual;

import monofl.Mono;
	
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.display.Stage;

class Camera2D
{
		
	public var view:Sprite;
		
	public function new()
	{
	}
		
		/** Turns on the camera using a Sprite as container.
		 * 
		 * @param container Sprite of the container where the cam is added
		 *  */
		
	public function turnOnAtSprite(container:Sprite):Void
	{
		view = new Sprite();
		container.addChild(view);
	}
		
		/** Turns on the camera using the stage at Mono.
		 * 
		 *  */
		
	public function turnOnAtStage():Void
	{
		view = new Sprite();
		Main.mono.mainStage.addChild(view);
	}
		
		/** Turns off the camera.
		 * 
		 *  */
		
	public function turnOff():Void
	{
		if(view != null)
		{
			view.parent.removeChild(view);
			view = null;
		}
		else
		{
			Main.mono.reportWarning("Camera wasn't on", "Visual", "Camera2D", "turnOff");
		}
	}
		
		/** Adds a sprite to the camera.
		 * 
		 * @param s Sprite to add
		 *  */
		
	public function addToView(s:Sprite):Void
	{
		if(view != null)
		{
			view.addChild(s);
		}
		else
		{
			Main.mono.reportError("Camera wasn't on", "Visual", "Camera2D", "addToView");
		}
	}
		
		/** Removes a sprite from the camera.
		 * 
		 * @param s Sprite to remove
		 *  */
		
	public function removeToView(s:Sprite):Void
	{
		if(view != null)
		{
			if(view.contains(s))
			{
				view.removeChild(s);
			}
			else
			{
				Main.mono.reportWarning("Sprite wasn't inside the view", "Visual", "Camera2D", "removeToView");
			}
		}
		else
		{
			Main.mono.reportWarning("Camera wasn't on", "Visual", "Camera2D", "removeToView");
		}
	}
		
		/** Smooth look to a sprite.
		 * 
		 * @param s Sprite wich the camera has to look at
		 * @param moveInX How much it should be moved in X (Default: 0)
		 * @param moveInY How much it should be moved in Y (Default: 0)
		 * @param zoom Zoom to use (Default: 1)
		 * @param speedInX Drag speed of look in X (Default: 25)
		 * @param speedInY Drag speed of look in Y (Default: 25)
		*  */
		
	public function smoothLookAt(s:Sprite, moveInX:Float = 0, moveInY:Float = 0, zoom:Int = 1, speedInX:Int = 25, speedInY:Int = 25):Void
	{
		x += (s.x * zoom + moveInX - Main.mono.mainStage.stageWidth / 2 - x) / speedInX;
		y += (s.y * zoom + moveInY - Main.mono.mainStage.stageHeight / 2 - y) / speedInY;
			
		if(zoom > 0)
			view.scaleX = view.scaleY = zoom;
		else
			Main.mono.reportWarning("The zoom can't be 0 or lower, zoom wasn't changed", "Visual", "Camera2D", "smoothLookAt");
	}
		
		/** Look to a sprite.
		 * 
		 * @param s Sprite wich the camera has to look at
		 * @param moveInX How much it should be moved in X (Default: 0)
		 * @param moveInY How much it should be moved in Y (Default: 0)
		 * @param zoom Zoom to use (Default: 1)
		 * */
		
	public function lookAt(s:Sprite, moveInX:Float = 0, moveInY:Float = 0, zoom:Int = 1):Void
	{
		x = s.x + zoom + moveInX - Main.mono.mainStage.stageWidth / 2;
		y = s.y + zoom + moveInY - Main.mono.mainStage.stageHeight / 2;
		if(zoom > 0)
			view.scaleX = view.scaleY = zoom;
		else
			Main.mono.reportWarning("The zoom can't be 0 or lower, zoom wasn't changed", "Visual", "Camera2D", "lookAt");
	}
		
	public function set_x(value:Float):Void
	{
		view.x = -value;
	}
		
	public function get_x():Float
	{
		return -view.x;
	}
		
	public function set_y(value:Float):Void
	{
		view.y = -value;
	}
	
	public function get_y():Float
	{
		return -view.y;
	}
}