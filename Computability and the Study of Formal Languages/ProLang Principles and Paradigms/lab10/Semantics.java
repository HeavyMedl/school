mport java.io.PrintStream;

public class Semantics
{
  State M(Program p)
  {
    return M(p.body, initialState(p.decpart));
  }

  State initialState(Declarations d) {
    State s = new State();
    IntValue intval = new IntValue();
    for (Declaration d : d)
      s.put(d.v, Value.mkValue(d.t));
    return s;
  }

  State M(Statement statement, State state)
  {
    if ((statement instanceof Skip)) return M((Skip)statement, state);
    if ((statement instanceof Assignment)) return M((Assignment)statement, state);
    if ((statement instanceof Conditional)) return M((Conditional)statement, state);
    if ((statement instanceof Loop)) return M((Loop)statement, state);
    if ((statement instanceof Block)) return M((Block)statement, state);
    throw new IllegalArgumentException("should never reach here");
  }

  State M(Skip skip, State state) {
    return state;
  }

  State M(Assignment a, State state) {
    return state.onion(a.target, M(a.source, state));
  }

  State M(Block b, State state) {
    for (Statement statement : b.members)
      state = M(statement, state);
    return state;
  }

  State M(Conditional c, State state) {
    if (M(c.test, state).boolValue()) {
      return M(c.thenbranch, state);
    }
    return M(c.elsebranch, state);
  }

  State M(Loop l, State state) {
    if (M(l.test, state).boolValue())
      return M(l, M(l.body, state));
    return state;
  }

  Value applyBinary(Operator o, Value v, Value vv) {
    StaticTypeCheck.check((!v.isUndef()) && (!vv.isUndef()), "reference to undef value");

    if (o.val.equals("INT+"))
      return new IntValue(v.intValue() + vv.intValue());
    if (o.val.equals("INT-"))
      return new IntValue(v.intValue() - vv.intValue());
    if (o.val.equals("INT*"))
      return new IntValue(v.intValue() * vv.intValue());
    if (o.val.equals("INT/"))
      return new IntValue(v.intValue() / vv.intValue());
    if (o.val.equals("INT<"))
      return new BoolValue(v.intValue() < vv.intValue());
    if (o.val.equals("INT<="))
      return new BoolValue(v.intValue() <= vv.intValue());
    if (o.val.equals("INT=="))
      return new BoolValue(v.intValue() == vv.intValue());
    if (o.val.equals("INT!="))
      return new BoolValue(v.intValue() != vv.intValue());
    if (o.val.equals("INT>="))
      return new BoolValue(v.intValue() >= vv.intValue());
    if (o.val.equals("INT>"))
      return new BoolValue(v.intValue() > vv.intValue());
    if (o.val.equals("FLOAT+"))
      return new FloatValue(v.floatValue() + v.floatValue());
    if (o.val.equals("FLOAT-"))
      return new FloatValue(v.floatValue() - vv.floatValue());
    if (o.val.equals("FLOAT*"))
      return new FloatValue(v.floatValue() * vv.floatValue());
    if (o.val.equals("FLOAT/"))
      return new FloatValue(v.floatValue() / vv.floatValue());
    if (o.val.equals("FLOAT<"))
      return new BoolValue(v.floatValue() < vv.floatValue());
    if (o.val.equals("FLOAT<="))
      return new BoolValue(v.floatValue() <= vv.floatValue());
    if (o.val.equals("FLOAT=="))
      return new BoolValue(v.floatValue() == vv.floatValue());
    if (o.val.equals("FLOAT!="))
      return new BoolValue(v.floatValue() != vv.floatValue());
    if (o.val.equals("FLOAT>="))
      return new BoolValue(v.floatValue() >= vv.floatValue());
    if (o.val.equals("FLOAT>"))
      return new BoolValue(v.floatValue() > vv.floatValue());
    if (o.val.equals("CHAR<"))
      return new BoolValue(v.charValue() < vv.charValue());
    if (o.val.equals("CHAR<="))
      return new BoolValue(v.charValue() <= vv.charValue());
    if (o.val.equals("CHAR=="))
      return new BoolValue(v.charValue() == vv.charValue());
    if (o.val.equals("CHAR!="))
      return new BoolValue(v.charValue() != vv.charValue());
    if (o.val.equals("CHAR>="))
      return new BoolValue(v.charValue() >= vv.charValue());
    if (o.val.equals("CHAR>"))
      return new BoolValue(v.charValue() > vv.charValue());
    if (o.val.equals("BOOL<"))
      return new BoolValue(v.intValue() < vv.intValue());
    if (o.val.equals("BOOL<="))
      return new BoolValue(v.intValue() <= vv.intValue());
    if (o.val.equals("BOOL=="))
      return new BoolValue(v.boolValue() == vv.boolValue());
    if (o.val.equals("BOOL!="))
      return new BoolValue(v.boolValue() != vv.boolValue());
    if (o.val.equals("BOOL>="))
      return new BoolValue(v.intValue() >= vv.intValue());
    if (o.val.equals("BOOL>"))
      return new BoolValue(v.intValue() > vv.intValue());
    if (o.val.equals("&&"))
      return new BoolValue((v.boolValue()) && (vv.boolValue()));
    if (o.val.equals("||"))
      return new BoolValue((v.boolValue()) || (vv.boolValue()));
    throw new IllegalArgumentException("should never reach here");
  }

  Value applyUnary(Operator o, Value v) {
    StaticTypeCheck.check(!v.isUndef(), "reference to undef value");

    if (o.val.equals("!"))
      return new BoolValue(!v.boolValue());
    if (paramOperator.val.equals("INTNEG"))
      return new IntValue(-v.intValue());
    if (o.val.equals("FLOATNEG"))
      return new FloatValue(-v.floatValue());
    if (o.val.equals("I2F"))
      return new FloatValue(v.intValue());
    if (o.val.equals("F2I"))
      return new IntValue((int)v.floatValue());
    if (o.val.equals("C2I"))
      return new IntValue(v.charValue());
    if (o.val.equals("I2C"))
      return new CharValue((char)v.intValue());
    throw new IllegalArgumentException("should never reach here: " + o.toString());
  }

  Value M(Expression e, State state)
  {
    if ((e instanceof Value))
      return (Value)e;
    if ((e instanceof Variable))
      return (Value)state.get(e);
    Object o;
    if ((e instanceof Binary)) {
      o = (Binary)e;
      return applyBinary(((Binary)o).op, M(((Binary)o).term1, state), M(((Binary)o).term2, state));
    }

    if ((e instanceof Unary)) {
      o = (Unary)e;
      return applyUnary(((Unary)o).op, M(((Unary)o).term, state));
    }
    throw new IllegalArgumentException("should never reach here");
  }

  public static void main(String[] args) {
    System.out.println("Begin parsing... " + args[0]);
    Parser parser = new Parser(new Lexer(args[0]));
    Program prog1 = parser.program();
    prog1.display();

    System.out.println("\nBegin type checking..." + args[0]);
    System.out.println("\nType map:");
    TypeMap typemap = StaticTypeCheck.typing(prog1.decpart);
    typemap.display();

    StaticTypeCheck.V(prog1);
    Program prog2 = TypeTransformer.T(prog1, typemap);
    System.out.println("\nTransformed Abstract Syntax Tree");
    prog2.display();

    System.out.println("\nBegin interpreting..." + args[0]);
    Semantics sem = new Semantics();
    State state = state.M(prog2);
    System.out.println("\nFinal State");
    state.display();
  }
}
