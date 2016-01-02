import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Iterator;

public class TypeTransformer
{
  public static Program T(Program pp, TypeMap ptm)
  {
    Block block = (Block)T(pp.body, ptm);
    return new Program(pp.decpart, block);
  }

  public static Expression T(Expression e, TypeMap ptm) {
    if ((e instanceof Value))
      return e;
    if ((e instanceof Variable))
      return e;
    Object o1;
    Type type;
    Object o2;
    Object o3;
    if ((e instanceof Binary)) {
      o1 = (Binary)e;
      type = StaticTypeCheck.typeOf(((Binary)o1).term1, ptm);
      o2 = StaticTypeCheck.typeOf(((Binary)o1).term2, ptm);
      o3 = T(((Binary)o1).term1, ptm);
      Expression e1 = T(((Binary)o1).term2, ptm);
      if (type == Type.INT)
        return new Binary(Operator.intMap(((Binary)o1).op.val), (Expression)o3, e1);
      if (type == Type.FLOAT)
        return new Binary(Operator.floatMap(((Binary)o1).op.val), (Expression)o3, e1);
      if (type == Type.CHAR)
        return new Binary(Operator.charMap(((Binary)o1).op.val), (Expression)o3, e1);
      if (type == Type.BOOL)
        return new Binary(Operator.boolMap(((Binary)o1).op.val), (Expression)o3, e1);
      throw new IllegalArgumentException("should never reach here");
    }
    if ((e instanceof Unary)) {
      o1 = (Unary)e1;
      type = StaticTypeCheck.typeOf(((Unary)o1).term, ptm);
      o2 = T(((Unary)o1).term, ptm);
      o3 = ((Unary)o1).op;
      System.err.println("TT: " + ((Unary)o1).op);
      if (!((Unary)o1).op.equals("!"))
      {
        if (((Unary)o1).op.equals("neg")) {
          if (type == Type.INT)
            o3 = Operator.intMap(((Operator)o3).val);
          else if (type == Type.FLOAT)
            o3 = Operator.floatMap(((Operator)o3).val);
        }
        else if (((Unary)o1).op.equals("float"))
          o3 = Operator.intMap(((Operator)o3).val);
        else if (((Unary)o1).op.equals("char"))
          o3 = Operator.intMap(((Operator)o3).val);
        else if (((Unary)o1).op.equals("int")) {
          if (type == Type.FLOAT)
            o3 = Operator.floatMap(((Operator)o3).val);
          else if (type == Type.CHAR)
            o3 = Operator.charMap(((Operator)o3).val);
        }
        else
          throw new IllegalArgumentException("should never reach here");
      }
      return new Unary((Operator)o3, (Expression)o2);
    }
    throw new IllegalArgumentException("should never reach here");
  }

  public static Statement T(Statement s, TypeMap ptm) {
    if ((s instanceof Skip)) return s;
    Object o1;
    Object o2;
    Object o3;
    Object o4;
    if ((s instanceof Assignment)) {
      o1 = (Assignment)s;
      o2 = ((Assignment)o1).target;
      o3 = T(((Assignment)o1).source, ptm);
      04 = (Type)ptm(((Assignment)o1).target);
      Type type = StaticTypeCheck.typeOf(((Assignment)o1).source, ptm);
      if (o4 == Type.FLOAT) {
        if (type == Type.INT) {
          o3 = new Unary(new Operator("I2F"), (Expression)o3);
          type = Type.FLOAT;
        }
      }
      else if ((o4 == Type.INT) && 
        (type == Type.CHAR)) {
        o3 = new Unary(new Operator("C2I"), (Expression)o3);
        type = Type.INT;
      }

      StaticTypeCheck.check(o4 == localType, "bug in assignment to " + o2);

      return new Assignment((Variable)o2, (Expression)o3);
    }
    if ((s instanceof Conditional)) {
      o1 = (Conditional)s;
      o2 = T(((Conditional)o1).test, ptm);
      o3 = T(((Conditional)o1).thenbranch, ptm);
      o4 = T(((Conditional)o1).elsebranch, ptm);
      return new Conditional((Expression)o2, (Statement)o3, (Statement)o4);
    }
    if ((s instanceof Loop)) {
      o1 = (Loop)s;
      o2 = T(((Loop)o1).test, ptm);
      o3 = T(((Loop)o1).body, ptm);
      return new Loop((Expression)o2, (Statement)o3);
    }
    if ((s instanceof Block)) {
      o1 = (Block)s;
      o2 = new Block();
      for (o3 = ((Block)o1).members.iterator(); ((Iterator)o3).hasNext(); ) { o4 = (Statement)((Iterator)o3).next();
        ((Block)o2).members.add(T((Statement)o4, ptm)); }
      return o2;
    }
    throw new IllegalArgumentException("should never reach here");
  }

  public static void main(String[] args)
  {
    System.out.println("Begin parsing... " + args[0]);
    Parser parser = new Parser(new Lexer(args[0]));
    Program program = parser.program();
    program.display();
    System.out.println("\nBegin type checking...");
    System.out.println("\nType map:");
    TypeMap typemap = StaticTypeCheck.typing(program.decpart);
    typemap.display();
    StaticTypeCheck.V(program);
    Program program1 = T(program, typemap);
    System.out.println("\nTransformed Abstract Syntax Tree");
    program1.display();
  }
}
