package forklang;

/**
 * Representation of a heap, which maps references to values.
 * 
 * @author hridesh
 *
 */
public interface Heap
{

	Value ref(Value value);

	Value deref(Value.RefVal loc);

	Value setref(Value.RefVal loc, Value value);

	Value free(Value.RefVal value);
	
	Value frequency(Value.RefVal loc);

	static public class Heap16Bit implements Heap
	{
		private class HotPair
		{
			int _access_count;
			Value _val;
			
			HotPair(Value value)
			{
				_access_count=0;
				_val=value;
			}
		}

		static final int HEAP_SIZE = 65_536;

		//Value[] _rep = new Value[HEAP_SIZE];
		HotPair[] _rep = new HotPair[HEAP_SIZE];
		int index = 0;

		public Value ref(Value value)
		{
			if (index >= HEAP_SIZE)
				return new Value.DynamicError("Out of memory error");
			Value.RefVal new_loc = new Value.RefVal(index);
			_rep[index++] = new HotPair(value);
			return new_loc;
		}

		public Value frequency(Value.RefVal loc)
		{
			System.out.println("freq=");
			try
			{
				HotPair derefed = _rep[loc.loc()];
				if(derefed==null)
					return new Value.NumVal(0);
				else
					return new Value.NumVal(derefed._access_count);
			}
			catch (ArrayIndexOutOfBoundsException e)
			{
				return new Value.DynamicError("Segmentation fault at access " + loc);
			}			
		}
		
		public Value deref(Value.RefVal loc)
		{
			try
			{
				HotPair derefed = _rep[loc.loc()];
				if(derefed==null)
					return null;
				
				derefed._access_count++;
				return derefed._val;
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
				HotPair pair = _rep[loc.loc()];
				if(pair==null)
					_rep[loc.loc()] = (pair=new HotPair(value));
				else
				{
					pair._access_count++;
					pair._val=value;
				}
				return pair._val;
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
				//REMARK: students should add this location to free list.
				return loc;
			}
			catch (ArrayIndexOutOfBoundsException e)
			{
				return new Value.DynamicError("Segmentation fault at access " + loc);
			}
		}

		public Heap16Bit()
		{
		}
	}

}
