grammar ForkLang;
 
 // Grammar of this Programming Language
 //  - grammar rules start with lowercase
 program : 
		(definedecl)* (exp)? //Zero or more define declarations followed by an optional expression.
		;

 definedecl  :                
 		'(' Define 
 			Identifier
 			exp
 			')' 
 		;

 exp : 
		varexp 
		| numexp 
		| strconst
		| boolconst
        | addexp 
        | subexp 
        | multexp 
        | divexp
        | letexp
        | lambdaexp 
        | callexp 
        | ifexp 
        | lessexp 
        | equalexp 
        | greaterexp 
        | carexp 
        | cdrexp 
        | consexp
        | listexp
        | nullexp
        | letrecexp
        | refexp //New for reflang
        | derefexp //New for reflang
        | assignexp //New for reflang
        | freeexp //New for reflang
        | forkexp //New for forklang
        | lockexp //New for forklang
        | unlockexp //New for forklang
        ;
 
 varexp  : 
 		Identifier
 		;
 
 numexp :
 		Number
 		| Number Dot Number
 		;

 strconst :
 		StrLiteral
 		;

 boolconst :
 		TrueLiteral
 		| FalseLiteral
 		;
  
 addexp :
 		'(' '+'
 		    exp 
 		    (exp)+ 
 		    ')' 
 		;
 
 subexp :  
 		'(' '-' 
 		    exp 
 		    (exp)+ 
 		    ')' 
 		;

 multexp : 
 		'(' '*' 
 		    exp 
 		    (exp)+ 
 		    ')' 
 		;
 
 divexp  : 
 		'(' '/' 
 		    exp 
 		    (exp)+ 
 		    ')' 
 		;

 letexp  :
 		'(' Let 
 			'(' ( '(' Identifier exp ')' )+  ')'
 			exp 
 			')' 
 		;

 lambdaexp :
 		'(' Lambda 
 			'(' Identifier* ')'
 			exp 
 			')' 
 		;

 callexp :
 		'(' exp 
 			exp* 
 			')' 
 		;

 ifexp :
 		'(' If 
 		    exp 
 			exp 
 			exp 
 			')' 
 		;

 lessexp :
 		'(' Less 
 		    exp 
 			exp 
 			')' 
 		;

 equalexp :
 		'(' Equal 
 		    exp 
 			exp 
 			')' 
 		;

 greaterexp :
 		'(' Greater 
 		    exp 
 			exp 
 			')' 
 		;

 carexp :
 		'(' Car 
 		    exp 
 			')' 
 		;

 cdrexp :
 		'(' Cdr 
 		    exp 
 			')' 
 		;

 consexp :
 		'(' Cons 
 		    exp 
 			exp 
 			')' 
 		;

 listexp :
 		'(' List 
 		    exp* 
 			')' 
 		;

 nullexp :
 		'(' Null 
 		    exp 
 			')' 
 		;

 letrecexp  :
 		'(' Letrec 
 			'(' ( '(' Identifier exp ')' )+  ')'
 			exp 
 			')' 
 		;

// ******************* New Expressions for RefLang **********************
 refexp  :
                '(' Ref
                    exp
                    ')'
                ;

 derefexp  :
                '(' Deref
                    exp
                    ')'
                ;

 assignexp  :
                '(' Assign
                    exp
                    exp
                    ')'
                ;

 freeexp  :
                '(' Free
                    exp
                    ')'
                ;

 forkexp  :
                '(' Fork
                    exp
                    exp
                    ')'
                ;


 lockexp  :
                '(' Lock
                    exp
                    ')'
                ;
 unlockexp  :
                '(' UnLock
                    exp
                    ')'
                ;


// Keywords

 Let : 'let' ;
 Define : 'define' ;
 Lambda : 'lambda' ;
 If : 'if' ; 
 Car : 'car' ; 
 Cdr : 'cdr' ; 
 Cons : 'cons' ; 
 List : 'list' ; 
 Null : 'null?' ; 
 Letrec : 'letrec' ;
 Less : '<' ;
 Equal : '=' ;
 Greater : '>' ;
 TrueLiteral : '#t' ;
 FalseLiteral : '#f' ;
 Dot : '.' ;
 Ref : 'ref' ;
 Deref : 'deref' ;
 Assign : 'set!' ;
 Free : 'free' ;
 Fork : 'fork' ;
 Lock : 'lock' ;
 UnLock : 'unlock' ;
 NewLock : 'newlock' ;
 
 // Lexical Specification of this Programming Language
 //  - lexical specification rules start with uppercase

 Identifier :   Letter LetterOrDigit*;
 	
 Number : DIGIT+ ;
 
// Identifier :   Letter LetterOrDigit*;

 Letter :   [a-zA-Z$_]
	|   ~[\u0000-\u00FF\uD800-\uDBFF] 
		{Character.isJavaIdentifierStart(_input.LA(-1))}?
	|   [\uD800-\uDBFF] [\uDC00-\uDFFF] 
		{Character.isJavaIdentifierStart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)))}? ;

 LetterOrDigit: [a-zA-Z0-9$_?]
	|   ~[\u0000-\u00FF\uD800-\uDBFF] 
		{Character.isJavaIdentifierPart(_input.LA(-1))}?
	|    [\uD800-\uDBFF] [\uDC00-\uDFFF] 
		{Character.isJavaIdentifierPart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)))}?;

 fragment DIGIT: ('0'..'9');
 fragment DIGIT_NOT_ZERO: ('1'..'9');

 fragment ESCQUOTE : '\\"';
 StrLiteral :   '"' ( ESCQUOTE | ~('\n'|'\r') )*? '"';

 AT : '@';
 ELLIPSIS : '...';
 WS  :  [ \t\r\n\u000C]+ -> skip;
 Comment :   '/*' .*? '*/' -> skip;
 Line_Comment :   '//' ~[\r\n]* -> skip;