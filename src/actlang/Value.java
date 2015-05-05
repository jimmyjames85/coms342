package actlang;

import java.util.List;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.locks.ReentrantLock;

import actlang.Heap.Heap16Bit;
import actlang.AST.*;

public interface Value
{
	public String tostring();

	public Object clone() throws CloneNotSupportedException;

	static class RefVal extends ReentrantLock implements Value
	{ //New in the reflang
		private static final long serialVersionUID = 1L;
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

		public Object clone() throws CloneNotSupportedException
		{
			return new RefVal(_loc);
		}
	}

	static class ActorVal extends Thread implements Value
	{
		private LinkedBlockingDeque<List<Value>> _queue;
		private Heap _h;
		private boolean _exit;
		private List<String> _formals;
		private Env _env;
		private Exp _body;
		private Evaluator _evaluator;

		public ActorVal(Env env, Heap heap, Evaluator evaluator, List<String> formals, Exp body)
		{
			_env = env;
			_formals = formals;
			_body = body;
			_h = heap;
			_evaluator = evaluator;
			_queue = new LinkedBlockingDeque<List<Value>>();
			_exit = false;

			this.start();

		}

		@Override
		public void run()
		{
			while (!_exit)
			{

				if (!_queue.isEmpty())
				{
					List<Value> actuals = _queue.removeFirst();

					Env newEnv = _env;

					for (String fml : _formals)
						new Env.ExtendEnv(newEnv, fml, actuals.remove(0));

					newEnv = new Env.ExtendEnv(newEnv, "self", this);

					_body.accept(_evaluator, newEnv, _h);

				}
			}
		}

		public Object clone() throws CloneNotSupportedException
		{
			return new ActorVal(_env, (Heap) _h.clone(), _evaluator, _formals, _body);
			//return new FunVal(_formals, _body);
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

		public synchronized void setExit()
		{
			_exit = true;
		}

		public synchronized boolean getExit()
		{
			return _exit;
		}

		public boolean receive(List<Value> vals)
		{
			if (_exit)
				return false;
			_queue.addLast(vals);
			return true;
		}

		public String tostring()
		{
			String result = "(actor ( ";
			for (String formal : _formals)
				result += formal + " ";
			result += ") ";
			result += _body.accept(new Printer.Formatter(), _env, null);
			return result + ")";
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
			result += _body.accept(new Printer.Formatter(), _env, null);
			return result + ")";
		}

		public Object clone() throws CloneNotSupportedException
		{
			return new FunVal(_env, _formals, _body);
		}
	}

	static class NumVal implements Value
	{
		private double _val;

		public Object clone() throws CloneNotSupportedException
		{
			return new NumVal(_val);
		}

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
	}

	static class BoolVal implements Value
	{

		public Object clone() throws CloneNotSupportedException
		{
			return new BoolVal(_val);
		}

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
	}

	static class StringVal implements Value
	{
		private java.lang.String _val;

		public StringVal(String v)
		{
			_val = v;
		}

		public Object clone() throws CloneNotSupportedException
		{
			return new StringVal(_val);
		}

		public String v()
		{
			return _val;
		}

		public java.lang.String tostring()
		{
			return "" + _val;
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

		public Object clone() throws CloneNotSupportedException
		{
			return new PairVal((Value) _fst.clone(), (Value) _snd.clone());
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
			return "(" + _fst.tostring() + " " + _snd.tostring() + ")";
		}

		protected java.lang.String tostringHelper()
		{
			String result = "";
			if (_fst instanceof Value.PairVal && !(_fst instanceof Value.ExtendList))
				result += ((Value.PairVal) _fst).tostringHelper();
			else
				result += _fst.tostring();
			if (!(_snd instanceof Value.EmptyList))
			{
				result += " ";
				if (_snd instanceof Value.PairVal && !(_snd instanceof Value.ExtendList))
					result += ((Value.PairVal) _snd).tostringHelper();
				else
					result += _snd.tostring();
			}
			return result;
		}
	}

	static interface ListVal extends Value
	{
	}

	static class EmptyList implements ListVal
	{
		public EmptyList()
		{
		}

		public Object clone() throws CloneNotSupportedException
		{
			return new EmptyList();
		}

		public String tostring()
		{
			return "()";
		}
	}

	static class ExtendList extends PairVal implements ListVal
	{
		public ExtendList(Value fst, Value snd)
		{
			super(fst, snd);
		}

		public String tostring()
		{
			String result = "(";
			if (_fst instanceof Value.PairVal && !(_fst instanceof Value.ExtendList))
				result += ((Value.PairVal) _fst).tostringHelper();
			else
				result += _fst.tostring();
			if (!(_snd instanceof Value.EmptyList))
			{
				result += " ";
				if (_snd instanceof Value.PairVal && !(_snd instanceof Value.ExtendList))
					result += ((Value.PairVal) _snd).tostringHelper();
				else
					result += _snd.tostring();
			}
			return result += ")";
		}
	}

	static class UnitVal implements Value
	{
		public static final UnitVal v = new UnitVal();

		public Object clone() throws CloneNotSupportedException
		{
			return new UnitVal();
		}

		public String tostring()
		{
			return "";
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

		public Object clone() throws CloneNotSupportedException
		{
			return new DynamicError(message);
		}

		public String tostring()
		{
			return "" + message;
		}
	}
}
