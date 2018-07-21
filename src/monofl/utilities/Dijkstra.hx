package monofl.utilities;

import monofl.Mono;
import monofl.utilities.complements.Nod;
import monofl.visual.Artist;
	
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.Vector;

class Dijkstra
{
	public var existeCamino:Bool = false; 
	public var graficar:Bool = false; 
	public var nodosCamino:Vector<Nod>;
		
	private var _nodos:Vector<Nod>;
	private var _nodosAbiertos:Vector<Nod>;
	private var _nodosCerrados:Vector<Nod>;
	private var _nodosSinCerrar:Vector<Nod>;
	private var _nodoInicial:Nod;
	private var _nodoFinal:Nod;
	private var _vision:Float;
	private var _posFinal:Point;
	
	public function new()
	{
		_nodos = new Vector<Nod>(); 
		_nodosAbiertos = new Vector<Nod>(); 
		_nodosCerrados = new Vector<Nod>(); 
		nodosCamino = new Vector<Nod>();
	}
		
	/** Executes Dijkstra.
	* 
	* @param initialPosition The initial position;
	* @param finalPosition The final position;
	* 
	*  */
	
	public function executeDijkstra(initialPosition:Point, finalPosition:Point, visionDistance:Float):Void
	{
			var i:Int; 
			var j:Int;
			var origen:Point; 
			var destino:Point; 
			var distancia:Float; 
			
			_vision = visionDistance; 
			_posFinal = finalPosition;
			
		for(i in 0 ... _nodos.length -1)
		{
			_nodos[i].fatherNode = null; 
			_nodos[i].nextNode = null; 
			_nodos[i].distanceToFather = Math.POSITIVE_INFINITY; 
		}
		_nodosAbiertos.splice(0, _nodosAbiertos.length); 
		nodosCamino.splice(0, nodosCamino.length); 
		_nodosCerrados.splice(0, _nodosCerrados.length);
		_nodoInicial = null;
		_nodoFinal = null;
			
		for(j in 0 ... _nodos.length-1) 
		{
			origen = initialPosition;
			destino = _nodos[j].position; 
			distancia = Point.distance(origen, destino);
			if(distancia<=visionDistance)
			{
				if(_nodoInicial == null) 
				{
					_nodoInicial = _nodos[j]; 
					_nodoInicial.distanceToFather = distancia; 
				}
				else if(_nodoInicial.distanceToFather > distancia)
				{
					_nodoInicial.distanceToFather = Math.POSITIVE_INFINITY;
					_nodoInicial = _nodos[j];
					_nodoInicial.distanceToFather = distancia;
				}
			}
				
			_nodoInicial.fatherNode = null; 
			origen = finalPosition; 
			distancia = Point.distance(origen, destino);
			
			if(distancia<=visionDistance)
			{
				if(_nodoFinal == null) 
				{
					_nodoFinal = _nodos[j];
					_nodoFinal.distanceToFather = distancia;
				}
				else if(_nodoFinal.distanceToFather > distancia)
				{
					_nodoFinal.distanceToFather = Math.POSITIVE_INFINITY;
					_nodoFinal = _nodos[j]; 
					_nodoFinal.distanceToFather = distancia; 
				}
			}
		}
			
		if(_nodoInicial != null && _nodoFinal != null)
		{
			_nodosSinCerrar = _nodos; 
			_nodosAbiertos.push(_nodoInicial); 
			explorarNodo(_nodoInicial); 
		}
		else
		{
			existeCamino = false; 
			Main.mono.reportInformation("Couldn't find a path", "Utilities", "Dijkstra", "executeDijkstra");
		}
	}
		
	/** Explore node.
	* 
	* @param nodo Node to explore
	* 
	*  */
		
