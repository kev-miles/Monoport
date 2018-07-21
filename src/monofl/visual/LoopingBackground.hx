package monofl.visual;

import openfl.display.Sprite;
import openfl.geom.Point;

class LoopingBackground
{
	private var _firstBackground:Sprite;
	private var _secondBackground:Sprite;
	private var _movement:Point;
	private var _stageWidth:Int;
	private var _stageHeight:Int;
	private var _placingSecond:Bool;
	private var _reproducing:Bool;
		
	/** Creates a looping background in any direction.
	 * 
	 * @param firstBackground Instance of the first background that will be used to loop
	 * @param secondBackground Instance of the second background that will be used to loop
	 * @param container Where the backgrounds will be added as childs
	 * @param direction The direction where the backgrounds will move
	 * 
	 *  */
		
	public function new(firstBackground:Sprite, secondBackground:Sprite, container:Sprite, direction:Point)
	{
		_firstBackground = firstBackground;
		_secondBackground = secondBackground;
		container.addChild(firstBackground);
		container.addChild(secondBackground);
		
		_movement = direction;
		
		_placingSecond = true;
			
		_firstBackground.x = _firstBackground.y = 0;
		if(_movement.x != 0) _secondBackground.x = _secondBackground.width * _movement.x / _movement.x *-1;
		else _secondBackground.x = 0;
		if(_movement.y != 0) _secondBackground.y = _secondBackground.height * _movement.y / _movement.y *-1;
		else _secondBackground.y = 0;
			
		_firstBackground.x -= 50;
		_secondBackground.x -= 50;
		
		_stageWidth = Main.mono.mainStage.stageWidth;
		_stageHeight = Main.mono.mainStage.stageHeight;
	}
		
	public function play():Void
	{
		if(!_reproducing)
			Main.mono.updateManager.addCallBack(update);
		_reproducing = true;
	}

	private function update():Void
	{
		_firstBackground.x += _movement.x;
		_firstBackground.y += _movement.y;
		
		_secondBackground.x += _movement.x;
		_secondBackground.y += _movement.y;
			
		if(_placingSecond)
		{
			if(_firstBackground.x > _stageWidth ||
				_firstBackground.x + _firstBackground.width < 0 ||
				_firstBackground.y > _stageHeight ||
				_firstBackground.y + _firstBackground.height < 0)
			{
				if(_movement.x != 0)
					_firstBackground.x = _secondBackground.x + _secondBackground.width * _movement.x / _movement.x;
				if(_movement.y != 0)
				{
					_firstBackground.y = _secondBackground.y - _secondBackground.height * _movement.y / _movement.y;
				}
				_placingSecond = false;
			}
		}
		else
		{
			if(_secondBackground.x > _stageWidth ||
				_secondBackground.x + _secondBackground.width < 0 ||
				_secondBackground.y > _stageHeight ||
				_secondBackground.y + _secondBackground.height < 0)
			{
				if(_movement.x != 0)
					_secondBackground.x = _firstBackground.x - _firstBackground.width * _movement.x / _movement.x;
				if(_movement.y != 0)
					_secondBackground.y = _firstBackground.y - _firstBackground.height * _movement.y / _movement.y;
				_placingSecond = true;
			}
			
		}
	}
		
		
	public function changeDirection(direction:Point):Void
	{
		_movement = direction;
	}
		
	public function stop():Void
	{
		if(_reproducing)
			Main.mono.updateManager.removeCallBack(update);
		_reproducing = false;
	}
		
	public function remove():Void
	{
		stop();
		_firstBackground.parent.removeChild(_firstBackground);
		_secondBackground.parent.removeChild(_secondBackground);
	}
}