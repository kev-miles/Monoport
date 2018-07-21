package monofl.managers;

import monofl.Mono;
	
import openfl.display.MovieClip;
import openfl.utils.Dictionary;
import openfl.Vector;

class PauseManager
{		
	public inline static var CATEGORY_DEFAULT:String = "Default";
	
	private var _allMovieClips:Dictionary<String,Vector<MovieClip>>;
	
	public function new()
	{
		_allMovieClips = new Dictionary<String,Vector<MovieClip>>();
		_allMovieClips[CATEGORY_DEFAULT] = new Vector<MovieClip>();
	}

	public function addMovieClip(mc:MovieClip, category:String = "Default"):Void
	{
		if(_allMovieClips[category] == null) _allMovieClips[category] = new Vector<MovieClip>();
		_allMovieClips[category].push(mc);
	}

	public function removeMovieClip(mc:MovieClip, category:String = "Default"):Void
	{
		if(_allMovieClips[category] == null)
		{
			Main.mono.reportWarning("The category hasn't been created yet", "Managers", "PauseManager", "removeMovieClip");
			return;
		}
			
		var allMovieClips:Vector<MovieClip> = _allMovieClips[category];
		
		var i:Int = 0;
		
		for(i in 0 ... allMovieClips.length -1)
		{
			if(allMovieClips[i] == mc)
			{
				allMovieClips.splice(i, 1);
				break;
			}
		}
	}

	public function stopEverything():Void
	{
		var value:Vector<MovieClip>;
		var i:Int = 0;
		
		for (value in _allMovieClips.each())
		{	
			for(i in 0 ... value.length -1)
			{
				value[i].stop();
			}
		}
	}

	public function playEverything():Void
	{
		var value:Vector<MovieClip>;
		var i:Int = 0;
		
		for (value in _allMovieClips.each())
		{
			for(i in 0 ... value.length -1)
			{
				value[i].play();
			}
		}
	}

	public function playCategory(category:String = "Default"):Void
	{
		var i:Int = 0;
		
		for (i in 0 ... _allMovieClips.get(category).length - 1)
		{
			_allMovieClips.get(category)[i].play();
		}
	}
		

	public function stopCategory(category:String = "Default"):Void
	{
		var i:Int = 0;
		
		for(i in 0 ... _allMovieClips.get(category).length - 1)
		{
			_allMovieClips.get(category)[i].stop();
		}
	}

	public function cleanCategory(category:String = "Default"):Void
	{
		_allMovieClips[category].splice(0, _allMovieClips[category].length);
	}
}