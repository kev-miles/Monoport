package monofl.managers;

import monofl.Mono;

#if flash
import com.newgrounds.API;
import com.newgrounds.components.FlashAd;
import com.newgrounds.components.ScoreBrowser;
import com.newgrounds.Medal;
#end

import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Stage;
	
class NewgroundsAPIManager
{
	#if flash
	
	private var _id:String;
	private var _encrypt:String;
	private var _root:DisplayObject;
	private var _flashAd:FlashAd;
	private var _scoreBrowser:ScoreBrowser;
		
	/** Starts the Newgrounds API.
	* 
	* @param apiID The ID of the game
	* @param apiEncrypt The encriptation key of the game
	* @param apiRoot  Root of the scene
	* 
	* */
		
	public function new(apiID:String, apiEncrypt:String, apiRoot:DisplayObject)
	{
		_id=apiID;
		_encrypt=apiEncrypt;
		_root = apiRoot;
		API.connect(_root, _id, _encrypt);
		Main.mono.reportOpen("NewgroundsAPIManager.as", "Managers");
	}
		
	/** Adds the Ad.
	* 
	* @param posX Position in X of the Ad (Default: 0)
	* @param posY Position in Y of Ad (Default: 0)
	* 
	*  */
	public function addAd(posX:Int = 0, posY:Int = 0):Void
	{
		if(_flashAd == null)
		{
			_flashAd = new FlashAd();
			_flashAd.x = posX;
			_flashAd.y = posY;
			Main.mono.mainStage.addChild(_flashAd);
		}
		else
		{
			Main.mono.reportWarning("An Ad already exists", "Managers", "NewgroundsAPIManager", "AddAd");
		}
	}
		
	/** Removes the Ad.
	* 
	* 
	*  */
	public function removeAd():Void
	{
		if(_flashAd!=null)
		{
			Main.mono.mainStage.removeChild(_flashAd);
			_flashAd = null;
		}
		else
		{
			Main.mono.reportWarning("Ad does not yet exist", "Managers", "NewgroundsAPIManager", "RemoveAd");
		}
	}
		
	/** Adds one to the custom event.
	* 
	* @param event Nane of the event
	* 
	*  */
		
	public function logCustomEvent(event:String):Void
	{
		API.logCustomEvent(event);
	}
		
	/** Loads a wabsite in a new tab and adds the link to the stats.
	* 
	* @param link Link to open
	* 
	*  */
		
	public function loadCustomLink(link:String):Void
	{
		API.loadCustomLink(link);
	}
		
	/** If a site was configurated, this function will load it.
	* 
	* 
	*  */
	
	public function loadMySite():Void
	{
		API.loadMySite();
	}
		
	/** If an official site was configurated, the function wil add it.
	* 
	* 
	*  */
		
	public function loadOfficialURL():Void
	{
		API.loadOfficialVersion();
	}
		
	/** Load the Newgrounds site.
	* 
	* 
	*  */
		
	public function loadNewgrounds():Void
	{
		API.loadNewgrounds();
	}
		
		
	/** Loads a highscore table.
	* 
	* @param scoreBoardName Name of the highscore table
	* @param period Period to show scores. It may be "All-Time", "This Month", "This Week", "This Year" y "Today" (Default: "All-Time")
	* @param posX Position in X (Default: 0)
	* @param posY Position in Y (Default: 0)
	* 
	*  */
	
	public function showScores(scoreBoardName:String, period:String = "All-Time", posX:Int = 0, posY:Int = 0):Void
	{
		if(_scoreBrowser==null)
		{
			_scoreBrowser = new ScoreBrowser();
			_scoreBrowser.scoreBoardName = scoreBoardName;
			_scoreBrowser.period = period;
			_scoreBrowser.loadScores();
			_scoreBrowser.x = posX;
			_scoreBrowser.y = posY;
			Main.mono.mainStage.addChild(_scoreBrowser);
		}
		else
		{
			Main.mono.reportWarning("A score table already exists", "Managers", "NewgroundsAPIManager", "showScores");
		}
	}
		
	/** Removes the score table.
	* 
	* 
	*  */
	
	public function hideScores():Void
	{
		if(_scoreBrowser!=null)
		{
			Main.mono.mainStage.removeChild(_scoreBrowser);
			_scoreBrowser = null;
		}
		else
		{
			Main.mono.reportWarning("A score table does not yet exist", "Managers", "NewgroundsAPIManager", "hideScores");
		}
	}
		
	/** Posts a score to the highscore table.
	* 
	* @param scoreBoardName Name of the highscore table.
	* @param score Puntaje a subir.
	* 
	*  */
	
	public function postScore(scoreBoardName:String, score:Float):Void
	{
		API.postScore(scoreBoardName, score);
	}
		
	/** Unlocks a medal.
	* 
	* @param medalName Name of the medal
	* 
	*  */
	
	public function unlockMedal(medalName:String):Void
	{
		API.unlockMedal(medalName);
	}
		
	/** Informs whether the medal was unlocked.
	* 
	* @param medalName Name of the medal
	* 
	*  */
	
	public function isMedalUnlocked(medalName:String):Bool
	{
		var medal:Medal = API.getMedal(medalName);
		return medal.unlocked;
	}
	
	#end
}
