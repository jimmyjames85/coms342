package reflang;

import java.util.ArrayList;
import java.util.List;

import reflang.AST.Exp;

public interface Value
{
	public String tostring();

	public List<Integer> reachable(Heap heap);

	static class RefVal implements Value
	{ //New in the reflang
		private int _loc = -1;

		public RefVal(int loc)
		{
			_loc = loc;
		}

		public String tostring()
		{
			return "loc:" + this._loc;
		}

		public int loc()
		{
			return _loc;
		}

		public List<Integer> reachable(Heap heap)
		{
			List<Integer> ret = new ArrayList<Integer>();
			Value val = heap.deref(this);
			if(val instanceof DynamicError)
				return ret;
			
			ret = val.reachable(heap);
			ret.add(_loc);
			return ret;
		}
	}

	static class FunVal implements Value
	{ //New in the funclang
		private Env _env;
		private List<String> _formals;
		private Exp _body;

		public FunVal(Env env, List<String> formals, Exp body)
		{
			_env = env;
			_formals = formals;
			_body = body;
		}

		public Env env()
		{
			return _env;
		}

		public List<String> formals()
		{
			return _formals;
		}

		public Exp body()
		{
			return _body;
		}

		public String tostring()
		{
			String result = "(lambda ( ";
			for (String formal : _formals)
				result += formal + " ";
			result += ") ";
			result += _body.accept(new Printer.Formatter(), _env);
			return result + ")";
		}
		
		public List<Integer> reachable(Heap heap)
		{
			return _env.reachableList(heap);
		}
	}

	static class NumVal implements Value
	{
		private double _val;

		public NumVal(double v)
		{
			_val = v;
		}

		public double v()
		{
			return _val;
		}

		public String tostring()
		{
			int tmp = (int) _val;
			if (tmp == _val)
				return "" + tmp;
			return "" + _val;
		}
		public List<Integer> reachable(Heap heap)
		{
			return new ArrayList<Integer>();
		}
	}

	static class BoolVal implements Value
	{
		private boolean _val;

		public BoolVal(boolean v)
		{
			_val = v;
		}

		public boolean v()
		{
			return _val;
		}

		public String tostring()
		{
			if (_val)
				return "#t";
			return "#f";
		}
		public List<Integer> reachable(Heap heap)
		{
			return new ArrayList<Integer>();
		}		
	}

	static class StringVal implements Value
	{
		private java.lang.String _val;

		public StringVal(String v)
		{
			_val = v;
		}

		public String v()
		{
			return _val;
		}

		public java.lang.String tostring()
		{
			return "" + _val;
		}
		public List<Integer> reachable(Heap heap)
		{
			return new ArrayList<Integer>();
		}		
	}

	static class PairVal implements Value
	{
		protected Value _fst;
		protected Value _snd;

		public PairVal(Value fst, Value snd)
		{
			_fst = fst;
			_snd = snd;
		}

		public Value fst()
		{
			return _fst;
		}

		public Value snd()
		{
			return _snd;
		}

		public java.lang.String tostring()
		{
			if (isList())
				return listToString();
			return "(" + _fst.tostring() + " " + _snd.tostring() + ")";
		}

		private boolean isList()
		{
			if (_snd instanceof Value.Null)
				return true;
			if (_snd instanceof Value.PairVal && ((Value.PairVal) _snd).isList())
				return true;
			return false;
		}

		private java.lang.String listToString()
		{
			String result = "(";
			result += _fst.tostring();
			Value next = _snd;
			while (!(next instanceof Value.Null))
			{
				result += " " + ((PairVal) next)._fst.tostring();
				next = ((PairVal) next)._snd;
			}
			return result + ")";
		}
		
		public List<Integer> reachable(Heap heap)
		{
			List<Integer> ret = _fst.reachable(heap);
			ret.addAll(_snd.reachable(heap));
			return ret;
		}		
	}

	static class Null implements Value
	{
		
		public Null()
		{
		}

		public String tostring()
		{
			return "()";
		}
		public List<Integer> reachable(Heap heap)
		{
			return new ArrayList<Integer>();
		}				
	}

	static class UnitVal implements Value
	{
		public static final UnitVal v = new UnitVal();

		public String tostring()
		{
			return "";
		}
		public List<Integer> reachable(Heap heap)
		{
			return new ArrayList<Integer>();
		}				
	}

	static class DynamicError implements Value
	{
		private String message = "Unknown dynamic error.";

		public DynamicError()
		{
		}

		public DynamicError(String message)
		{
			this.message = message;
		}

		public String tostring()
		{
			return "" + message;
		}
		public List<Integer> reachable(Heap heap)
		{
			return new ArrayList<Integer>();
		}				
	}
}
