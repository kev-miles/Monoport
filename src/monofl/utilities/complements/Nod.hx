package monofl.utilities.complements;

	
import monofl.visual.Artist;
	
import openfl.display.Sprite;
import openfl.geom.Point;

class Nod
{
	public var fatherNode:Nod; 
	public var nextNode:Nod;
	public var distanceToFather:Float; 
	public var position:Point; 
	public var gra:Sprite; 
		
	public function new(p:Point, g:Bool)
	{
		position = p;
		if(g) 
		{
			gra = Artist.circle(0, 0, 2, 0x000000, 1); 
			gra.x = p.x; 
			gra.y = p.y; 
			Main.mono.mainStage.addChild(gra); 
		}	
	}
}