import java.util.*;

public class Parser {
    // Recursive descent parser that inputs a C++Lite program and 
    // generates its abstract syntax.  Each method corresponds to
    // a concrete syntax grammar rule, which appears as a comment
    // at the beginning of the method.
  
    Token token;          // current token from the input stream
    Lexer lexer;
  
    public Parser(Lexer ts) { // Open the C++Lite source program
        lexer = ts;                          // as a token stream, and
        token = lexer.next();            // retrieve its first Token
    }
  
    private String match (TokenType t) {
        String value = token.value();
        if (token.type().equals(t))
            token = lexer.next();
        else
            error(t);
        return value;
    }
  
    private void error(TokenType tok) {
        System.err.println("Syntax error: expecting: " + tok 
                           + "; saw: " + token);
        System.exit(1);
    }
  
    private void error(String tok) {
        System.err.println("Syntax error: expecting: " + tok 
                           + "; saw: " + token);
        System.exit(1);
    }
  
    public Program program() {
        // Program --> void main ( ) '{' Declarations Statements '}'
        TokenType[ ] header = {TokenType.Int, TokenType.Main,
                          TokenType.LeftParen, TokenType.RightParen};
        for (int i=0; i<header.length; i++)   // bypass "int main ( )"
            match(header[i]);
        match(TokenType.LeftBrace);
        
	Declarations decs = declarations();
	Block blk = statements();
        
	match(TokenType.RightBrace);

        return new Program(decs, blk);  // student exercise
    }
  
    private Declarations declarations () {
        // Declarations --> { Declaration }
        Declarations decs = new Declarations();
	while (isType()) {
		declaration(decs);
	}

        return decs;  // student exercise
    }
  
    private void declaration(Declarations ds){
        Type localtype = type();
        Variable v = new Variable(match(TokenType.Identifier));
        Declaration d = new Declaration(v, localtype);
        ds.add(d);
        while (token.type().equals(TokenType.Comma)) {
                lexer.next();
                v = (Variable) primary();
                localtype = type();
                ds.add(new Declaration(v, localtype));
                }

        match(TokenType.Semicolon);
  }

  private Type type () {
        // Type  -->  int | bool | float | char 
        Type t = null;
	if (token.type().equals(TokenType.Int))
		t = Type.INT;
	else if (token.type().equals(TokenType.Bool))
		t = Type.BOOL;
	else if (token.type().equals(TokenType.Float))
		t = Type.FLOAT;
	else if (token.type().equals(TokenType.Char))
		t = Type.CHAR;
	else error("Int || Bool || Float || Char");
	token = lexer.next();
        return t;          
    }
  
    private Statement statement() {
        // Statement --> ; | Block | Assignment | IfStatement | WhileStatement
        Statement s = new Skip();
	if (token.type().equals(TokenType.Semicolon)) {
		token = lexer.next(); }
	else if (token.type().equals(TokenType.LeftBrace)) {
		token = lexer.next();
		s = statements();
		match(TokenType.RightBrace); }

	else if (token.type().equals(TokenType.If)) {
		s = ifStatement(); }
	
	else if (token.type().equals(TokenType.While)) {
		s = whileStatement(); }

	else if (token.type().equals(TokenType.Identifier)) {
		s = assignment() ; }
	
	else { error("Illegal Statement"); }
	return s;
    }
  
    private Block statements () {
        // Block --> '{' Statements '}'
        Block b = new Block();
	while (!token.type().equals(TokenType.RightBrace)) {
		b.members.add(statement());
	}
	return b;
    }
  
    private Assignment assignment () {
        // Assignment --> Identifier = Expression ;
        Variable target = new Variable(match(TokenType.Identifier));
	match(TokenType.Assign);
	Expression source = expression();
	match(TokenType.Semicolon);
	return new Assignment(target, source);
    }
  
    private Conditional ifStatement () {
        // IfStatement --> if ( Expression ) Statement [ else Statement ]
        match(TokenType.If);
	Expression e = expression();
	Statement s = statement();
	Statement skip = new Skip();
	if (token.type().equals(TokenType.Else)) {
		token = lexer.next();
		skip = statement(); }
	return new Conditional(e, s, skip);  // student exercise
    }  

    private Loop whileStatement () {
        // WhileStatement --> while ( Expression ) Statement
        match(TokenType.While);
	match(TokenType.LeftParen);
	Expression e = expression();
	match(TokenType.RightParen);
	Statement s = statement(); 
	
        return new Loop(e, s);  // student exercise
    }

    private Expression expression () {
        // Expression --> Conjunction { || Conjunction }
        Expression c = conjunction();
	while (token.type().equals(TokenType.Or)) {
		Operator op = new Operator(token.value());
		token = lexer.next();
		Expression e = c;
		c = new Binary(op, c, e); }
        return c;  // student exercise
    }
  
