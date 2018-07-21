package monofl.controls;

import monofl.Mono;
	
import openfl.events.MouseEvent;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;
import openfl.Vector;

class GestureController 
{
	public var drawing:Bool;
	public var px:Int;
	public var py:Int;
	public var px2:Int;
	public var py2:Int;
	public var lastDirection:Float;
	public var currentDirection:Float =-1;
	public var movementList:Vector<String> = new Vector<String>();
	public var oldMovementList:Vector<String>;
	public var changeMovementList:Vector<String> = new Vector<String>();
	public var oldChangeMovementList:Vector<String>;

	public function new() 
	{
		
	}
	
	/** Turns on the gesture detector.
	* 
	* 
	*  */
	
	public function turnOn():Void
	{
		Main.mono.updateManager.addCallBack(evUpdate); 
		Main.mono.mainStage.addEventListener(MouseEvent.MOUSE_DOWN, detectMovement);
		Main.mono.mainStage.addEventListener(MouseEvent.MOUSE_UP, stopDetectingMovement);
	}
		
	/** Turns off the gesture detector.
	* 
	*  */
	
	public function turnOff():Void
	{
		Main.mono.updateManager.removeCallBack(evUpdate); 
		Main.mono.mainStage.removeEventListener(MouseEvent.MOUSE_DOWN, detectMovement);
		Main.mono.mainStage.removeEventListener(MouseEvent.MOUSE_UP, stopDetectingMovement);
	}
		
	/** enterFrame of the gesture detector.
	* 
	* 
	*  */
	
	private function evUpdate():Void
	{
		if(drawing)
		{
			var dX:Int = Std.int(px - Main.mono.mainStage.mouseX); 
			var dY:Int = Std.int(py - Main.mono.mainStage.mouseY); 
			var distance:Float = dX*dX+dY*dY; 
			if(distance>400) 
			{
				var angle:Float=Math.atan2(dY,dX)*57.2957795; 
				var refinedAngle:Float = 0;
				var directionString:String;
				
				if (angle >= 22 *-1 && angle < 23) 
				{ 
					refinedAngle=0; 
					movementList.push("left");
					addToChangeMovement(movementList[movementList.length-1]);
				}
				if (angle >= 23 && angle < 68) 
				{
					refinedAngle=Math.PI/4; 
					movementList.push("up left");
					addToChangeMovement(movementList[movementList.length-1]);
				}
				if (angle >= 68 && angle < 113) 
				{
					refinedAngle=Math.PI/2;
					movementList.push("up");
					addToChangeMovement(movementList[movementList.length-1]);
				}
				if (angle >= 113 && angle < 158)
				{
					refinedAngle=Math.PI/4*3; 
					movementList.push("up right");
					addToChangeMovement(movementList[movementList.length-1]);
				}
				if (angle >= 158 || angle < 157 *-1)
				{
					refinedAngle=Math.PI; 
					movementList.push("right"); 
					addToChangeMovement(movementList[movementList.length-1]);
				}
				if (angle>=157*-1&&angle<112*-1) {
					refinedAngle=- Math.PI/4*3; 
					movementList.push("down right"); 
					addToChangeMovement(movementList[movementList.length-1]); 
				}
				if (angle>=112*-1&&angle<67*-1) {
					refinedAngle=- Math.PI/2; 
					movementList.push("down"); 
					addToChangeMovement(movementList[movementList.length-1]); 
				}
				if (angle >= 67 *-1 && angle < 22 *-1) 
				{
					refinedAngle=- Math.PI/4; 
					movementList.push("down left"); 
					addToChangeMovement(movementList[movementList.length-1]); 
				}
				px2-=Std.int(Math.sqrt(distance)*Math.cos(refinedAngle)); 
				py2-=Std.int(Math.sqrt(distance)*Math.sin(refinedAngle));
				if (refinedAngle != lastDirection) 
				{ 
					lastDirection=refinedAngle; 
				}
				else 
				{
					if (currentDirection != lastDirection) 
					{ 
						currentDirection=lastDirection;
					}
				}
				px=Std.int(Main.mono.mainStage.mouseX); 
				py=Std.int(Main.mono.mainStage.mouseY); 
			}
		}
	}
		
	/** Checks whether movement should or not be added. In case it should be added, it is added. 
	* 
	* @param direction The direction to be added.
	* 
	*  */
		
	private function addToChangeMovement(direction:String):Void
	{
		if(changeMovementList.length>0) 
		{
			if(changeMovementList[changeMovementList.length-1]!=direction) 
			{
				changeMovementList.push(direction);
			}
		}
		else 
		{
			changeMovementList.push(direction); 
		}
	}
		
	/** Detects when the user is drawing.
	* 
	* 
	*  */
	
	private function detectMovement(e:MouseEvent):Void
	{
		if(!drawing)
		{
			drawing=true; 
			movementList = new Vector<String>(); 
			changeMovementList = new Vector<String>(); 
			px=px2=Std.int(Main.mono.mainStage.mouseX); 
			py=py2=Std.int(Main.mono.mainStage.mouseY); 
		}
	}
		
	/** Detects when the user stops drawing.
	* 
	* 
	*  */
		
	private function stopDetectingMovement(e:MouseEvent):Void
	{
		drawing=false;
		oldMovementList = movementList;
		oldChangeMovementList = changeMovementList;
	}
}
