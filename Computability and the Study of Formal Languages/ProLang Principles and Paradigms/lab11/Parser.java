import java.io.PrintStream;
import java.util.ArrayList;

public class Parser
{
  Token token;
  Lexer lexer;
  String funcId = "";

  public Parser(Lexer l) {
    this.lexer = l;
    this.token = this.lexer.next();
  }

  private String match(TokenType tok) {
    String str = this.token.value();
    if (this.token.type().equals(tok))
      this.token = this.lexer.next();
    else
      error(tok);
    return str;
  }

  private void error(TokenType tok) {
    System.err.println("Syntax error: expecting: " + tok + "; saw: " + this.token);

    System.exit(1);
  }

  private void error(String s) {
    System.err.println("Syntax error: expecting: " + s + "; saw: " + this.token);

    System.exit(1);
  }

  public Program program()
  {
    Program p = new Program();
    p.globals = new Declarations();
    p.functions = new Functions();

    while (!this.token.type().equals(TokenType.Eof)) {
      Type t = type();
      if (this.token.type().equals(TokenType.Identifier)) {
        Declaration d = new Declaration(this.token.value(), t);
        this.token = this.lexer.next();
        if ((this.token.type().equals(TokenType.Comma)) || (this.token.type().equals(TokenType.Semicolon)))
        {
          p.globals.add(d);
          while (this.token.type().equals(TokenType.Comma)) {
            this.token = this.lexer.next();
            d = new Declaration(this.token.value(), localType);
            p.globals.add(d);
            this.token = this.lexer.next();
          }
          this.token = this.lexer.next();
        }
        else if (this.token.type().equals(TokenType.LeftParen))
        {
          Function f = new Function(d.v.id(), t);
          this.funcId = d.v.id();
          this.token = this.lexer.next();
          f = functionRest(f);
          p.functions.add(f);
        } else {
          error("FunctionOrGlobal");
        }
      } else { error("Identifier"); }
    }
    return p;
  }

  public Function functionRest(Function f)
  {
    f.params = new Declarations();

    while ((this.token.type().equals(TokenType.Int)) || (this.token.type().equals(TokenType.Bool)) || (this.token.type().equals(TokenType.Char)) || (this.token.type().equals(TokenType.Float))) {
      f.params = parameter(f.params);
      if (this.token.type().equals(TokenType.Comma))
        match(TokenType.Comma);
    }
    match(TokenType.RightParen);
    match(TokenType.LeftBrace);
    f.locals = declarations();
    f.body = statements();
    match(TokenType.RightBrace);
    return f;
  }

  public Declarations parameter(Declarations ds)
  {
    Declaration d = new Declaration();
    d.t = new Type(this.token.value());
    this.token = this.lexer.next();
    if (this.token.type().equals(TokenType.Identifier))
      d.v = new Variable(this.token.value());
    else
      error("Identifier");
    this.token = this.lexer.next();
    ds.add(d);
    return ds;
  }

  private Declarations declarations()
  {
    Declarations ds = new Declarations();
    while (isType()) {
      declaration(ds);
    }
    return ds;
  }

  private void declaration(Declarations ds)
  {
    Type localType = type();
    while (!this.token.type().equals(TokenType.Semicolon)) {
      String str = match(TokenType.Identifier);
      ds.add(new Declaration(str, localType));
      if (this.token.type().equals(TokenType.Comma))
        match(TokenType.Comma);
    }
    match(TokenType.Semicolon);
  }

  private Type type()
  {
    Type type = null;
    if (this.token.type().equals(TokenType.Int))
      type = Type.INT;
    else if (this.token.type().equals(TokenType.Bool))
      type = Type.BOOL;
    else if (this.token.type().equals(TokenType.Float))
      type = Type.FLOAT;
    else if (this.token.type().equals(TokenType.Char))
      type = Type.CHAR;
    else if (this.token.type().equals(TokenType.Void))
      type = Type.VOID;
    else error("int | bool | float | char | void");
    this.token = this.lexer.next();
    return type;
  }

  private Statement statement()
  {
    Object o = new Skip();
    if (this.token.type().equals(TokenType.Semicolon)) {
      this.token = this.lexer.next();
    } else if (this.token.type().equals(TokenType.LeftBrace)) {
      this.token = this.lexer.next();
      o = statements();
      match(TokenType.RightBrace);
    }
    else if (this.token.type().equals(TokenType.If)) {
      o = ifStatement();
    } else if (this.token.type().equals(TokenType.While)) {
      o = whileStatement();
    } else if (this.token.type().equals(TokenType.Identifier)) {
      o = assignmentOrCall();
    } else if (this.token.type().equals(TokenType.Return)) {
      o = returnStatement(); } else {
      error("Illegal statement");
    }return o;
  }

  private Block statements()
  {
    Block b = new Block();
    while (!this.token.type().equals(TokenType.RightBrace)) {
      b.members.add(statement());
    }
    return b;
  }

  private Statement assignmentOrCall()
  {
    Variable v = new Variable(this.token.value());
    Call c = new Call();
    this.token = this.lexer.next();
    if (this.token.type().equals(TokenType.Assign)) {
      this.token = this.lexer.next();
      Expression e = expression();
      match(TokenType.Semicolon);
      return new Assignment(v, e);
    }
    if (this.token.type().equals(TokenType.LeftParen)) {
      c.name = v.id();
      this.token = this.lexer.next();
      c.args = arguments();
      match(TokenType.RightParen);
      match(TokenType.Semicolon);
      return c;
    }
    error("assignmentOrCall");
    return null;
  }

  private Return returnStatement()
  {
    Return r = new Return();
    match(TokenType.Return);
    r.target = new Variable(this.funcId);
    r.result = expression();
    match(TokenType.Semicolon);
    return r;
  }

