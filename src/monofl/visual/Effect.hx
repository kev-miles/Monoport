package monofl.visual;

import monofl.Mono;
	
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.events.Event;
	
class Effect
{
		
	private var _model:MovieClip;
	private var _movX:Float;
	private var _movY:Float;
		
	/** Creates the effect.
	 * @param container Sprite where to place the effect
	 * @param model MovieClip of the effect
	 * @param posX X position
	 * @param posY Y position
	 * @param movX X speed (Default: 0)
	 * @param movY Y speed (Default: 0)
	 * */
	
	public function new(container:Sprite, model:MovieClip, posX:Float, posY:Float, movX:Float = 0, movY:Float = 0)
	{
		_model = model;
		_model.x = posX; 
		_model.y = posY; 
		container.addChild(this._model); 
		_model.addEventListener("endEffect", destroy); 
		if(movX!=0 || movY!=0) 
		{
			_movX = movX; 
			_movY = movY; 
			model.addEventListener(Event.ENTER_FRAME, moveEffect); 
		}
	}
		
	/** Animates the effect.
	 * 
	 * */
	
	private function moveEffect(e:Event):Void
	{
		_model.x+=_movX;
		_model.y+=_movY;
	}
		
	/** Destroys the effect.
	 * 
	 * */
	
	public function destroy(e:Event):Void
	{
		if(_movX!=0 || _movY!=0) 
		{
			_model.removeEventListener(Event.ENTER_FRAME, moveEffect); 
		}
		_model.parent.removeChild(_model); 
		_model.removeEventListener("endEffect", destroy); 
	}
}