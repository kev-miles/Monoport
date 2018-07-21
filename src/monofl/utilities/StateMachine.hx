package monofl.utilities;

import monofl.Mono;
import monofl.utilities.complements.State;	

import openfl.utils.Dictionary;

class StateMachine
{
	private var _currentState:State;
	private var _states:Dictionary<String,State>;
		
	public function StateMachine()
	{
		_states = new Dictionary<String,State>(); 
	}
		
	/** The update that must be called each time per frame.
	* 
	*  */
	
	public function update():Void
	{
		_currentState.update(); 
	}
		
	/** Adds a state.
	* 
	* @param state State to be added
	* @param name Name of the state
	* 
	*  */
		
	public function addState(state:State, name:String):Void
	{
		_states[name] = state; 
		if(_currentState==null) 
		{
			_currentState = state; 
		}
	}
		
	/** Changes to other state.
	* 
	* @param name Name of the state.
	* 
	*  */
	
	public function setState(name:String):Void
	{
		if(_states[name]!=null) 
		{
			if(_states[name] != _currentState)
			{
				_currentState.sleep(); 
				_currentState = _states[name];
				_currentState.awake();
			}
			else
			{
				Main.mono.reportWarning("It was already in the state "+name+" so it won't change state", "Utilities", "StateMachine", "setState");
			}
		}
		else
		{
			Main.mono.reportWarning("The state didn't exist, so no changes were made", "Utilities", "StateMachine", "setState");
		}
	}
}