  private Expressions arguments()
  {
    Expressions e = new Expressions();
    while (!this.token.type().equals(TokenType.RightParen)) {
     e.add(expression());
      if (this.token.type().equals(TokenType.Comma))
        match(TokenType.Comma);
      else if (!this.token.type().equals(TokenType.RightParen))
        error("Expressions");
    }
    if (e.size() == 0)
      e = null;
    return e;
  }

  private Conditional ifStatement()
  {
    match(TokenType.If);
    Expression e = expression();
    Statement s = statement();
    Object o = new Skip();
    if (this.token.type().equals(TokenType.Else)) {
      this.token = this.lexer.next();
      o = statement();
    }
    return new Conditional(e, s, (Statement)o);
  }

  private Loop whileStatement()
  {
    match(TokenType.While);
    match(TokenType.LeftParen);
    Expression e = expression();
    match(TokenType.RightParen);
    Statement s = statement();
    return new Loop(e, s);
  }

  private Expression expression()
  {
    Object o = conjunction();
    while (this.token.type().equals(TokenType.Or)) {
      Operator op = new Operator(this.token.value());
      this.token = this.lexer.next();
      Expression e = conjunction();
      o = new Binary(op, (Expression)o, e);
    }
    return o;
  }

  private Expression conjunction()
  {
    Object o = equality();
    while (this.token.type().equals(TokenType.And)) {
      Operator op = new Operator(this.token.value());
      this.token = this.lexer.next();
      Expression e = equality();
      o = new Binary(op, (Expression)o, e);
    }
    return o;
  }

  private Expression equality()
  {
    Object o = relation();
    while (isEqualityOp()) {
      Operator op = new Operator(this.token.value());
      this.token = this.lexer.next();
      Expression e = relation();
      o = new Binary(op, (Expression)o, e);
    }
    return o;
  }

  private Expression relation()
  {
    Object o = addition();
    while (isRelationalOp()) {
      Operator op = new Operator(this.token.value());
      this.token = this.lexer.next();
      Expression e = addition();
      o = new Binary(op, (Expression)o, e);
    }
    return o;
  }

  private Expression addition()
  {
    Object o = term();
    while (isAddOp()) {
      Operator op = new Operator(match(this.token.type()));
      Expression e = term();
      o = new Binary(op, (Expression)o, e);
    }
    return o;
  }

  private Expression term()
  {
    Object o = factor();
    while (isMultiplyOp()) {
      Operator op = new Operator(match(this.token.type()));
      Expression e = factor();
      o = new Binary(op, (Expression)o, e);
    }
    return o;
  }

  private Expression factor()
  {
    if (isUnaryOp()) {
      Operator op = new Operator(match(this.token.type()));
      Expression e = primary();
      return new Unary(op, e);
    }
    return primary();
  }

  private Expression primary()
  {
    Object o1 = null;
    Object o2;
    Object o3;
    if (this.token.type().equals(TokenType.Identifier)) {
      o2 = new Variable(match(TokenType.Identifier));
      o1 = o2;
      if (this.token.type().equals(TokenType.LeftParen))
      {
        this.token = this.lexer.next();
        o3 = new Call();
        ((Call)o3).name = ((Variable)o2).id();
        ((Call)o3).args = arguments();
        match(TokenType.RightParen);
        o1 = o3;
      }
    } else if (isLiteral()) {
      o1 = literal();
    } else if (this.token.type().equals(TokenType.LeftParen)) {
      this.token = this.lexer.next();
      o1 = expression();
      match(TokenType.RightParen);
    } else if (isType()) {
      o2 = new Operator(match(this.token.type()));
      match(TokenType.LeftParen);
      o3 = expression();
      match(TokenType.RightParen);
      o1 = new Unary((Operator)o2, (Expression)o3); } else {
      error("Identifier | Literal | ( | Type");
    }return o1;
  }

  private Value literal() {
    String str = null;
    switch (Parser.1.$SwitchMap$TokenType[this.token.type().ordinal()]) {
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

  private boolean isAddOp()
  {
    return (this.token.type().equals(TokenType.Plus)) || (this.token.type().equals(TokenType.Minus));
  }

  private boolean isMultiplyOp()
  {
    return (this.token.type().equals(TokenType.Multiply)) || (this.token.type().equals(TokenType.Divide));
  }

  private boolean isUnaryOp()
  {
    return (this.token.type().equals(TokenType.Not)) || (this.token.type().equals(TokenType.Minus));
  }

  private boolean isEqualityOp()
  {
    return (this.token.type().equals(TokenType.Equals)) || (this.token.type().equals(TokenType.NotEqual));
  }

  private boolean isRelationalOp()
  {
    return (this.token.type().equals(TokenType.Less)) || (this.token.type().equals(TokenType.LessEqual)) || (this.token.type().equals(TokenType.Greater)) || (this.token.type().equals(TokenType.GreaterEqual));
  }

  private boolean isType()
  {
    return (this.token.type().equals(TokenType.Int)) || (this.token.type().equals(TokenType.Bool)) || (this.token.type().equals(TokenType.Float)) || (this.token.type().equals(TokenType.Char));
  }

  private boolean isLiteral()
  {
    return (this.token.type().equals(TokenType.IntLiteral)) || (isBooleanLiteral()) || (this.token.type().equals(TokenType.FloatLiteral)) || (this.token.type().equals(TokenType.CharLiteral));
  }

  private boolean isBooleanLiteral()
  {
    return (this.token.type().equals(TokenType.True)) || (this.token.type().equals(TokenType.False));
  }

  public static void main(String[] args)
  {
    System.out.println("Begin parsing... " + args[0]);
    Parser parser = new Parser(new Lexer(args[0]));
    Program program = parser.program();
    program.display();
  }
}
