import java.io.PrintStream;
import java.util.HashMap;

public class TypeMap extends HashMap<Variable, Type>
{
  public void display()
  {
    System.out.print("{ ");
    String str = "";
    for (Variable v : keySet()) {
      System.out.print(str + "<" + v + ", " + ((Type)get(v)).getId() + ">");
      str = ", ";
    }
    System.out.println(" }");
  }
}
