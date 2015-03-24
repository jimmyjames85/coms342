package forklang;
import java.io.IOException;

import forklang.AST.*;

/**
 * This main class implements the Read-Eval-Print-Loop of the interpreter with
 * the help of Reader, Evaluator, and Printer classes. 
 * 
 * @author hridesh
 *
 */
public class Interpreter {
	public static void main(String[] args) {
		System.out.println("ForkLang: Type a program to evaluate and press the enter key,\n" + 
				"e.g. (ref 342) \n" + 
				"or try (deref (ref 342)) \n" +
				"or try (let ((class (ref 342))) (deref class)) \n" +
				"or try (let ((class (ref 342))) (set! class 541)) \n" + 
				"or try  (let ((r (ref 342))) (let ((d (free r))) (deref r))) \n" +
				"Press Ctrl + C to exit.");
		Reader reader = new Reader();
		Evaluator eval = new Evaluator(reader);
		Printer printer = new Printer();
		try {
			while (true) { // Read-Eval-Print-Loop (also known as REPL)
				Program p = reader.read();
				try {
					Value val = eval.valueOf(p);
					printer.print(val);
				} catch (Env.LookupException e) {
					printer.print(e);
				}
			}
		} catch (IOException e) {
			System.out.println("Error reading input.");
		}
	}
}