	private function explorarNodo(nodo:Nod):Void
	{
		var i:Int; 
		var posNodo:Point =nodo.position; 
		var posPosible:Point; 
		
		for(i in 0 ... _nodosSinCerrar.length-1) 
		{
			if(_nodosSinCerrar[i]!=nodo)
			{
				posPosible = _nodosSinCerrar[i].position; 
				if(Point.distance(posPosible, posNodo) <= _vision) 
				{
					if(!vectorContainsNode(_nodosSinCerrar[i], _nodosAbiertos)) 
					{
						_nodosSinCerrar[i].distanceToFather = Point.distance(posPosible, posNodo)+nodo.distanceToFather; 
						_nodosSinCerrar[i].fatherNode = nodo; 
						_nodosAbiertos.push(_nodosSinCerrar[i]); 
					}
					
					if(Point.distance(posPosible, posNodo)+nodo.distanceToFather < _nodosSinCerrar[i].distanceToFather)
					{
						_nodosSinCerrar[i].distanceToFather = Point.distance(posPosible, posNodo)+nodo.distanceToFather; 
						_nodosSinCerrar[i].fatherNode = nodo; 
					}
				}
			}
		}
			
		_nodosAbiertos=removeNode(nodo, _nodosAbiertos);
		_nodosSinCerrar=removeNode(nodo, _nodosSinCerrar); 
		_nodosCerrados.push(nodo);
			
		if(nodo == _nodoFinal) 
		{
			
			existeCamino = true; 
			nodosCamino.push(_nodoFinal);
			
			var aux:Nod = _nodoFinal.fatherNode; 
			var auxN:Nod = _nodoFinal; 
			
			while(aux != _nodoInicial)
			{
				if(graficar) 
				{
					var lin:Sprite = new Sprite(); 
					lin = Artist.line(Std.int(aux.position.x), Std.int(aux.position.y), Std.int(auxN.position.x), Std.int(auxN.position.y), 3, 0x00ff00, 1); 
					Main.mono.mainStage.addChild(lin); 
				}
				nodosCamino.push(aux); 
				auxN = aux;
				aux = aux.fatherNode; 
			}
			Main.mono.reportInformation("A path was found", "Utilities", "Dijkstra", "exploreNode");
		}
		
		else if(_nodosAbiertos.length>0)
		{
			var nodoExplorar:Nod = nodo; 
			var fitness:Float = Math.POSITIVE_INFINITY; 
			
			posPosible = _nodosAbiertos[0].position; 
			
			var i:Int = 0;
			for(i in 0 ... _nodosAbiertos.length -1) 
			{
				var d:Float = Point.distance(nodo.position, posPosible) + _nodosAbiertos[i].distanceToFather; 
				if(d < fitness) 
				{
					fitness = d; 
					nodoExplorar = _nodosAbiertos[i]; 
				}
			}
			explorarNodo(nodoExplorar); 
		}
		else
		{
			existeCamino = false; 
			Main.mono.reportInformation("Couldn't find a path", "Utilities", "Dijkstra", "exploreNode");
		}
	}
		
	/** Add a node.
	* 
	* @param p Position of the node
	* 
	*  */
		
	public function agregarNodo(p:Point):Void
	{
		var n:Nod = new Nod(p, graficar); 
		_nodos.push(n); 
	}
		
	/** Removes a node based on its position.
	* 
	* @param p Point where the node is
	* 
	*  */
		
	public function containsNode(p:Point):Void
	{
		var i:Int = 0;
		for(i in 0 ... _nodos.length-1) 
		{
			if(_nodos[i].position == p) 
			{
				_nodos.splice(i, 1);
			}
		}
	}
		
	/** Removes the node.
	* 
	* @param nodo Node
	* @param vect Vector
	* 
	* @return Returns the vector whitout the node
	*  */
		
	private function removeNode(nodo:Nod, vect:Vector<Nod>):Vector<Nod>
	{
		var i:Int = 0;
		var aux:Int;
		
		for(i in 0 ... vect.length -1)
		{
			if(vect[i] == nodo)
			{
				vect.splice(i, 1);
				break;
			}
		}		
		return vect;
	}
		
	/** Tells if the vector has the node.
	* 
	* @param nodo Node
	* @param vect Vector
	* 
	* @return Returns if it has it
	*  */
	
	private function vectorContainsNode(nodo:Nod, vect:Vector<Nod>):Bool
	{
		var result:Bool = false;
		var i:Int = 0;
		for(i in 0 ... vect.length-1) 
		{
			if(vect[i] == nodo) 
			{
				return true;
			}
		}
		return result;
	}
}