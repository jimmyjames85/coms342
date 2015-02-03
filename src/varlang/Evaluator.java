package varlang;

import static varlang.AST.*;
import static varlang.Value.*;

import java.util.List;
import java.util.ArrayList;

import varlang.AST.AddExp;
import varlang.AST.Const;
import varlang.AST.DivExp;
import varlang.AST.ErrorExp;
import varlang.AST.MultExp;
import varlang.AST.Program;
import varlang.AST.SubExp;
import varlang.AST.VarExp;
import varlang.AST.Visitor;
import varlang.Env.EmptyEnv;
import varlang.Env.ExtendEnv;

public class Evaluator implements Visitor<Value>
{

	Value valueOf(Program p)
	{
		Env env = new EmptyEnv();
		for(int i=1;i<13;i++)
		{
			String month = "";
			switch (i)
			{
				case 1:
					month="Jan";
					break;
				case 2:
					month="Feb";
					break;
				case 3:
					month="Mar";
					break;
				case 4:
					month="Apr";
					break;
				case 5:
					month="May";
					break;
				case 6:
					month="Jun";
					break;
				case 7:
					month="Jul";
					break;
				case 8:
					month="Aug";
					break;
				case 9:
					month="Sep";
					break;
				case 10:
					month="Oct";
					break;
				case 11:
					month="Nov";
					break;
				case 12:
					month="Dec";
					break;
				default:
					break;
			}
			env =new ExtendEnv( env,month, new Int(i)); 
		}

		
		
		// Value of a program in this language is the value of the expression
		return (Value) p.accept(this, env);
	}

	@Override
	public Value visit(AddExp e, Env env)
	{
		List<Exp> operands = e.all();
		int result = 0;
		for (Exp exp : operands)
		{
			Int intermediate = (Int) exp.accept(this, env); // Dynamic type-checking
			result += intermediate.v(); //Semantics of AddExp in terms of the target language.
		}
		return new Int(result);
	}

	@Override
	public Value visit(Const e, Env env)
	{
		return new Int(e.v());
	}

	@Override
	public Value visit(DivExp e, Env env)
	{
		List<Exp> operands = e.all();
		Int lVal = (Int) operands.get(0).accept(this, env);
		int result = lVal.v();
		for (int i = 1; i < operands.size(); i++)
		{
			Int rVal = (Int) operands.get(i).accept(this, env);
			result = result / rVal.v();
		}
		return new Int(result);
	}

	@Override
	public Value visit(ErrorExp e, Env env)
	{
		return new Value.DynamicError("Encountered an error expression");
	}

	@Override
	public Value visit(MultExp e, Env env)
	{
		List<Exp> operands = e.all();
		int result = 1;
		for (Exp exp : operands)
		{
			Int intermediate = (Int) exp.accept(this, env); // Dynamic type-checking
			result *= intermediate.v(); //Semantics of MultExp.
		}
		return new Int(result);
	}

	@Override
	public Value visit(Program p, Env env)
	{
		return (Value) p.e().accept(this, env);
	}

	@Override
	public Value visit(SubExp e, Env env)
	{
		List<Exp> operands = e.all();
		Int lVal = (Int) operands.get(0).accept(this, env);
		int result = lVal.v();
		for (int i = 1; i < operands.size(); i++)
		{
			Int rVal = (Int) operands.get(i).accept(this, env);
			result = result - rVal.v();
		}
		return new Int(result);
	}

	@Override
	public Value visit(VarExp e, Env env)
	{
		// Previously, all variables had value 42. New semantics.
		return env.get(e.name());
	}

	@Override
	public Value visit(LetExp e, Env env)
	{ // New for varlang.
		List<String> names = e.names();
		List<Exp> value_exps = e.value_exps();
		List<Value> values = new ArrayList<Value>(value_exps.size());

		for (Exp exp : value_exps)
			values.add((Value) exp.accept(this, env));

		Env new_env = env;
		for (int i = 0; i < names.size(); i++)
			new_env = new ExtendEnv(new_env, names.get(i), values.get(i));

		
		return (Value) e.body().accept(this, new_env);
	}

}
