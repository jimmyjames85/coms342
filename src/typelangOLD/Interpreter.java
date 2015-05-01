package typelang;

import java.io.IOException;

import typelang.AST.*;

/**
 * This main class implements the Read-Eval-Print-Loop of the interpreter with
 * the help of Reader, Evaluator, and Printer classes.
 * 
 * @author hridesh
 *
 */
public class Interpreter
{
	public static void main(String[] args)
	{
		System.out.println("TypeLang: Type a program to evaluate and press the enter key,\n" + "e.g. ((lambda (x y z : (num num num -> num)) (+ x (+ y z))) 1 2 3) \n"
				+ "or try (let ((x : num 2)) x) \n" + "or try (car (list : num  1 2 8)) \n" + "or try (ref : num 2) \n"
				+ "or try  (let ((a : Ref num (ref : num 2))) (set! a (deref a))) \n" + "Press Ctrl + C to exit.");
		Reader reader = new Reader();
		Evaluator eval = new Evaluator(reader);
		Printer printer = new Printer();
		Checker checker = new Checker(); // Type checker
		try
		{
			//Program p = reader.read();
			//requireFile("src/typelang/lib/roman.scm");
			
			while (true)
			{ // Read-Eval-Print-Loop (also known as REPL)
				try
				{
					Program p = reader.read();
					Type t = checker.check(p);
					/*** Type checking the program ***/
					if (t instanceof Type.ErrorT)
						printer.print(t);
					else
					{
						try
						{
							Value val = eval.valueOf(p);
							printer.print(val);
						}
						catch (Env.LookupException e)
						{
							printer.print(e);
						}
					}
				}
				catch (NullPointerException e)
				{
					System.out.println(e.toString());
				}
			}
		}
		catch (IOException e)
		{
			System.out.println("Error reading input.");
		}
	}
}
