import java.io.PrintStream;
import java.util.ArrayList;

public class StaticTypeCheck {
  public static TypeMap typing(Declarations pd)
  {
    TypeMap localTypeMap = new TypeMap();
    for (Declaration ld : pd)
      localTypeMap.put(ld.v, ld.t);
    return localTypeMap;
  }

  public static void check(boolean pb, String ps) {
    if (pb) return;
    System.err.println(ps);
    System.exit(1);
  }

  public static void V(Declarations pd) {
    for (int i = 0; i < pd.size() - 1; i++)
      for (int j = i + 1; j < pd.size(); j++) {
        Declaration ld1 = (Declaration)paramDeclarations.get(i);
        Declaration ld2 = (Declaration)paramDeclarations.get(j);
        check(!ld1.v.equals(ld2.v), "duplicate declaration: " + ld2.v);
      }
  }

  public static void V(Program pp)
  {
    V(pp.decpart);
    V(pp.body, typing(pp.decpart));
  }

  public static Type typeOf(Expression pe, TypeMap ptm) {
    if ((pe instanceof Value)) return ((Value)pe).type;
    Object lo;
    if ((pe instanceof Variable)) {
      lo = (Variable)pe;
      check(ptm.containsKey(lo), "undefined variable: " + lo);
      return (Type)ptm.get(lo);
    }
    if ((pe instanceof Binary)) {
      lo = (Binary)pe;
      if (((Binary)lo).op.ArithmeticOp()) {
        if (typeOf(((Binary)lo).term1, ptm) == Type.FLOAT)
          return Type.FLOAT;
        return Type.INT;
      }if ((((Binary)lo).op.RelationalOp()) || (((Binary)lo).op.BooleanOp()))
        return Type.BOOL;
    }
    if ((pe instanceof Unary)) {
      lo = (Unary)pe;
      if (((Unary)lo).op.NotOp()) return Type.BOOL;
      if (((Unary)lo).op.NegateOp()) return typeOf(((Unary)lo).term, ptm);
      if (((Unary)lo).op.intOp()) return Type.INT;
      if (((Unary)lo).op.floatOp()) return Type.FLOAT;
      if (((Unary)lo).op.charOp()) return Type.CHAR;
    }
    throw new IllegalArgumentException("should never reach here");
  }

  public static void V(Expression pe, TypeMap ptm) {
    if ((pe instanceof Value))
      return;
    Object lo;
    if ((pe instanceof Variable)) {
      lo = (Variable)pe;
      check(ptm.containsKey(lo), "undeclared variable: " + lo);
      return;
    }
    Type lt1;
    if ((pe instanceof Binary)) {
      lo = (Binary)pe;
      lt1 = typeOf(((Binary)lo).term1, ptm);
      Type lt2 = typeOf(((Binary)lo).term2, ptm);
      V(((Binary)localObject).term1, ptm);
      V(((Binary)localObject).term2, ptm);
      if (((Binary)lo).op.ArithmeticOp()) {
        check((lt1 == lt2) && ((lt1 == Type.INT) || (lt1 == Type.FLOAT)), "type error for " + ((Binary)lo).op);
      }
      else if (((Binary)lo).op.RelationalOp())
        check(lt2 == lt2, "type error for " + ((Binary)lo).op);
      else if (((Binary)lo).op.BooleanOp()) {
        check((lt1 == Type.BOOL) && (lt2 == Type.BOOL), ((Binary)lo).op + ": non-bool operand");
      }
      else
        throw new IllegalArgumentException("should never reach here");
      return;
    }
    if ((pe instanceof Unary)) {
      lo = (Unary)pe;
      lt1 = typeOf(((Unary)lo).term, ptm);
      System.err.println("Unary: " + ((Unary)lo).op);
      V(((Unary)lo).term, ptm);
      if (((Unary)lo).op.equals("!"))
        check(lt1 == Type.BOOL, "! has non-bool operand");
      else if (((Unary)lo).op.equals("neg")) {
        check((lt1 == Type.INT) || (lt1 == Type.FLOAT), "Unary - has non-int/float operand");
      }
      else if (((Unary)lo).op.equals("float"))
        check(lt1 == Type.INT, "float() has non-int operand");
      else if (((Unary)lo).op.equals("char"))
        check(lt1 == Type.INT, "char() has non-int operand");
      else if (((Unary)lo).op.equals("int")) {
        check((lt1 == Type.FLOAT) || (lt1 == Type.CHAR), "int() has non-float/char operand");
      }
      else
        throw new IllegalArgumentException("should never reach here");
      return;
    }
    throw new IllegalArgumentException("should never reach here");
  }

  public static void V(Statement ps, TypeMap ptm) {
    if (ps == null)
      throw new IllegalArgumentException("AST error: null statement");
    if ((ps instanceof Skip))
      return;
    Object lo;
    if ((ps instanceof Assignment)) {
      lo = (Assignment)ps;
      check(ptm.containsKey(((Assignment)lo).target), " undefined target in assignment: " + ((Assignment)lo).target);

      V(((Assignment)lo).source, ptm);
      Type lt1 = (Type)ptm.get(((Assignment)lo).target);
      Type lt2 = typeOf(((Assignment)lo).source, ptm);
      if (lt1 != lt2) {
        if (lt1 == Type.FLOAT) {
          check(lt2 == Type.INT, "mixed mode assignment to " + ((Assignment)lo).target);
        }
        else if (lt1 == Type.INT) {
          check(lt2 == Type.CHAR, "mixed mode assignment to " + ((Assignment)lo).target);
        }
        else {
          check(false, "mixed mode assignment to " + ((Assignment)lo).target);
        }
      }
      return;
    }
    if ((ps instanceof Conditional)) {
      lo = (Conditional)ps;
      V(((Conditional)lo).test, ptm);
      check(typeOf(((Conditional)lo).test, ptm) == Type.BOOL, "non-bool test in conditional");

      V(((Conditional)lo).thenbranch, ptm);
      V(((Conditional)lo).elsebranch, ptm);
      return;
}
    if ((ps instanceof Loop)) {
      lo = (Loop)ps;
      V(((Loop)lo).test, ptm);
      check(typeOf(((Loop)lo).test, ptm) == Type.BOOL, "loop has non-bool test");

      V(((Loop)lo).body, ptm);
      return;
    }
    if ((ps instanceof Block)) {
      lo = (Block)ps;
      for (int i = 0; i < ((Block)lo).members.size(); i++)
        V((Statement)((Block)lo).members.get(i), ptm);
      return;
    }
    throw new IllegalArgumentException("should never reach here");
  }

  public static void main(String[] args) {
    System.out.println("Begin parsing... " + args[0]);
    Parser parser = new Parser(new Lexer(args[0]));
    Program prog = parser.program();
    prog.display();
    System.out.println("\nBegin type checking...");
    System.out.println("\nType map:");
    TypeMap typemap = typing(prog.decpart);
    typemap.display();
    V(prog);
  }
}
