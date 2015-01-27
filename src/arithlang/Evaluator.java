package arithlang;

import static arithlang.AST.*;
import static arithlang.Value.*;

import java.util.List;

public class Evaluator implements Visitor<Value>
{

	Printer.Formatter ts = new Printer.Formatter();

	Value valueOf(Program p)
	{
		// Value of a program in this language is the value of the expression
		return (Value) p.accept(this);
	}

	@Override
	public Value visit(AddExp e)
	{
		List<Exp> operands = e.all();
		double result = 0;

		for (Exp exp : operands)
		{
			Value intermediate = (Value) exp.accept(this);

			if (intermediate instanceof DynamicError)
				return intermediate;

			result += ((NumVal) intermediate).v(); //Semantics of AddExp in terms of the target language.
		}

		return new NumVal(result);
	}

	@Override
	public Value visit(NumExp e)
	{
		return new NumVal(e.v());
	}

	/***************** Question 6 **************************/
	@Override
	public Value visit(DivExp e)
	{
		List<Exp> operands = e.all();
		Value lVal = (Value) operands.get(0).accept(this);

		if (lVal instanceof DynamicError)
			return lVal;

		double result = ((NumVal) lVal).v();
		for (int i = 1; i < operands.size(); i++)
		{

			Value rVal = (Value) operands.get(i).accept(this);
			if (rVal instanceof DynamicError)
				return rVal;

			result = result / ((NumVal) rVal).v();

			if (Double.isInfinite(result))
				return new DynamicError("Cannont divide by argument #" + (1 + i) + " in divexp: divide by zero error.");

		}
		return new NumVal(result);

	}

	/***************** Question 4 **************************/
	@Override
	public Value visit(PowExp e)
	{
		List<Exp> operands = e.all();
		Value lVal = (Value) operands.get(0).accept(this);

		if (lVal instanceof DynamicError)
			return lVal;

		double result = ((NumVal) lVal).v();
		for (int i = 1; i < operands.size(); i++)
		{

			Value rVal = (Value) operands.get(i).accept(this);
			if (rVal instanceof DynamicError)
				return rVal;

			result = Math.pow(result, ((NumVal) rVal).v());
		}

		return new NumVal(result);

	}

	/***************** Question 5 **************************/
	@Override
	public Value visit(MaxExp e)
	{
		List<Exp> operands = e.all();
		Value lVal = (Value) operands.get(0).accept(this);

		if (lVal instanceof DynamicError)
			return lVal;

		double result = ((NumVal) lVal).v();
		for (int i = 1; i < operands.size(); i++)
		{
			Value rVal = (Value) operands.get(i).accept(this);
			if (rVal instanceof DynamicError)
				return rVal;

			result = Math.max(result, ((NumVal) rVal).v());
		}

		return new NumVal(result);
	}

	@Override
	public Value visit(MinExp e)
	{
		List<Exp> operands = e.all();
		Value lVal = (Value) operands.get(0).accept(this);

		if (lVal instanceof DynamicError)
			return lVal;

		double result = ((NumVal) lVal).v();
		for (int i = 1; i < operands.size(); i++)
		{
			Value rVal = (Value) operands.get(i).accept(this);
			if (rVal instanceof DynamicError)
				return rVal;

			result = Math.min(result, ((NumVal) rVal).v());
		}

		return new NumVal(result);

	}

	/***************** End Question 5 **********************/

	@Override
	public Value visit(ErrorExp e)
	{
		return new Value.DynamicError("Encountered an error expression");
	}

	@Override
	public Value visit(MultExp e)
	{
		List<Exp> operands = e.all();
		double result = 1;
		for (Exp exp : operands)
		{
			Value intermediate = (Value) exp.accept(this);
			if (intermediate instanceof DynamicError)
				return intermediate;

			result *= ((NumVal) intermediate).v(); //Semantics of MultExp.
		}

		return new NumVal(result);
	}

	@Override
	public Value visit(Program p)
	{
		return (Value) p.e().accept(this);
	}

	@Override
	public Value visit(SubExp e)
	{
		List<Exp> operands = e.all();
		Value lVal = (Value) operands.get(0).accept(this);
		if (lVal instanceof DynamicError)
			return lVal;

		double result = ((NumVal) lVal).v();
		for (int i = 1; i < operands.size(); i++)
		{

			Value rVal = (Value) operands.get(i).accept(this);
			if (rVal instanceof DynamicError)
				return rVal;
			result = result - ((NumVal) rVal).v();
		}

		return new NumVal(result);
	}

	@Override
	public Value visit(VarExp e)
	{
		return new NumVal(42); // All variables have value 42 in this language.
	}

}