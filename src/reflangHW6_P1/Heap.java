package reflang;

import reflang.Value.DynamicError;

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

	static public class Heap16Bit implements Heap
	{
		static final int HEAP_SIZE = 65_536;

		Value[] _rep = new Value[HEAP_SIZE];
		int index = 0;

		public Value ref(Value value)
		{
			if (index >= HEAP_SIZE)
				return new Value.DynamicError("Out of memory error");
			Value.RefVal new_loc = new Value.RefVal(index);
			_rep[index++] = value;
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
			
			Value ret = new DynamicError("Unkown Error");
			try
			{
				if (_rep[loc.loc()] == null)
				{
					//not sure if we should check against null however
					//can't check isAssignable on null value
					ret = new Value.DynamicError("Unable to check assignability near loc: " + loc.loc());
				}
				else if (!value.getClass().isAssignableFrom(_rep[loc.loc()].getClass()))
				{
					//QUESTION 4 also in AST.AssignExp.accept()
					
					ret = new Value.DynamicError("Assigning a value of an incompatible type to the location");
				}
				else
				{
					_rep[loc.loc()] = value;
					ret = value;
				}

			}
			catch (ArrayIndexOutOfBoundsException e)
			{
				ret = new Value.DynamicError("Segmentation fault at access " + loc);
			}
			
			return ret;
		}

		public Value free(Value.RefVal loc)
		{

			try
			{
				if (_rep[loc.loc()] == null)
					return new Value.DynamicError("Illegal deallocation of ref value loc:" + loc.loc());

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
