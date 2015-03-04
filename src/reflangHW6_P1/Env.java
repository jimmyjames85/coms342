package reflang;

import java.util.List;

import reflang.Value.*;

/**
 * Representation of an environment, which maps variables to values.
 * 
 * @author hridesh
 *
 */
public interface Env
{
	Value get(String search_var);

	boolean isEmpty();

	@SuppressWarnings("serial")
	static public class LookupException extends RuntimeException
	{
		LookupException(String message)
		{
			super(message);
		}
	}

	static public class EmptyEnv implements Env
	{
		public Value get(String search_var)
		{
			throw new LookupException("No binding found for name: " + search_var);
		}

		public boolean isEmpty()
		{
			return true;
		}
	}

	static public class ExtendEnv implements Env
	{
		private Env _saved_env;
		private String _var;
		private Value _val;

		public ExtendEnv(Env saved_env, String var, Value val)
		{
			_saved_env = saved_env;
			_var = var;
			_val = val;
		}

		public synchronized Value get(String search_var)
		{
			if (search_var.equals(_var))
				return _val;
			return _saved_env.get(search_var);
		}

		public boolean isEmpty()
		{
			return false;
		}

		public Env saved_env()
		{
			return _saved_env;
		}

		public String var()
		{
			return _var;
		}

		public Value val()
		{
			return _val;
		}
	}

	static public class ExtendEnvRec implements Env
	{
		private Env _saved_env;
		private List<String> _names;
		private List<Value.FunVal> _funs;

		public Env saved_env()
		{
			return _saved_env;
		}

		public List<String> names()
		{
			return _names;
		}

		public List<FunVal> vals()
		{
			return _funs;
		}

		public ExtendEnvRec(Env saved_env, List<String> names, List<Value.FunVal> funs)
		{
			_saved_env = saved_env;
			_names = names;
			_funs = funs;
		}

		public boolean isEmpty()
		{
			return false;
		}

		public Value get(String search_var)
		{
			int size = _names.size();
			for (int index = 0; index < size; index++)
			{
				if (search_var.equals(_names.get(index)))
				{
					FunVal f = _funs.get(index);
					if(!(f.env() instanceof ExtendEnvRec))
					{
						_funs.remove(index);
						f=new Value.FunVal(this, f.formals(), f.body());
						_funs.add(f);
					}

					//return new Value.FunVal(this, f.formals(), f.body());
					return f;
					
					//HW6 #1

					//A The enviornment frame is within ExtendEnvRec
					
					//B Originally it did not return the same FunVal

					//C I've modified the function to used the new ExtendEnvRec
					//  and now it DOES return the same FunVal object each time

				}
			}

			return _saved_env.get(search_var);
		}
	}

}
