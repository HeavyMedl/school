import java.util.Scanner;

public class DataAnalyzer
{
  public static void main(String[] args)
  {
    Scanner in = new Scanner(System.in);
    
    double n;
    double sum = 0;
    while (in.hasNextDouble())
    {
      System.out.print("Enter value, Q to quit: ");
      String input = in.next();
      
      if (in.hasNextDouble()) {
       n = in.nextDouble();
       sum = sum + n; }
      else 
        input.equalsIgnoreCase("Q"); }
    System.out.println(sum);
  }
  
}