    private Expression conjunction () {
        // Conjunction --> Equality { && Equality }
        Expression lO = equality();
	while (token.type().equals(TokenType.And)) {
		Operator op = new Operator(token.value());
		token = lexer.next();
		Expression e = equality();
		lO = new Binary(op, (Expression)lO, e); }
        return lO;  // student exercise
    }
  
    private Expression equality () {
        // Equality --> Relation [ EquOp Relation ]
        Expression lO = relation();
	while (isEqualityOp()) {
		Operator op = new Operator(token.value());
		token = lexer.next();
		Expression e = relation();
		lO = new Binary(op, (Expression)lO, e); }
        return lO;  // student exercise
    }

    private Expression relation(){
        // Relation --> Addition [RelOp Addition]
        Expression lO = addition();
	while (isRelationalOp()) {
		Operator op = new Operator(token.value());
		token = lexer.next();
		Expression e = addition();
		lO = new Binary(op, (Expression)lO, e); }
        return (lO);  // student exercise
    }
  
    private Expression addition () {
	// Addition --> Term { AddOp Term }
        Expression e = term();
        while (isAddOp()) {
            Operator op = new Operator(match(token.type()));
            Expression term2 = term();
            e = new Binary(op, e, term2);
        }
        return e;
    }
  
    private Expression term () {
        // Term --> Factor { MultiplyOp Factor }
        Expression e = factor();
        while (isMultiplyOp()) {
            Operator op = new Operator(match(token.type()));
            Expression term2 = factor();
            e = new Binary(op, e, term2);
        }
        return e;
    }
  
    private Expression factor() {
        // Factor --> [ UnaryOp ] Primary 
        if (isUnaryOp()) {
            Operator op = new Operator(match(token.type()));
            Expression term = primary();
            return new Unary(op, term);
        }
        else return primary();
    }
  
    private Expression primary () {
        // Primary --> Identifier | Literal | ( Expression )
        //             | Type ( Expression )
        Expression e = null;
        if (token.type().equals(TokenType.Identifier)) {
            e = new Variable(match(TokenType.Identifier));
        } else if (isLiteral()) {
            e = literal();
        } else if (token.type().equals(TokenType.LeftParen)) {
            token = lexer.next();
            e = expression();       
            match(TokenType.RightParen);
        } else if (isType( )) {
            Operator op = new Operator(match(token.type()));
            match(TokenType.LeftParen);
            Expression term = expression();
            match(TokenType.RightParen);
            e = new Unary(op, term);
        } else error("Identifier | Literal | ( | Type");
        return e;
    }

    private Value literal( ) {
        String str = null;
	switch (token.type().ordinal()) {
	case 1:
		str = match(TokenType.IntLiteral);
		return new IntValue(Integer.parseInt(str));
	case 2:
		str = match(TokenType.CharLiteral);
		return new CharValue(str.charAt(0));
	case 3:
		str = match(TokenType.True);
		return new BoolValue(true);
	case 4:
		str = match(TokenType.False);
		return new BoolValue(false);
	case 5:
		str = match(TokenType.FloatLiteral);
		return new FloatValue(Float.parseFloat(str));
	}
	throw new IllegalArgumentException("should not reach here");
    }	
  

    private boolean isAddOp( ) {
        return token.type().equals(TokenType.Plus) ||
               token.type().equals(TokenType.Minus);
    }
    
    private boolean isMultiplyOp( ) {
        return token.type().equals(TokenType.Multiply) ||
               token.type().equals(TokenType.Divide);
    }
    
    private boolean isUnaryOp( ) {
        return token.type().equals(TokenType.Not) ||
               token.type().equals(TokenType.Minus);
    }
    
    private boolean isEqualityOp( ) {
        return token.type().equals(TokenType.Equals) ||
            token.type().equals(TokenType.NotEqual);
    }
    
    private boolean isRelationalOp( ) {
        return token.type().equals(TokenType.Less) ||
               token.type().equals(TokenType.LessEqual) || 
               token.type().equals(TokenType.Greater) ||
               token.type().equals(TokenType.GreaterEqual);
    }
    
    private boolean isType( ) {
        return token.type().equals(TokenType.Int)
            || token.type().equals(TokenType.Bool) 
            || token.type().equals(TokenType.Float)
            || token.type().equals(TokenType.Char);
    }
    
    private boolean isLiteral( ) {
        return token.type().equals(TokenType.IntLiteral) ||
            isBooleanLiteral() ||
            token.type().equals(TokenType.FloatLiteral) ||
            token.type().equals(TokenType.CharLiteral);
    }
    
    private boolean isBooleanLiteral( ) {
        return token.type().equals(TokenType.True) ||
            token.type().equals(TokenType.False);
    }

    public static void main(String args[]) {
        Parser parser  = new Parser(new Lexer(args[0]));
        Program prog = parser.program();
        prog.display();           // display abstract syntax tree
    } //main

} // Parser
