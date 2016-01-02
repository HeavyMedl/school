import java.util.Scanner;

public class FactorGenTest
{
  public static void main(String[] args)
  {
    Scanner in = new Scanner(System.in);
    
    FactorGenerator twelve = new FactorGenerator(150);
    
    for (int i=1; i > 0; i++) {
      System.out.println(twelve.nextFactor());
    }
  }
}