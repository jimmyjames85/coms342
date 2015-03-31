package reflang;

import java.util.ArrayList;
import java.util.List;

import reflang.Value.RefVal;

/**
 * Representation of a heap, which maps references to values.
 * 
 * @author hridesh
 *
 */
public interface Heap
{

	
	void gc(Env env);

	Value ref(Value value);

	Value deref(Value.RefVal loc);

	Value setref(Value.RefVal loc, Value value);

	Value free(Value.RefVal value);

	static public class Heap16Bit implements Heap
	{

		static final int HEAP_SIZE = 3;// 65_536;
		Boolean[] _mark = new Boolean[HEAP_SIZE];
		Value[] _rep = new Value[HEAP_SIZE];
		List<Integer> _free = new ArrayList<Integer>();

		int index = 0;

		public Value ref(Value value)
		{
			
			//if (index >= HEAP_SIZE)
				//return new Value.DynamicError("Out of memory error");
			if(_free.isEmpty())
				return new Value.DynamicError("Out of memory error");
			
			
			int myIndex = _free.get(0);
			_free.remove(new Integer(myIndex));
			
			Value.RefVal new_loc = new Value.RefVal(myIndex);
			_rep[myIndex++] = value;
			return new_loc;
		}

		public Value deref(Value.RefVal loc)
		{
			try
			{
				return _rep[loc.loc()];
			}
			catch (ArrayIndexOutOfBoundsException e)
			{
				return new Value.DynamicError("Segmentation fault at access " + loc);
			}
		}

		public Value setref(Value.RefVal loc, Value value)
		{
			try
			{
				return _rep[loc.loc()] = value;
			}
			catch (ArrayIndexOutOfBoundsException e)
			{
				return new Value.DynamicError("Segmentation fault at access " + loc);
			}
		}

		public Value free(Value.RefVal loc)
		{
			try
			{
				_rep[loc.loc()] = null;
				_free.add(loc.loc());
				//REMARK: students should add this location to free list.
				return loc;
			}
			catch (ArrayIndexOutOfBoundsException e)
			{
				return new Value.DynamicError("Segmentation fault at access " + loc);
			}
		}

		public void markAll()
		{
			for (int i = 0; i < HEAP_SIZE; i++)
				_mark[i] = true;
		}

		public void clearReachable(Env env)
		{
			List<Integer> reachable = env.reachableList(this);
			for (Integer loc : reachable)
				_mark[loc] = false;
		}

		public void sweep()
		{
			for (int i = 0; i < HEAP_SIZE; i++)
			{
				if (_mark[i])
				{
					free(new RefVal(i));
				}
			}
		}

		public void gc(Env env)
		{
			markAll();
			clearReachable(env);
			sweep();
		}

		public Heap16Bit()
		{
			for (int i = 0; i < HEAP_SIZE; i++)
				free(new RefVal(i));
		}
	}

}
